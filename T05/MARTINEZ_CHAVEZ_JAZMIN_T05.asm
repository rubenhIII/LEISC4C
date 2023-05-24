section .data
    alphabet db "abcdefghijklmnopqrstuvwxyz",0   ; Alfabeto en minúsculas
    counts times 26 db 0                         ; Contador para cada letra del alfabeto

section .bss
    buffer resb 1                                ; Buffer para leer un carácter del archivo

section .text
    global _start

_start:
    ; Abrir el archivo de texto para lectura
    mov eax, 5               ; Código del sistema para abrir archivo
    mov ebx, input           ; Nombre del archivo (input.txt)
    mov ecx, 0               ; Modo de apertura (lectura)
    int 0x80                 ; Llamada al sistema

    ; Leer caracteres y contar frecuencia
read_loop:
    mov eax, 3               ; Código del sistema para leer archivo
    mov ebx, 3               ; Descriptor de archivo (asume que se abrió con fd=3)
    mov ecx, buffer          ; Dirección del búfer para almacenar el carácter leído
    mov edx, 1               ; Longitud del búfer
    int 0x80                 ; Llamada al sistema

    cmp eax, 0               ; Verificar si llegó al final del archivo
    je end_loop

    ; Actualizar el contador para el carácter leído
    movzx eax, byte [buffer]
    sub al, 'a'              ; Convertir a índice basado en 'a'
    inc byte [counts + eax]

    jmp read_loop

end_loop:
    ; Cerrar el archivo
    mov eax, 6               ; Código del sistema para cerrar archivo
    mov ebx, 3               ; Descriptor de archivo
    int 0x80                 ; Llamada al sistema

    ; Mostrar los resultados
    mov esi, alphabet        ; Puntero al alfabeto
    mov edi, counts          ; Puntero a los contadores

    print_loop:
    movzx eax, byte [edi]    ; Obtener el contador actual
    cmp eax, 0               ; Verificar si es cero
    jz skip_print

    add eax, '0'             ; Convertir a carácter ASCII
    push eax                 ; Empujar el carácter en la pila
    mov eax, 4               ; Código del sistema para escribir en la salida estándar
    mov ebx, 1               ; Descriptor de archivo (salida estándar)
    mov ecx, esp             ; Dirección del carácter en la pila
    mov edx, 1               ; Longitud del búfer
    int 0x80                 ; Llamada al sistema

    add esp, 4               ; Ajustar la pila

    skip_print:
    inc esi                  ; Avanzar al siguiente carácter del alfabeto
    inc edi                  ; Avanzar al siguiente contador

    cmp byte [esi], 0        ; Verificar si llegó al final del alfabeto
    jnz print_loop

exit:
    mov eax, 1               ; Código del sistema para salir
    xor ebx



