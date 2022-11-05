global gameloop,msg_fim
extern p_i,p_t,tecla,cor,canMoveRet,velBolaX,velBolaY,bolaY,bolaX,retX,gameover_msg,jogador_perdeu
extern janela,line,pintar_frame,frect

gameloop:
        pushf
        push    ax
        push    bx
        xor     ax,ax
        mov     al,[cor]
        push    ax ; guardando a cor antiga
frame_inicial:
        call    apagar_msg ; apagando texto "loading..."
        call    frame_jogo ; desenhando janela do jogo
esperar_acao:
        call    pintar_frame
        mov     byte [canMoveRet],0
loop3:
        mov     ax,[bolaY]
        sub     ax,raio
        cmp     ax,retH
        jl      gameover ; termina se o ponto inferior do circulo tiver passado da borda/altura do retangulo
        call    pintar_frame
	mov	bx,[p_i]
        cmp     [p_t],bx
        je      loop3
decodificar:
        mov     word [p_t],bx
	cmp	byte [bx+tecla],tecla_finalizar
        je      player_quit
	cmp	byte [bx+tecla],pausar
        jne     nao_pausar
        jmp     freeze
break_freeze:
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
freeze:
        mov     word [bx+tecla],aux_key1
stuck:
	mov	bx,[p_i]
        cmp     byte [bx+tecla],tecla_finalizar
        je      player_quit
        cmp     byte [bx+tecla],pausar
        jne     stuck
        jmp     break_freeze
mover_ret:
        mov     byte [canMoveRet],1
fim_decode:
        jmp     esperar_acao
gameover:
        call    msg_fim
        mov     byte[jogador_perdeu],1
player_quit:
        pop     ax
        mov     [cor],al ; recuperando cor antiga
        pop     bx
        pop     ax
        popf
        ret

frame_jogo:
        call    janela ; desenhando contorno
        push    ax
        mov     byte [cor],cor_fundo
        xor     ax,ax
        push    ax ; carregando x do ponto inicial (0)
        push    ax ; carregando y do ponto inicial (0)
        mov     ax,telaX-1
        push    ax ; carregando x do ponto final (telaX-1)
        xor     ax,ax
        push    ax ; carregando y do ponto final (0)
        call    line ; apagando borda branca inferior
        pop     ax
        ret

; Apaga porção central da tela onde eh escrito texto
apagar_msg:
        push    ax
        xor     ax,ax
        mov     al,[cor]
        push    ax
        mov     ax,cor_fundo
        push    ax ; passando cor de fundo
        mov     ax,90
        push    ax ; passando largura
        mov     ax,30
        push    ax ; passando altura
        mov     ax,telaX/2-30 ; passando coordenada x do canto inferior esquerdo
        push    ax
        mov     ax,telaY/2-22 ; passando coordenada y do canto inferior esquerdo
        push    ax
        call    frect ; apagando texto anteriormente desenhado no centro da imagem
        pop     ax
        mov     [cor],al
        pop     ax
        ret

msg_fim:
        push    ax
        push    bx
        push    cx
        push    dx
        push    es
        push    bp
        xor     ax,ax
        mov     al,[cor]
        add     ax,2
        mov     bl,0010h
        div     bl
        mov     bl,ah ; cor do texto, que foi configurada para ser diferente da cor do fundo
        mov     cx,51 ; tamanho do texto (hardcoded)
        mov     ax,textoX-20
        mov     ah,textoY
        mov     dx,ax ; dl = coluna, dh = linha
        push    ds
        pop     es ; a string a ser impressa deve ser apontada por ES:BP
        mov     bp,gameover_msg ; a string a ser impressa deve ser apontada por ES:BP
        mov     al,0 ; al = write mode
        mov     ah,13h
        int     10h
        pop     bp
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     ax
        ret

%include "asm/config.asm"
