global trocar_int9,restaurar_int9
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
	mov	word [es:int9*4+2], cs ; escrevendo novo ip da int9
	mov	word [es:int9*4],tecla_pressionada ; escrevendo novo cs da int9
	sti	
        ret
; funcao para restaurar tratamento padrao da int 9
restaurar_int9:
	cli
	xor	ax, ax
	mov	es, ax
	mov	ax, [cs_dos]
	mov	[es:int9*4+2], ax
	mov	ax, [offset_dos]
	mov	[es:int9*4], ax 
	sti
        ret
; novo tratamento implementado para int 9
tecla_pressionada:
	push	ax
	push	bx
	push	word seg cs_dos
	mov	ax,seg cs_dos
	mov	ds,ax
	in	al, kb_data
	inc	word [p_i]
	and	word [p_i],7
	mov	bx,[p_i]
	mov	[bx+tecla],al
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
