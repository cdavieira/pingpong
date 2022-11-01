global menu
extern p_i,p_t,tecla,rect,cor,line,facil_msg,medio_msg,dificil_msg

menu:
        pushf
        push    ax
        push    bx
        call    pintar_menu
        mov     cx,0100h
loop2:
        push    cx
        mov     cx,8000h
loop3:
        nop
        loop    loop3
        pop     cx
        loop    loop2
        pop     bx
        pop     ax
        popf
        ret
esperar_tecla:
	mov	bx,[p_t]
opcoes_menu:
	cmp	byte [bx+tecla],tecla_sair
	je	sair_menu
	cmp	byte [bx+tecla],seta_dir
	cmp	byte [bx+tecla],seta_esq
        jmp     esperar_tecla
sair_menu:
        pop     bx
        pop     ax
        popf
        ret

pintar_menu:
        push    ax
        ;call    janela
        mov     ax,0005h
        push    ax
        mov     ax,facil_msg
        push    ax
        mov     ax,0001h
        push    ax
        mov     ax,verde
        push    ax
        call    caixa_modo
        mov     ax,0005h
        push    ax
        mov     ax,medio_msg
        push    ax
        mov     ax,0003h
        push    ax
        mov     ax,vermelho
        push    ax
        call    caixa_modo
        mov     ax,0007h
        push    ax
        mov     ax,dificil_msg
        push    ax
        mov     ax,0005h
        push    ax
        mov     ax,vermelho
        push    ax
        call    caixa_modo
        pop     ax
        ret

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
; Parametros: tamanho do texto (bp+12), ponteiro para texto (bp+10), indice multiplicativo (bp+8), cor da borda da caixa (bp+6)
; As dimensoes dessas caixas estao definidas no arquivo de configuracao (config.asm)
caixa_modo:
        push    ax
        push    bp
        mov     bp,sp
        ; escrevendo texto
        push    bp
        push    bx
        push    cx
        push    dx
        push    es
        mov     bx,[bp+6]
        mov     cx,[bp+12]
        mov     ah,linhas/2
        mov     ax,colunas/2
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
        pop     bp
        pop     ax
        ret     8

%include "asm/config.asm"
