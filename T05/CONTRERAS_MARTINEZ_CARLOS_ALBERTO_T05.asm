GLOBAL main

section .data
    archEntrada db "data.txt", 0    
    archSalida db "resultado.txt", 0  
    letraMayus db 65                
    letraMinus db 97                
    contNum db 0                    
    contLetras db 0
    ascii db 0                      
    espacio db " "                   
    newline db 10                   
    comp db 1                       ; Variable de comparación

section .bss
    fd resw 1                       ; Descriptor de archivo
    fdSalida resw 1                 ; Descriptor de archivo para el archivo de salida
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

        ; Revisar si es el carácter que queremos

        mov al, [buffer]
        cmp al, [letraMayus]             ; Comparar para verificar si contiene la letra mayúscula
        je next
        cmp al, [letraMinus]             ; Comparar si es la letra en minúscula
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

escribir:
    ; Abrir el archivo de escritura
    mov eax, 5
    mov

compare:
    cmp byte [comp], 1
    je crear
    jmp escribir

crear:
    inc byte [comp]
    mov eax, 8                       ; Número de llamada del sistema para crear un archivo
    mov ebx, archSalida               ; Nombre del archivo
    mov ecx, 0777                     ; Permisos (rwx rwx rwx)
    int 0x80                          ; Realizar la llamada al sistema
    mov [fdSalida], eax

    ; Cerrar el archivo de escritura
    mov eax, 6
    mov ebx, [fdSalida]
    int 0x80

    jmp escribir