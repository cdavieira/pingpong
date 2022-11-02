global animation
extern full_circle,cor,velBolaY,velBolaX,delay,modo_anterior

; descrição
; A função animation desenha os frames da animação de um circulo vermelho que quica pelas paredes sob um angulo de 45 graus.
; Para isso, internamente são passados 8 valores a cada frame para a stack (ordem com que os valores são inseridos na stack):
; 1º push: coordenada x atual do centro do circulo
; 2º push: coordenada y atual do centro do circulo
; 3º push: coordenada x atual do centro do circulo
; 4º push: coordenada y atual do centro do circulo
; 5º push: raio do circulo
; 6º push: coordenada x atual do centro do circulo
; 7º push: coordenada y atual do centro do circulo
; 8º push: raio do circulo
; Os valores 8, 7 e 6 servirão de parâmetros para a função full_circle, que desenhara o circulo vermelho na tela
; Os valores 5, 4 e 3 servirão de parâmetros para outra chamada a função full_circle, que apagara o circulo vermelho previamente desenhado ao desenhar na mesma posição anterior um circulo com a mesma cor de fundo da tela
; Os valores 2 e 1 servirão para atualizar as coordenadas atuais com os valores armazenados em velBolaY e velBolaX, respectivamente
; Após desenhar um frame, todos os valores previamente passados para a stack ja foram removidos, de modo que no retorno da função não restam nenhum valor adicionado na stack.
animation:
        ret
	; frame inicial
	mov byte[cor],vermelho
	mov word ax,telaX/2
	push ax
	mov word ax,telaY/2
	push ax
	mov word ax,telaX/2
	push ax
	mov word ax,telaY/2
	push ax
	mov word ax,raio
	push ax
	mov word ax,telaX/2
	push ax
	mov word ax,telaY/2
	push ax
	mov word ax,raio
	push ax
render_frame:
	mov byte[cor],vermelho
	call full_circle ; desenhando frame
	call delay	 ; fazendo o frame persistir na tela por um certo tempo
	mov byte[cor],preto ; mudando cor do circulo para a mesma que a de fundo
	call full_circle ; apagando o circulo vermelho com um circulo da mesma cor que o fundo
	pop ax ; obtendo y
	cmp ax,limIY ; testando limite inferior de Y
	jle  mudar_sentidoY
	cmp ax,limSY ; testando limite superior de Y
	jge  mudar_sentidoY
	jmp nao_mudar_sentidoY
mudar_sentidoY:
	neg  word [velBolaY]
nao_mudar_sentidoY:
	mov bx,ax ; store y
	pop ax ; obtendo x
	cmp ax,limEX ; testando limite esquerdo de X
	jle  mudar_sentidoX
	cmp ax,limDX ; testando limite direito de X
	jge mudar_sentidoX
	jmp nao_mudar_sentidoX
mudar_sentidoX:
	neg  word [velBolaX]
nao_mudar_sentidoX:
	add ax,word [velBolaX]
	push ax
	add bx,word [velBolaY]
	push bx ; atualizando valores para que o proximo frame seja desenhado
	push ax
	push bx
	mov dx,raio
	push dx
	push ax
	push bx
	push dx
parar:
	; desempilhar os parametros que ainda estao na pilha
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	pop ax
	ret

%include "asm/config.asm"
