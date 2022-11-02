global menu
extern p_i,p_t,tecla,rect,cor,line,facil_msg,medio_msg,dificil_msg,cores_menu

menu:
        pushf
        push    ax
        push    bx
        xor     ax,ax
        mov     al,[cores_menu+1]
        push    ax
        mov     al,[cores_menu+2]
        push    ax
        mov     al,[cores_menu+3]
        push    ax
        call    pintar_menu
        ; mov     cx,0100h
; loop2:
        ; push    cx
        ; mov     cx,8000h
; loop3:
        ; nop
        ; loop    loop3
        ; pop     cx
        ; loop    loop2
        ; pop     bx
        ; pop     ax
        ; popf
        ; ret
esperar_tecla:
	mov	bx,[p_i]
        cmp     [p_t],bx
        je      esperar_tecla
opcoes_menu:
        mov     word [p_t],bx
	cmp	byte [bx+tecla],tecla_cont
        je      sair_menu
        cmp     byte [bx+tecla],tecla_finalizar
        je      fechar_jogo
        push    ax
        push    bx
        xor     ax,ax
        cmp     byte [bx+tecla],esquerda_menu
        je      att_menu
        cmp     byte [bx+tecla],direita_menu
        jne     final_menu ; caso nenhuma tecla valida tenha sido pressionada
att_menu:
        mov     al,byte [cores_menu] ; al = caixa selecionada (0 a 2)
        mov     bx,0003h
        div     bl ; 0 < ah (resto) < 2 (ah = resto da div)
        xchg    al,ah
        pop     bx
        cmp     byte [bx+tecla],esquerda_menu
        push    bx
        jne     dir
        dec     ax ; al = al-1
        jmp     esq
dir:
        inc     ax ; al = al+1
esq:
        mov     bx,0003h
        and     ax,00efh
        div     bl ; (caso al = 0) (ah = resto da div)
        xchg    al,ah ; al = resto da div
        and     ax,00ffh
        mov     bx,ax ; bx = indice da proxima caixa a ser pintada de verde
        inc     bx ; indice 0 -> [cores_menu+1], indice 1 -> [cores_menu+2] ...
        mov     al,byte [cores_menu] ; ax = caixa atualmente pintada de verde
        mov     byte [cores_menu+bx],verde
        dec     bx
        mov     byte [cores_menu],bl ; atualizando o indice da caixa atualmente verde
        mov     bx,ax ; trocando a cor da caixa anteriormente verde para vermelho
        inc     bx ; indice 0 -> [cores_menu+1], indice 1 -> [cores_menu+2] ...
        mov     byte [cores_menu+bx],vermelho
        mov     ax,cor_fundo
        push    ax
        push    ax
        push    ax
        call    pintar_menu ; apagando caixas
        mov     al,byte [cores_menu+1]
        push    ax
        mov     al,byte [cores_menu+2]
        push    ax
        mov     al,byte [cores_menu+3]
        push    ax
        call    pintar_menu ; redesenhando caixas com cores att
final_menu:
        pop     bx
        pop     ax
        jmp     esperar_tecla
fechar_jogo:
        mov     byte [cores_menu],0ffh
sair_menu:
        pop     bx
        pop     ax
        popf
        ret

; Desenha o menu inicial
; Parametros: cor da caixa do modo facil (bp+10), cor da caixa do modo medio (bp+8) e cor da caixa do modo dificil (bp+6)
; Posicionamento do texto (da coluna em que eh disposto) deve ser feito manualmente
pintar_menu:
        push    ax
        push    bp
        mov     bp,sp
        call    janela
        mov     ax,000eh ; posicionando a coluna do texto "facil"
        push    ax
        mov     ax,0005h ; quantidade de letras da palavra facil
        push    ax
        mov     ax,facil_msg ; passando endereço do ponteiro para msg
        push    ax
        mov     ax,0001h ; passando fator multiplicativo
        push    ax
        mov     ax,[bp+10] ; passando cor das bordas da caixa
        push    ax
        call    caixa_modo
        mov     ax,00025h ; posicionando a coluna do texto "medio" 
        push    ax
        mov     ax,0005h ; quantidade de letras da palavra medio
        push    ax
        mov     ax,medio_msg ; passando endereço do ponteiro para msg
        push    ax
        mov     ax,0003h ; passando fator multiplicativo
        push    ax
        mov     ax,[bp+8] ; passando cor das bordas da caixa
        push    ax
        call    caixa_modo
        mov     ax,0003bh ; posicionando a coluna do texto "dificil"
        push    ax
        mov     ax,0007h ; quantidade de letras da palavra dificil
        push    ax
        mov     ax,dificil_msg ; passando endereço do ponteiro para msg
        push    ax
        mov     ax,0005h ; passando fator multiplicativo
        push    ax
        mov     ax,[bp+6] ; passando cor das bordas da caixa
        push    ax
        call    caixa_modo
        pop     bp
        pop     ax
        ret     6

; Desenha a janela que delimita o jogo, com bordas brancas
; Parametros: -
; As dimensoes dessa janela estao definidas no arquivo de configuracao (config.asm)
janela:
        push    ax
        xor     ax,ax
        mov     ax,branco_intenso
        push    ax
        mov     ax,telaX-1
        push    ax
        mov     ax,telaY-1
        push    ax
        xor     ax,ax
        push    ax
        push    ax
        call    rect
        pop     ax
        ret

; Desenha as caixas de dificuldade do menu inicial
; Parametros: coluna do texto (bp+14), numero de caracteres do texto (bp+12), ponteiro para texto (bp+10), indice multiplicativo (bp+8), cor da borda da caixa (bp+6)
; As dimensoes dessas caixas estao definidas no arquivo de configuracao (config.asm)
caixa_modo:
        push    ax
        push    bp
        mov     bp,sp
        xor     ax,ax
        mov     ax,[bp+6]
        push    ax
        mov     ax,caixaW
        push    ax
        xor     ax,ax
        mov     ax,caixaH
        push    ax
        xor     ax,ax
        mov     ax,caixaX
        imul    byte [bp+8]
        push    ax
        mov     ax,caixaY
        push    ax
        call    rect
        ; escrevendo texto
        push    bp
        push    bx
        push    cx
        push    dx
        push    es
        mov     bx,[bp+6]
        mov     cx,[bp+12]
        mov     ax,[bp+14]
        mov     ah,textoY
        mov     dx,ax
        push    ds
        pop     es
        mov     bp,[bp+10]
        mov     al,0
        mov     ah,13h
        int     10h
        pop     es
        pop     dx
        pop     cx
        pop     bx
        pop     bp
        ; fim da rotina de impressao do texto
        pop     bp
        pop     ax
        ret     10

%include "asm/config.asm"
