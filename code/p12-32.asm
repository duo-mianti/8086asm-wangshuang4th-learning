assume cs:code

code segment
start:
    ; 要调用的子程序
    mov ah, 0
    ; 颜色
    mov al, 2
    int 7ch

    mov ax, 4c00h
    int 21h
code ends

end start