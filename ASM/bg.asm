global pintar_fundo
extern cor,line

; Pinta o fundo do jogo com a cor definida na variavel cor_fundo no arquivo config.asm
; Parametros: ponteiro para mensagem (bp+6) e tamanho da mensagem (bp+4)
pintar_fundo:
        push    bp
        mov     bp,sp
        push    cx
        push    ax
        xor     ax,ax
        mov     al,byte [cor]
        push    ax ; guardando cor anteriormente guardada na var. cor
mensagem:
        ; imprimir mensagem de carregamento
        push    bp
        push    bx
        push    dx
        push    es
        mov     ax,cor_fundo
        add     ax,2
        mov     bx,0010h
        div     bl
        xor     bx,bx ; bh = numero da pagina, bl = cor
        mov     bl,ah ; ah = resto da divisao anterior
        mov     cx,[bp+4]; numero de caracteres da string
        mov     ax,025h
        mov     ah,textoY
        mov     dx,ax ; dl = coluna, dh = linha
        push    ds
        pop     es ; a string a ser impressa deve ser apontada por ES:BP
        mov     bp,[bp+6] ; a string a ser impressa deve ser apontada por ES:BP
        mov     al,0 ; al = write mode
        mov     ah,13h
        int     10h
        pop     es
        pop     dx
        pop     bx
        pop     bp
        mov     byte [cor],cor_fundo
        mov     cx,telaX-1
colorir:
        push    cx ; coordenada X do ponto inicial
        xor     ax,ax
        push    ax ; coordenada Y do ponto inicial (0)
        push    cx ; coordenada X do ponto final
        xor     ax,ax
        mov     ax,telaY-1
        push    ax ; coordenada Y do ponto final (altura da tela)
        call    line
        loop    colorir
        pop     ax
        mov     [cor],al
        pop     ax
        pop     cx
        pop     bp
        ret     4



%include "asm/config.asm"
