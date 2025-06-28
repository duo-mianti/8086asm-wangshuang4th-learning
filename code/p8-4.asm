assume cs:code

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
    db 21 dup ('year summ ne ?? ')
table ends

stack segment
    dw 8 dup (0)
stack ends

code segment
start:
    mov ax, table
    mov ds, ax

    mov ax, data
    mov es, ax

    mov ax, stack
    mov ss, ax
    mov sp, 10h

    mov bx, 0
    mov bp, 0
    mov cx, 21
s0:
    push cx
    mov cx, 4
    mov si, 0
    s:
        mov al, es:[bp+si]
        mov ds:[bx+si], al
        inc si
        loop s
    add bx, 10h
    add bp, 4
    pop cx
    loop s0

    mov bx, 0
    mov cx, 21
s1:
    mov ax, es:[bp]
    mov ds:[bx+5], ax
    mov ax, es:[bp+2]
    mov ds:[bx+7], ax
    add bx, 10h
    add bp, 4
    loop s1

    mov bx, 0
    mov cx, 21
s2:
    mov ax, es:[bp]
    mov ds:[bx+0ah], ax
    mov ax, ds:[bx+5]
    mov dx, ds:[bx+7]
    div word ptr ds:[bx+0ah]
    mov ds:[bx+0dh], ax
    add bx, 10h
    add bp, 2
    loop s2

    mov ax, 4c00h
    int 21h
code ends

end start

; 把整个table看成一个结构体数组，用循环来遍历
; 每一行是一个结构体，在一层循环内处理完
; 结构体的第一部分是年份，用内层循环把数据复制过去
; 收入是dd型数据，用ax分两次复制过去
; 雇员数是dw型数据，用一次ax复制
; 人均收入用div除法解决，我只需要除法的商，计算完将会存在ax里
; data段当中的数据是紧密排列的，bp寄存器直接接着用，不用重新赋值

; CSDN有一种封装函数做法，把一部分代码放在code段开头，start放在中间真正刚开始的部分，然后用jmp跳转过去，再用jmp跳转回来，url如下https://blog.csdn.net/Dr_Cheeze/article/details/127444922

; 知乎有一种方法，是把年份当作数值用两次ax直接复制，而不是逐个字节来遍历复制，这样就不需要使用额外的栈空间，而且让所有字段的处理方法保持一致（都是每2字节一组复制），只用一轮循环就完成了任务，url如下https://zhuanlan.zhihu.com/p/626774043