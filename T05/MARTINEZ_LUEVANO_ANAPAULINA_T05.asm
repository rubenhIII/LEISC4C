 GLOBAL main
; Nota: ; Nota:mi compañero Alonso_Arambula me estuvo asesorando con el programa 
section .data
    Origen db "data.txt",0
    Destino db  "MARTINEZ_LUEVANO_ANAPAULINA_COUNT.txt",0 
    ABC db "A" ; donde empiezan las mayusculas segun el codigo ASCII
    abc db "a" ;donde empiezan las munisculas en el codigo ASCII
    espacio db " "
    newline db 10
    number_ascii db 0
    cont db 0
    contl db 0
    contador db 1
    

section .bss
    fd_L  resw 1
    fd_N resw 1
    buffer resb 1

section .text

    main:
        ;abrir el archivo origen 
        mov eax, 5      ; abrir archivo
        mov ebx, Origen
        mov ecx, 2      ;Bandera para lectura-escritura
        mov edx, 777    ;Privilegios
        int 0x80        ;Abrimos el archivo
            
        mov [fd_L], eax   ;Guardar identificador de archivo

        ; Comprobar si se abrió el archivo correctamente
        cmp eax, -1
        jz error
        jmp LeerChar

 
    ext:
        ; Cerrar el archivo de origen
        mov eax, 6
        mov ebx, [fd_L]
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80

    error:
        ; Imprimir mensaje de Error
        mov eax, 1 ; para salir 
        mov ebx, 1 ; indica que hubo un error
        int 0x80
        jmp ext       
    

        LeerChar:
            ;Leer el caracter
            mov eax, 3 ; llama el sistema para leer
            mov ebx, eax
            mov ecx, buffer;buffer de lectura 
            mov edx, 1 ; para que solo lea 1 byte 
            int 0x80

            ;Verificar si llego al final del archivo
            cmp eax, 0
            jz finArc ; si se llego al final del archivo entonces salta a la etiqueta fin Arc

            ;Verificar si la es la letra buscada
            mov al, [buffer] ; se manda la letra que esta leyendo a al
            cmp al, [ABC];Mayusculas-compara 
            je sigC
            cmp al, [abc];Minusculas-compara
            je sigC

            ;Mover el puntero de archivo al siguiente carácter
            mov eax, 19 ; Llamada al sistema "lseek" que nos permite movernos dentro del archivo
            mov ebx, [fd_L] ; Descriptor de archivo del archivo abierto
            mov ecx, 0 ; Desplazamiento: 1 byte (siguiente carácter)
            mov edx, 1 ; Origen: SEEK_CUR (desplazamiento relativo)
            int 0x80

            ;regresar al inicio del loop interno
            jmp LeerChar

        finArc:
            ;cerrar el archivo de lectura
            mov eax, 6
            mov ebx, [fd_L]
            int 0x80

            inc byte [contl]
            cmp byte [contl], 27
            je ext                      ; Salir


            jmp escribir;escribir en archivo

    sigC:
        ; Mover el puntero de archivo al siguiente carácter
        mov eax, 19 ; Llamada al sistema "lseek" que nos permite movernos dentro del archivo
        mov ebx, [fd_L] ; guarda la posicion 
        mov ecx, 0 ; lee un byte 
        mov edx, 1 ; nos indica la posicion actual para movernos 
        int 0x80
        inc byte[cont] ;incrementar contardor de letras
        jmp LeerChar;regresar al loop interno


    escribir:
        cmp byte[contador], 1
        je CrearArchivo
    

        ;abrir archivo de escritura
        mov eax, 5
        mov ebx, Destino
        mov ecx, 2
        mov edx, 777
        int 0x80

        ;Guardar referencia de archivo
        mov [fd_N], eax

        ;Recorrer el offset en archivo
        mov eax, 0x13
        mov ebx, [fd_N]
        mov ecx, 0
        mov edx, 2
        int 0x80

        ;Escribir letra en Mayuscula
        mov eax, 4 ; llama al sistema para escribir
        mov ebx, [fd_N]
        mov ecx, ABC ; direccion de variable
        mov edx, 1 ;longitud de variables
        int 0x80

        ; Escribir el espacio en el archivo
        mov eax, 4
        mov ebx, [fd_N]
        mov ecx, espacio
        mov edx, 1 ; Longitud del buffer
        int 0x80

        ;Cambiar el numero a ASCII
        add byte [cont], 48
        mov al, [cont]
        mov [number_ascii], al

        ; Escribir el número en el archivo
        mov eax, 4
        mov ebx, [fd_N]
        mov ecx, number_ascii
        mov edx, 1 ; Longitud del buffer
        int 0x80

        ; Escribir el salto de línea en el archivo
        mov eax, 4
        mov ebx, [fd_N]
        mov ecx, newline
        mov edx, 1 ; Longitud del buffer
        int 0x80

        ;Cerrar archiov de escritura
        mov eax, 6
        mov ebx, [fd_N]
        int 0x80

        ;Siguiente letra
        inc byte[ABC]
        inc byte[abc]
        ;Reiniciar contador
        mov byte[cont],0

        ;Abrir archivo de lectura
        mov eax, 5      ;Identificador llamada al sistema abrir archivo
        mov ebx, Origen
        mov ecx, 2      ;Bandera para lectura-escritura
        mov edx, 777    ;Privilegios
        int 0x80        ;Abrimos el archivo
            
        mov [fd_L], eax   ;Guardar identificador de archivo

        jmp LeerChar


        CrearArchivo:
        inc byte[contador]
            ;vamos a crear el archivo donde se guardaran los resultados
        mov eax, 5          ; Código de llamada al sistema para abrir el archivo 
        mov ebx, Destino    
        mov ecx, 0102o      ; Modo de apertura 
        mov edx, 0666o      ; Permisos del archivo
        int 0x80            

        ;Guardar referencia de archivo
        mov [fd_N], eax

        ;Cerrar archiov de escritura
        mov eax, 6
        mov ebx, [fd_N]
        int 0x80

        jmp escribir
        