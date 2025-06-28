assume cs:code, ss:stack

stack segment
    dw 8 dup (0)
stack ends

code segment
start:
    mov ax, stack
    mov ss, ax
    mov sp, 16
    
    mov ax, 4240h
    mov dx, 000fh
    mov cx, 0ah
    call divdw

    mov ax, 4c00h
    int 21h

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
code ends

end start