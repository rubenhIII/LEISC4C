;Autor: Einar Naim Aguilar Santana
;Fecha: 24/05/2023 

GLOBAL main

section .bss
    fdIn  resw 1 ;espacio de bytes reservado para entrada
    fdOut resw 1 ;espacio de bytes reservado para salida
    buffer resb 1

section .text
    main:
        call abrir_Archivo
        call cicloLect
        call Siguiente_Letra
        jmp main

    abrir_Archivo:
        ; Abre el archivo de entrada especificado en input_file
        ; usando la llamada al sistema 5 (sys_open) con permisos de lectura y escritura
        mov eax, 5
        mov ebx, input_file
        mov ecx, 2
        mov edx, 777
        int 0x80
        ; Almacena el descriptor de archivo resultante en fdEntrada
        mov [fdIn], eax
        ret

    cicloLect:     
        ; Realiza una lectura de un byte desde el archivo de entrada
        ; usando la llamada al sistema 3 (sys_read) 
        mov eax, 3
        mov ebx, eax
        mov ecx, buffer
        mov edx, 1
        int 0x80
            
        cmp eax, 0 ; Comprueba si se ha alcanzado el final del archivo
        JE sali_Escr

        mov al, [buffer] ; Obtiene el valor leído en el registro al

        cmp al, [may] ; Comprueba si el valor es una letra mayúscula (compara con may)
        JE contador_repeticiones

        cmp al, [min] ; Comprueba si el valor es una letra minúscula (compara con Letras)
        JE contador_repeticiones

        jmp cicloLect ; Salta de vuelta al ciclo de lectura

    contador_repeticiones:
        inc byte[repet] 
        jmp cicloLect

    escribir:
        mov eax, 5
        mov ebx, output_file
        mov ecx, 2
        mov edx, 777 ;permisos de lectura escritura y ejecucion para usuario, grupo, otros
        int 0x80

        mov [fdOut], eax

        mov eax, 19
        mov ebx, [fdOut]
        mov ecx, 0
        mov edx, 2
        int 0x80

       
        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, min
        mov edx, 1
        int 0x80

    espacios:
        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, espacio
        mov edx, 1
        int 0x80

        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, espacio
        mov edx, 1
        int 0x80

        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, espacio
        mov edx, 1
        int 0x80

        call cambio_num

    escribir_num:    
        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, cambio
        mov edx, 1
        int 0x80
    
    salto_de_linea:
        mov eax, 4
        mov ebx, [fdOut]
        mov ecx, salto_Linea
        mov edx, 1
        int 0x80
        
        call arch_escri

        ret

    Siguiente_Letra:
        inc byte[may]
        inc byte[min]
        mov byte[repet],0
        
        ret

    sali_Escr:
        call arch_lect

        inc byte [caract]
        call contSalida

        cmp byte [arch], 1
        je crearAr

        call escribir

        ret
    
    crearAr:
        inc byte[arch]
        mov eax, 8
        mov ebx, output_file
        mov ecx, 0777
        int 0x80
        mov [fdOut], eax

        mov eax, 6
        mov ebx, [fdOut]
        int 0x80
        call escribir

        ret

    contSalida:
        cmp byte [caract],27
        je ext

        ret

    cambio_num:
        add byte [repet], 48
        mov al, [repet]
        mov [cambio], al

        ret

    arch_lect:
        mov eax, 6
        mov ebx, [fdIn]
        int 0x80

        ret

    arch_escri:
        mov eax, 6
        mov ebx, [fdOut]
        int 0x80

        ret

    ext:
        call arch_lect

        mov eax, 1
        mov ebx, 0
        int 0x80

section .data
    input_file db "data.txt", 0
    output_file db "AGUILAR_SANTANA_EINAR_NAIM_COUNT.txt", 0
    may db 65 ;numero a partir de donde comienzan las letras mayusculas en ascii
    min db 97 ;numero a partir de donde comienzan las letras minusculas en ascii
    espacio db 32 ;espasio en ascii
    salto_Linea db 10 ;salto de linea en escii

    ;Serie de contadores
    cambio db 0
    repet db 0
    caract db 0
    arch db 1