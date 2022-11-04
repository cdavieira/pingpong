global pintar_fundo
extern cor,line

; Pinta o fundo do jogo com a cor definida na variavel cor_fundo no arquivo config.asm
; Parametros: ponteiro para mensagem (bp+6) e tamanho da mensagem (bp+4)
pintar_fundo:
        push    bp
        mov     bp,sp
        push    dx
        push    cx
        push    ax
        xor     ax,ax
        mov     al,[cor]
        push    ax ; guardando cor anterior
        mov     ax,cor_fundo
        add     ax,2
        mov     bx,0010h
        div     bl
        xor     dx,dx ; dh = numero da pagina, dl = cor
        mov     dl,ah ; ah = resto da divisao anterior
        and     dl,0fh ; dll = cor do texto
        mov     al,cor_fundo
        shl     al,4
        or      dl,al ; dlh = fundo do texto (igual a cor de fundo)
        push    dx ; dh = 00h, dl = 0h(cor do fundo)0h(cor do texto)
        push    word [bp+6]
        push    word [bp+4]
        call    mensagem
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
        cmp     cx,telaX/2-50
        jne     nao_repintar_txt
        push    dx
        push    word [bp+6]
        push    word [bp+4]
        call    mensagem
nao_repintar_txt:
        loop    colorir
        pop     ax
        mov     [cor],al
        pop     ax
        pop     cx
        pop     dx
        pop     bp
        ret     4

; Pinta texto no centro da tela de carregamento (orienta-se de acordo com linhas/colunas e nao pixels)
; Parametros: accent color e cor da fonte (bp+8), ponteiro para mensagem (bp+6), numero de caracteres da mensagem (bp+4)
mensagem:
        ; imprimir mensagem de carregamento
        push    bp
        mov     bp,sp
        push    dx
        push    cx
        push    bx
        push    ax
        push    es
        xor     bx,bx
        mov     bl,byte [bp+8]
        xor     ax,ax
        mov     cx,[bp+4]; numero de caracteres da string
        mov     ax,textoX
        mov     ah,textoY
        mov     dx,ax ; dl = coluna, dh = linha
        push    ds
        pop     es ; a string a ser impressa deve ser apontada por ES:BP
        mov     bp,[bp+6] ; a string a ser impressa deve ser apontada por ES:BP
        mov     al,0 ; al = write mode
        mov     ah,13h
        int     10h
        pop     es
        pop     ax
        pop     bx
        pop     cx
        pop     dx
        pop     bp
        ret     6

%include "asm/config.asm"
