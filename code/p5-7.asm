assume cs:codesg
codesg segment
    
    mov ax, 20h
    mov ds, ax
    mov cx, 40h
    mov bx, 0
s:  mov ds:[bx], bl
    inc bl
    loop s

    mov ax, 4c00h
    int 21h
codesg ends
end