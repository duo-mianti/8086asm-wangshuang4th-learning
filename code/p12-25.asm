assume cs:code

code segment
    s:     db '00/00/00 00:00:00$'  ; 预格式化字符串模板
    s0:    db 9, 8, 7, 4, 2, 0      ; CMOS 寄存器索引：年/月/日/时/分/秒

start:
    mov ax, cs       ; 正确设置数据段
    mov ds, ax
    mov es, ax       ; 确保ES=DS（某些DOS功能需要）
    
    mov si, offset s0
    mov di, offset s
    mov cx, 6        ; 循环6次（年/月/日/时/分/秒）

s2:
    push cx
    mov al, [si]     ; 读取CMOS寄存器索引
    out 70h, al      ; 选择寄存器
    in al, 71h       ; 读取值

    ; 将AL中的BCD码转换为ASCII字符
    mov ah, al
    mov cl, 4
    shr ah, cl        ; 高4位
    and al, 00001111b      ; 低4位
    add ah, '0'      ; 转换为ASCII
    add al, '0'
    mov [di], ah     ; 写入字符串高位
    mov [di+1], al   ; 写入字符串低位

    add di, 3        ; 移动到下一个字段（跳过'/'或':'或空格）
    inc si           ; 下一个CMOS索引
    pop cx
    loop s2

    ; 显示字符串
    mov dx, offset s
    mov ah, 9        ; DOS功能：显示字符串
    int 21h

    ; 退出程序
    mov ax, 4c00h
    int 21h

code ends
end start