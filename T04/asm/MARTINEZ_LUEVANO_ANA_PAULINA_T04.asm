;Viernes 04/Abril/2023
;programa para calcular el seno de un numero 

GLOBAL main:

    section .data
        signo DD 0;es para el signo de la operacion
        numkM DD 7;numero maximo de iteraciones
        numx DD 0.785398; el numero es pi/4
        base: DD 0
        conta: DD 0;es el valor para las iteraciones
        powr2 DD 1.0 ;el resultado de la segunda potencia
        numd DD 1.0 ;guarda el numero que sera el numerador
        deno DD 1 ;guarda el numero que sera el denominador 
        divR DD 0.0 ;guarda el resultado de la division
        auxiliar: dd 0.785398
        senx DD 0.0;respuesta final de la ecuacion

    section .text
            finit

        main:
            mov ecx, 0
            mov eax,1
            mov [deno], eax
            
            inc dword[conta]
            call exponente;llamamos a la funcion exponente donde se eleva numx a la 2k+1
            mov ecx, [base]
            call factorialE;llamamos a la funcion factorialE donde sacamos el factorial de 2k+1
            call signoO ;llamamos a la funcion signoO donde se hace lo del signo 
            mov ecx, 0
            mov ecx, [base]
            call potencia2;elevamos el numero 0.7853 a exponente 2k+1
            call division;;hace la division entre el signo y el denominador
            call mulD;multiplica el valor de la potencia 2 por el resultado de la division
            call resultado;pasa el resultado final de las operaciones a la variable senx
            mov eax, [conta];limpia el regitro eax
            cmp eax,[numkM];compara si no llego al numero total de iteraciones que se desean hacer
            jne  main ; si aun no llega al total de las iteraciones regresa al main
            jmp ext ;si ya se llego al numero total de iteraciones salta a la etiqueta fin
        

        signoO:
            mov ebx,0
            mov eax,0
            mov eax,[conta]
            and eax,1
            cmp eax,0b
            jz positivo
            jmp negativo
        negativo:
            mov eax,-1
            mov[signo],eax
            ret
        
        positivo:
            mov eax,1
            mov [signo],eax
            ret

        exponente:;2k+1
            mov eax,0; limpia el registro eax
            mov eax, [conta];le asigna al registro el valor de numk
            mov ecx,2;le asigna al registro ebx el valor de 2
            mul ecx;se multiplica lo que tiene el registro eax y ebx 
            inc eax;se suma +1 al resultado de la multiplicacion 
            mov [base],eax;se mueve el resultado de 2k+1 a la variable exp
            ;mov ecx,[base];se limpia el registro que usaremos como contador
            ;mov ecx,[exp];se manda el valor del exp a el registro ecx
            ;jmp potencia2; salta a la funcion potencia2
            ret
        
        potencia2:
             call cicloE
             loop potencia2
             ret

        cicloE:
            fld dword[numx]; se carga a la pila la variable donde se guarda el resultado
            fld dword[powr2];se carga a la pila el valor que se va a multiplicar
            fmulp;se pone una f porque estamos trabajando con flotantes y se hace la multiplicacion
            fst dword[powr2]; saca el valor del resultado de la pila
            finit
            ret
        

        factorialE:
           mov eax,[deno]
           mul ecx
           mov [deno],eax
           dec ecx
           cmp ecx,0
           jz bk1
           call factorialE
        
        bk1:
            ret
         
        
        division:
            fld dword[powr2]
            fild dword[deno]
            fdiv
            fst dword[divR]
            ret
        
        mulD:
            finit
            fld dword[divR]
            fild dword[signo] 
            fmul      
            fst dword[divR]
            ret

          resultado:
            fld dword[auxiliar];se carga a la pila la variable senx
            fld dword [divR];se carga a la pila la variable divR donde esta el resultado de la division
            fadd ;se suman los valores de las dos variables que estan en la pila
            fst dword [senx];saca el resultado de la suma de la pila y la guarda en senx
            finit
            fld dword [senx]
            fst dword[auxiliar]
            finit
        ext1:
            ret

	    ext:
		  mov eax,1
		  mov ebx,0
		  int 0x80
       