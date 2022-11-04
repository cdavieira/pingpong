global line,smart_line
extern plot_xy,deltax,deltay,cor

; push x1;  push y1;  push x2;  push y2;  call line;   (x<639, y<479)
smart_line:
	push 	bp
	mov	bp,sp
	; salvando o contexto, empilhando registradores
	pushf
	push 	ax
	push	cx
	push	dx
        ; y = row, x = column
        mov     cx,[bp+10]
        mov     dx,[bp+8]
        mov     ah,0dh
        int     10h
        cmp     al,byte [cor]
        jne     precisa_desenhar
        mov     cx,[bp+6]
        mov     dx,[bp+4]
        mov     ah,0dh
        int     10h
        cmp     al,byte [cor]
        jne     precisa_desenhar
        jmp     fim_smartline
precisa_desenhar:
        push    word [bp+10]
        push    word [bp+8]
        push    word [bp+6]
        push    word [bp+4]
        call    line
fim_smartline:
	pop	dx
	pop	cx
	pop	ax
	popf
	pop	bp
	ret	8

; função line
; push x1;  push y1;  push x2;  push y2;  call line;   (x<639, y<479)
line:
	push 	bp
	mov	bp,sp
	; salvando o contexto, empilhando registradores
	pushf
	push 	ax
	push 	bx
	push	cx
	push	dx
	push	si
	push	di
	; resgata os valores das coordenadas previamente definidas antes de chamar a funcao line
	mov	ax,[bp+10]  ; x1
	mov	bx,[bp+8]   ; y1
	mov	cx,[bp+6]   ; x2
	mov	dx,[bp+4]   ; y2
	cmp	ax,cx       ; compare x1 with x2
	je	linev       ; jump to vertical line
	jb	line1       ; jump if x1 < x2
	xchg	ax,cx       ; else, exchange x1 with x2,
	xchg	bx,dx       ; and exchange y1 with y2,
	jmp	line1
; seção vertical line
linev:	                    ; deltax=0
	cmp	bx,dx       ; compare y1 with y2
	jb	linevd      ; jump if y1 < y2, down vertical line
	xchg	bx,dx       ; else, exchange y1 with y2, up vertical line
linevd:	                    ;
	push	ax          ; column
	push	bx          ; row
	call 	plot_xy
	cmp	bx,dx       ; compare y1 with y2
	jne	inclinev    ; if not equal, jump to increase pixel
	jmp	end_line    ; else jump fim_line
inclinev:
        inc	bx
	jmp	linevd
; seção horizontal line
line1:			    ; deltax <,=,>0
	; compare modulus deltax & deltay due to cx > ax -> x2 > x1
	push	cx          ; save x2 in stack
	sub	cx,ax       ; cx = cx-ax -> x2 = x2-x1 -> deltax
	mov	[deltax],cx ; save deltax
	pop	cx          ; cx = x2
	push	dx          ; save y2 in stack
	sub	dx,bx       ; dx = dx-bx -> y2 = y2-y1 -> deltay
	ja	line32      ; jump if dx > bx -> y2 > y1
	neg	dx          ; else, invert dx
; y = -mx+b
line32:
	mov	[deltay],dx ; save deltay
	pop	dx          ; dx = y2

	push	ax          ; save x2 in stack
	mov	ax,[deltax] ; compare deltax with deltay
	cmp	ax,[deltay]
	pop	ax          ; ax = x2
	jb	line5       ; jump if deltax < deltay

	;  cx > ax e deltax>deltay
	push	cx
	sub	cx,ax
	mov	[deltax],cx
	pop	cx
	push	dx
	sub	dx,bx
	mov	[deltay],dx
	pop	dx

	mov	si,ax
line4:
	push	ax
	push	dx
	push	si
	sub	si,ax	; (x-x1)
	mov	ax,[deltay]
	imul	si
	mov	si,[deltax]	; arredondar
	shr	si,1
;  se numerador (dx)>0 soma se <0 subtrai
	cmp	dx,0
	jl	ar1
	add	ax,si
	adc	dx,0
	jmp	arc1
ar1:	sub	ax,si
	sbb	dx,0
arc1:
	idiv    word[deltax]
	add	ax,bx
	pop	si
	push	si
	push	ax
	call	plot_xy
	pop	dx
	pop	ax
	cmp	si,cx
	je	end_line
	inc	si
	jmp	line4
                                ;
line5:	cmp	bx,dx           ; compare y1 with y2
	jb 	line7           ; jump if y1 < y2 -> line
	xchg	ax,cx       ; else
	xchg	bx,dx
line7:
	push	cx
	sub	cx,ax
	mov	word[deltax],cx
	pop	cx
	push	dx
	sub	dx,bx
	mov	[deltay],dx
	pop	dx

	mov	si,bx
line6:
	push	dx
	push	si
	push	ax
	sub	si,bx		; (y-y1)
	mov	ax,[deltax]
	imul	si          	; signed multiply
	mov	si,[deltay]	; arredondar
	shr	si,1            ; shift operand1 right

;  se numerador (dx)>0 soma se <0 subtrai
	cmp	dx,0
	jl	ar2
	add	ax,si
	adc	dx,0
	jmp	arc2
ar2:	sub	ax,si
	sbb	dx,0
arc2:
	idiv    word[deltay]
	mov	di,ax
	pop	ax
	add	di,ax
	pop	si
	push	di
	push	si
	call	plot_xy
	pop	dx
	cmp	si,dx
	je	end_line
	inc	si
	jmp	line6

end_line:
	pop	di
	pop	si
	pop	dx
	pop	cx
	pop	bx
	pop	ax
	popf
	pop	bp
	ret	8
