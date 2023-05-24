GLOBAL main

section .data
    archivo db "data.txt",0
    archivo2 db "FILLINGHAM_GAETA_ROBERT_EVERETT_COUNT.txt",0
    buffer_size equ 13 ;cantidad de letras en data.txt

    letter db 65 ;representa el abecedario
    data db 0 ;cuantas veces se encontro letter en la cadena en una iteracion
    c dd 0  ;varaible temporal del registro ecx
    casilla dd -1 ;variable que recorre la cadena

    ;caracteres para escribir sobre el archivo
    espacio db 32
    fl db 10


section .bss
    fd resw 1
    fd2 resw 1
    separator resd 5
    buffer resb buffer_size
section .text

    main: 
    ;LEER EL ARCHIVO CON CARACTERES
        ;Abrir el archivo data.txt

        mov eax, 5
        mov ebx, archivo
        mov ecx, 2
        mov edx, 777
        int 0x80

        mov [fd], eax
    uno:
        ;leer el archvivo, la string estara en buffer
        mov eax, 3
        mov ebx, [fd]
        mov ecx, buffer
        mov edx, buffer_size
        int 0x80
    a:
        ;Cerrar el archivo
        mov eax, 6
        mov ebx, [fd]
        int 0x80

    ;ABRIR EL ARCHIVO2
    ;abrir el archvio2
    
    dos:
        mov eax, 5
        mov ebx, archivo2
        mov ecx, 2
        mov edx, 777
        int 0x80

        mov [fd2], eax

    ;ANALISIS
        mov ecx, 52
        mov eax, 0

    analisis:
        ;regresar casilla a -1
        mov edx, -1
        mov [casilla], edx
        ;Recorrer la cadena
    cadena:
        
        ;incrementar casilla
        mov edx, [casilla]
        inc edx
        mov [casilla], edx
        
        ;Colocar esi en la casilla del string
        mov edi, [casilla]          
        mov esi, buffer    
        add esi, edi    
         
        ;guardar en al el caracter
        mov al, [esi]
        
        ;Comparar el caracter de la String con la letra del alfabeto
        cmp al, [letter]
        jne evaluacion
        ;Si son iguales entonces incrementamos el valor de  dato
        mov edx, [data]
        inc edx
        mov [data], edx
    evaluacion:    
        ;Evaluar si se llego al final de la cadena
        mov edx, 12
        cmp [casilla], edx
        jb cadena
    final:

        checar:
        
    
        ;Imprimir DATO
        call imprimir

        ;Pasar a la siguiente letra en el codigo ASCII
        mov edx, [letter]
        inc edx
        mov [letter], edx
      
        ;poner dato en cero
        mov edx, 0
        mov [data], edx
       
        loop analisis





    ;ESCRIBIR EL ARCHIVO DE LA CUENTA
    imprimir:
        mov [c], ecx 
        
    tres:
        ;pasar data a su caracter
        mov edx, [data]
        add edx, 48
        mov [data], edx


        ;escribir letter
        mov eax, 4
        mov ebx, [fd2]
        mov ecx, letter
        mov edx, 1
        int 0x80

        ;escribir espacio
        mov eax, 4
        mov ebx, [fd2]
        mov ecx, espacio
        mov edx, 1
        int 0x80

        ;escribir data 
        mov eax, 4
        mov ebx, [fd2]
        mov ecx, data
        mov edx, 1
        int 0x80

        ;escribir enter
        mov eax, 4
        mov ebx, [fd2]
        mov ecx, fl
        mov edx, 1
        int 0x80

        
        
        
        mov ecx, [c]
    
        ret

    exit:   

        cuatro:
        ;Cerrar el archivo
        mov eax, 6
        mov ebx, [fd2]
        int 0x80
        
     
        mov eax, 1
        int 0x80



