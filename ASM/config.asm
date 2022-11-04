; código de cores
preto		equ	0
azul		equ	1
verde		equ	2
cyan		equ	3
vermelho	equ	4
magenta		equ	5
marrom		equ	6
branco		equ	7
cinza		equ	8
azul_claro	equ	9
verde_claro	equ	10
cyan_claro	equ	11
rosa		equ	12
magenta_claro	equ	13
amarelo		equ	14
branco_intenso	equ	15

; configuracoes gerais
telaX		equ	640	; comprimento da tela em pixels
telaY		equ	480	; altura da tela em pixels
colunas         equ     74      ; numero de colunas (localizacao do cursor)
linhas          equ     30      ; numero de linhas (localizacao do cursor)
cor_fundo       equ     rosa

; teclado ibm codigos
j_breakcode     equ     0a4h
j_makecode      equ     024h
k_breakcode     equ     0a5h
k_makecode      equ     025h
q_breakcode     equ     090h
q_makecode      equ     010h
enter_makecode  equ     09ch
enter_breakcode equ     01ch
s_breakcode     equ     09fh
s_makecode      equ     01fh
v_makecode      equ     02fh
v_breakcode     equ     0afh
r_makecode      equ     013h
esc             equ     51h

; configuracoes do menu
caixaW          equ     telaX/7 ; width/largura das caixas
caixaH          equ     telaY/7 ; height/altura das caixas
caixaX          equ     caixaW ; coordenada X (pixels) da primeira caixa, deve ser menor que 255
caixaY          equ     3*caixaH ; coordenada Y (pixels) das caixas, deve ser menor que 255
textoX          equ     025h ; coordenada X dos textos centrais (em colunas e nao em pixels)
textoY          equ     linhas/2 ; coordenada Y dos textos centrais (em linhas e nao em pixels)
tecla_cont      equ     enter_breakcode ; tecla para selecionar modo e continuar jogo
esquerda_menu   equ     j_breakcode ; tecla para selecionar modo de jogo a esquerda
direita_menu    equ     k_breakcode ; tecla para selecionar modo de jogo a direita

; configuracoes do jogo
tecla_finalizar equ     q_makecode ; tecla para sair do jogo instantaneamente
pausar          equ     s_makecode ; tecla para pausar jogo
reiniciar       equ     r_makecode ; tecla para reiniciar jogo
mover_esq       equ     j_makecode ; mover o retangulo para a esquerda
mover_dir       equ     k_makecode ; mover o retangula para a direita
aux_key1        equ     v_makecode ; chave de controle temporaria para certas situacoes ; nao afeta jogo
aux_key2        equ     v_breakcode ; chave de controle temporaria para certas situacoes ; nao afeta jogo

; configurações da animação
raio		equ	10	; raio da bolinha
bolaVel		equ	3	; deslocamento nas direções X e Y
retH            equ     20 ; altura do retangulo
retW            equ     40 ; largura do retangulo
limEX		equ	raio+bolaVel+2 ; limite esquerdo X (valor mínimo) ; +2: +1 borda do jogo +1 borda do circulo
limDX		equ	telaX-raio-bolaVel-2 ; limite direito X (valor máximo) ; +2: +1 borda do jogo +1 borda do circulo
limSY		equ	telaY-raio-bolaVel-2 ; limite superior Y (valor máximo)
limIY		equ	retH+raio+bolaVel ; limite inferior Y (valor mínimo)
retCor          equ     azul
retBorda        equ     preto ; cor da borda do retangulo
retVel          equ     15 ; velocidade do retangulo
bolaCor         equ     verde
bolaBorda       equ     preto ; cor da borda da bola
minRetX         equ     retW/2+retVel
maxRetX         equ     telaX-retW/2-1-retVel
dificultar      equ     2

; interrupcao teclado
kb_data 	equ 	60h  ; porta de leitura de teclado
kb_ctl  	equ 	61h  ; porta de reset para pedir nova interrupcao
pictrl  	equ 	20h
eoi	 	equ 	20h
int9		equ 	9h

; OUTROS
; CODIGOS TECLADO IBM
; 0 ???? ; 1 ???? ; 2 ???? ; 3 ????
; 4 ???? ; 5 ???? ; 6 ???? ; 7 ????
; 8 ???? ; 9 ????
; a 1e9e ; b 30b0 ; c 2eae ; d 20a0
; e 1292 ; f 21a1 ; g 22a2 ; h 23a3
; i 1797 ; j 24a4 ; k 25a5 ; l 26a6
; m 32b2 ; n ???? ; o ???? ; p ????
; q 1090 ; r 1393 ; s 1f9f ; t ????
; u ???? ; v 2faf ; w ???? ; x ????
; y ???? ; z ???? ;
; -> e04de0cd ; <- e04be0cb ; ↑ e048e0c8 ; ↓ e050e0d0
; enter 1c9c ; esc 0181 ; shift ; ctrl ; space 39b9 ; alt 38b8
; REFS: https://web.archive.org/web/20090206085854/http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
