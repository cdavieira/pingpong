global rect
extern cor,line

; Desenha um retangulo na tela dada coordenada inicial (canto inferior esquerdo), largura, altura e cor
; Fica ao encargo do programador garantir que as coordenadas dos pontos do retangulo estejam nos limites da tela!
; Pilha antes da chamada:
    ; cor   (word) <- bp+16
    ; largura (word) <- bp+14
    ; altura (word) <- bp+12
    ; coordenada X (word) <- bp+10
    ; coordenada Y (word) <- bp+8
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
