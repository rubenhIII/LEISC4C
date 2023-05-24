; Autor: Adrian Alonso Arambula 4°C ISC 
; Programa en Lenguaje Ensamblador para la arquitectura i386
; que lea los caracteres de un archivo de texto y cuente cuántas
; veces se repite cada letra del alfabeto.

; En este programa se lee caracter por caracter y se identifica la letra independientemente
; si es mayúscula o minúscula y se aumenta el contador de cada letra.
; Una vez leido el archivo completo, se crea o se abre un nuevo archivo de texto
; y se esciben los resultados en forma de lista (hasta 9999 de un mismo caracter).

GLOBAL main
; Nota: Se abre y cierra los archivo en 
; varias ocasiones, ya que es la única 
; forma encontrada para el funcionamiento correcto
section .data
    file db "data.txt",0
    file_c db "ALONSO_ARAMBULA_ADRIAN_COUNT.txt",0 
    ABC db "A"                          ;variable para mayusculas
    abc db "a"                          ;variable para minusculas
    space db " "                        ;espacio ASCII
    newline db 10                       ;nueva linea ASCII
    number_ascii db 0                   ;escritor en ASCII
    cont dw 0                           ;contador de letras
    imp dd 0                            ;variable que guarda residuo
    contl db 26                         ;contador de lecturas
    Error db "Error al abrir el archiv!",0    ;mensaje de Error
    msgerr equ $-Error                  ;tamaño de mensaje de Error
    fd  dd 1                            ;referencia del archivo de lectura
    fd_c dd 1                           ;referencia del archivo de escritura
    intdiv dd 100                       ; Divisor
    divisor dd 10                       ; Divisor del divisor inicial
    refnum dd 0                         ;referencia a contador
    limit db 0                          ;limite de bucle de escritura de numeros

section .bss
    buffer resb 1

section .text

    main:
        ;Borrar archivo si esta creado
        mov eax, 10 ; system call 10: para borrar el archivo
        mov ebx, file_c ; nombre del archivo a borrar
        int 0x80

        ; Abrir/Crear el archivo
        mov eax, 5          ; Código de llamada al sistema "open"
        mov ebx, file_c     ; Nombre del archivo
        mov ecx, 0102o      ; Modo de apertura (2 = O_WRONLY | O_CREAT)
        mov edx, 0666o      ; Permisos del archivo
        int 0x80            ; Llamada al sistema

        ;Guardar referencia de archivo
        mov [fd_c], eax

        ;Cerrar archiov de escritura
        mov eax, 6
        mov ebx, [fd_c]
        int 0x80

        mov eax, 5      ;Identificador llamada al sistema abrir archivo
        mov ebx, file
        mov ecx, 2      ;Bandera para lectura-escritura
        mov edx, 777    ;Privilegios
        int 0x80        ;Abrimos el archivo
            
        mov [fd], eax   ;Guardar identificador de archivo

        ; Comprobar si se abrió el archivo correctamente
        cmp eax, 0
        jz error
        jmp loop
 
    ext:
        ; Cerrar el archivo de origen
        mov eax, 6
        mov ebx, [fd]
        int 0x80
        ;Salir del codigo
        mov eax, 1
        mov ebx, 0
        int 0x80

    error:
        ; Imprimir mensaje de Error
        mov eax, 4
        mov ebx, 1
        mov ecx, Error
        mov edx, msgerr
        int 0x80
        jmp ext       
    
    loop:
        inter_loop:
            ;Leer el caracter
            mov eax, 3
            mov ebx, eax
            mov ecx, buffer
            mov edx, 1 ; Longitud del búfer (1 byte)
            int 0x80

            ;Verificar si llego al final del archivo
            cmp eax, 0
            jz cmpo

            ; Imprimir caracteres
            ; mov eax, 4
            ; mov ebx, 1
            ; mov ecx, buffer
            ; mov edx, 1
            ; int 0x80

            ;Verificar si la es la letra buscada
            mov al, byte[buffer]

            cmp byte[abc],al;Minusculas
            je aunc
            cmp byte[ABC],al;Mayusculas, 
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
            inc dword[cont] ;incrementar contardor de letras

            ;regresar al inicio del loop interno
            jmp inter_loop

        cmpo:
            ;cerrar el archivo de lectura
            mov eax, 6
            mov ebx, [fd]
            int 0x80
            jne escribir;escribir en archivo

    

    escribir:
        ; Crear archivo de resultados
        ;abrir archivo de escritura
        mov eax, 5
        mov ebx, file_c
        mov ecx, 2
        mov edx, 777
        int 0x80

        ;Guardar referencia de archivo
        mov [fd_c], eax

        ;Recorrer el offset en archivo
        mov eax, 0x13
        mov ebx, [fd_c]
        mov ecx, 0
        mov edx, 2
        int 0x80

        ;Escribir letra en Mayuscula
        mov eax, 4
        mov ebx, [fd_c]
        mov ecx, ABC
        mov edx, 1
        int 0x80

        ; Escribir el espacio en el archivo
        mov eax, 4
        mov ebx, [fd_c]
        mov ecx, space
        mov edx, 1 ; Longitud del buffer
        int 0x80

        ;si el numero es menor a 10
        cmp dword[cont],10
        ;configuracion de escritura de numeros
        mov byte[limit],1
        mov dword[intdiv],1
        mov eax, dword[cont]
        mov [refnum],eax
        jl less
        ;si el numero es menor a 100
        cmp dword[cont],100
        ;configuracion de escritura de numeros
        mov byte[limit],2
        mov dword[intdiv],10
        mov eax, dword[cont]
        mov [refnum],eax
        jl less
        ;si el numero es menor a 1000
        cmp dword[cont],1000
        ;configuracion de escritura de numeros
        mov byte[limit],3
        mov dword[intdiv],100
        mov eax, dword[cont]
        mov dword[refnum],eax
        jl less
        ;si el numero es menor a 1000
        cmp dword[cont],10000
        ;configuracion de escritura de numeros
        mov byte[limit],4
        mov dword[intdiv],1000
        mov eax, dword[cont]
        mov [refnum],eax
        jl less

        less:
            ;divicion
            mov eax, dword [refnum]
            xor edx, edx
            div dword [intdiv]
            ;guardar resultado y residuo
            mov dword [refnum], eax
            mov dword [imp], edx

            ;Pasar a numero ASCII
            mov al, byte[refnum]
            add al, 48
            mov byte[number_ascii], al

            ; Escribir el número en el archivo
            mov eax, 4
            mov ebx, [fd_c]
            mov ecx, number_ascii
            mov edx, 1 ; Longitud del buffer
            int 0x80

            mov dword[refnum],0;Limpiar numero de referencia

            ;mover residuo a numero de referencia
            mov eax,dword[imp]
            mov dword[refnum], eax
            
            ;dividir el divisor incial para la siguiene interacción
            mov eax, dword [intdiv]
            xor edx, edx
            div dword [divisor]
            ;mover resultado de la división
            mov dword [intdiv], eax
            ;decrementar contador de interacción
            dec byte[limit]
            cmp byte[limit], 0
            jz continuar
            jmp less
        continuar:
        ; Escribir el salto de línea en el archivo
        mov eax, 4
        mov ebx, [fd_c]
        mov ecx, newline
        mov edx, 1 ; Longitud del buffer
        int 0x80

        ;Cerrar archiov de escritura
        mov eax, 6
        mov ebx, [fd_c]
        int 0x80

        ;Siguiente letra
        inc byte[ABC]
        inc byte[abc]
        ;Reiniciar contador
        mov dword[cont],0

        ;Abrir archivo de lectura
        mov eax, 5      ;Identificador llamada al sistema abrir archivo
        mov ebx, file
        mov ecx, 2      ;Bandera para lectura-escritura
        mov edx, 777    ;Privilegios
        int 0x80        ;Abrimos el archivo
            
        mov [fd], eax   ;Guardar identificador de archivo
        ;revisar si paso por todas las letra de la A a la Z
        dec byte [contl]
        cmp byte [contl],0
        je ext;salir
        jmp loop
    ;23 de mayo de 2023 codigo termiando