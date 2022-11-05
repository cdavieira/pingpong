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
	push	ax
	push	bx
	push	ds
	mov	ax,seg cs_dos
	mov	ds,ax
	in	al, kb_data ; al armazena o caracter lido no teclado (tanto makecode como breakcode)
        cmp     al, 0e0h ; caso o caracter lido seja 0e0, significa que o makecode apresenta +1 codigo no buffer de leitura
        jne     cont
	in	al, kb_data ; le-se o segundo codigo do buffer e o armazena em al. Nesse caso, esse sera o codigo interpretado pelo programa.
cont:
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
