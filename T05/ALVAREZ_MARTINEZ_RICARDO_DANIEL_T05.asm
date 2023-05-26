GLOBAL main

section .data
    archEntrada db "data.txt", 0     ; Nombre del archivo de entrada
    archSalida db "ALVAREZ_MARTINEZ_RICARDO_DANIEL_COUNT.txt", 0  ; Nombre del archivo de salida
    letterA db 65                   ; Valor ASCII de la letra A
    lettera db 97                   ; Valor ASCII de la letra a, para empezar a recorrer
    contNum db 0                    ; Contador de números
    contLetras db 0                 ; Contador de letras
    ascii db 0                      
    espacio db " "                  
    newline db 10                   
    comp db 1                       

section .bss
    fd resw 1                       ; Descriptor de archivo
    fdOutput resw 1                 ; Descriptor de archivo para el archivo de salida
    buffer resb 1                   ; Búfer para lectura de archivos

section .text

    main:
        mov eax, 5                   ; Abrir el archivo de entrada
        mov ebx, archEntrada
        mov ecx, 2                   
        mov edx, 777                 ; Permisos lectura, escritura y ejecución para todos
        int 0x80

        mov [fd], eax                 ; Guardar el archivo

        read_loop:
            mov eax, 3
            mov ebx, dword [fd]
            mov ecx, buffer
            mov edx, 1                   ; Longitud del bufer
            int 0x80
            cmp eax, 0                   ;final del archivo
            jz end                        ;salir del bucle si es fin de archivo

            

            mov al, [buffer]
            cmp al, [letterA]             ; Corroborar si contiene la letra mayúscula
            je next
            cmp al, [lettera]             ; Corroborar si es la letra en minúscula
            je next

            jmp read_loop

        end:  
            mov eax, 6 ; Cerrar el archivo de lectura
            mov ebx, [fd]
            int 0x80

            
            inc byte [contLetras]       ;recorrido de las letras
            cmp byte [contLetras], 27
            je exit                         
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
        mov eax, 8                       ;crea un archivo
        mov ebx, archSalida               ;Nombre del archivo de salida
        mov ecx, 0777                     
        int 0x80                          ;Llamada al sistema
        mov [fdOutput], eax
        
        mov eax, 6     ; Cerrar el archivo de escritura
        mov ebx, [fdOutput]
        int 0x80
        jmp write

    write:
        mov eax, 5                         ; Abrir el archivo de escritura
        mov ebx, archSalida
        mov ecx, 2                        
        mov edx, 777                      
        int 0x80
        mov [fdOutput], eax
        
        mov eax, 0x13             ; Recorrer el offset
        mov ebx, [fdOutput]
        mov ecx, 0
        mov edx, 2
        int 0x80
                                       
        mov eax, 4                         ; Llamada al sistema para escribir
        mov ebx, [fdOutput]                
        mov ecx, letterA                   ; Valor de la letra
        mov edx, 1                         ; Longitud de la letra
        int 0x80

        mov eax, 4                         
        mov ebx, [fdOutput]                ;lo mismo que lo anterior pero para el espacio
        mov ecx, espacio                   ; Espacio en formato ASCII
        mov edx, 1                         
        int 0x80
        
        add byte [contNum], 48
        mov al, [contNum]
        mov [ascii], al

        mov eax, 4
        mov ebx, [fdOutput]
        mov ecx, ascii
        mov edx, 1                         ;Longitud del búfer
        int 0x80

        mov eax, 4
        mov ebx, [fdOutput]                ;salto de línea en el archivo
        mov ecx, newline
        mov edx, 1                         ;Longitud del búfer
        int 0x80
        
        mov eax, 6                        ;Cierra el archivo
        mov ebx, [fdOutput]
        int 0x80
        inc byte [letterA]
        inc byte [lettera]
        mov byte [contNum], 0

        mov eax, 5                        ;Llamada al sistema para abrir archivo
        mov ebx, archEntrada
        mov ecx, 2                        ; Bandera para lectura-escritura
        mov edx, 777                      
        int 0x80                          ; Abrir el archivo

        mov [fd], eax                     ; Guardar el descriptor de archivo

        jmp read_loop

    exit:

        mov eax, 6                       ;salida
        mov ebx, [fd]
        int 0x80

        mov eax, 1
        mov ebx, 0
        int 0x80