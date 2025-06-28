assume cs:code

code segment
start:
    mov ax, 1234h
    mov bx, ax
    mov ax, 0
    shl bx, 1
    adc ax, bx
    mov cl, 2
    shl bx, cl
    adc ax, bx

    mov ax, 4c00h
    int 21h
code ends

end start