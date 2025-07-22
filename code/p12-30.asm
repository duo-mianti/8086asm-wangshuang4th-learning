assume cs:code

stack segment
    db 128 dup (0)
stack ends

code segment
start:
    ; 设置各段地址
    mov ax, stack
    mov ss, ax
    mov sp, 128
    push cs
    pop ds
    mov ax, 0
    mov es, ax

    ; 安装新程序
    mov si, offset int9
    mov di, 204h
    mov cx, offset int9end - offset int9
    cld
    rep movsb

    ; 将原中断地址保存在0:200处
    push es:[9*4]
    pop es:[200h]
    push es:[9*4+2]
    pop es:[202h]

    ; 改变后中断的入口地址
    cli
    mov word ptr es:[9*4], 204h
    mov word ptr es:[9*4+2], 0
    sti

    mov ax, 4c00h
    int 21h

; 定义新中断例程
int9:
    push ax
    push bx
    push cx
    push es
    
    in al, 60h
    pushf

    ; 调用旧中断例程
    ; 此时cs寄存器值为0
    call dword ptr cs:[200h]

    ; 接收到A键的断码就触发
    cmp al, 1eh+80h
    jne int9ret
    ; 满屏幕覆盖上字符A
    mov ax, 0b800h
    mov es, ax
    mov bx, 0
    mov cx, 2000
    s:
        mov byte ptr es:[bx], 'A'
        mov byte ptr es:[bx+1], 00000111b
        add bx, 2
        loop s
int9ret:
    pop es
    pop cx
    pop bx
    pop ax
    ret
int9end:
    nop
code ends

end start