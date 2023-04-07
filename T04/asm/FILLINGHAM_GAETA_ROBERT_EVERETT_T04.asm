

GLOBAL main

section .text
    
    main:
        FINIT
        mov EDX, [n]
        

    
    oneExp:
        mov ECX, [n]
        dec ECX
        mov EAX, [one]
        mov EBX, [one]

        mult:
            mul EBX
            loop mult
        mov [one], EAX

        fild dword [one]

        mov EDX, -1
        mov [one], EDX
        ;fst dword [stackTop]

    numerator:
        exponential:
            ;ponemos 2n en ECX para el loop
            mov ECX,[n]
            
            mov EAX, 2
            mul ECX
            mov ECX, EAX

            fld dword [angle]
            mults:
                fld dword [angle]
                fmul
                loop mults
                jmp denominator
                ;fst dword [stackTop]
            
    
    denominator:
        inc EAX
        mov EBX, EAX
        dec EBX
        mov ECX, EAX
        sub ECX, 2
        factorial:
           mul EBX
           dec EBX
           loop factorial
        mov [fact], EAX
        fild dword [fact]

    fst dword [stackTop]
    
    operations:
        fdiv
        fmul
        fst dword [stackTop]
    
    check2:
        mov EDX, [n]
        cmp EDX, 0
        je breakp
        cmp EDX, [nFinal]
        je skipAdd

        fadd
        
        cmp EDX, 1
        je nUno

    skipAdd:
        dec EDX
        mov [n], EDX
        call oneExp

    

    nUno:
        fld dword [angle]
        fadd
        fst dword [senx]
    breakp:
        




section .data
    angle DD 0.7853
    one DD      -1
    n   DD      5 ;debe ser mayor a 2 y menor a 6
    nFinal DD  5

    stackTop DD 0
    fact DD 0

    senx DD 0.0