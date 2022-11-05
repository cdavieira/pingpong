global rect,frect,rectPretty,smart_rect
extern cor,line

; Desenha um retangulo na tela dada coordenada inicial (canto inferior esquerdo), largura, altura e cor
; Fica ao encargo do programador garantir que as coordenadas dos pontos do retangulo estejam nos limites da tela!
; Pilha antes da chamada:
    ; cor   (word) <- bp+16 (push)
    ; largura (word) <- bp+14 (push)
    ; altura (word) <- bp+12 (push)
    ; coordenada X (word) <- bp+10 (push)
    ; coordenada Y (word) <- bp+8 (push)
    ; endereço de retorno <- bp+6
    ; ax <- bp+4
    ; bx <- bp+2
    ; bp <- bp
rect:
        push    ax
        push    bx
        push    bp
        mov     bp,sp
        xor     ax,ax
        mov     ax,[bp+16]
        mov     byte [cor],al
margem_esq:
        mov     ax,[bp+10]
        push    ax
        mov     bx,[bp+8]
        push    bx
        push    ax
        add     bx,[bp+12]
        push    bx
        call    line
margem_dir:
        push    ax
        push    bx
        add     ax,[bp+14]
        push    ax
        push    bx
        call    line
margem_top:
        push    ax
        push    bx
        push    ax
        sub     bx,[bp+12]
        push    bx
        call    line
margem_bot:
        push    ax
        push    bx
        sub     ax,[bp+14]
        push    ax
        push    bx
        call    line
        pop     bp
        pop     bx
        pop     ax
        ret     10

; Desenha um retangulo pintado na tela dada coordenada inicial (canto inferior esquerdo), largura, altura e cor
; Fica ao encargo do programador garantir que as coordenadas dos pontos do retangulo estejam nos limites da tela!
; Pilha durante execucao:
    ; cor   (word) <- bp+16 (push)
    ; largura (word) <- bp+14 (push)
    ; altura (word) <- bp+12 (push)
    ; coordenada X (word) <- bp+10 (push)
    ; coordenada Y (word) <- bp+8 (push)
    ; endereço de retorno <- bp+6
    ; ax <- bp+4
    ; bx <- bp+2
    ; bp <- bp
    ; cx <- bp-2
    ; dx <- bp-4
frect:
        push    ax
        push    bx
        push    bp
        mov     bp,sp
        push    cx
        push    dx
        xor     ax,ax
        mov     ax,[bp+16]
        mov     byte [cor],al
        mov     ax,[bp+10]
        mov     bx,[bp+8]
        mov     cx,[bp+14]
pintar_frect:
        mov     dx,ax
        add     dx,cx
        push    dx ; x inicial = x ponto inicial + indice linha (cx)
        push    bx ; y inicial = y ponto inicial
        push    dx ; x final = x ponto inicial + indice linha (cx)
        mov     dx,bx
        add     dx,[bp+12] ; y final = y inicial + altura do retangulo
        push    dx
        call    line
        loop    pintar_frect
        pop     dx
        pop     cx
        pop     bp
        pop     bx
        pop     ax
        ret     10

; Desenha um retangulo pintado e bordado na tela dada coordenada inicial (canto inferior esquerdo), largura, altura, cor de fundo e cor de borda
; Fica ao encargo do programador garantir que as coordenadas dos pontos do retangulo estejam nos limites da tela!
; Pilha durante execucao:
    ; cor de borda (word) <- bp+14 (push)
    ; cor de fundo (word) <- bp+12 (push)
    ; largura (word) <- bp+10 (push)
    ; altura (word) <- bp+8 (push)
    ; coordenada X (word) <- bp+6 (push)
    ; coordenada Y (word) <- bp+4 (push)
    ; endereço de retorno <- bp+2
    ; bp <- bp
rectPretty:
        push    bp
        mov     bp,sp
        push    word [bp+12]
        push    word [bp+10]
        push    word [bp+8]
        push    word [bp+6]
        push    word [bp+4]
        call    frect
        push    word [bp+14]
        push    word [bp+10]
        push    word [bp+8]
        push    word [bp+6]
        push    word [bp+4]
        call    rect
        pop     bp
        ret     12

; Redesenha apenas as linhas necessarias para mover o retangulo do jogador na tela. Melhora a qualidade de desenho do retangulo drasticamente.
; Parametros: coordenada X antiga (bp+6), coordenada X nova (bp+4)
smart_rect:
        push    bp
        mov     bp,sp
        pushf
        push    cx
        mov     cx,[bp+6]
        sub     cx,[bp+4]
        cmp     cx,0
        jz      fim_smartrect1 ; "gambiarra" para lidar com excesso de limite do (short) jump
        push    ax
        push    bx
        push    dx
        mov     bx,0 ; nao pode usar xor para limpar bx aqui, pois ele mexe com a flag CF usada pela instrucao js
        mov     ax,0 ; nao pode usar xor para limpar ax aqui, pois ele mexe com a flag CF usada pela instrucao js
        mov     dx,0 ; nao pode usar xor para limpar dx aqui, pois ele mexe com a flag CF usada pela instrucao js
        mov     al,[cor]
        push    ax
        js      retToRight ; cx eh negativo, deve ser convertido para positivo para ser usado no loop
        ; retToLeft code
        mov     ax,cor_fundo
        push    ax
        mov     ax,retCor
        push    ax
        mov     dx,-1
        jmp     desenhar_esq
retToRight:
        neg     cx
        mov     ax,retCor
        push    ax
        mov     ax,cor_fundo
        push    ax
        mov     dx,1
desenhar_esq:
        pop     ax
        mov     [cor],al ; obtendo cor das linhas do lado esquerdo
        push    cx ; guardando o numero de linhas a serem desenhadas
        mov     bx,[bp+6]
        sub     bx,retW/2 ; obtendo coordenada x do lado esquerdo do retangulo antigo
loop10:
        push    bx ; x0
        xor     ax,ax ; ax funciona como a coordenada y do lado esquerdo do retangulo antigo
        push    ax ; y0
        push    bx ; x1
        mov     ax,retH
        push    ax ; y1
        call    line
        add     bx,dx
        loop    loop10
desenhar_dir:
        pop     cx ; reobtendo o numero de linhas a serem desenhadas
        pop     ax ; obtendo a cor das linhas do lado direito
        mov     [cor],al ; obtendo cor das linhas do lado direito
        xor     bx,bx
        mov     bx,retW/2
        add     bx,[bp+6] ; obtendo coordenada x do lado direito do retangulo antigo
loop11:
        push    bx ; x0
        xor     ax,ax ; ax funciona como a coordenada y do lado direito do retangulo antigo
        push    ax ; y0
        push    bx ; x1
        mov     ax,retH
        push    ax ; y1
        call    line
        add     bx,dx
        loop    loop11
        jmp     desenhar_contorno
fim_smartrect1:
        jmp     fim_smartrect
desenhar_contorno:
        mov     dx,[bp+6]
        sub     dx,[bp+4]
        mov     byte [cor],retBorda
        ; borda esq
        xor     bx,bx
        mov     bx,retW/2
        sub     bx,[bp+4] ; obtendo coordenada x do lado esquerdo do retangulo antigo
        push    bx
        xor     ax,ax
        push    ax
        push    bx
        mov     ax,retH
        push    ax
        call    line
        ; borda dir
        xor     bx,bx
        mov     bx,retW/2
        add     bx,[bp+4] ; obtendo coordenada x do lado direito do retangulo antigo
        push    bx
        xor     ax,ax
        push    ax
        push    bx
        mov     ax,retH
        push    ax
        call    line
        ; borda esq e dir
        cmp     dx,0
        js      toright
        ; toleft
        mov     bx,[bp+4]
        sub     bx,retW/2
        jmp     bordas_ed ; bordas esquerda e direita
toright:
        neg     dx
        mov     bx,[bp+6]
        add     bx,retW/2
bordas_ed:
        push    bx ; x0
        xor     ax,ax
        push    ax ; y0
        add     bx,dx
        push    bx ; x1
        push    ax ; y1
        call    line
        sub     bx,dx
        push    bx ; x0
        mov     ax,retH
        push    ax ; y0
        add     bx,dx
        push    bx ; x1
        push    ax ; y1
        call    line
        ; recuperando contexto
        pop     ax
        mov     [cor],al
        pop     dx
        pop     bx
        pop     ax
fim_smartrect:
        pop     cx
        popf
        pop     bp
        ret     4

%include "asm/config.asm"
