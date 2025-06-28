assume cs:code

code segment
start:
    ; ax = 0
    mov ax, 0
    push ax
    ; 标志寄存器全清零
    popf
    ; ax = 0fff0h
    mov ax, 0fff0h
    ; ax = 0，另外标志寄存器0,2,6,11位变1，其余是0。也就是00001000 01000101b
    add ax, 0010h
    pushf
    ; ax = 00001000 01000101b
    pop ax
    ; al = 01000101b
    and al, 11000101b
    ; ah = 00001000b
    and ah, 00001000b

    mov ax, 4c00h
    int 21h
code ends

end start