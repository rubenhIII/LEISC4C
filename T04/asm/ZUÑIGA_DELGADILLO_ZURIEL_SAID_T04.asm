GLOBAL main

section .text
    main:
        fld dword [x]

        ; calcular seno
        fld1
        fld dword [x]
        fld dword [x]
        call calcular
        fstp dword [term]
        fld dword [term]
        fld dword [x]
        fld dword [x]
        call calcular
        fstp dword [term]
        fld dword [term]
        fld dword [x]
        fld dword [x]
        call calcular
        fstp dword [term]
        fld dword [term]
        fld dword [x]
        fld dword [x]
        call calcular
        fstp dword [term]
        fld dword [term]
        fld dword [x]
        fld dword [x]
        call calcular
        fstp dword [term]

        ; imprimir resultado
        fld dword [senx]
        fstp qword [esp]
        mov eax, 1
        mov ebx, 0
        int 0x80

        ; salir del programa
        mov eax, 1
        xor ebx, ebx
        int 0x80

    factorial:
        ; fact = fact * (n - 1)
        fld dword [facto]
        fld dword [facto]
        fld1
        fsub
        fmul
        fstp dword [facto]
        fldz
        fld dword [facto]
        fcomip st0, st1
        je .done
        dec dword [esp]
        jmp factorial

    .done:
        fstp st1
        add dword [esp], 4
        ret

    calcular:
        ; term = (sign * x^n) / n!
        fld dword [signo]
        fld dword [aux]
        fld dword [x]
        fmul
        fxch
        fld dword [x]
        fmul
        fxch
        fld dword [facto]
        call factorial
        fdiv
        fmul
        fld dword [signo]
        fchs
        fxch
        fstp dword [signo]
        add dword [esp], 4
        ret

section .data
    x       dd 0.7853              
    facto   dd 1.0                 ; factorial
    signo   dd 1.0                 ; signo
    aux     dd 0.0                 ; variable auxiliar
    term    dd 0.0                 ; término actual
    senx    dd 0.0                 ; resultado