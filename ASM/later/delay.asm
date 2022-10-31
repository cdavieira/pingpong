global delay
extern velocidade

; descrição
; A função delay serve para estender a duração de um frame na tela.
; Para isso, faz loops (no momento 2) para fazer o frame perdurar mais tempo na tela
delay:
	push cx ; guardando valor antigo de cx
	mov cx, word [velocidade]
	push cx ; freeze2
	push cx ; freeze3
freeze1:
	nop
	loop freeze1
	pop cx
freeze2:
	nop
	loop freeze2
	pop cx
freeze3:
	nop
	loop freeze3
	pop cx ; recuperando valor original de cx
	ret
