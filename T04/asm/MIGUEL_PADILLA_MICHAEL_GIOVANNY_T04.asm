;Nombre: Michael Giovanny Miguel Padilla, ISC4C
;Programa para sacar el seno de un numero utilzando FPU
;Basado en el desarrollo de la serie de Taylor: x - (x)³/3! + (x)⁵/5! - (x)⁷/7! + (x)⁹/9!...........

GLOBAL main


section .text
    FINIT



main:
    mov eax, 0;Muevo al registro eax 0
    mov ebx, 1;A ebx le asigno un valor de 1, puesto que el factorial inicialmente esta en 1 antes de asignarle el calculo del factorial de algun numero
    mov ecx, 0;Muevo a ecx 0
    mov ecx, [base];Muevo el valor que tiene almacenado base al contador ecx
    mov [factorial], ebx;Muevo a la variable factorial lo que hay en ebx, que es un 1, puesto que inicialmente la variable antes de asignarle el factorial de un numero esta inicializada con 1
    call factCalc;Llamada a la etiqueta factCalc que saca el factorial de un numero
    call Potencia;Llamada a la etiqueta potencia que basicamente eleva el valor de x a valores de 3, 5, 7, 9, 11.......
    call parImp;Llamada a la etiqueta parImp que lo que hace es determinar si un numero es par o impar, esto lo uso para 
               ;Determinar los signos de la serie de Taylor, pues van intercalados (-> +,-,+,-,+,-............) cuando el numero es par
               ;indica el uso de un signo negativo y cuando es impar indica el uso de un signo positivo
    call Incrementos;Llamada a la etiqueta incrementos que basicamente incrementa el valor de ciertas variables
    cmp dword[pvuelta], 6;->6 en mi programa equivale a un valor de n de 5->(n-1), Si le asigno a n 6 por como lo hice equivale a 5
    jne main;si el valor de la variable pvuelta es distinta (!) de 6 salta a la etiqueta main
    jmp ext;Si no se cumple salta a ext



    ext:;Breakpoint
        mov eax, 1
        mov ebx, 0
        int 0x80



    factCalc:;Etiqueta factorial
        mov eax, [factorial];Mueve al registro eax lo que tiene a variable factorial
        mul ecx;MUL lo que hace es multiplicar lo que se encuentra en ecx por lo que hay en el registro eax
        mov [factorial], eax; Muevo lo que tiene eax a factorial
        dec ecx;Decremento el valor de ecx
        cmp ecx,0;Compara el valor de ecx con cero
        jz etiquetaRet;Si es igual a cero salta etiquetaRet
        call factCalc;sino hace una llamada recursiva a factCalc




    Potencia:;Etiqueta Potencia
        mov ecx, 0; Muevo a ecx el valor de 0
        mov cl, [exponente];Muevo a la parte baja de ecx el valor de exponente
        
        FINIT;Reinicia o mas bien inicializa la pila estableciendo todo su estado en cero, borrando los valores que hayan estado

        fld dword  [numX];Cargar numx en el registro ST0 del FPU

        AgregaMUl:;Etiqueta de MUltiplicacion 
            fld dword [numX];Cargo el valor de numx en la pila con la instruccion fld
            FMULP;Multiplica 2 valores en punto flotante almacenados en la pila
            loop AgregaMUl;loop es basicamente el ciclo, y haciendo uso del regisro ecx repite ciertas veces cierta seccion del codigo en este caso lo que ay en AgregaMUL
        
        fst dword [resultado];En resultado se guarda la potencia del numero haiendo uso de fst 

        jmp etiquetaRet;Salto a la etiquetaRet




        parImp:;parImp determina si un numero es par o impar
            mov eax, 0;Mueve a eax un cero
            mov eax, [Contador];Mueve al registro eax el valor que contiene la variable Contador
            and eax, 1;Enmascaramiento and 0001 con el valor del contador, si despues del enmascaramiento hay 0b, indica que el numero es par
            cmp eax, 0b;Si despues del enmascaramiento hay 0b en eax, indica que el numero ha sido par, por ende salta a Restar
            je Restar;Si es igual a 0b, salta a Restar, sino simplemente corre a la etiqueta Sumar




        Sumar:
            FINIT ;Reiniciar o iniciar la pila nuevamente
            mov ecx, 0 ;Nuevamente le coloco a ecx un valor de cero
            mov eax, 0 ;Nuevamente le coloco a eax un valor de cero
            mov ebx, 0 ;Nuevamente le coloco a ecb un valor de cero


            fld dword [resultado] ;Ingresa el resultado inicialmene a la pila (resultado almacena el valor de numX elevado a cierta potencia)
            fild dword [factorial] ;Ingresa el resultado del factorial a la pila con fild pues el valor que genera factorial es un valor decimal

            FDIV  ; Realiza la division correspondiente potencia(resultado)/factorial
            fst dword [divisiones];guarda lo que hay en el tope de la pila en la variable divisiones

            FINIT ;Reiniciar o iniciar la pila nuevamente
            fld dword[divisiones];Ingresa a la pila el contenido de divisiones
            fld dword [senx];Ingresa a la pila el conenido de senx

            fadd ;Hace la suma correspondiente entre ambos

            fst dword[senx];Almacena el resultado de dicha suma en senx

            jmp etiquetaRet;Salto a la etiquetaRet




        Restar:
            FINIT ;Reiniciar o iniciar la pila nuevamente
            mov ecx, 0 ;Nuevamente le coloco a ecx un valor de cero
            mov eax, 0 ;Nuevamente le coloco a eax un valor de cero
            mov ebx, 0 ;Nuevamente le coloco a ebx un valor de cero
            mov cx, [conta] ;Muevo al registro cx el valor de conta, conta lo que hace es indicar si la primera operacion
                            ;de la serie de taylor donde resta inicialmente el valor de x - x^3/3! se ha cumplido

            ;Agregando los valores a la pila
            cmp cx, 1;Si lo que hay en cx es igual a 1 salta a la etiqueta Vuelta2 y esto indica la primera resta de la serie de Taylor, 
            JE Vuelta2;Salta a Vuelta2, si no se cumple simplemente continua con el codigo

            fld dword [resultado] ;Ingresa el contenido de la variable resultado inicialmene a la pila
            fild dword [factorial] ;Ingresa el contenido de factorial a la pila con fild pues este almacena un  valor decimal

            FDIV  ; Realiza la division correspondiente potencia/factorial
            fst dword [divisiones];Con fst almacenamos el valor de dich division en la variable divisiones
            FINIT;Reiniciar o iniciar la pila nuevamente
            fld dword[senx];Ingresa a la pila el contenido de senx
            fld dword[divisiones];Ingresa a la pila el contenido de divisiones
            fsub ;fsub realiza la resta correspondiente enre ambos valores de la pila
            fst dword[senx];Almacena el resultado de dicha resta en senx

            
            jmp etiquetaRet;Slto a la etiquetaRet



        Vuelta2:;Vuelta2
            fld dword [resultado] ;Ingresa elcontenido de resultado a la pila
            fild dword [factorial] ;Ingresa el contenido de factorial a la pila

            FDIV  ; Realiza la division correspondiente potencia/factorial
            fst dword [divisiones];Guarda en divisiones el valor de dicha division
            FINIT;Reiniciar o iniciar la pila nuevamente
            fld dword [valorSE];ingresa el contenido de valorSE que es un 0.785398 a la pila, esto para realizar la prmera operacion
                                ;de la serie de Taylor que es x - x^3/3!
            fld dword [divisiones]; Ingresa a la pila el contenido de divisiones

            fsub ;Hace la primera resta de la serie de Taylor

            fst dword[senx];Almacena el resultado en a variable senx

            jmp etiquetaRet;Salto a la etiquetaRet



        Incrementos:;INcrementos, basicamente hace los incrementos correspondientes de las variables usadas como contadores
            mov eax, [Contador]

            add eax, 1;suma 1 a eax
            mov [Contador], eax ;Aumento el contador en 1 (+1)

            inc dword [exponente];Inrementa exponente en 1
            inc dword[exponente];Incrementa exponente en 1, con lo anterior se ha incrementado exponente 2 veces
            

            mov eax, [pvuelta];mueve a eax el contenido de pvuelta
            add eax, 1;suma 1 a lo que hay en eax
            mov [pvuelta], eax;Mueve a pvuelta lo que hay en eax

            mov eax, [conta];Mueve a eax el contenido de conta
            add eax, 1;suma 1 a eax
            mov [conta], eax;mueve el conenido de eax a conta

            inc dword [base];Incrementa en 1 el contenido que hay en base
            inc dword [base];Incrementa en 1 el contenido que hay en base, con lo anterior se ha incremetado 2 veces

            jmp etiquetaRet;Salto a etiquetaRet



        etiquetaRet:;EtiquetaRet
            ret;regresa a la ubicacion de la instruccion que hizo la llamada a una subrutina



;VARIABLES
section .data
;Variables del Factorial
factorial: DD 1 ;GUARDA EL RESULTADO DEL FACTORIAL
base: DD 3;Numero a sacar el factorial, inicialmente comienz con el factorial de 3

;Variables de la potencia
exponente: DD 2 ;->(3-1)Inicialmente Comienza con elevar a la tercera potencia
numX: DD 0.785398 ;NUmero a sacar el seno ->Pi/4
resultado: DD 0.0;guarda el resultado de elevar numX a cierta potencia



valorSE: DD 0.785398
senx: DD 0.0;Almacena el resultado de sacar el seno de 0.785398
Contador: DD 2 ;Usado para determinar si el numero es par o impar
 

divisiones: DD 0.0;Almacena el resultado de las divisiones

conta: DD 1;Contador que indica la primera resta realizada en la serie de Taylor que es x - (x)³/3!
pvuelta: DD 1;Vueltas 
