;Alumna: MARIANA AVILA RIVERA   4C_ISC
;Programa para obtener el seno de un número (usando FPU)
GLOBAL main

section .data
    numero: dd 0.7853   ;El numero a evaluar
    aux0:   dd 0.0
    aux1:   dd 1.0
    oper:   db 0    ;ALmacena el resultado de 2n+1
    potRes: dd 1.0  ;Resultado de la potencia del numero
    facRes: dd 1    ;Resultado del factorial de "oper"
    divRes: dd 0.0  ;Resultado de la división
    band:   db 0    ;bandera para determinar +1(band=0) o -1(band=1) en la sumatoria
    senx:   dd 0.0  ;Guarda el resultado de la operación

section .text
    finit
    main:
        ;Quitando basura de los registros
        mov ecx, 0
        mov eax, 0
        mov ebx, 0
         ;Se usará bl para llevar la cuenta de "n" (n=0). 
         ;Se usará bh para llevar la cuenta de la sumatoria
        mov bh, 3   ;Se harán 3 sumatorias

      ciclo:
        ;reiniciando variables
        mov dword [facRes],1
        mov eax,[aux1]
        mov dword [potRes],eax
        mov eax,[aux0]
        mov dword [divRes],eax

        call operacion
        mov cl,[oper] ;Para calcular x^oper, hara la multiplicación el numero de veces de "oper"
        call potencia
        mov eax, 0
        mov ecx, 0
        mov cl,[oper] ;El número a calcular el factrial
        call factCalc
        call div
        call sumatoria
        dec bh
        CMP bh,0 ;compara dh==0
        JNE ciclo ; Si dh!=0 salta el main sino termina el programa 
        call ext

operacion:
    ;Obtiene el 2n+1
    mov al,2
    mul bl          ;Realiza la multiplicación (al= al*bl)
    inc al          ;al+1
    mov [oper],al   ;Guarda el resultado
    inc bl          ;bl+1
    ret

potencia:
        ;Con FLD cargamos en la pila
        fld dword [numero] ;base
        fld dword [potRes] ;resultado de la potencia

        fmulp ;Realiza la multiplicación en la pila y saca a ST(0) de la pila

        fstp dword [potRes]; Copia el valor de ST(0) de memoria y lo saca de la pila
        loop potencia
        ret

factCalc:
        mov ax, [facRes]
        mul cl
        mov [facRes],eax
        loop factCalc
        ret

div:
        ;Cargando datos a la pila
        fld dword [potRes] ;numerador
        fild dword [facRes] ;denominador. Se convierte de entero a punto flotante

        fdivp ;Realiza la división y elimina el primer dato de la pila
        fst dword [divRes] ; Copia el valor de ST(0) de memoria
        ret

sumatoria:
        ;+1(band=0) o -1(band=1)
        cmp byte [band],0  ;Compara la variable band con 0
        je sum ;Slata a "sum" si band==0 (es un +1)

        ;En este punto ST(0) tiene el resultado de la división
        fchs    ;Cambia el signo de ST(0) en la pila
    sum:
        fld dword [senx] ;carga el contenido de senx en la pila
        faddp ;Se realiza una suma de los elementos de la pila y saca ST(0) de la pila
        fstp dword [senx]; guarda el resultado de la suma en senx y lo saca de la pila
        
        cmp byte [band],0  ;Compara la variable band con 0
        je cambio ;Slata a "cambio" si band==0
        mov byte [band],0 ;cambiando bandera
        ret
    cambio:
        mov byte [band],1 ;cambiando bandera
        ret ;regresa a donde fue llamada la etiqueta

ext:
        MOV ECX, 1
        MOV EBX, 0
        INT 0X80 