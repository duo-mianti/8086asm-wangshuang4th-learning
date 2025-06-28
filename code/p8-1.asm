assume cs:code

code segment
start:
    mov dx, 1
    mov ax, 86a1h
    mov bx, 64h
    div bx

    mov ax, 1001
    mov bl, 100
    div bl

    mov ax, 4c00h
    int 21h
code ends

end start