assume cs:code

code segment
start:
    mov al, 8           ; 取得月份数据
    out 70h, al
    in al, 71h

    mov ah, al          ; 分离月份的十、个位
    mov cl, 4
    shr ah, cl
    and al, 00001111b
    
    add ah, 30h         ; 转换为ASCII码
    add al, 30h

    mov bx, 0b800h      ; 显示
    mov es, bx
    mov byte ptr es:[160*12+40*2], ah
    mov byte ptr es:[160*12+40*2+2], al
    
    mov ax, 4c00h
    int 21h
code ends

end start