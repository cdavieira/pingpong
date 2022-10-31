;    função full_circle
;    push xc; push yc; push r; call full_circle;  (xc+r<639,yc+r<479)e(xc-r>0,yc-r>0)

global full_circle
extern line

full_circle:
	push 	bp
	mov	bp,sp
	pushf	;coloca os flags na pilha
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di

	mov	ax,[bp+8]    ; resgata xc
	mov	bx,[bp+6]    ; resgata yc
	mov	cx,[bp+4]    ; resgata r

	mov	si,bx
	sub	si,cx
	push    ax	;coloca xc na pilha
	push	si	;coloca yc-r na pilha
	mov	si,bx
	add	si,cx
	push	ax	;coloca xc na pilha
	push	si	;coloca yc+r na pilha
	call line
	mov	di,cx
	sub	di,1	 ;di=r-1
	mov	dx,0  	;dx ser� a vari�vel x. cx � a variavel y

;aqui em cima a l�gica foi invertida, 1-r => r-1
;e as compara��es passaram a ser jl => jg, assim garante
;valores positivos para d

stay_full:	;loop
	mov	si,di
	cmp	si,0
	jg	inf_full       ;caso d for menor que 0, seleciona pixel superior (n�o  salta)
	mov	si,dx	;o jl � importante porque trata-se de conta com sinal
	sal	si,1	;multiplica por doi (shift arithmetic left)
	add	si,3
	add	di,si     ;nesse ponto d=d+2*dx+3
	inc	dx	;incrementa dx
	jmp	plotar_full
inf_full:
	mov	si,dx
	sub	si,cx  	;faz x - y (dx-cx), e salva em di
	sal	si,1
	add	si,5
	add	di,si	;nesse ponto d=d+2*(dx-cx)+5
	inc	dx	;incrementa x (dx)
	dec	cx	;decrementa y (cx)

plotar_full:
	mov	si,ax
	add	si,cx
	push	si	;coloca a abcisa y+xc na pilha
	mov	si,bx
	sub	si,dx
	push    si	;coloca a ordenada yc-x na pilha
	mov	si,ax
	add	si,cx
	push	si	;coloca a abcisa y+xc na pilha
	mov	si,bx
	add	si,dx
	push    si	;coloca a ordenada yc+x na pilha
	call 	line

	mov	si,ax
	add	si,dx
	push	si	;coloca a abcisa xc+x na pilha
	mov	si,bx
	sub	si,cx
	push    si	;coloca a ordenada yc-y na pilha
	mov	si,ax
	add	si,dx
	push	si	;coloca a abcisa xc+x na pilha
	mov	si,bx
	add	si,cx
	push    si	;coloca a ordenada yc+y na pilha
	call	line

	mov	si,ax
	sub	si,dx
	push	si	;coloca a abcisa xc-x na pilha
	mov	si,bx
	sub	si,cx
	push    si	;coloca a ordenada yc-y na pilha
	mov	si,ax
	sub	si,dx
	push	si	;coloca a abcisa xc-x na pilha
	mov	si,bx
	add	si,cx
	push    si	;coloca a ordenada yc+y na pilha
	call	line

	mov	si,ax
	sub	si,cx
	push	si	;coloca a abcisa xc-y na pilha
	mov	si,bx
	sub	si,dx
	push    si	;coloca a ordenada yc-x na pilha
	mov	si,ax
	sub	si,cx
	push	si	;coloca a abcisa xc-y na pilha
	mov	si,bx
	add	si,dx
	push    si	;coloca a ordenada yc+x na pilha
	call	line

	cmp	cx,dx
	jb	fim_full_circle  ;se cx (y) est� abaixo de dx (x), termina
	jmp	stay_full	;se cx (y) est� acima de dx (x), continua no loop
fim_full_circle:
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	popf
	pop	bp
	ret	6
