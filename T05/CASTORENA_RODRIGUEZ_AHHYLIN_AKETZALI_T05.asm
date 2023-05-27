GLOBAL main

section .bss
    fd resw 1                       
    fdOutput resw 1                  
    buffer resb 1                   

section .text

    main:
        mov eax, 5                   ; Abrir el archivo de entrada
        mov ebx, archivoEntrada
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
            jz end

            

            mov al, [buffer]
            cmp al, [letraA]             ;  si  la letra  es mayúscula
            je next
            cmp al, [letraa]             ; si es la letra en minúscula
            je next

            jmp read_loop

        end:  
            mov eax, 6                   ; Cerrar el archivo de lectura
            mov ebx, [fd]
            int 0x80

            
            inc byte [contaLetras]       ;recorrido de las letras
            cmp byte [contaLetras], 27
            je exit                         
            jl compare                      ; Escribir en archivo

        next:
            inc byte [contaNum]
            jmp read_loop

    compare:
        cmp byte [comp], 1
        je create
        jmp write

    create:
        inc byte [comp]
        mov eax, 8                       ;crea un archivo
        mov ebx, archivoSalida               ;Nombre del archivo de salida
        mov ecx, 0777                     
        int 0x80                          ;Llamada al sistema
        mov [fdOutput], eax
        
        mov eax, 6                           ; Cerrar el archivo de escritura
        mov ebx, [fdOutput]
        int 0x80
        jmp write

    write:
        mov eax, 5                         ; Abrir el archivo de escritura
        mov ebx, archivoSalida
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
        mov ecx, letraA                   ; Valor de la letra
        mov edx, 1                         ; Longitud de la letra
        int 0x80

        mov eax, 4                         
        mov ebx, [fdOutput]                
        mov ecx, espacio                   ; Espacio en formato ASCII
        mov edx, 1                         
        int 0x80
        
        add byte [contaNum], 48
        mov al, [contaNum]
        mov [ascii], al

        mov eax, 4
        mov ebx, [fdOutput]
        mov ecx, ascii
        mov edx, 1                         
        int 0x80

        mov eax, 4
        mov ebx, [fdOutput]                ;salto de línea en el archivo
        mov ecx, newline
        mov edx, 1                         ;Longitud del búffer
        int 0x80
        
        mov eax, 6                        ;Cierra el archivo
        mov ebx, [fdOutput]
        int 0x80
        inc byte [letraA]
        inc byte [letraa]
        mov byte [contaNum], 0

        mov eax, 5                        ;Llamada al sistema para abrir archivo
        mov ebx, archivoEntrada
        mov ecx, 2                        ; Bandera para lectura y escritura
        mov edx, 777                      
        int 0x80                          ; Abrir el archivo

        mov [fd], eax                     
        jmp read_loop

    exit:

        mov eax, 6                       ;salida
        mov ebx, [fd]
        int 0x80
        mov eax, 1
        mov ebx, 0
        int 0x80
    
    section .data
    archivoEntrada db "data.txt", 0     ; Nombre del archivo de entrada
    archivoSalida db "CASTORENA_RODRIGUEZ_AHYLIN_AKETZALI_COUNT.txt", 0  ; Nombre del archivo de salida
    letraA db 65                   ; ASCII de la letra A
    letraa db 97                   ; ASCII de la letra a
    contaNum db 0                    ; Contador de números
    contaLetras db 0                 ; Contador de letras
    ascii db 0                      
    espacio db " "                  
    newline db 10                   
    comp db 1 