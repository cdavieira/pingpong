global desenhar_menu
export 

desenhar_menu:
        pushf
        push    ax
        push    bx
        push    cx
        push    dx
        push    bp
        mov     bp,sp
        ; codigo vai aqui
        pop     ax
        pop     ax
        pop     ax
        pop     ax
        pop     ax
        popf
        ret
