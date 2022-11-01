global trocar_int9,restaurar_int9,tecla_pressionada
extern offset_dos,cs_dos,p_i,tecla

; funcao para modificar tratamento padrao da int 9
trocar_int9:
	cli
	xor	ax, ax
	mov	es, ax
	mov	ax, [es:int9*4] ; carregou ax com offset anterior
	mov	[offset_dos], ax ; guardando ip original da int9
	mov	ax, [es:int9*4+2] ; guardando cs original da int9
	mov	[cs_dos], ax
        ; minha modificacao
        push    es
        push    bx
        mov     ax,cs
        mov     es,ax
        mov     bx,[offset_dos]
        mov     byte [es:bx],50h ; push ax
        mov     word [es:bx+1],060e4h ; in al,60h
        mov     word [es:bx+3],04fb4h ; mov ah,4fh
        mov     byte [es:bx+5],0f9h ; stc
        mov     word [es:bx+6],015cdh ; int 15h
        mov     word [es:bx+8],00473h ; jnb e995
        mov     word [es:bx+0ah],038feh ; ???
        mov     word [es:bx+0ch],0010h ; ???
        mov     byte [es:bx+0eh],0fah ; cli
        mov     word [es:bx+0fh],020b0h ; mov al,20h
        mov     word [es:bx+11h],020e6h ; out 20h,al
        mov     byte [es:bx+13h],58h ; pop ax
        mov     byte [es:bx+14h],0cfh ; iret
        pop     bx
        pop     es
        ; fim
	mov	word [es:int9*4+2], cs ; escrevendo novo cs da int9
        mov     ax,seg tecla_pressionada
        rol     ax,4
        mov     dx,cs
        rol     dx,4
        sub     ax,dx
        add     ax,tecla_pressionada
	mov	word [es:int9*4],ax; escrevendo novo ip da int9
	sti	
        ret
; funcao para restaurar tratamento padrao da int 9
restaurar_int9:
	cli
	xor	ax, ax
	mov	es, ax
	mov	ax, [offset_dos]
	mov	[es:int9*4], ax 
	mov	ax, [cs_dos]
	mov	[es:int9*4+2], ax
	sti
        ret
; novo tratamento implementado para int 9
; ao final, caracter esta em uma posicao do vetor tecla e [p_i] armazena essa posicao
tecla_pressionada:
        ; inicio rotina antiga
        push    ax
        in      al,60h
        mov     ah,4fh
        stc
        int     15h ; sets cf=1 if new scancode was generated or cf=0 otherwise
        jnb     continue ; jumps if scancode didnt change
var1    dw      038feh,0010h ; gets here if new scancode was generated (cf=1)
continue:
        cli
        mov al,20h
        out 20h,al
        pop ax
        ; iret
        ; fim rotina antiga
        ; !!! EMENDAR ROTINA ANTIGA COM NOVA !!! 
	push	ax
	push	bx
	push	ds
	mov	ax,seg cs_dos
	mov	ds,ax
	in	al, kb_data ; al armazena o caracter lido no teclado
	inc	word [p_i] ; atualizando deslocamento
	and	word [p_i],7 ; atualizando deslocamento
	mov	bx,[p_i] ; atualizando deslocamento
	mov	[bx+tecla],al ; o caracter eh armazenado no lugar da memoria apontado por tecla + deslocamento (bx)
	in	al, kb_ctl
	or	al, 80h
	out	kb_ctl, al
	and	al, 7fh
	out	kb_ctl, al
	mov	al, eoi
	out	pictrl, al
	pop	ds
	pop	bx
	pop	ax
	iret

%include "asm/config.asm"
