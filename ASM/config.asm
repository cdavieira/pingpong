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
cor_fundo       equ     preto

; teclado ibm codigos
j_breakcode     equ     0a4h
j_makecode      equ     024h
k_breakcode     equ     0a5h
k_makecode      equ     025h
q_breakcode     equ     090h
q_makecode      equ     010h
enter_makecode  equ     09ch
enter_breakcode equ     01ch
s_breakcode     equ     08fh
s_makecode      equ     01fh
esc             equ     51h

; configuracoes do menu
caixaW          equ     telaX/7 ; width/largura das caixas
caixaH          equ     telaY/7 ; height/altura das caixas
caixaX          equ     caixaW ; coordenada X da primeira caixa, deve ser menor que 255
caixaY          equ     3*caixaH ; coordenada Y das caixas, deve ser menor que 255
textoX          equ     colunas/7+2 ; coordenada X do primeiro texto ; DEPRECATED
textoY          equ     linhas/2 ; coordenada Y dos textos
tecla_cont      equ     enter_breakcode ; tecla para selecionar modo e continuar jogo
tecla_finalizar equ     q_makecode ; tecla para sair do jogo instantaneamente
pausar          equ     s_breakcode ; tecla para pausar jogo
esquerda_menu   equ     j_breakcode ; tecla para selecionar modo de jogo a esquerda
direita_menu    equ     k_breakcode ; tecla para selecionar modo de jogo a direita

; configuracoes do jogo
mover_esq       equ     j_makecode ; mover o retangulo para a esquerda
mover_dir       equ     k_makecode ; mover o retangula para a direita

; configurações da animação
raio		equ	10	; raio da bolinha
ganho		equ	5	; deslocamento nas direções X e Y
limEX		equ	raio+ganho ; limite esquerdo X (valor mínimo)
limDX		equ	telaX-raio-ganho ; limite direito X (valor máximo)
limSY		equ	telaY-raio-ganho ; limite superior Y (valor máximo)
limIY		equ	raio+ganho ; limite inferior Y (valor mínimo)

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
; q 1090 ; r ???? ; s 1f9f ; t ????
; u ???? ; v 2faf ; w ???? ; x ????
; y ???? ; z ???? ;
; -> e04de0cd ; <- e04be0cb ; ↑ e048e0c8 ; ↓ e050e0d0
; enter 1c9c ; esc 0181 ; shift ; ctrl ; space 39b9 ; alt 38b8
; REFS: https://web.archive.org/web/20090206085854/http://download.microsoft.com/download/1/6/1/161ba512-40e2-4cc9-843a-923143f3456c/translate.pdf
