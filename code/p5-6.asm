assume cs:codesg
codesg segment
    
    mov bx, 0
    mov cx, 12
    mov ax, 0ffffh
    mov ds, ax
    mov ax, 20h
    mov es, ax
s:  mov dl, ds:[bx]
    mov es:[bx], dl
    inc bx
    loop s

    mov ax, 4c00h
    int 21h
codesg ends
end