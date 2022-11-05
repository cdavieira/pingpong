extern modo_anterior,cores_menu,loading_msg,cor,velBolaX,velBolaY
extern limSY,limIY,limEX,limDX,tecla,jogador_perdeu,bolaX,bolaY,retX,canMoveRet
extern trocar_int9,restaurar_int9,menu,gameloop,pintar_fundo,msg_fim,p_t,p_i

extern pintar_frame

segment code
..start:
	; configura segmentos
	mov	ax,seg modo_anterior ; pegando segmento base (data) definido para simbolo "modo_anterior"
	mov	ds,ax
	mov	ax,stack ; nao eh necessario talvez...
	mov	ss,ax ; nao eh necessario talvez...
	mov	sp,stacktop ; nao eh necessario talvez...

	; salvar modo corrente de video
	mov	ah,0Fh
	int	10h
	mov	[modo_anterior],al

        ; alterar interrupcao padrao do teclado
        call    trocar_int9

nova_partida:
        call	menu ; iniciando cena do menu
        cmp     byte [cores_menu],0ffh ; caso a tecla q tenha sido pressionada durante o menu
        je      fecharr_jogo
jogar:
        call    set_default ; definindo configuracoes iniciais do jogo
        call    preparar_fundo ; preparando cor de fundo
	call	gameloop
        cmp     byte [jogador_perdeu],0
        jz      fecharr_jogo
decidindo:
	mov	bx,[p_i]
        cmp     [p_t],bx
        je      decidindo ; stuck in a maze
        mov     [p_t],bx
        cmp     byte [tecla+bx],reiniciar
        je      nova_partida
checar_quit:
        cmp     byte [tecla+bx],tecla_finalizar
        jne     decidindo
fecharr_jogo:
	; restaurar interrupcao padrao do teclado
        call    restaurar_int9
	; recuperar modo de video previo
	mov	ah,0
	mov	al,[modo_anterior]
	int	10h
	; finalizar programa
	mov     ax,4c00h
	int     21h

; Prepara a tela de fundo do jogo (loading screen)
preparar_fundo:
        push    ax
	mov	word ax,0012h
	int	10h ; apagando menu
        xor     ax,ax
        mov     ax,cor_fundo
        cmp     ax,preto
        je      nao_colorir_fundo
        xor     ax,ax
        mov     ax,loading_msg
        push    ax
        mov     ax,000ah
        push    ax
        call    pintar_fundo ; carregando cor de fundo, se for diferente de preto
nao_colorir_fundo:
        pop     ax
        ret

; Configura o jogo com as condicoes iniciais inerentes a velocidade dos objetos, limites da tela e outros
set_default:
        push    ax
        push    bx
        push    cx
        mov     word [velBolaX],-1*bolaVel ; configurando velocidade x inicial
        mov     word [velBolaY],bolaVel ; configurando velocidade y inicial
        xor     cx,cx
        mov     cl,[cores_menu]
mudar_velocidade:
        sub     word [velBolaX],dificultar
        add     word [velBolaY],dificultar
        loop    mudar_velocidade
limites_tela:
        xor     ax,ax
        xor     bx,ax
        mov     ax,[velBolaY]
        cmp     ax,0
        jge     continuar ; caso ax seja positivo, continuar, senao converter para positivo
        neg     ax
continuar:
        add     ax,raio
        mov     bx,telaY-1
        sub     bx,ax
        mov     word [limSY],bx
        xor     bx,bx
        mov     bx,retH
        add     bx,ax
        mov     word [limIY],bx
        mov     word [limEX],ax
        xor     bx,bx
        mov     bx,telaX-1
        sub     bx,ax
        mov     word [limDX],bx
geral:
        mov     word [canMoveRet],1 ; habilitando desenho do retangulo
        mov     word [bolaX],telaX/2 ; configurando coordenadas iniciais da bola
        mov     word [bolaY],telaY/2 ; configurando coordenadas iniciais da bola
        mov     word [retX],telaX/2 ; configurando coordenadas iniciais do jogador
        mov     byte [jogador_perdeu],0 ; resetando status de derrota do jogador
        pop     cx
        pop     bx
        pop     ax
        ret

segment stack stack
	resb	512
stacktop:

%include "asm/config.asm"
