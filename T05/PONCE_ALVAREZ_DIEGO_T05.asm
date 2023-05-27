section .data
    file_name db "victima.txt", 0
    buffer_size equ 1024
    alphabet_size equ 26
    alphabet db "abcdefghijklmnopqrstuvwxyz"

section .bss
    buffer resb buffer_size
    counts resb alphabet_size

section .text
    global main

main:
    ; Abrir el archivo en modo de lectura
    mov eax, 5  ; Código de la llamada al sistema 'open'
    mov ebx, file_name
    mov ecx, 0  ; Modo de lectura
    int 0x80    ; Realizar la llamada al sistema

    cmp eax, -1
    je error_exit
    mov ebx, eax  ; Guardar el descriptor de archivo en ebx

read_loop:
    ; Leer desde el archivo al búfer
    mov eax, 3  ; Código de la llamada al sistema 'read'
    mov ebx, eax  ; Descriptor de archivo
    mov ecx, buffer
    mov edx, buffer_size
    int 0x80    ; Realizar la llamada al sistema

    cmp eax, 0  ; Si se alcanza el final del archivo, salir del bucle
    je count_chars

    ; Contar las letras en el búfer
    mov ecx, eax  ; Longitud del búfer
    mov edi, buffer
count_chars_loop:
    movzx eax, byte [edi]  ; Cargar el siguiente carácter en al
    cmp al, 'a'
    jb next_char
    cmp al, 'z'
    ja next_char
    sub al, 'a'  ; Convertir la letra en un índice (0-25)
    inc byte [counts + eax]
next_char:
    inc edi
    loop count_chars_loop

    jmp read_loop

count_chars:
    ; Imprimir los conteos de letras
    mov ecx, alphabet_size
    mov esi, counts
print_loop:
    movzx eax, byte [esi]
    add eax, '0'  ; Convertir el número en un carácter
    mov [esi], al  ; Guardar el carácter en el búfer

    ; Escribir el carácter en la salida estándar
    mov eax, 4  ; Código de la llamada al sistema 'write'
    mov ebx, 1  ; Descriptor de archivo de salida estándar
    mov ecx, esi
    mov edx, 1  ; Longitud del búfer
    int 0x80    ; Realizar la llamada al sistema

    inc esi
    loop print_loop

exit:
    ; Cerrar el archivo
    mov eax, 6  ; Código de la llamada al sistema 'close'
    mov ebx, ebx
    int 0x80    ; Realizar la llamada al sistema

    ; Salir del programa
    mov eax, 1  ; Código de la llamada al sistema 'exit'
    xor ebx, ebx
    int 0x80    ; Realizar la llamada al sistema

error_exit:
    ; Manejar el error al abrir el archivo
    mov eax, 4  ; Código de la llamada al sistema 'write'
    mov ebx, 2  ; Descriptor de archivo de error estándar
    mov ecx, file_name
    mov edx, 11  ; Longitud del mensaje de error
    int 0x80    ; Realizar la llamada al sistema

    jmp exit