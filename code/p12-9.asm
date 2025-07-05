assume cs:code, ss:stack, ds:data

stack segment
    db 200h dup (0)
stack ends

data segment
    ; 13回车，10换行，后面$符结尾
    szmsg db 13, 10, 'hello world!', 13, 10, '$'
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    ; lea取得标号的地址
    lea dx, szmsg
    ; 功能号9号表示显示ds:dx位置的字符串，以$符结束
    mov ah, 9
    ; 21号中断处理中断，执行ah保存的功能号对应的操作
    int 21h

    ; 这里ah是4c，效果是把程序结束执行退回
    mov ax, 4c00h
    int 21h
code ends

end start