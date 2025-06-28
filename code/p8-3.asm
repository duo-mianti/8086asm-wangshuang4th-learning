assume cs:code, ds:data

data segment
    db 3 dup (0)
    db 3 dup (0, 1, 2)
    db 80 dup (0)
    db 3 dup ('abc', 'ABC')
data ends

code segment
start:
    mov ax, data
    mov ds, ax

    mov ax, 4c00h
    int 21h
code ends

end start
