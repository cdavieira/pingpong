global rect,frect,rectPretty
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
