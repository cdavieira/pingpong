global plot_xy
extern cor

; funcao plot_xy
;  push x;  push y;  call plot_xy;   (x<639, y<479)
plot_xy:
	push    bp
	mov	bp,sp
	; salvando o contexto, empilhando registradores
	pushf
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	; preparando para chamar a int 10h
	mov     ah,0ch      ; int 10h/ah = 0ch - change color for a single pixel.
	mov     al,[cor]    ; al = pixel color
	mov     bh,0
	mov     dx,479
	sub	dx,[bp+4]   ; dx = row
	mov     cx,[bp+6]   ; cx = column - load in ax
	int     10h
	; recupera-se o contexto
	pop     di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	popf
	pop	bp
	ret	4	; add 4 cause row and column were updated before to enter in the function
