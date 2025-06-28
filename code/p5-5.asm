assume cs:codesg
codesg segment
    
    mov bx, 0
    mov cx, 12
s:  mov ax, 0ffffh
    mov ds, ax
    mov dl, ds:[bx]
    mov ax, 20h
    mov ds, ax
    mov ds:[bx], dl
    inc bx
    loop s

    mov ax, 4c00h
    int 21h
codesg ends
end