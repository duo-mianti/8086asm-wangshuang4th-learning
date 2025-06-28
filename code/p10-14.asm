assume cs:code, ds:table, es:data

data segment
    db '1975', '1976', '1977', '1978', '1979', '1980', '1981', '1982', '1983'
    db '1984', '1985', '1986', '1987', '1988', '1989', '1990', '1991', '1992'
    db '1993', '1994', '1995'

    dd 16, 22, 382, 1356, 2390, 8000, 16000, 24486, 50065, 97479, 140417, 197514
    dd 345980, 590827, 803530, 1183000, 1843000, 2759000, 3753000, 4649000, 5937000

    dw 3, 7, 9, 13, 28, 38, 130, 220, 476, 778, 1001, 1442, 2258, 2793, 4037, 5635, 8226
    dw 11542, 14430, 15257, 17800
data ends

table segment
    db 672 dup (' ')
table ends

stack segment
    dw 8 dup (0)
stack ends

code segment
start:
    ; 初始化 2 个数据段，将 ds 指向 data，es 指向 table
	mov ax, data
	mov es, ax
	mov ax, table
	mov ds, ax

	; 初始化偏移地址寄存器变量
	mov bx, 0	
	mov si, 0
	mov di, 0

	mov cx, 21
    mov dx, 0
s:
	push dx
    ; 写入年份（4字节）
	mov ax, es:[bx+0]
	mov [si+0], ax
	mov ax, es:[bx+2]
	mov [si+2], ax

	; 写入空格（1字节）
	mov al, 0
	mov [si+4], al

	; 写入收入（4字节）
	mov ax, es:[bx+84]
	mov dx, es:[bx+86]
    add si, 5
    call dtoc
    sub si, 5

	; 写入空格（1字节）
	mov al, 0
	mov [si+13], al

	; 写入雇员数（2字节）
	mov ax, es:[di+168]
    mov dx, 0
	add si, 14
    call dtoc
    sub si, 14

	; 写入空格（1字节）
	mov al, 0
	mov [si+22], al

	; 写入人均收入（2字节）
	mov ax, es:[bx+84]
	mov dx, es:[bx+86]
    push cx
	mov cx, es:[di+168]
    call divdw
	add si, 23
    call dtoc
    sub si, 23
    pop cx

	; 写入空格（1字节）
	mov al, 0
	mov [si+27], al

    pop dx
    call print_str

	add bx, 4
	add si, 32
	add di, 2
	loop s

    mov ax, 4c00h
    int 21h

print_str:
    mov cl, 2
    mov dl, 0
    call show_str
    add si, 5
    add dl, 5
    call show_str
    add si, 9
    add dl, 9
    call show_str
    add si, 9
    add dl, 9
    call show_str
    inc dh
    sub si, 23
    ret 

dtoc:
    push si
    push ax
    push bx
    push cx
    push dx

    mov bx, 0
    dtoc_capital:
        mov cx, ax
        or cx, dx
        jcxz dtoc_ok
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
            mov ds:[si], bl
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