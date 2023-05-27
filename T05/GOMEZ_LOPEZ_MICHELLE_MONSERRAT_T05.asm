
GLOBAL main

section .bss
    fd resw 1                       ; Descriptor de archivo
    fdS resw 1                 ; Descriptor de archivo para el archivo de salida
    buffer resb 1                   ; Búfer para lectura de archivos

section .text

main:
    ; Abrir el archivo de entrada
    mov eax, 5
    mov ebx, archivo1
    mov ecx, 2                   ; Bandera para lectura y escritura
    mov edx, 777                 ; Permisos lectura, escritura y ejecución para todos
    int 0x80

    mov [fd], eax                 ; Guardar el descriptor de archivo

    read_loop:
        mov eax, 3
        mov ebx, dword [fd]
        mov ecx, buffer
        mov edx, 1                   ; Longitud del búfer (1 byte)
        int 0x80

        cmp eax, 0                   ; Comprobar si se llegó al final del archivo
        jz final                       ; Si es así, salir del bucle

        ; Revisar si es el carácter que queremos

        mov al, [buffer]
        cmp al, [letraMayus]             ; Comparar para verificar si contiene la letra mayúscula
        je sig
        cmp al, [letraMinus]             ; Comparar si es la letra en minúscula
        je sig

        jmp read_loop

    
    sig:
        inc byte [contN]
        jmp read_loop


    escribir:
        ; Abrir el archivo de escritura
        mov eax, 5
        mov ebx, archivo2
        mov ecx, 2                        ; Bandera para lectura y escritura
        mov edx, 777                      ; Permisos lectura, escritura y ejecución para todos
        int 0x80

        mov [fdS], eax

        ; Recorrer el offset en archivo
        mov eax, 0x13
        mov ebx, [fdS]
        mov ecx, 0
        mov edx, 2
        int 0x80
        ; Escribir una letra

        mov eax, 4                         ; Llamada al sistema "write"
        mov ebx, [fdS]                ; Descriptor de archivo: stdout
        mov ecx, letraMayus                   ; Valor de la letra
        mov edx, 1                         ; Longitud: 1 byte
        int 0x80

        ; Escribir un espacio
        mov eax, 4                         ; Llamada al sistema "write"
        mov ebx, [fdS]                ; Descriptor de archivo
        mov ecx, espacio                   ; Espacio en formato ASCII
        mov edx, 1                         ; Longitud: 1 byte
        int 0x80

        ; Cambiar el número a ASCII
        add byte [contN], 48
        mov al, [contN]
        mov [ascii], al

        ; Escribir el número en el archivo
        mov eax, 4
        mov ebx, [fdS]
        mov ecx, ascii
        mov edx, 1                         ; Longitud del búfer
        int 0x80

        ; Escribir el salto de línea en el archivo
        mov eax, 4
        mov ebx, [fdS]
        mov ecx, newline
        mov edx, 1                         ; Longitud del búfer
        int 0x80

        ; Cerrar el archivo de escritura
        mov eax, 6
        mov ebx, [fdS]
        int 0x80

        ; Moverse a la siguiente letra
        inc byte [letraMayus]
        inc byte [letraMinus]
        mov byte [contN], 0

        mov eax, 5                        ; Identificador de llamada al sistema para abrir archivo
        mov ebx, archivo1
        mov ecx, 2                        ; Bandera para lectura-escritura
        mov edx, 777                      ; Privilegios
        int 0x80                          ; Abrir el archivo

        mov [fd], eax                     ; Guardar el descriptor de archivo

        jmp read_loop
        

    compara:
        cmp byte [comp], 1
        je crear
        jmp escribir

    crear:
        inc byte [comp]
        mov eax, 8                       ; Número de llamada del sistema para crear un archivo
        mov ebx, archivo2               ; Nombre del archivo
        mov ecx, 0777                     ; Permisos (rwx rwx rwx)
        int 0x80                          ; Realizar la llamada al sistema
        mov [fdS], eax

        ; Cerrar el archivo de escritura
        mov eax, 6
        mov ebx, [fdS]
        int 0x80

        jmp escribir

    final:
        ; Cerrar el archivo de lectura
        mov eax, 6
        mov ebx, [fd]
        int 0x80

        ; Revisar si se pasó por todas las letras de la A a la Z
        inc byte [contL]
        cmp byte [contL], 27
        je exit                         ; Salir
        jl compara                      ; Escribir en archivo

    exit:                      ;saliendo del programa

        mov eax, 6
        mov ebx, [fd]
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80


    section .data
    archivo1 db "data.txt", 0    ; archivo inicial
    archivo2 db "GOMEZ_LOPEZ_MICHELLE_MONSERRAT_COUNT.txt", 0     ; arhcivo final
    letraMayus db 65                ; Valor ASCII de la letra 'A'
    letraMinus db 97                ; Valor ASCII de la letra 'a'
    contN db 0                    ; Contador
    contL db 0                 ; Contador
    ascii db 0                      ; almacena el número convertido a ASCII
    espacio db " "                  ;  espacio
    newline db 10                   ;  nueva línea
    comp db 1                       ; comparación