extern modo_anterior,trocar_int9,restaurar_int9,menu,cores_menu,velocidade,gameloop,pintar_fundo,loading_msg,cor

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
        call	menu
        cmp     byte [cores_menu],0ffh
        je      fecharr_jogo
        mov     cl,byte [cores_menu]
        and     cx,00ffh
        cmp     cx,0
        jz      jogar
mudar_velocidade:
        sub     byte [velocidade],20
        loop    mudar_velocidade
jogar:
	mov	word ax,0012h
	int	10h ; apagando menu
        xor     ax,ax
        mov     ax,cor_fundo
        cmp     ax,preto
        je      nao_colorir
        xor     ax,ax ; carregando cor de fundo, se for diferente de preto
        mov     ax,loading_msg
        push    ax
        mov     ax,000ah
        push    ax
        call    pintar_fundo
nao_colorir:
	call	gameloop

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
