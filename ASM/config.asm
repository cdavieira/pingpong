; configuracoes do menu
tecla_sair	equ	51h ; tecla Q
coluninha	equ	14h

; configurações da animação
telaX		equ	640	; comprimento da tela
telaY		equ	480	; altura da tela
raio		equ	10	; raio da bolinha
ganho		equ	5	; deslocamento nas direções X e Y
limEX		equ	raio+ganho ; limite esquerdo X (valor mínimo)
limDX		equ	telaX-raio-ganho ; limite direito X (valor máximo)
limSY		equ	telaY-raio-ganho ; limite superior Y (valor máximo)
limIY		equ	raio+ganho ; limite inferior Y (valor mínimo)

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

; interrupcao teclado
kb_data 	equ 	60h  ; porta de leitura de teclado
kb_ctl  	equ 	61h  ; porta de reset para pedir nova interrupcao
pictrl  	equ 	20h
eoi	 	equ 	20h
int9		equ 	9h
