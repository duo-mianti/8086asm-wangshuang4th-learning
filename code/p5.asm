assume cs:codesg
codesg segment
    mov ax, 2000h
    mov ds, ax
    mov bx, 1000h
    mov ax, [bx]
    inc bx
    inc bx
    mov [bx], ax
    inc bx
    inc bx
    mov [bx], ax
    inc bx
    mov [bx], al
    inc bx
    mov [bx], al
codesg ends
end