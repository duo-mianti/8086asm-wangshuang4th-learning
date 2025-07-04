assume cs:code, ds:data

data segment
    db 8, 11, 8, 1, 8, 5, 63, 38
data ends

code segment
start:
    mov ax, data
    mov ds, ax
    mov bx, 0
    mov ax, 0
    mov cx, 8
    s:
        cmp byte ptr ds:[bx], 8
        jne next
        inc ax
    next:
        inc bx
    loop s

    mov ax, 4c00h
    int 21h
code ends

; code segment
; start:
;     mov ax, data
;     mov ds, ax
;     mov bx, 0
;     mov ax, 0
;     mov cx, 8
;     s:
;         cmp byte ptr ds:[bx], 8
;         je ok
;         jmp short next
;     ok:
;         inc ax
;     next:
;         inc bx
;     loop s

;     mov ax, 4c00h
;     int 21h
; code ends

end start