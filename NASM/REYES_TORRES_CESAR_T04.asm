;Copyright (c) 2023, Cesar Reyes Torres <> All rights reserved. 

GLOBAL main
extern printf

section .data
    x:   DD 3.1214 ;Radianes
    n:   DD 5      ;Aproximacion
    aux: DD 0.0    ;Auxiliar de operaciones
    sum: DD 0.0    ;Sumatoria
    msg  db "El valor de Senx es: %f", 10, 0

section .text
    main:
        ;do --> 2n+1
        mov eax,2
        mov ebx,[n]
        mul ebx
        add eax,1
        mov ecx,eax
        sub ecx,1       ;Para loop
        mov [aux],ecx
        FINIT           ;Inicializa FPU
        FLD DWORD [x]
        FLD DWORD [x]

        ;do --> x'(2n+1)
        exponencial:
            FMUL st0,st1
            loop exponencial
        FIST DWORD [aux]  
        ; inicializar el registro ECX con el valor de EAX-1
        mov ecx, eax
        dec ecx
        mov ebx, 1

        ;do --> (2n+1)!
        factorial:
            cmp ecx, 0    ; comprobar si se ha alcanzado el final del bucle
            je nextStep
            imul ebx, eax ; multiplicar EBX por EAX, resultado en EBX
            dec eax       ; decrementar EAX
            dec ecx       ; decrementar ECX
            jmp factorial

        nextStep:

            ;do --> x'(2n+1) / (2n+1)!
            mov [aux],ebx    ;result (2n+1)!
            FILD DWORD [aux] ;ponemos en pila la parte del factorial

            FDIVP st1,st0    ;Divide st1 / st0

            ;do --> -1'(n)
            mov ecx,[n]
            sub ecx,1   ;Para que el loop no haga un ciclo demas
            FLD1
            FCHS
            FLD1
            FCHS
        exponencial2:
            FMUL st0,st1
            loop exponencial2
        
        ;do -> (-1)'n * x'(2n+1) / (2n+2)!
        FMUL st0,st2

        ;Sumatoria
        FLD DWORD [sum]
        FADD
        FSTP DWORD [aux]
        mov eax,[aux]
        mov DWORD [sum],eax

        ;ciclo tipo (n;n>=0;n--)
        mov edx,[n]
        sub edx,1
        mov [n],edx

        cmp edx,0
        ja  main
        call print
        jmp ext ;Salida definitiva

    print:
        finit             ; inicializa el coprocesador FPU
        fld DWORD [x] 
        fld DWORD [sum]  
        FADD
        fstp qword [esp]  ; guarda en la pila
        mov eax, 0        ; indica el valor de retorno para printf
        mov ebx, msg      ; pasa la cadena de formato a printf
        push msg
        call printf       ; imprime el valor en decimal
        ret

    ext:  ;Terminar Ejecucion
        add esp, 8      ;liberar pila
        mov eax, 1
        xor ebx, ebx
        int 0x80 
