;AUTOR: Ruben Eduardo Davila FLores

GLOBAL main

section .data
    archEntrada db "data.txt", 0     ; Nombre del archivo de entrada
    archSalida db "DAVILA_FLORES_RUBEN_EDUARDO_COUNT.txt", 0  ; Nombre del archivo de salida
    letterA db 65                   ; Valor ASCII de la letra 'A'
    lettera db 97                   ; Valor ASCII de la letra 'a'
    contNum db 0                    ; Contador de números
    contLetras db 0                 ; Contador de letras
    ascii db 0                      ; Variable para almacenar el número convertido a ASCII
    espacio db " "                  ; Carácter espacio
    newline db 10                   ; Carácter de nueva línea
    comp db 1                       ; Variable de comparación

section .bss
    fd resw 1                       ; Descriptor de archivo
    fdOutput resw 1                 ; Descriptor de archivo para el archivo de salida
    buffer resb 1                   ; Búfer para lectura de archivos

section .text

    main:
        ; Abrir el archivo de entrada
        mov eax, 5
        mov ebx, archEntrada
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
            jz end                        ; Si es así, salir del bucle

            ; revisar si es el carácter que queremos

            mov al, [buffer]
            cmp al, [letterA]             ; Comparar para verificar si contiene la letra mayúscula
            je next
            cmp al, [lettera]             ; Comparar si es la letra en minúscula
            je next

            jmp read_loop

        end:
            ; Cerrar el archivo de lectura
            mov eax, 6
            mov ebx, [fd]
            int 0x80

            ; Revisar si se pasó por todas las letras de la A a la Z
            inc byte [contLetras]
            cmp byte [contLetras], 27
            je exit                         ; Salir
            jl compare                      ; Escribir en archivo

        next:
            inc byte [contNum]
            jmp read_loop

    compare:

        cmp byte [comp], 1
        je create
        jmp write

    create:
        inc byte [comp]
        mov eax, 8                       ; Número de llamada del sistema para crear un archivo
        mov ebx, archSalida               ; Nombre del archivo
        mov ecx, 0777                     ; Permisos (rwx rwx rwx)
        int 0x80                          ; Realizar la llamada al sistema
        mov [fdOutput], eax

        ; Cerrar el archivo de escritura
        mov eax, 6
        mov ebx, [fdOutput]
        int 0x80

        jmp write

    write:
        ; Abrir el archivo de escritura
        mov eax, 5
        mov ebx, archSalida
        mov ecx, 2                        ; Bandera para lectura y escritura
        mov edx, 777                      ; Permisos lectura, escritura y ejecución para todos
        int 0x80

        mov [fdOutput], eax

        ; Recorrer el offset en archivo
        mov eax, 0x13
        mov ebx, [fdOutput]
        mov ecx, 0
        mov edx, 2
        int 0x80
        ; Escribir una letra

        mov eax, 4                         ; Llamada al sistema "write"
        mov ebx, [fdOutput]                ; Descriptor de archivo: stdout
        mov ecx, letterA                   ; Valor de la letra
        mov edx, 1                         ; Longitud: 1 byte
        int 0x80

        ; Escribir un espacio
        mov eax, 4                         ; Llamada al sistema "write"
        mov ebx, [fdOutput]                ; Descriptor de archivo
        mov ecx, espacio                   ; Espacio en formato ASCII
        mov edx, 1                         ; Longitud: 1 byte
        int 0x80

        ; Cambiar el número a ASCII
        add byte [contNum], 48
        mov al, [contNum]
        mov [ascii], al

        ; Escribir el número en el archivo
        mov eax, 4
        mov ebx, [fdOutput]
        mov ecx, ascii
        mov edx, 1                         ; Longitud del búfer
        int 0x80

        ; Escribir el salto de línea en el archivo
        mov eax, 4
        mov ebx, [fdOutput]
        mov ecx, newline
        mov edx, 1                         ; Longitud del búfer
        int 0x80

        ; Cerrar el archivo de escritura
        mov eax, 6
        mov ebx, [fdOutput]
        int 0x80

        ; Moverse a la siguiente letra
        inc byte [letterA]
        inc byte [lettera]
        mov byte [contNum], 0

        mov eax, 5                        ; Identificador de llamada al sistema para abrir archivo
        mov ebx, archEntrada
        mov ecx, 2                        ; Bandera para lectura-escritura
        mov edx, 777                      ; Privilegios
        int 0x80                          ; Abrir el archivo

        mov [fd], eax                     ; Guardar el descriptor de archivo

        jmp read_loop

    exit:

        mov eax, 6
        mov ebx, [fd]
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80
