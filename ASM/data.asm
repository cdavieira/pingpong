global modo_anterior,cor,deltax,deltay,velocidade,ganhoX,ganhoY,cs_dos,offset_dos,tecla_u,tecla,p_i,p_t,teclasc,facil_msg,medio_msg,dificil_msg,cores_menu,caixa_verde

segment data

; animacao
modo_anterior	db	0
cor		db	branco_intenso
deltax		dw      0
deltay		dw      0
linha		dw	0
coluna		dw	0
velocidade	dw	80h ; duração de cada frame da animação
ganhoX 		dw	-1*ganho ; ganho na direção x (valor variável)
ganhoY		dw	ganho	 ; ganho na direção y (valor variável)
coordX          dw      telaX/2
coordY          dw      telaY/2

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
cores_menu      db      0,verde,vermelho,vermelho ; [cores_menu+0] guarda o modo atualmente selecionado (0 - facil, 1 - medio e 2 - dif)

%include "asm/config.asm"
