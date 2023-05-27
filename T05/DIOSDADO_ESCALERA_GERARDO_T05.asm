; Realizar un programa en ensamblador que abra un archivo existente de nombre data.txt
; y cuente el número de veces que se repite cada letra del alfabeto.
; Crear un archivo donde Se guarde el conteo de cada letra en el siguiente formato:
; A n
; B n
; C n
; ...
; El nombre del archivo de salida será DIOSDADO_ESCALERA_GERARDO_COUNT.txt

GLOBAL main

section .data
    ; Archivos de lectura y escritura y referencias
    FileWrite DB "DIOSDADO_ESCALERA_GERARDO_COUNT.txt",0
    FW DD 1
    FileRead DB "data.txt",0
    FR DD 1

    ; Variables de impresión y conteo
    MAY DB 65       ; Empieza en A
    min DB 97       ; Empieza en a
    Space DB 32     ; Espacio
    Number DB 0     ; Numero de letras
    Newline DB 10   ; Salto de linea
    Rem DW 0        ; Residuo de la división
    imp DD 0        ; residuo
    Letters DB 26   ; Letras del alfabeto ingles

    ; Contador de letras
    Counter DD 0
    Aux DD 0
    Aux2 DD 0

section .bss
    Buffer resb 1   ; Buffer para leer un caracter

section .text
    main:
        ; Borrar el archivo de escritura si existe
        mov EAX, 10         ; Llamada sys_unlink (eliminar archivo)
        mov EBX, FileWrite  ; Nombre del archivo de escritura
        int 0x80            ; Llamada al sistema para eliminar archivo

        ; Abrir el archivo de escritura o crearlo si no existe
        mov EAX, 5          ; Llamada sys_open (abrir archivo)
        mov EBX, FileWrite  ; Nombre del archivo de escritura
        mov ECX, 00222      ; Bandera para escritura
        mov EDX, 666o       ; Privilegios de lectura y escritura
        int 0x80            ; Llamada al sistema para abrir archivo

        ; Guardar identificador de archivo de escritura
        mov [FW], EAX

        ; Cerrar el archivo de escritura
        mov EAX, 6      ; Llamada sys_close (cerrar archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        int 0x80        ; Llamada al sistema para cerrar archivo

        ; Abrir el archivo de lectura
        mov EAX, 5          ; Llamada sys_open (abrir archivo)
        mov EBX, FileRead   ; Nombre del archivo de lectura
        mov ECX, 00444      ; Bandera para lectura
        mov EDX, 444o       ; Privilegios de lectura
        int 0x80            ; Llamada al sistema para abrir archivo
        
        ; Guardar identificador de archivo de lectura
        mov [FR], EAX
    
    CmpLetter:
        CmpText:
            ; Leer un caracter del archivo
            mov EAX, 3      ; Llamada sys_read (leer archivo)
            mov EBX, [FR]   ; Identificador de archivo de lectura
            mov ECX, Buffer ; Buffer para almacenar el caracter leído
            mov EDX, 1      ; Número de bytes a leer (1 byte)
            int 0x80        ; Llamada al sistema para leer archivo

            ; Verificar si se llegó al final del archivo
            cmp EAX, 0  ; Si EAX es 0, se llegó al final del archivo
            jz EOF     ; Saltar si se llegó al final del archivo

            ; Verificar si el caracter leído es una letra
            mov AL, byte [Buffer]   ; Mover el caracter leído a AL
            cmp byte[MAY],AL        ; Comparar con la letra mayuscula
            je Increase                 ; Saltar si es mayuscula
            cmp byte[min],AL        ; Comparar con la letra minuscula
            je Increase                 ; Saltar si es minuscula

            ; Recorrer el offset en archivo de lectura para leer el siguiente caracter
            mov EAX, 19     ; Llamada sys_lseek (reposicionar offset en archivo)
            mov EBX, [FR]   ; Identificador de archivo de lectura
            mov ECX, 0      ; Offset a reposicionar (0 bytes)
            mov EDX, 1      ; Bandera para reposicionar offset (1 = SEEK_CUR)
            int 0x80        ; Llamada al sistema para reposicionar offset en archivo

            ; Comparar el siguiente caracter
            jmp CmpText

    Increase:
        ; Incrementar contador de letras
        inc byte[Counter]

        ; Recorrer el offset en archivo de lectura para leer el siguiente caracter
        mov EAX, 19         ; Llamada sys_lseek (reposicionar offset en archivo)
        mov EBX, [FR]       ; Identificador de archivo de lectura
        mov ECX, 0          ; Offset a reposicionar (0 bytes)
        mov EDX, 1          ; Bandera para reposicionar offset (1 = SEEK_CUR)
        int 0x80            ; Llamada al sistema para reposicionar offset en archivo

        ; Comparar el siguiente caracter
        jmp CmpText

    EOF:
        ; Cerrar el archivo de lectura
        mov EAX, 6      ; Llamada sys_close (cerrar archivo)
        mov EBX, [FR]   ; Identificador de archivo de lectura
        int 0x80        ; Llamada al sistema para cerrar archivo

        ; Abrir el archivo de escritura
        mov EAX, 5          ; Llamada sys_open (abrir archivo)
        mov EBX, FileWrite  ; Nombre del archivo de escritura
        mov ECX, 00333      ; Bandera para escritura
        mov EDX, 666o       ; Privilegios de lectura y escritura
        int 0x80            ; Llamada al sistema para abrir archivo

        ; Recorrer el offset en archivo de escritura para escribir al final
        mov EAX, 19     ; Llamada sys_lseek (reposicionar offset en archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        mov ECX, 0      ; Offset a reposicionar (0 bytes)
        mov EDX, 2      ; Bandera para reposicionar offset (2 = SEEK_END)
        int 0x80        ; Llamada al sistema para reposicionar offset en archivo

        ; Escribir la letra actual
        mov EAX, 4      ; Llamada sys_write (escribir archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        mov ECX, MAY    ; Letra actual
        mov EDX, 1      ; Número de bytes a escribir (1 byte)
        int 0x80        ; Llamada al sistema para escribir archivo

        ; Escribir el espacio
        mov EAX, 4      ; Llamada sys_write (escribir archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        mov ECX, Space  ; Espacio
        mov EDX, 1      ; Número de bytes a escribir (1 byte)
        int 0x80        ; Llamada al sistema para escribir archivo

        ; Escribir el contador de letras
        mov AL, byte[Counter]   ; Mover el contador de letras a AL
        cmp byte[Counter], 100  ; Verificar si el contador es mayor o igual a 100
        jge Hundred             ; Saltar si es mayor o igual a 100
        cmp byte[Counter], 10   ; Verificar si el contador es mayor o igual a 10
        jge Ten                 ; Saltar si es mayor o igual a 10
        jmp One                 ; Saltar si es menor a 10

        Hundred:
            mov BL, 100         ; Divisor
            div BL              ; Dividir AL entre BL
            add AL, 48          ; Sumar 48 para convertir a caracter
            mov byte[Aux], AL   ; Guardar el caracter en Aux
            mov byte[Aux2], AH  ; Guardar el residuo en Aux2
            jmp Write           ; Saltar a escribir

        Ten:
            mov BL, 10          ; Divisor
            div BL              ; Dividir AL entre BL
            add AL, 48          ; Sumar 48 para convertir a caracter
            mov byte[Aux], AL   ; Guardar el caracter en Aux
            mov byte[Aux2], AH  ; Guardar el residuo en Aux2
            jmp Write           ; Saltar a escribir

        One:
            add AL, 48          ; Sumar 48 para convertir a caracter
            mov byte[Aux], AL   ; Guardar el caracter en Aux
            mov EAX, 4      ; Llamada sys_write (escribir archivo)
            mov EBX, [FW]   ; Identificador de archivo de escritura
            mov ECX, Aux    ; Contador de letras
            mov EDX, 1      ; Número de bytes a escribir (1 byte)
            int 0x80        ; Llamada al sistema para escribir archivo
            jmp WriteNewline; Saltar a escribir el salto de línea

        Write:
            mov EAX, 4      ; Llamada sys_write (escribir archivo)
            mov EBX, [FW]   ; Identificador de archivo de escritura
            mov ECX, Aux    ; Contador de letras
            mov EDX, 1      ; Número de bytes a escribir (1 byte)
            int 0x80        ; Llamada al sistema para escribir archivo
            mov AL, byte[Aux2]  ; Mover el residuo a AL
            cmp AH, 10          ; Verificar si el residuo es mayor o igual a 10
            jl One              ; Saltar si es menor a 10
            ret                 ; Retornar

        ; Escribir el salto de línea
        WriteNewline:
        mov EAX, 4      ; Llamada sys_write (escribir archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        mov ECX, Newline; Salto de línea
        mov EDX, 1      ; Número de bytes a escribir (1 byte)
        int 0x80        ; Llamada al sistema para escribir archivo

        ; Cerrar el archivo de escritura
        mov EAX, 6      ; Llamada sys_close (cerrar archivo)
        mov EBX, [FW]   ; Identificador de archivo de escritura
        int 0x80        ; Llamada al sistema para cerrar archivo

        ; Reiniciar contador de letras
        mov byte[Counter],0
        
        ; Incrementar letra actual 
        inc byte[MAY]
        inc byte[min]

        ; Abrir el archivo de lectura
        mov EAX, 5          ; Llamada sys_open (abrir archivo)
        mov EBX, FileRead   ; Nombre del archivo de lectura
        mov ECX, 00444      ; Bandera para lectura
        mov EDX, 444o       ; Privilegios de lectura
        int 0x80            ; Llamada al sistema para abrir archivo
            
        ; Verificar si se han recorrido todas las letras
        dec byte [Letters]  ; Decrementar contador de letras
        cmp byte [Letters],0; Comparar con 0
        jne CmpLetter       ; Continuar con la siguiente letra si no se han recorrido todas

    ext:
        ; Cerrar el archivo de lectura
        mov EAX, 6      ; Llamada sys_close (cerrar archivo)
        mov EBX, [FR]   ; Identificador de archivo de lectura
        int 0x80        ; Llamada al sistema para cerrar archivo

        ; Terminar el programa
        mov EAX, 1  ; Llamada sys_exit (terminar programa)
        mov EBX, 0  ; Código de salida (0 = éxito)
        int 0x80    ; Llamada al sistema para terminar programa