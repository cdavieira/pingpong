global gameloop
extern p_i,p_t,tecla,tecla_u,teclasc

gameloop:
nenhuma_tecla:
	mov	ax,[p_i]
	cmp	ax,[p_t]
	je	nenhuma_tecla
decode_tecla:
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
	jb	eh_decimal
	add	al, 07h
eh_decimal:	
	mov	[teclasc], al ; gravando primeiro digito do numero
	add	ah, 30h
	cmp	ah, 3ah
	jb	eh_decimal1
	add	ah, 07h
eh_decimal1:
	mov	[teclasc+1], ah ; gravando segundo digito do numero
teclas_jogo:
	cmp	byte [tecla_u], 'q'
	je	finalizar_jogo
        ; adicionar codigo aqui
        ; adicionar demais acoes tomadas mediante certas teclas aqui
        ; chamar funcao de renderizacao
	jmp	nenhuma_tecla
finalizar_jogo:
        ; rotina de finalizacao do jogo
        ret
