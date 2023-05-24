GLOBAL main

section .data
file db "data.txt",0
file_c db "MELGOZA_DELATORRE_ABRAHAM_COUNT.txt",0
ABC db "A" ; variable para mayúsculas
abc db "a" ; variable para minúsculas
space db " " ; espacio ASCII
newline db 10 ; nueva línea ASCII
number_ascii db 0 ; escritor en ASCII
cont dw 0 ; contador de letras
imp dd 0 ; variable que guarda residuo
contl db 26 ; contador de lecturas
Error db "Error al abrir el archivo!",0 ; mensaje de error
msgerr equ $-Error ; tamaño de mensaje de error
fd dd 1 ; referencia del archivo de lectura
fd_c dd 1 ; referencia del archivo de escritura
intdiv dd 100 ; divisor
divisor dd 10 ; divisor del divisor inicial
refnum dd 0 ; referencia a contador
limit db 0 ; límite de bucle de escritura de números

section .bss
buffer resb 1

section .text
main:
    ; Borrar archivo si está creado
    mov eax, 10 ; system call 10: para borrar el archivo
    mov ebx, file_c ; nombre del archivo a borrar
    int 0x80

    ; Abrir/Crear el archivo
    mov eax, 5          ; código de llamada al sistema "open"
    mov ebx, file_c     ; nombre del archivo
    mov ecx, 0102o      ; modo de apertura (2 = O_WRONLY | O_CREAT)
    mov edx, 0666o      ; permisos del archivo
    int 0x80            ; llamada al sistema

    ; Guardar referencia de archivo
    mov [fd_c], eax

    ; Cerrar archivo de escritura
    mov eax, 6
    mov ebx, [fd_c]
    int 0x80

    mov eax, 5      ; Identificador llamada al sistema abrir archivo
    mov ebx, file
    mov ecx, 2      ; Bandera para lectura-escritura
    mov edx, 777    ; Privilegios
    int 0x80        ; Abrimos el archivo
        
    mov [fd], eax   ; Guardar identificador de archivo

    ; Comprobar si se abrió el archivo correctamente
    cmp eax, 0
    jz error
    jmp loop

ext:
    ; Cerrar el archivo de origen
    mov eax, 6
    mov ebx, [fd]
    int 0x80
    ; Salir del código
    mov eax, 1
    mov ebx, 0
    int 0x80

error:
    ; Imprimir mensaje de error
    mov eax, 4
    mov ebx, 1
    mov ecx, Error
    mov edx, msgerr
    int 0x80
    jmp ext       

loop:
    inter_loop:
        ; Leer el carácter
        mov eax, 3
        mov ebx, eax
        mov ecx, buffer
        mov edx, 1 ; longitud del búfer (1 byte)
        int 0x80

        ; Verificar si llegó al final del archivo
        cmp eax, 0
        jz cmpo

        ; Verificar si es la letra buscada
        mov al, byte[buffer]

        cmp byte[abc], al ; Minúsculas
        je aunc
        cmp byte[ABC], al ; Mayúsculas 
        je aunc

        mov eax, 19 ; Llamada al sistema "lseek"
        mov ebx, [fd] ; Descriptor de archivo del archivo abierto
        mov ecx, 0 ; Desplazamiento: 1 byte (siguiente carácter)
        mov edx, 1 ; Origen: SEEK_CUR (desplazamiento relativo)
        int 0x80
        jmp inter_loop

    aunc:
        ; Mover el puntero de archivo al siguiente carácter
        mov eax, 19 ; Llamada al sistema "lseek"
        mov ebx, [fd] ; Descriptor de archivo del archivo abierto
        mov ecx, 0 ; Desplazamiento: 1 byte (siguiente carácter)
        mov edx, 1 ; Origen: SEEK_CUR (desplazamiento relativo)
        int 0x80
        inc dword[cont] ; Incrementar contador de letras

        ; Regresar al inicio del loop interno
        jmp inter_loop

    cmpo:
        ; Cerrar el archivo de lectura
        mov eax, 6
        mov ebx, [fd]
        int 0x80
        jne escribir ; Escribir en archivo

escribir:
    ; Abrir archivo de escritura
    mov eax, 5
    mov ebx, file_c
    mov ecx, 2
    mov edx, 777
    int 0x80

    ; Guardar referencia de archivo
    mov [fd_c], eax

    ; Recorrer el offset en archivo
    mov eax, 0x13
    mov ebx, [fd_c]
    mov ecx, 0
    mov edx, 2
    int 0x80

    ; Escribir letra en mayúscula
    mov eax, 4
    mov ebx, [fd_c]
    mov ecx, ABC
    mov edx, 1
    int 0x80

    ; Escribir el espacio en el archivo
    mov eax, 4
    mov ebx, [fd_c]
    mov ecx, space
    mov edx, 1 ; longitud del buffer
    int 0x80

    ; Configuración de escritura de números según el valor del contador
    cmp dword[cont], 10
    mov byte[limit], 1
    mov dword[intdiv], 1
    mov eax, dword[cont]
    mov [refnum], eax
    jl less

    cmp dword[cont], 100
    mov byte[limit], 2
    mov dword[intdiv], 10
    mov eax, dword[cont]
    mov [refnum], eax
    jl less

    cmp dword[cont], 1000
    mov byte[limit], 3
    mov dword[intdiv], 100
    mov eax, dword[cont]
    mov dword[refnum], eax
    jl less

    cmp dword[cont], 10000
    mov byte[limit], 4
    mov dword[intdiv], 1000
    mov eax, dword[cont]
    mov [refnum], eax
    jl less

    less:
        ; División
        mov eax, dword[refnum]
        xor edx, edx
        div dword[intdiv]
        ; Guardar resultado y residuo
        mov dword[refnum], eax
        mov dword[imp], edx

        ; Pasar a número ASCII
        mov al, byte[refnum]
        add al, 48
        mov byte[number_ascii], al

        ; Escribir el número en el archivo
        mov eax, 4
        mov ebx, [fd_c]
        mov ecx, number_ascii
        mov edx, 1 ; longitud del buffer
        int 0x80

        mov dword[refnum], 0 ; Limpiar número de referencia

        ; Mover residuo a número de referencia
        mov eax, dword[imp]
        mov dword[refnum], eax

        ; Dividir el divisor inicial para la siguiente iteración
        mov eax, dword[intdiv]
        xor edx, edx
        div dword[divisor]
        ; Mover resultado de la división
        mov dword[intdiv], eax
        ; Decrementar contador de iteración
        dec byte[limit]
        cmp byte[limit], 0
        jz continuar
        jmp less

    continuar:
    ; Escribir el salto de línea en el archivo
    mov eax, 4
    mov ebx, [fd_c]
    mov ecx, newline
    mov edx, 1 ; longitud del buffer
    int 0x80

    ; Cerrar archivo de escritura
    mov eax, 6
    mov ebx, [fd_c]
    int 0x80

    ; Siguiente letra
    inc byte[ABC]
    inc byte[abc]
    ; Reiniciar contador
    mov dword[cont], 0

    ; Abrir archivo de lectura
    mov eax, 5      ; Identificador llamada al sistema abrir archivo
    mov ebx, file
    mov ecx, 2      ; Bandera para lectura-escritura
    mov edx, 777    ; Privilegios
    int 0x80        ; Abrimos el archivo
        
    mov [fd], eax   ; Guardar identificador de archivo
    ; Revisar si pasó por todas las letras de la A a la Z
    dec byte[contl]
    cmp byte[contl], 0
    je ext ; Salir
    jmp loop
