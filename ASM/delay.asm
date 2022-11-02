global delay
extern velocidade

; descrição
; A função delay serve para estender a duração de um frame na tela.
; Para isso, faz loops (no momento 2) para fazer o frame perdurar mais tempo na tela
delay:
	push cx ; guardando valor antigo de cx
	mov cx, word [velocidade]
loop2:
        push    cx
        mov     cx,8000h
loop3:
        nop
        loop    loop3
        pop     cx
        loop    loop2
	pop cx ; recuperando valor original de cx
	ret
