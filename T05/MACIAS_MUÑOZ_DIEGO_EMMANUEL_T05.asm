section .data
    file db "data.txt", 0
    buffer_size equ 30
    counts times 26 db 0

section .bss
    fd resw 1
    buffer resb buffer_size

section .text
    global _start

_start:
    ; Abrir archivo
    mov eax, 5      ; Identificador de llamada al sistema abrir archivo
    mov ebx, file
    mov ecx, 0      ; Bandera para lectura
    int 0x80        ; Abrir el archivo
    mov [fd], eax   ; Guardar el identificador del archivo en la variable fd

    ; Leer contenido del archivo y contar letras
    mov eax, 3      ; Identificador de llamada al sistema leer archivo
    mov ebx, [fd]   ; Cargar el identificador del archivo
    mov ecx, buffer ; Puntero al buffer de lectura
    mov edx, buffer_size ; Tamaño de lectura
    int 0x80        ; Leer contenido del archivo

    ; Cerrar archivo
    mov eax, 6      ; Identificador de llamada al sistema cerrar archivo
    mov ebx, [fd]   ; Cargar el identificador del archivo
    int 0x80        ; Cerrar el archivo

    ; Contar letras y almacenar los resultados en el arreglo "counts"
    mov esi, buffer ; Puntero al contenido del archivo
.count_loop:
    lodsb           ; Cargar siguiente byte en AL y avanzar puntero
    cmp al, 'a'
    jb .skip_count  ; Si el carácter es menor que 'a', saltar al siguiente carácter
    cmp al, 'z'
    ja .skip_count  ; Si el carácter es mayor que 'z', saltar al siguiente carácter
    sub al, 'a'     ; Restar 'a' para obtener el índice en el arreglo de conteo
    inc byte [counts + eax]  ; Incrementar el contador correspondiente
.skip_count:
    cmp byte [esi], 0 ; Verificar si llegamos al final del archivo
    jne .count_loop

    ; Imprimir conteo de letras
    mov esi, 'a'    ; Iniciar con la letra 'a'
    mov edi, 0      ; Contador de letras
.print_loop:
    movzx eax, byte [counts + edi]  ; Cargar el conteo de la letra en AL
    add al, '0'    ; Convertir el conteo en un carácter
    mov [buffer], al

    ; Escribir letra y conteo en la salida estándar
    mov eax, 4     ; Identificador de la llamada al sistema escribir
    mov ebx, 1     ; Descriptor de archivo para la salida estándar
    mov ecx, esi   ; Apuntador a la letra
    mov edx, 1     ; Tamaño de la letra (un solo carácter)
    int 0x80       ; Escribir la letra en la salida estándar

    mov eax, 4     ; Identificador de la llamada al sistema escribir
    mov ebx, 1     ; Descriptor de archivo para la salida estándar
    mov ecx, buffer  ; Apuntador al conteo
    mov edx, 1     ; Tamaño del conteo (un solo carácter)
    int 0x80       ; Escribir el conteo en la salida estándar

    inc esi        ; Avanzar a la siguiente letra
    inc edi        ; Avanzar al siguiente índice de conteo
    cmp edi, 26    ; Verificar si hemos recorrido todas las letras
    jl .print_loop

    ; Salir del programa
    mov eax, 1      ; Identificador de llamada al sistema para salir
    xor ebx, ebx    ; Código de salida 0
    int 0x80
