; Programa que calcula el seno de un radian
; Utiliza la serie de Taylor
; Se define como la sumatoria de (-1)^n * x^(2n+1) / (2n+1)!

GLOBAL main

section .data
    senx DD 0.0 ; Resultado
    n DD 4     ; Indice superior de la sumatoria
    i DD 0      ; Indice inferior de la sumatoria
    signo DD -1 ; Signo del numerador
    x DD 0.7853 ; Valor de x
    exponente DD 0  ; Exponente para x
    factorial DD 1  ; Factorial para el denominador

section .text
    FINIT
    main:

    sum:
        mov eax, [i]
        mov ecx, [n]
        cmp eax, ecx
        jg ext
        jmp exp

    exp:
        fld dword [x]
        mov ecx, [i]
        cmp ecx, 0
        je sign
        
        mov eax, 2
        mov ebx, [i]
        mul ebx
        inc eax
        mov [exponente], eax
        mov ecx, [exponente]
        jmp expcalc
        
        expcalc:
            fld dword [x]
            fmul
            dec ecx
            cmp ecx, 1
            jne expcalc
            jmp sign

    sign:
        mov eax, [signo]
        mov ebx, -1
        mov ecx, [i]

        cmp ecx, 0
        je zero

        cmp ecx, 1
        je uno

        jmp expsigno

        zero:
            mov eax, 1
            mov [signo], eax
            jmp fact

        uno:
            mov eax, 1
            mov [signo], eax
            fchs
            jmp fact

        expsigno:
            imul ebx
            mov [signo], eax
            dec ecx
            cmp ecx, 1
            jne expsigno
            mov eax, [signo]
            cmp eax, -1
            fchs
            jmp fact

    fact:
        mov eax, [factorial]
        mov ecx, [i]
        cmp ecx, 0
        je division
        mov eax, 2
        mul ecx
        inc eax
        mov [factorial], eax
        mov ecx, eax

        factcalc:
            mov eax, [factorial]
            dec ecx
            mul ecx
            mov [factorial], eax
            cmp ecx, 1
            jne factcalc
            jmp division

    division:
        fild dword [factorial]
        fdiv
        fld dword [senx]
        fadd
        fstp dword [senx]
        mov eax, [i]
        inc eax
        mov [i], eax
        jmp sum

    ext:
        mov eax,  1
        mov ebx, 0
        int 0x80
    
    