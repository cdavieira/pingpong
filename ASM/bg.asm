global pintar_fundo
extern cor,line,loading_msg

; Pinta o fundo do jogo com a cor definida na variavel cor_fundo no arquivo config.asm
; Parametros: tamanho da mensagem (bp+4) e ponteiro para mensagem (bp+6)
; FAZER A PASSAGEM DE PARAMETROS AQUI E MUDAR A CHAMADA LA NA MAIN
pintar_fundo:
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
        xor     bx,bx ; bh = numero da pagina, bl = cor
        mov     cx,[bp+12] ; numero de caracteres da string
        mov     ax,[bp+14]
        mov     ah,textoY
        mov     dx,ax ; dl = coluna, dh = linha
        push    ds
        pop     es ; a string a ser impressa deve ser apontada por ES:BP
        mov     bp,[bp+10] ; a string a ser impressa deve ser apontada por ES:BP
        mov     al,0 ; al = write mode
        mov     ah,13h
        int     10h
        pop     es
        pop     dx
        pop     bx
        pop     bp
colorir:
        mov     byte [cor],cor_fundo
        mov     cx,telaX-1
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
        ret



%include "asm/config.asm"
