assume cs:code

code segment
start:
    mov ax, 0b800h
    mov es, ax
    mov ah, 'a'
s:
    mov es:[160*12+40*2], ah
    inc ah
    cmp ah, 'z'
    jna s
    
    mov ax, 4c00h
    int 21h
code ends

end start

; 基础版程序，存在缺陷，就是看不清屏幕上显示的跳动的字符，而是直接看到z