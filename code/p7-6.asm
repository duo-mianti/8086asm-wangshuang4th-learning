assume cs:code

code segment
start:
    mov ax, 2000h
    mov ds, ax
    mov bx, 1000h

    mov si, 0
    mov ax, ds:[bx+2+si]

    inc si
    mov cx, ds:2[bx+si]

    inc si
    mov di, si
    mov bx, ds:[bx][di].2

    mov ax, 4c00h
    int 21h
code ends

end start