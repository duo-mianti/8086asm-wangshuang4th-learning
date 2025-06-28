assume cs:code

data segment
    db 10 dup (0)
data ends

code segment
start:
    mov ax, 12666
    mov bx, data
    mov ds, bx
    mov si, 0
    call dtoc

    mov dh, 8
    mov dl, 3
    mov cl, 2
    call show_str

    mov ax, 4c00h
    int 21h

dtoc:
    push si
    push ax
    push bx
    push cx
    push dx

    mov bx, 0
    dtoc_capital:
        mov cx, ax
        jcxz dtoc_ok
        mov dx, 0
        mov cx, 10
        call divdw
        add cx, 30h
        push cx
        inc bx
        jmp short dtoc_capital

    dtoc_ok:
        mov cx, bx
        dtoc_s0:
            pop bx
            mov ds:[si], bx
            inc si
            loop dtoc_s0
        
        pop dx
        pop cx
        pop bx
        pop ax
        pop si
        ret

divdw:
    push bp
    push dx
    push ax

    mov ax, dx
    mov dx, 0
    div cx              ; 计算H/N
    push ax
    mov bp, sp
    mov ax, ss:[bp+2]   ; 取出L
    div cx              ; 计算[rem(H/N)*65536+L]/N，这个结果就是最终结果的低16位，已经保存在ax里面了
    mov cx, dx          ; 把计算结果余数放到cx
    mov dx, ss:[bp]     ; 取回计算结果高16位

    add sp, 6           ; 存入了3个字型数据，一共6字节
    pop bp
    ret

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