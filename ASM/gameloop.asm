global gameloop
extern  p_i,p_t,velocidade

gameloop:
        pushf
        push    ax
        push    bx
esperar_acao:
	mov	bx,[p_i]
        cmp     [p_t],bx
        ; atualizar posicao da bolinha
        je      esperar_acao
decodificar:
        ; decodificar botao apertado
gameover:
        pop     bx
        pop     ax
        popf
        ret
