;Copyright (c) 2023, Cesar Reyes Torres <> All rights reserved. 

GLOBAL main
;extern printf

section .data
    x:    DD 0.7853 ;Radianes
    n:    DD 5      ;Aproximacion
    i:    DD 1      ;Auxuliar
    aux:  DD 0.0    ;Auxiliar de operaciones
    senx: DD 0.0    ;Sumatoria
    ;msg   DD "El valor de Senx es: %f", 10, 0

section .text
    main:
        ;Para ciclo n=0 to n
        mov edx,[n]    ;edx tendra el limite
        mov eax,[x]
        mov [senx],eax ;cuando n=0 -> x
        mov eax,1
        mov [n],eax
    sumatoria:
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
            mov eax,-1
            mov ebx,[i]
            imul ebx
            mov [i],eax
            FILD DWORD [i]
        
        ;do -> (-1)'n * x'(2n+1) / (2n+2)!
        FMUL st0,st1

        ;Sumatoria
        FLD DWORD [senx]
        FADD
        FSTP DWORD [senx]

        ;ciclo tipo (n;n>=0;n--)
        mov eax,[n]
        cmp eax,edx
        ja  print

        inc eax
        mov [n],eax
        jmp sumatoria ;Salida definitiva

    print:
        ;****
        ;finit             ; inicializa el coprocesador FPU
        ; fstp qword [esp]  ; guarda en la pila
        ; mov eax, 0        ; indica el valor de retorno para printf
        ; mov ebx, msg      ; pasa la cadena de formato a printf
        ; push msg
        ; call printf       ; imprime el valor en decimal
        ;****
        jmp ext

    ext:  ;Terminar Ejecucion
        add esp, 8      ;liberar pila
        mov eax, 1
        xor ebx, ebx
        int 0x80 


;             Para usar libreria de C
;---------------------------------------------------
;- nasm -f elf32 -g serieTaylor.asm                -
;- gcc -m32 -no-pie serieTaylor.o -o serieTaylorEx -
;- gdb serieTaylorEx                               -
;---------------------------------------------------