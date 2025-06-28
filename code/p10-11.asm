assume cs:code, ds:data

data segment
    db 'Welcome to masm!', 0
data ends

code segment
start:
    mov dh, 8
    mov dl, 3
    mov cl, 2
    mov ax, data
    mov ds, ax
    mov si, 0
    call show_str

    mov ax, 4c00h
    int 21h

show_str:
    push ax
    push bx
    push cx
    push dx
    push es
    push si

    mov ax, 0b800h
    mov es, ax
    mov ax, 0
    mov al, 160
    mul dh
    add ax, 160
    mov bl, dl
    mov bh, 0
    add bx, bx
    add bx, ax          ; 字符串显示位置的起始地址

    mov al, 16
    mov ah, 0
    mul cl              ; 字符串颜色转成属性字节格式

    show_str_capital:
        mov cl, ds:[si]
        mov ch, 0
        jcxz show_str_ok
        mov es:[bx], cl
        mov es:[bx+1], al
        inc si
        add bx, 2
        jmp short show_str_capital

    show_str_ok:
        pop si
        pop es
        pop dx
        pop cx
        pop bx
        pop ax
        ret

code ends

end start