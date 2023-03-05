org 100h

.data
vector db 5, 2, 9, 1, 7
n equ $-vector

.code
start:
    mov bx, n        ; bx = n
    dec bx           ; bx = n - 1
outerloop:
    mov si, 0        ; si = 0
innerloop:
    mov al, [vector+si]
    cmp al, [vector+si+1]
    jle skip_swap
    xchg al, [vector+si+1]
    mov [vector+si], al
skip_swap:
    inc si
    cmp si, bx
    jl innerloop
    dec bx
    jnz outerloop

    ; imprimir el vector ordenado
    mov si, 0
printloop:
    mov dl, [vector+si]
    add dl, 30h     ; convertir de número a caracter
    mov ah, 02h     ; función de impresión del DOS
    int 21h
    inc si
    cmp si, n
    jl printloop

    ; finalizar el programa
    mov ah, 4ch
    int 21h