global modo_anterior,cor,deltax,deltay
global velocidade,velBolaX,velBolaY,velRetX,bolaX,bolaY,retX,canMoveRet
global cs_dos,offset_dos,tecla,p_i,p_t
global facil_msg,medio_msg,dificil_msg,cores_menu,loading_msg,pause_msg

segment data

; animacao
modo_anterior	db	0
cor		db	branco_intenso
canMoveRet      db      1 ; controla renderizacao do retangulo do jogador
deltax		dw      0
deltay		dw      0
velocidade	dw	80h ; duração de cada frame da animação
velBolaX 	dw	-1*bolaVel ; ganho na direção x (valor variável)
velBolaY	dw	bolaVel	 ; ganho na direção y (valor variável)
velRetX         dw      retVel
bolaX           dw      telaX/2 ; coordenada X do ponto central do circulo
bolaY           dw      telaY/2 ; coordenada Y do ponto central do circulo
retX            dw      telaX/2 ; coordenada X do ponto central do retangulo

; teclado
cs_dos		dw	1
offset_dos	dw	1
tecla		resb	8
p_i		dw	0   ; ponteiro p/ int (qnd pressiona tecla)
p_t		dw	0   ; ponterio p/ int (qnd solta tecla)

; menu
facil_msg       db      "facil"
medio_msg       db      "medio"
dificil_msg     db      "dificil"
loading_msg     db      "loading..."
pause_msg       db      "jogo pausado"
cores_menu      db      0,verde,vermelho,vermelho ; [cores_menu+0] guarda o modo atualmente selecionado (0 - facil, 1 - medio e 2 - dif)

%include "asm/config.asm"
