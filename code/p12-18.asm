assume cs:code
code segment
start:
    mov ax, cs
    mov ds, ax
    mov si, offset capital
    mov ax, 0
    mov es, ax
    mov di, 200h
    mov cx, offset capitalend - offset capital
    cld
    rep movsb

    mov ax, 0
    mov es, ax
    mov word ptr es:[7ch*4], 200h
    mov word ptr es:[7ch*4+2], 0

    mov ax, 4c00h
    int 21h

capital:
    push bp
    mov bp, sp
    add [bp+2], bx
    pop bp
    iret
capitalend:
    nop
code ends

end start