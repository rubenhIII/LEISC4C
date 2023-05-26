section .data
     filename db 'archivo.txt', 0
     buffer_size equ 256
     buffer db buffer_size
     counter db 26 dup(0)

 section .text
     global _start

 _start:
     ; Abrir el archivo
     mov eax, 5       ; número de la función del sistema para abrir archivo (open)
     mov ebx, filename
     mov ecx, 0       ; marca de modo de sólo lectura
     int 0x80         ; llama al sistema

     ; Guardar el descriptor de archivo en ebx
     mov ebx, eax

     ; Leer el archivo
     mov eax, 3       ; número de la función del sistema para leer archivo (read)
     mov edx, buffer_size
     mov ecx, buffer
     int 0x80         ; llama al sistema

     ; Contar las letras
     mov esi, buffer  ; puntero al búfer
     mov ecx, edx    ; longitud del búfer

 count_loop:
     lodsb            ; carga el siguiente byte en al y avanza el puntero
     cmp al, 0       ; si el byte es nulo, termina el bucle
     je end_count

     cmp al, 'A'
     jb skip_count
     cmp al, 'Z'
     ja skip_count

     sub al, 'A'     ; convierte la letra a un índice entre 0 y 25
     inc byte [counter + eax]

 skip_count:
     loop count_loop

 end_count:
     ; Cerrar el archivo
     mov eax, 6       ; número de la función del sistema para cerrar archivo (close)
     int 0x80         ; llama al sistema

     ; Mostrar los resultados
     mov esi, counter ; puntero al contador de letras
     mov ecx, 26      ; número de letras en el alfabeto

 display_loop:
     mov dl, byte [esi]
     add dl, '0'      ; convierte el número en un carácter
     mov ah, 2        ; número de la función del sistema para imprimir carácter (print)
     int 0x21         ; llama al sistema

     inc esi
     loop display_loop

     ; Salir del programa
     mov eax, 1       ; número de la función del sistema para salir (exit)
     xor ebx, ebx     ; código de salida cero
     int 0x80         ; llama al sistema