;Autor: Juan Rodolfo Aranda Cisneros
;Fecha: 05/03/2023

.model small
.stack 100h

.data
    array db 6, 3, 9, 1, 8, 2
    size equ ($ - array)

.code
    main proc
        mov ax, @data
        mov ds, ax
        
        mov cx, size
        dec cx

    outer_loop:
        mov si, 0
    inner_loop:
        mov al, array[si]
        cmp si, cx
        jge next_element
        mov bl, array[si+1]
        cmp al, bl
        jle next_element
        mov array[si], bl
        mov array[si+1], al
    next_element:
        inc si
        cmp si, cx
        jle inner_loop

        loop outer_loop

    ; Imprimir el arreglo ordenado
        mov ah, 9
        lea dx, array
        int 21h

        mov ah, 4ch
        int 21h
    main endp
end main

