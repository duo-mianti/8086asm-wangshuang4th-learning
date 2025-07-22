assume cs:code

stack segment
    db 128 dup (0)
stack ends

; 数据段存放原int 9中断例程的入口地址
data segment
    dw 0, 0
data ends

code segment
start:
    mov ax, stack
    mov ss, ax
    mov sp, 128
    mov ax, data
    mov ds, ax

    ; 保存旧中断例程入口
    mov ax, 0
    mov es, ax
    push es:[9*4]
    pop ds:[0]
    push es:[9*4+2]
    pop ds:[2]

    ; 设置新中断例程入口
    mov word ptr es:[9*4], offset int9
    mov es:[9*4+2], cs

    ; 显示字符
    mov ax, 0b800h
    mov es, ax
    mov ah, 'a'
s:
    mov es:[160*12+40*2], ah
    call delay          ; 调用延时函数子程序
    inc ah
    cmp ah, 'z'
    jna s
    mov ax, 0
    mov es, ax

    ; 恢复原来的地址
    push ds:[0]
    pop es:[9*4]
    push ds:[2]
    pop es:[9*4+2]
    
    mov ax, 4c00h
    int 21h

; 定义延时函数
; 无意义的双重循环，拖慢运行速度
delay:
    push ax
    push dx

    mov dx, 10h
    mov ax, 0
s1:
    sub ax, 1
    sbb dx, 0
    cmp ax, 0
    jne s1
    cmp dx, 0
    jne s1
    
    pop dx
    pop ax
    ret

; 定义中断例程
int9:
    push ax
    push bx
    push es

    ; 读出键盘输入
    in al, 60h

    ; 标志寄存器入栈
    pushf

    ; 把IF、TF设为0
    pushf
    pop bx
    and bh, 11111100b
    push bx
    popf

    ; 调用原来的int 9中断例程
    ; 直接用双字涵盖段地址和偏移地址
    call dword ptr ds:[0]

    cmp al, 1
    jne int9ret
    mov ax, 0b800h
    mov es, ax
    inc byte ptr es:[160*12+40*2+1]

int9ret:
    pop es
    pop bx
    pop ax
    ret
code ends

end start