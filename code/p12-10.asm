assume cs:code

code segment
start:
    ; do0安装程序
    mov ax, cs
    mov ds, ax
    mov si, offset do0
    mov ax, 0
    mov es, ax
    mov di, 200h
    mov cx, offset do0end-offset do0
    cld
    rep movsb

    ; 设置中断向量表
    mov ax, 0
    mov es, ax
    mov word ptr es:[0*4], 200h
    mov word ptr es:[0*4+2], 0

    mov ax, 4c00h
    int 21h

do0:
    ; 这条指令是2字节指令
    jmp short do0start
    ; 将数据写到代码区，保证与代码一起加载
    db "overflow"
do0start:
    mov ax, cs
    mov ds, ax
    mov si, 202h
    mov ax, 0b800h
    mov es, ax
    ; 直接输出到显示缓冲区
    mov di, 12*160+36*2
    mov cx, 9
s:
    mov al, ds:[si]
    mov es:[si], al
    inc si
    add di, 2
    loop s

    mov ax, 4c00h
    int 21h
do0end:
    nop
code ends

end start