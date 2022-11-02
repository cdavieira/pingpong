global gameloop,janela
extern  p_i,p_t,velocidade

gameloop:
        pushf
        push    ax
        push    bx
        call    janela
esperar_acao:
	mov	bx,[p_i]
        cmp     [p_t],bx
        ; atualizar posicao da bolinha
        ; checar se o player perdeu
        je      esperar_acao
decodificar:
        mov     word [p_t],bx
	cmp	byte [bx+tecla],pausar
        jne     nao_pausar
        call    freeze
        jmp     fim_decode
nao_pausar:
	cmp	byte [bx+tecla],mov_esq
        jne     outra_tecla1
        jmp     fim_decode
outra_tecla1:
	cmp	byte [bx+tecla],mov_dir
fim_decode:
        jmp     esperar_acao
freeze:
	mov	bx,[p_i]
        cmp     byte [bx+tecla],s_makecode
        jne     freeze
        ret
gameover:
        pop     bx
        pop     ax
        popf
        ret
