GLOBAL main

section .text
    
    main:
        mov ebx,1
        mov [res2n1],ebx    ;Reinicio de variable para del valor 2n+1 para que durante las iteraciones no haya problemas
        mov [fac2n1],ebx    ;Reinicio de variable para del valor (2n+1)! para que durante las iteraciones no haya problemas
        mov [numNeg],ebx    ;Reinicio del numero negativo para no tener problemas en las iteraciones
        mov ebx,0           ;Reinicio nuevamente el registro EBX

        call num2n1         ;Llamada hacia etiqueta para sacar el valor de 2n+1

        mov ecx, 0
        mov cx, [res2n1]    ;Inicializo el contador CX para ciclar y sacar los valores del factorial
        call facto2n1       ;Llamada hacia etiqueta para sacar el valor de (2n+1)!

        call potencia       ;Llamada a etiqueta para sacar el valor de (x)^2n+1

        jmp potenciaNeg     ;Salto hacia etiqueta para sacar el valor de (-1)^n



    num2n1:
        mov eax,[n] ;Paso el valor de n a EAX para sacar 2n+1
        shl eax,1 ;Multiplicacion de n*2
        add eax,1 ;Sumo 1 a 2n

        mov [res2n1],eax ; Guardo resultado en variable

        mov eax,0 ;Reinicio registro EAX

        ret ;retorno a main
        
    facto2n1:
        mov eax,[fac2n1]    ;Muevo el valor de fac2n1 para ir realizando las iteraciones de la multiplicacion
        mul cx              ;Multiplico los registros para ir sacando el total del factorial

        mov [fac2n1],eax    ;Voy almacenando el resultado en la variable fac2n1 para cuando termine el ciclo ahi se guarde

        dec cx              ;Decremento contador
        cmp cx,0            
        jz bk               ;Si CX es cero salto hacia etiqueta break para retornar al main
        call facto2n1       ;Si no es cero se continua ciclando para el valor del factorial
        bk:
            mov eax,0       ;Reinicio registro EAX
            ret             ;Retorno a main
    
    potencia:
        fld dword [x]   ;Meto el valor de x a la pila 2 veces para irlo multiplicando por si mismo
        fld dword [x]

        mov ecx,0
        mov ecx,[res2n1] ;Almaceno el valor de 2n+1 en el registro ECX 
        dec ecx         ;Decremento el registro ECX para usarlo en el ciclo

        call potencia2  ;Llamada a etiqueta para sacar la potencia
        fstp dword [numPotencia] ;Saco el resultado de la pila y lo almaceno en la variable numPotencia

        ret ;retorno a main
    
    potencia2:
        fmul st0,st1 ;Multiplico el numero por si mismo hasta que se llegue a la potencia requerida

        loop potencia2 ;Loop para sacar potencia
        
        ret ;Retorno a potencia

    potenciaNeg:
        mov eax,[n] ;Muevo el valor de n al registro EAX que representa el numero de la iteracion de la sumatoria que se encuentra
        and eax,1 ;Enmascaramiento de un AND 0001 con n, si al enmascarar hay un 0b esto indica que el numero es par, en caso de que no el numero es impar
        cmp eax,0b ;Comparo EAX con 0b

        jz pos ;Si es cero indica que es numero par por lo que salta a su etiqueta
        jmp negativo ;En caso de que no sea cero se salta a etiqueta de negativo

        negativo:
            mov ebx,-1 ;Almaceno un -1 en EBX como auxiliar
            mov [numNeg],ebx ;Guardo el resultado en mi variable numNeg que almacena el resultado de la operacion (-1)^n
            jmp divMul ;Salto a siguiente etiqueta para sacar el resultado de (-1)^n/(2n+1)!

        pos:
            mov ebx,1 ;Almaceno un 1 en EBX como auxiliar
            mov [numNeg],ebx ;Guardo el resultado en mi variable numNeg que almacena el resultado de la operacion (-1)^n
            jmp divMul ;Salto a siguiente etiqueta para sacar el resultado de (-1)^n/(2n+1)!
        
        mov eax,0 ;Reinicio de registros EAX y EBX
        mov ebx,0

    divMul:
       finit                  ;Reinicio de la FPU
       fild dword [numNeg]   ;Cargo el resultado de (-1)^n
       fild dword [fac2n1] ;Cargo resultado de (2n+1)!

       fdiv                 ;Divido numNeg/fac2n1

       fstp dword [resDiv] ;Almaceno resultado de division en la variable 

       finit                ;Reinicio la FPU

       fld dword [resDiv]       ;Cargo el resultado de la division (-1)^n/(2n+1)!
       fld dword [numPotencia] ;Cargo el resultado de (x)^2n+1

       fmul st0,st1             ;Multiplico ambos valores

       fstp dword [resMul]      ;Almaceno en resultado en la variable resMul

       jmp suma             ;Salto hacia etiqueta suma

    suma:

        finit ;Reinicio de la FPU

        fld dword [senx]    ;Almaceno la variable senx 
        fld dword [resMul]  ;Almaceno el resultado de la multiplicacion

        fadd                ;Sumo para meter el resultado de la operacion de la iteracion n dentro de la sumatoria para ir sacando todas las sumas 

        fstp dword [senx]   ;Guardo resultado de suma en senx

        dec dword[n]        ;Decremento n para la siguiente iteracion

        cmp dword [n],1   ;Comparo n con 1 para saber si ya llegue al valor de n=1

        jae main          ;Si n es mayor o igual a 1 continuo con las iteraciones

        jmp fin         ;Caso contrario salto hacia etiqueta fin

    fin:            ;En esta etiqueta al valor de la sumatoria se le agregara el valor cuando n=0 directamente ya que en este caso siempre en n=0 la sumatoria dara x
        finit
        fld dword [x]      ;ALmaceno el valor de x
        fld dword [senx]    ;Almaceno el valor de senx 

        fadd                ;Sumo para agregar el valor de la iteracion n=0 dentro de la sumatoria almacenada en senx

        fstp dword [senx]   ;Almaceno el resultado en senx
        jmp ext             ;Salto hacia el exit para finalizar

    ext:
    mov eax,1
    mov ebx,0
    int 0x80

section .data

    x: DD 0.785398 ;Variable de la cual se sacara el senx
    n: DD 3      ;Numero de iteraciones a realizar
    res2n1: DD 1 ;Variable para almacenar valor de 2n+1
    fac2n1: DD 1 ;Variable para resultado de (2n+1)!
    numPotencia: DD 1.0 ;Variable para almacenar el resultado de (x)^2n+1
    numNeg: DD 1 ;Variable para almacenar el valor de (-1)^n
    resDiv: DD 1.0 ;Variable para almacenar el resultado de la division
    resMul: DD 1.0 ;Variable para almacrnar el resultado de la multiplicacion 
    senx: DD 0.0 ;Variable para almacenar resultado de la sumatoria