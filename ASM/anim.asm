global anim_bola,anim_ret,pintar_frame
extern cor,velBolaY,velBolaX,delay,retX,bolaX,bolaY,canMoveRet,velRetX,tecla,p_t
extern circPretty,rectPretty,full_circle

; A função anim_bola atualiza a posicao do circulo em movimento, que quica pelas paredes sob um angulo de 45 graus.
anim_bola:
        push    ax
        push    bx
        push    dx
        mov     ax,[bolaY]
        mov     bx,[bolaX]
        cmp     ax,limSY
        jge     mudar_sentidoY
        cmp     ax,limIY
        jg      nao_mudar_sentidoY
        xor     dx,dx
        mov     dx,[retX] ; assumindo que a posicao do retX nunca excedera os limites da tela
        sub     dx,retW/2
        sub     dx,raio
        cmp     bx,dx; checando se a bola toca o retangulo
        jl      nao_mudar_sentidoY
        xor     dx,dx
        mov     dx,[retX] ; assumindo que a posicao do retX nunca excedera os limites da tela
        add     dx,retW/2
        add     dx,raio
        cmp     bx,dx
        jg      nao_mudar_sentidoY
mudar_sentidoY:
	neg     word [velBolaY]
nao_mudar_sentidoY:
	cmp	bx,limEX ; testando limite esquerdo de X
	jle	mudar_sentidoX
	cmp	bx,limDX ; testando limite direito de X
	jle	nao_mudar_sentidoX
mudar_sentidoX:
	neg     word [velBolaX]
nao_mudar_sentidoX:
	add	ax,word [velBolaY]
	add	bx,word [velBolaX]
        mov     [bolaY],ax
        mov     [bolaX],bx
parar:
        pop     dx
        pop     bx
        pop     ax
	ret

; A função anim_ret atualiza a posicao do retangulo do jogador
anim_ret:
        push    ax
        mov     ax,[retX]
        cmp     ax,minRetX
        jle     disable_leftkey
        cmp     ax,maxRetX
        jg      disable_rightkey
        jmp     checar_ambas
disable_leftkey:
        call    rightkey_action
        jmp     parar1
disable_rightkey:
        call    leftkey_action
        jmp     parar1
checar_ambas:
        call    leftkey_action
        call    rightkey_action
parar1:
        pop     ax
	ret

; controla a renderizacao sujeita a acao de mover o retangulo do jogador para esquerda
leftkey_action:
        push    bx
        push    ax
        mov     bx,[p_t]
        cmp     byte [tecla+bx],mover_esq
        je      checar_sentido_esq
        jmp     parar2
checar_sentido_esq:
        cmp     word [velRetX],0
        jns     mudar_sentidoX1
        jmp     nao_mudar_sentidoX1
mudar_sentidoX1:
	neg     word [velRetX]
nao_mudar_sentidoX1:
        mov     ax,[retX]
	add	ax,word [velRetX]
        mov     [retX],ax
parar2:
        pop     ax
        pop     bx
        ret

; controla a renderizacao sujeita a acao de mover o retangulo do jogador para direita
rightkey_action:
        push    bx
        push    ax
        mov     bx,[p_t]
        cmp     byte [tecla+bx],mover_dir
        je      checar_sentido_dir
        jmp     parar3
checar_sentido_dir:
        cmp     word [velRetX],0
        js      mudar_sentidoX2
        jmp     nao_mudar_sentidoX2
mudar_sentidoX2:
	neg     word [velRetX]
nao_mudar_sentidoX2:
        mov     ax,[retX]
	add	ax,word [velRetX]
        mov     [retX],ax
parar3:
        pop     ax
        pop     bx
        ret

; Desenha na tela o retangulo do jogador de acordo com suas coordenadas atuais
pintar_ret:
        push    ax
        xor     ax,ax
        push    ax ; carregando cor da borda do retangulo
        mov     al,retCor
        push    ax ; carregando cor do retangulo
        mov     ax,retW
        push    ax ; carregando largura do retangulo
        mov     ax,retH
        push    ax ; carregando altura do retangulo
        mov     ax,[retX]
        sub     ax,retW/2
        push    ax ; carregando coordenada x do canto inferior esquerdo do retangulo
        xor     ax,ax
        push    ax ; carregando coordenada y do canto inferior esquerdo do retangulo
        call    rectPretty
        pop     ax
        ret

apagar_ret:
        push    ax
        xor     ax,ax
        mov     ax,cor_fundo
        push    ax ; carregando cor da borda do retangulo
        mov     al,cor_fundo
        push    ax ; carregando cor do retangulo
        mov     ax,retW
        push    ax ; carregando largura do retangulo
        mov     ax,retH
        push    ax ; carregando altura do retangulo
        mov     ax,[retX]
        sub     ax,retW/2
        push    ax ; carregando coordenada x do canto inferior esquerdo do retangulo
        xor     ax,ax
        push    ax ; carregando coordenada y do canto inferior esquerdo do retangulo
        call    rectPretty
        pop     ax
        ret

; Desenha na tela a bola de acordo com suas coordenadas atuais
pintar_bola:
        push    ax
        xor     ax,ax
        mov     al,bolaBorda
        push    ax ; carregando cor da borda do circulo
        mov     al,bolaCor
        push    ax ; carregando cor de fundo do circulo
        mov     ax,[bolaX]
        push    ax ; carregando coordenada x inicial do circulo
        xor     ax,ax
        mov     ax,[bolaY]
        push    ax ; carregando coordenada y inicial do circulo
        xor     ax,ax
        mov     ax,raio
        push    ax ; carregando raio do circulo
        call    circPretty
        pop     ax
        ret

apagar_bola:
        push    ax
        xor     ax,ax
        mov     al,cor_fundo
        push    ax ; carregando cor da borda do circulo
        mov     al,cor_fundo
        push    ax ; carregando cor de fundo do circulo
        mov     ax,[bolaX]
        push    ax ; carregando coordenada x inicial do circulo
        xor     ax,ax
        mov     ax,[bolaY]
        push    ax ; carregando coordenada y inicial do circulo
        xor     ax,ax
        mov     ax,raio
        push    ax ; carregando raio do circulo
        call    circPretty
        pop     ax
        ret

; Pinta na tela o circulo e o retangulo do jogador de acordo com suas coordenadas atuais. O retangulo eh apenas atualizado caso o jogador tenha movido
pintar_frame:
        cmp     byte [canMoveRet],0
        jz      nao_att_ret
        call    apagar_ret
        call    anim_ret
        call    pintar_ret
nao_att_ret:
        call    apagar_bola
        call    anim_bola
        call    pintar_bola
        ret

apagar_frame:
        call    apagar_ret
        call    apagar_bola
        ret

%include "asm/config.asm"
