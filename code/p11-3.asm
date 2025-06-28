assume cs:code, ds:data

data segment
    dw 0a452h, 0a8f5h, 78e6h, 0a8eh, 8b7ah, 54f6h, 0f04h, 671eh
    dw 0e71eh, 0ef04h, 54f6h, 8b7ah, 0a8eh, 78e6h, 58f5h, 0452h
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov si, 0
    mov di, 16
    mov cx, 8

    call add128

    mov ax, 4c00h
    int 21h

add128:
    push ax
    push cx
    push si
    push di

    sub ax, ax
    s:
        mov ax, ds:[si]
        adc ax, ds:[di]
        mov ds:[si], ax
        
        inc si
        inc si
        inc di
        inc di
        loop s

    pop di
    pop si
    pop cx
    pop ax
    ret

code ends

end start