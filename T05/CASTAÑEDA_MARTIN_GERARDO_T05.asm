section .data
    file_name db "/home/geras/Documentos/Codigos_ensamblador/data.txt", 0
    output_file_name db "/home/geras/Documentos/Codigos_ensamblador/CASTAÑEDA_MARTIN_GERARDO_COUNT.txt", 0
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ", 0
    count_msg db "%c %d", 10, 0
    eof_msg db "Fin del archivo", 10, 0
    file_error_msg db "Error al abrir el archivo", 10, 0
    output_file_error_msg db "Error al crear el archivo de conteo", 10, 0

section .bss
    buffer resb 256
    counts resd 26  ; arreglo para almacenar los conteos de cada letra

section .text

global _start

_start:
    ; Abrir el archivo de entrada
    mov eax, 5            ; syscall number para abrir un archivo
    mov ebx, file_name    ; nombre del archivo
    mov ecx, 0            ; banderas de apertura (solo lectura)
    int 0x80              ; invocar la interrupción del sistema

    cmp eax, -1           ; comprobar si hubo un error al abrir el archivo
    je file_error

    mov ebx, eax          ; almacenar el descriptor de archivo en ebx

    ; Crear o truncar el archivo de salida
    mov eax, 8            ; syscall number para crear o truncar un archivo
    mov ebx, output_file_name
    mov ecx, 0644         ; permisos del archivo (lectura/escritura para el usuario)
    int 0x80

    cmp eax, -1           ; comprobar si hubo un error al crear o truncar el archivo
    je output_file_error

    mov edx, eax          ; almacenar el descriptor de archivo en edx

    ; Inicializar los conteos de las letras a 0
    mov edi, counts
    xor ecx, ecx
    mov eax, 26
    rep stosd

read_loop:
    ; Leer el archivo de entrada en el búfer
    mov eax, 3            ; syscall number para leer de un archivo
    mov ebx, ebx          ; descriptor de archivo de entrada
    mov ecx, buffer       ; búfer de lectura
    mov edx, 255          ; tamaño máximo de lectura
    int 0x80              ; invocar la interrupción del sistema

    cmp eax, 0            ; comprobar si se alcanzó el final del archivo
    je end_of_file

    ; Contar las letras en el búfer de lectura
    mov esi, buffer
count_loop:
    movzx edi, byte [esi]  ; leer el siguiente carácter del búfer de lectura
    cmp edi, 0            ; comprobar si se alcanzó el final del búfer
    je read_loop

    ; Comparar el carácter con cada letra del alfabeto
    mov edi, 0
compare_loop:
    cmp byte [alphabet + edi], 0  ; comprobar si se alcanzó el final del alfabeto
    je count_loop

    cmp byte [alphabet + edi], al ; comparar el carácter con la letra actual del alfabeto
    jne next_letter
    ; Incrementar el contador de la letra actual del alfabeto
    add dword [counts + edi*4], 1

    jmp count_loop

next_letter:
    inc edi               ; pasar a la siguiente letra del alfabeto
    jmp compare_loop

end_of_file:
    ; Escribir los conteos de las letras en el archivo de salida
    mov ecx, counts       ; dirección del arreglo de conteos
    mov esi, alphabet     ; dirección del alfabeto

write_loop:
    movzx eax, byte [esi]  ; obtener la letra actual del alfabeto
    mov edx, dword [ecx]  ; obtener el conteo correspondiente
    cmp edx, 0            ; comprobar si el conteo es 0
    je next_letter_write

    ; Escribir la letra y el conteo en el archivo de salida
    mov eax, 4            ; syscall number para escribir en un archivo
    mov ebx, edx          ; descriptor de archivo de salida
    mov edx, 2            ; número de argumentos
    mov edi, count_msg    ; mensaje de formato
    int 0x80              ; invocar la interrupción del sistema

next_letter_write:
    add esi, 1            ; pasar a la siguiente letra del alfabeto
    add ecx, 4            ; pasar al siguiente conteo

    cmp byte [esi], 0     ; comprobar si se alcanzó el final del alfabeto
    jne write_loop

    ; Escribir el mensaje de finalización en el archivo de salida
    mov eax, 4            ; syscall number para escribir en un archivo
    mov ebx, edx          ; descriptor de archivo de salida
    mov edx, eof_msg      ; mensaje de finalización
    mov ecx, 0            ; longitud del mensaje
    int 0x80              ; invocar la interrupción del sistema

    ; Cerrar los archivos
    mov eax, 6            ; syscall number para cerrar un archivo
    mov ebx, ebx          ; descriptor de archivo de entrada
    int 0x80

    mov eax, 6            ; syscall number para cerrar un archivo
    mov ebx, edx          ; descriptor de archivo de salida
    int 0x80

    ; Salir del programa
    mov eax, 1            ; syscall number para salir del programa
    xor ebx, ebx          ; código de salida 0
    int 0x80

file_error:
    ; Manejar el error al abrir el archivo de entrada
    mov eax, 4            ; syscall number para escribir en la salida estándar
    mov ebx, 1            ; salida estándar (consola)
    mov ecx, file_error_msg
    mov edx, 0            ; longitud del mensaje
    int 0x80              ; invocar la interrupción del sistema

    jmp exit_program

output_file_error:
    ; Manejar el error al crear o truncar el archivo de salida
    mov eax, 4            ; syscall number para escribir en la salida estándar
    mov ebx, 1            ; salida estándar (consola)
    mov ecx, output_file_error_msg
    mov edx, 0            ; longitud del mensaje
    int 0x80              ; invocar la interrupción del sistema

exit_program:
    ; Salir del programa
    mov eax, 1            ; syscall number para salir del programa
    mov ebx, 1
    int 0x80

