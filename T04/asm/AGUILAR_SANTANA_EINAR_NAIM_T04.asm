GLOBAL main
;Autor: Einar Naim Aguilar Santana
;Fecha: 07/03/2023
;Descripcion del Programa: Este programa realizara la serie de taylor tomando en cuenta a la x como pi/4
    
GLOBAL main

section .text
  finit ; se usara numeros con punto flotante
  main:
        mov ecx, 0 ;contador ecx inicializado en 0

    inicializarSum:
        fld dword [x] ;hace un push de x en la pila
        fld dword [senx] ; hace un push de senx en la pila
        faddp ;hace la suma de los dos numeros de la pila
        fstp dword[senx] ;guarda el resultado en senx

    secuencia:
        call taylor ;llama a la etiqueta taylor
        add dword [n], 2 ;se suma a la variable n un 2 
        fld1 ;hace un push de una constante 1
        fstp dword [numerador] ; se guarda el resultado en numerador 
        dec dword [iteraciones] ;se decrementa el valor de la variable iteraciones
        jnz secuencia ;se salta si no es cero otra vez a secuencia

    ext: ;etiqueta con una interrupcion para salir
        mov eax, 1 
        mov ebx, 0 
        int 0x80     

    taylor:
        mov cx, [n] ;se guarda n en el registro cx

        potencia:
            fld dword [x] ;hace un push de x en la pila
            fld dword [numerador] ; hace un push de numerador en la pila
            fmulp ;hace una multiplicacion a los dos elementos de la pila
            fstp dword [numerador] ;se guarda el resultado de la operacion en numerador
            loop potencia ;se hace un loop a esta misma etiqueta de potencia

        DenominadorCalc:
            mov cx, [n] ;se guarda el contenido de n al registro cx
            mov [denominador], cx ;se mieve el contenido de cx a denominador
            dec cx ;decrementa cx
            factCalc:
                mov ax, [denominador] ;valor en denominador se guarda en el registro bx
                mul cx ;se multiplica con cx
                mov [denominador], ax ;el valor que se encuentra en el registro bx se cuarda en denominador
                loop factCalc ;se hace un loop a "factCalc"

        divisionCalc:
            fld dword [numerador] ;Hace un push de numerador
            fild dword [denominador] ;Carga el "denominador" entero de una ubicación de memoria, lo convierte en numero real
            fdivp ;realiza la division entre los elementos de la pila
            fild dword [signo] ;carga el "signo" entero de una ubicación de memoria, lo convierte en numero real
            fmulp  ;realiza la multiplicacion entre los elementos de la pila para cambiarlo de signo       
            fstp dword [division] ;se guarda los resultados de las anteriores operaciones en la variable "division"
            fild dword [signo] ;carga el "signo" entero de una ubicación de memoria, lo convierte en numero real
            fchs ;invierte el bit de signo los números negativos se vuelven positivos y viceversa.
            fistp dword [signo] ;se guarda el resultado en signo

        sumatoria:
            fld dword [senx] ;se guarda el contenido de senx a la pila
            fld dword [division] ;se guarda el contenido de division a la pila
            faddp ;se suma los contenidos del contenido de la pila 
            fstp dword [senx] ;se guarda el resultado de la operacion en senx
    ret

section .data
    
    ;Componentes de la division
    denominador DD 0.0 ;denominador de la division
    numerador DD 1.0 ;numerador de la division
    division DD 0.0 ;resultado de la division

    ;Correccion de signos
    signo DD -1 ;Se usara para alternar entre positivo o negativo

    ;Componentes de la serie
    n DD 3 ;n de la serie de taylor
    iteraciones DD 5 ;iteraciones maximas para sacar la aproximacion de seno de pi/4      
    x DD 0.7853 ;x que equivale a pi/4        
    senx DD 0.0 ;se guardara el resultado aqui de la suma de todas la iteraciones realizadas