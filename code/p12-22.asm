assume cs:code

code segment
start:
    mov al, 08h         ; 设置声音频率
    out 42h, al
    out 42h, al

    in al, 61h          ; 读设备控制器端口原值
    mov ah, al          ; 保存原值

    or al, 3            ; 打开扬声器和定时器
    out 61h, al         ; 接通扬声器，发声

    mov cx, 60000       ; 延时
delay:
    add bx, 1
    loop delay

    mov al, ah          ; 恢复端口原值
    out 61h, al

    mov ax, 4c00h
    int 21h
code ends

end start