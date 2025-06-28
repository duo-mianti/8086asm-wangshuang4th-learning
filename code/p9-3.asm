assume cs:code, ds:data

data segment
    db 'welcome to masm!'
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov ax, 0b800h
    mov es, ax

    mov bx, 0   ; TODO 内容没有居中，未完成
    mov si, 0
    mov di, 0
    mov cx, 16
s0:
    mov al, ds:[di]
    mov es:[bx+si], al
    inc si
    inc di
    mov byte ptr es:[bx+si], 00000010b
    inc si
    loop s0

    add bx, 160
    mov si, 0
    mov di, 0
    mov cx, 16
s1:
    mov al, ds:[di]
    mov es:[bx+si], al
    inc si
    inc di
    mov byte ptr es:[bx+si], 00100100b
    inc si
    loop s1

    add bx, 160
    mov si, 0
    mov di, 0
    mov cx, 16
s2:
    mov al, ds:[di]
    mov es:[bx+si], al
    inc si
    inc di
    mov byte ptr es:[bx+si], 01110001b
    inc si
    loop s2

    mov ax, 4c00h
    int 21h
code ends

end start