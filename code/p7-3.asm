assume cs:code, ds:data

data segment
    db 'BaSiC'
    db 'MinIX'
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov bx, 0
    mov cx, 5
s:  
    mov al, ds:[bx]
    and al, 11011111b
    mov ds:[bx], al

    mov al, ds:[5+bx]
    or al, 00100000b
    mov ds:[5+bx], al
    inc bx
    loop s

    mov ax, 4c00h
    int 21h
code ends

end start