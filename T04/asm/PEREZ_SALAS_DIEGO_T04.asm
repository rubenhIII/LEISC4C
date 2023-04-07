GLOBAL main

section .data
    x:    DD 0.7853 ;Valor de π/4
    n:    DD 6      ;aprox
    i:    DD 1      ;aux
    aux:  DD 0.0    ;operaciones
    senx: DD 0.0    ;suma
    ;msg   DD "Valor senx: %f", 10, 0

section .text
    main:
        ;main del ciclo n=0 a n
        mov edx,[n]    ;limite
        mov eax,[x]
        mov [senx],eax 
        mov eax,1
        mov [n],eax
    suma:
        ;2n+1
        mov eax,2
        mov ebx,[n]
        mul ebx
        add eax,1
        mov ecx,eax
        sub ecx,1       ;loop
        mov [aux],ecx
        FINIT           ;Inicia FPU
        FLD DWORD [x]
        FLD DWORD [x]

        ;x'(2n+1)
        expo:
            FMUL st0,st1
            loop expo
        FIST DWORD [aux]  
        ; Genera el registro ECX y nos da el valor EAX-1
        mov ecx, eax
        dec ecx
        mov ebx, 1

        ;(2n+1)!
        fact:
            cmp ecx, 0    ; comprueba si llegamos al final del bucle
            je nextStep
            imul ebx, eax ; Nos da el resultado de la multiplicacion
            dec eax       ; decrementa
            dec ecx       ; decrementa
            jmp fact

        next:

            ;x'(2n+1) / (2n+1)!
            mov [aux],ebx    ;resultado
            FILD DWORD [aux] ;el resultado factorial se envia a la pila

            FDIVP st1,st0    ;Division

            ;-1'(n)
            mov eax,-1
            mov ebx,[i]
            imul ebx
            mov [i],eax
            FILD DWORD [i]
        
        ;(-1)'n * x'(2n+1) / (2n+2)!
        FMUL st0,st1

        ;Suma
        FLD DWORD [senx]
        FADD
        FSTP DWORD [senx]

        ;ciclo (n;n>=0;n--)
        mov eax,[n]
        cmp eax,edx
        ja  print       ;Exit

        inc eax
        mov [n],eax
        jmp suma  ;Ciclo

    print:
        ;finit             
        ; fstp qword [esp] 
        ; mov eax, 0        
        ; mov ebx, msg      
        ; push msg
        ; call printf       ; valor decimal
        jmp exit

    exit:  
        add esp, 8      ;libera la pila
        mov eax, 1
        xor ebx, ebx
        int 0x80 