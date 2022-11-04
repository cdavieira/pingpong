extern modo_anterior,cores_menu,loading_msg,cor,velBolaX,velBolaY,tecla,jogador_perdeu
extern trocar_int9,restaurar_int9,menu,gameloop,pintar_fundo,msg_fim,p_t,p_i

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
	; alterar modo de video para grafico 640x480 16 cores
	mov	word ax,0012h
	int	10h
        mov     byte [cores_menu],1
        mov     byte [cores_menu+1],vermelho ; modo 0 
        mov     byte [cores_menu+2],verde ; modo 1 
        mov     byte [cores_menu+3],vermelho ; modo 2
        call	menu ; iniciando cena do menu
        mov     word [velBolaX],-1*bolaVel ; configurando velocidade x inicial
        mov     word [velBolaY],bolaVel ; configurando velocidade y inicial
        cmp     byte [cores_menu],0ffh ; caso a tecla q tenha sido pressionada durante o menu
        je      fecharr_jogo
        xor     cx,cx
        mov     cl,[cores_menu]
mudar_velocidade:
        sub     word [velBolaX],dificultar
        add     word [velBolaY],dificultar
        loop    mudar_velocidade
jogar:
	mov	word ax,0012h
	int	10h ; apagando menu
        xor     ax,ax
        mov     ax,cor_fundo
        cmp     ax,preto
        je      nao_colorir
        xor     ax,ax
        mov     ax,loading_msg
        push    ax
        mov     ax,000ah
        push    ax
        call    pintar_fundo ; carregando cor de fundo, se for diferente de preto
nao_colorir:
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

segment stack stack
	resb	512
stacktop:

%include "asm/config.asm"
