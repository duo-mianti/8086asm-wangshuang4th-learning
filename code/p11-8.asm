assume cs:code, ds:data

data segment
    db "Beginner's All-purpose Symbolic Instruction Code.", 0
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov si, 0
    call letterc

    mov ax, 4c00h
    int 21h

letterc:
    push cx
    push si
    pushf

    capital:
        mov cl, ds:[si]
        mov ch, 0
        jcxz ok
        cmp cl, 61h
        jb next
        cmp cl, 7ah
        ja next
        and cl, 11011111b
        mov ds:[si], cl
    next:
        inc si
        jmp capital
    ok:
        popf
        pop si
        pop cx
        ret
code ends

end start