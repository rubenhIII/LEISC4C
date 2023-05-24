;Nombre: Michael Giovanny Miguel Padilla, ISC4C
;Programa que abre, lee un archivo de texto y cuenta las veces que se repite cada letra del abecedario
;Los resultados son escritos en otro archivo mismo que es creado automaticamente

;NOTA: NO entiendo por que, al ser creado el archivo y querer abrirlo, este no deja abrirlo por problemas
;de permisos si segun yo al crearlo, lo creo con todos los permisos (r(lectura), w(escritura), x(ejecucion)), para poder 
;abrir el archivo donde se guardan los resutados es necesario cambiar los permisos con un chmod 777 NombreArchivo.txt desde la terminal
;De esta forma y se podra acceder al contenido del archivo

GLOBAL main
section .data
    ;Variables
    input_file db "data.txt", 0
    output_file db "MIGUEL_PADILLA_MICHAEL_GIOVANNY_COUNT.txt", 0
    Letras_may db 65;Inicialmente contiene la letra A mayuscula->valor ascii
    Letras_min db 97;Inicialmente contiene la letra a minuscula->valor ascii

    espacio db 20h;espacio en hexadecimal->ascii=32
    salto_Linea db 0Ah;salto de linea en hexadecimal->ascii=10
    cambioVal db 0
    contRepet db 0
    contCaract db 0
    contArch db 1

section .bss
    fdEntrada  resw 1
    fdSalida resw 1
    buffer resb 1

section .text

    main:
        call abrir_Archivo
        call cicloLect
        call Siguiente_Letra
        jmp main



    abrir_Archivo:
        mov eax, 5      ;Identificador llamada al sistema abrir archivo
        mov ebx, input_file
        mov ecx, 2      ;Bandera para lectura-escritura
        mov edx, 777    ;Privilegios o permisos del archivo rwx
        int 0x80        ;Abrimos el archivo  
        mov [fdEntrada], eax   ;Guardar identificador de archivo

        ret

 

    cicloLect:
        ;Lectura del primer caracter inicialmente, el colocar 1 byte hace que vaya leyendo caracter x caracter
        mov eax, 3
        mov ebx, eax
        mov ecx, buffer
        mov edx, 1;1 byte del buffer->1 caracter
        int 0x80;Llamada al sistema

            
        cmp eax, 0;Verifica si se ha llega al final del archivo
        JE sali_Escr;De ser asi, salta a la parte donde se crea inicialmente el archivo y luego a escribir dichos resultados en el archivo

        mov al, [buffer];Moviendo el caracter a la parte baja del registro ax

        cmp al, [Letras_may];Comparando dicho caracter con las letras mayusculas
        JE conteoRepeticiones;Si es igual al caracter, este salta al conteo de las repeticiones, si no continua

        cmp al, [Letras_min];Comparando dicho caracter con las letras minusculas
        JE conteoRepeticiones;Si es igual al caracter, este salta al conteo de las repeticiones, si no continua

        jmp cicloLect



    conteoRepeticiones:
        inc byte[contRepet] ;incrementar contardor de letras->Las repeticiones de cada una
        jmp cicloLect;salto al ciclo de lectura



    escribir:
        mov eax, 5;Indica que se realizará la llamada al sistema para abrir un archivo.
        mov ebx, output_file;Se mueve la dirección del nombre del archivo al registro 
        mov ecx, 2;Se mueve el valor 2 al registro ecx, indicando que se desea abrir el archivo en modo de lectura y escritura
        mov edx, 777;Se mueve el valor 777 al registro edx, representando los permisos de acceso del archivo en notación octal.
        int 0x80;Llamada al sistema 

        mov [fdSalida], eax;Guardando el identificdor del archivo de salida


        ;Esta llamada al sistema realizará la operación correspondiente, que en este caso es cambiar 
        ;la posición de lectura/escritura en el archivo identificado por el descriptor almacenado en ebx. 
        ;El cambio de posición se realiza moviendo edx bytes hacia adelante desde la posición actual.
        mov eax, 19
        mov ebx, [fdSalida]
        mov ecx, 0
        mov edx, 2
        int 0x80

        ;Escribiendo cada letra en el archivo, en este caso es la respectiva letra en minuscula 
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, Letras_min
        mov edx, 1;1 byte del buffer 
        int 0x80

        ;De esta forma escribimos un espacio en el archivo
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, espacio
        mov edx, 1;1 byte del buffer 
        int 0x80


        ;De esta forma escribimos un espacio en el archivo
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, espacio
        mov edx, 1;1 byte del buffer 
        int 0x80


        ;De esta forma escribimos un espacio en el archivo
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, espacio
        mov edx, 1;1 byte del buffer 
        int 0x80


        ;Con lo anterior, se han escrito 3 espacios entre la respectiva letra y el numero de veces que se repite
        call cambioNum;Cambia el valor en binario a su respectivo numero

        ;Escritura del numero en el archivo
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, cambioVal;Numero a ser escrito
        mov edx, 1;1 byte del buffer
        int 0x80

        ;Escritura del salto de línea en el archivo
        mov eax, 4
        mov ebx, [fdSalida]
        mov ecx, salto_Linea
        mov edx, 1;1 byte del bufferr
        int 0x80

        ;Cierre del archivo, mismo donde vamos escribiendo los resultados
        call cierreArchE

        ret



    Siguiente_Letra:
        inc byte[Letras_may];Se incrementa en 1 la letra en mayuscula, es decir si inicialmente esta en 65 que es una A, al incrementar y ser 66 seria una B y asi sucesivamente
        inc byte[Letras_min];Se incrementa en 1 la letra en minuscula, es decir si inicialmente esta en 97 que es una a, al incrementar y ser 98 seria una b y asi sucesivamente
        mov byte[contRepet],0;Se mueve al contador que lleva el conteo de las repeticiones un cero, haciendo un reinicio del mismo
        
        ret




    sali_Escr:
        call cierreArchL

        inc byte [contCaract]
        call contSalida

        cmp byte [contArch], 1;Comprueba si el contArch es igual a 1, de ser asi, lo que hace es saltar a la etiqueta que crea el archivo
        je crearAr;Si es diferente de 1, lo que hace es simplemente llamar a escribir

        call escribir;Llamada a escribir, lo que hace es que escribe los resultados en el archivo

        ret


    
    crearAr:;Etiqueta donde se crea el archivo

        inc byte[contArch]
        mov eax, 8;Función: creat
        mov ebx, output_file;Nombre del archivo
        mov ecx, 0777;Permisos
        ;mov edx, 0              ; No se utiliza en la llamada a "creat"
        int 0x80;Llamada al sistema para crear el archivo
        mov [fdSalida], eax


        mov eax, 6
        mov ebx, [fdSalida]
        int 0x80


        call escribir;hace una llamada para escribir en el archivo

        ret


    contSalida:;En esta etiqueta, lo que se hace es comprobar si fueron revisadas todas las letras el abecedario, de ser asi, fnaliza el programa
        cmp byte [contCaract],27
        je fin_Programa

        ret


    cambioNum:
        ;Conversión de número binario a valor ASCII
        add byte [contRepet], 48
        mov al, [contRepet]
        ;Después de realizar esta operación, el valor ASCII del número binario estará en el registro AL
        mov [cambioVal], al;Muevo dicho valor a la variabe cambioVal

        ret

    cierreArchL:;Cierre archivo de lectura
        mov eax, 6
        mov ebx, [fdEntrada]
        int 0x80

        ret


    cierreArchE:;Cierre archivo de escritura
        mov eax, 6
        mov ebx, [fdSalida]
        int 0x80

        ret


    fin_Programa:
        call cierreArchL

        mov eax, 1
        mov ebx, 0
        int 0x80