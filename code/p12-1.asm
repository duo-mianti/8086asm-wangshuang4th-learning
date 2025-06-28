assume cs:code

code segment
start:
    mov al, 00000001b
    shl al, 1
    shl al, 1
    shl al, 1
    mov cl, 3
    shl al, cl
    mov cl, 2
    shr al, cl

    mov ax, 4c00h
    int 21h
code ends

end start