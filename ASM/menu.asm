global menu
extern p_i,p_t,tecla,rect,cor,line

menu:
        pushf
        push    ax
        push    bx
        call    pintar_menu
        mov     cx,0f000h
        push    cx
        push    cx
        push    cx
        push    cx
        push    cx
        push    cx
loop5:
        nop
        loop loop5
        pop  cx
loop6:
        nop
        loop loop6
        pop  cx
loop7:
        nop
        loop loop7
        pop  cx
loop8:
        nop
        loop loop8
        pop cx
loop9:
        nop
        loop loop9
        pop  cx
loop10:
        nop
        loop loop10
        pop  cx
loop11:
        nop
        loop loop11
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
loading_anim:
        mov     cx,10
        mov     dx,100
loop1:
        mov     byte [cor],branco_intenso
        mov     ax,telaX/2
        sub     ax,dx
        push    ax
        mov     ax,telaY/2-coluninha
        push    ax
        mov     ax,telaX/2
        sub     ax,dx
        push    ax
        mov     ax,telaY/2+coluninha
        push    ax
        call    line
        push    cx
delay1:
        mov     cx,8000h
        push    cx
delay2:
        nop
        loop    delay2
        pop     cx
delay3:
        nop
        loop    delay3
        pop     cx
        mov     byte [cor],preto
        mov     ax,telaX/2
        sub     ax,dx
        push    ax
        mov     ax,telaY/2-coluninha
        push    ax
        mov     ax,telaX/2
        sub     ax,dx
        push    ax
        mov     ax,telaY/2+coluninha
        push    ax
        call    line
        sub     dx,20
        loop    loop1
        jmp     esperar_tecla
sair_menu:
        pop     bx
        pop     ax
        popf
        ret
pintar_menu:
        call    janela
        call    caixa_facil
        call    caixa_medio
        call    caixa_dific
        ret
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
caixa_facil:
        push    ax
        xor     ax,ax
        mov     ax,verde
        push    ax
        mov     ax,caixaW
        push    ax
        xor     ax,ax
        mov     ax,caixaH
        push    ax
        xor     ax,ax
        mov     ax,caixaX
        push    ax
        mov     ax,caixaY
        push    ax
        call    rect
        pop     ax
        ret
caixa_medio:
        push    ax
        xor     ax,ax
        mov     ax,vermelho
        push    ax
        mov     ax,caixaW
        push    ax
        xor     ax,ax
        mov     ax,caixaH
        push    ax
        xor     ax,ax
        mov     ax,3*caixaX
        push    ax
        xor     ax,ax
        mov     ax,caixaY
        push    ax
        call    rect
        pop     ax
        ret
caixa_dific:
        push    ax
        xor     ax,ax
        mov     ax,vermelho
        push    ax
        mov     ax,caixaW
        push    ax
        xor     ax,ax
        mov     ax,caixaH
        push    ax
        xor     ax,ax
        mov     ax,5*caixaX
        push    ax
        xor     ax,ax
        mov     ax,caixaY
        push    ax
        call    rect
        pop     ax
        ret

%include "asm/config.asm"
