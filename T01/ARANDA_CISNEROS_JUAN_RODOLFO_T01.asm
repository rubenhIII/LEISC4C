;Autor: Juan Rodolfo Aranda Cisneros
;Fecha: 05/03/2023

org 100h    ; Inicio del programa en la dirección 100h

.data       ; Definición de los datos
array dw 6, 2, 8, 4, 5
n dw 5      ; Tamaño de la lista

.code       ; Código del programa
start:
    mov cx, n           ; Carga el tamaño de la lista en CX
    dec cx              ; Disminuye CX en 1 (el índice comienza en 0)
outer_loop:
    mov si, 0           ; Carga el índice del primer elemento en SI
inner_loop:
    mov ax, [array+si]  ; Carga el elemento actual en AX
    mov bx, [array+si+2]; Carga el siguiente elemento en BX
    cmp ax, bx          ; Compara los elementos
    jle skip_swap       ; Salta si están en orden
    xchg ax, bx         ; Intercambia los elementos
    mov [array+si], ax  ; Almacena el elemento intercambiado en el primer índice
    mov [array+si+2], bx; Almacena el elemento intercambiado en el segundo índice
skip_swap:
    add si, 2           ; Avanza al siguiente par de elementos
    cmp si, cx          ; Compara con CX para verificar si es el último par
    jl inner_loop       ; Salta si hay más pares por comparar
    loop outer_loop     ; Repite el proceso hasta que la lista esté ordenada

    ; Aquí puedes agregar el código para imprimir la lista ordenada

    mov ah, 4ch         ; Carga la función de salida
    int 21h             ; Salida del programa

end start   ; Fin del programa

