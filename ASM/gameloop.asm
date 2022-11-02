global gameloop
extern  p_i,p_t,velocidade,tecla,janela,rect,cor,line

gameloop:
        pushf
        push    ax
        push    bx
frame_inicial:
        call    janela ; desenhando contorno
        xor     ax,ax
        mov     al,[cor]
        push    ax
        mov     byte [cor],cor_fundo ; apagando borda branca inferior
        xor     ax,ax
        push    ax ; carregando x do ponto inicial (0)
        push    ax ; carregando y do ponto inicial (0)
        mov     ax,telaX-1
        push    ax ; carregando x do ponto final (telaX-1)
        xor     ax,ax
        push    ax ; carregando y do ponto final (0)
        call    line
        ; testar frect
esperar_acao:
	mov	bx,[p_i]
        cmp     [p_t],bx
        ; atualizar posicao da bolinha
        ; checar se o player perdeu
        je      esperar_acao
decodificar:
        mov     word [p_t],bx
	cmp	byte [bx+tecla],tecla_finalizar
        je      gameover
	cmp	byte [bx+tecla],pausar
        jne     nao_pausar
        ; TALVEZ COLOCAR AQUI PARA EXIBIR UMA MENSAGEM DE PAUSE NA TELA
        call    freeze
        jmp     fim_decode
nao_pausar:
	cmp	byte [bx+tecla],mover_esq
        jne     outra_tecla1
        jmp     fim_decode
outra_tecla1:
	cmp	byte [bx+tecla],mover_dir
fim_decode:
        jmp     esperar_acao
freeze:
	mov	bx,[p_i]
        cmp     byte [bx+tecla],s_makecode
        jne     freeze
        ret
gameover:
        pop     ax
        mov     [cor],al
        pop     bx
        pop     ax
        popf
        ret

%include "asm/config.asm"
