global gameloop
extern p_i,p_t,tecla,cor,canMoveRet,pause_msg,bolaY,retX
extern janela,line,pintar_frame

gameloop:
        pushf
        push    ax
        push    bx
frame_inicial:
        call    janela ; desenhando contorno
        xor     ax,ax
        mov     al,[cor]
        push    ax ; guardando a cor antiga
        mov     byte [cor],cor_fundo
        xor     ax,ax
        push    ax ; carregando x do ponto inicial (0)
        push    ax ; carregando y do ponto inicial (0)
        mov     ax,telaX-1
        push    ax ; carregando x do ponto final (telaX-1)
        xor     ax,ax
        push    ax ; carregando y do ponto final (0)
        call    line ; apagando borda branca inferior
esperar_acao:
        call    pintar_frame
        mov     byte [canMoveRet],0
loop3:
        mov     ax,[bolaY]
        sub     ax,raio
        cmp     ax,retH
        jl      gameover ; termina se o ponto inferior do circulo tiver passado da borda/altura do retangulo
        call    pintar_frame
        ; CHECAR SE O PLAYER PERDEU
	mov	bx,[p_i]
        cmp     [p_t],bx
        je      loop3
decodificar:
        mov     word [p_t],bx
	cmp	byte [bx+tecla],tecla_finalizar
        je      gameover
	cmp	byte [bx+tecla],pausar
        jne     nao_pausar
        ; TALVEZ COLOCAR AQUI PARA EXIBIR UMA MENSAGEM DE PAUSE NA TELA
        call    freeze
        mov     byte [bx+tecla],aux_key2
        jmp     fim_decode
nao_pausar:
	cmp	byte [bx+tecla],mover_esq
        jne     outra_tecla1
        cmp     word [retX],minRetX ; checando se a posicao do ret pode ser atualizada ou nao
        jg      mover_ret ; signed
        jmp     fim_decode
outra_tecla1:
	cmp	byte [bx+tecla],mover_dir
        jne     fim_decode
        cmp     word [retX],maxRetX ; checando se a posicao do ret pode ser atualizada ou nao
        jl      mover_ret ; signed
        jmp     fim_decode
mover_ret:
        mov     byte [canMoveRet],1
fim_decode:
        jmp     esperar_acao
gameover:
        pop     ax
        mov     [cor],al ; recuperando cor antiga
        pop     bx
        pop     ax
        popf
        ret
freeze:
        mov     word [bx+tecla],aux_key1
stuck:
	mov	bx,[p_i]
        cmp     byte [bx+tecla],pausar
        jne     stuck
        ret

%include "asm/config.asm"
