global modo_anterior,cor,deltax,deltay
global velBolaX,velBolaY,velRetX,bolaX,bolaY,retX,canMoveRet,jogador_perdeu
global cs_dos,offset_dos,tecla,p_i,p_t
global facil_msg,medio_msg,dificil_msg,cores_menu,loading_msg,gameover_msg

segment data

; animacao
modo_anterior	db	0
cor		db	branco_intenso
canMoveRet      db      1 ; controla renderizacao do retangulo do jogador
deltax		dw      0
deltay		dw      0
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
gameover_msg    db      "Game over! Digite q para fechar ou r para reiniciar"
cores_menu      db      1,vermelho,verde,vermelho ; [cores_menu+0] guarda o modo atualmente selecionado (0 - facil, 1 - medio e 2 - dif)
jogador_perdeu  db      0

%include "asm/config.asm"
