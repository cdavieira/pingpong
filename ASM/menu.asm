global desenhar_menu
extern p_i,p_t,tecla_u,tecla,teclasc,line,cor

desenhar_menu:
        pushf
        push    ax
        push    bx
esperar_tecla:
	mov	bx,[p_t]
	mov	al, [bx+tecla]
        cmp     al,tecla_sair
	;mov	ax,[p_i]
	;cmp	ax,[p_t]
	je	esperar_tecla
tratar_tecla:
	inc	word[p_t]
	and	word[p_t],7
	mov	bx,[p_t]
	xor	ax, ax
	mov	al, [bx+tecla]
	mov	[tecla_u],al
	mov	bl, 16
	div	bl
	add	al, 30h
	cmp	al, 3ah
	jb	eh_decimal2
	add	al, 07h
eh_decimal2:	
	mov	[teclasc], al ; gravando primeiro digito do numero
	add	ah, 30h
	cmp	ah, 3ah
	jb	eh_decimal3
	add	ah, 07h
eh_decimal3:
	mov	[teclasc+1], ah ; gravando segundo digito do numero
opcoes_menu:
	cmp	byte [tecla_u],tecla_sair
	je	sair_menu
loading_anim:
	mov	cx,10
	mov	dx,100
loop1:
	mov	byte [cor],branco_intenso
	mov	ax,telaX/2
	sub	ax,dx
	push	ax
	mov	ax,telaY/2-coluninha
	push	ax
	mov	ax,telaX/2
	sub	ax,dx
	push	ax
	mov	ax,telaY/2+coluninha
	push	ax
	call	line
	push	cx
delay1:
	mov	cx,8000h
	push	cx
delay2:
	nop
	loop	delay2
	pop	cx
delay3:
	nop
	loop	delay3
	pop	cx
	mov	byte [cor],preto
	mov	ax,telaX/2
	sub	ax,dx
	push	ax
	mov	ax,telaY/2-coluninha
	push	ax
	mov	ax,telaX/2
	sub	ax,dx
	push	ax
	mov	ax,telaY/2+coluninha
	push	ax
	call	line
	sub	dx,20
	loop	loop1
	jmp	esperar_tecla
sair_menu:
        pop     bx
        pop     ax
        popf
        ret

%include "asm/config.asm"
