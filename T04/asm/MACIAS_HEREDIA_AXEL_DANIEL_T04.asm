GLOBAL main
section .data
    senx DD 0.0
    max DD 2
    x DD 0.7853
    n DD 3
    factr DD 0.0
    potr DD 1.0
    division DD 0.0
    unoS DD -1

section .text
    finit

    main:
        mov eax, 0
        mov ecx, 0
    inicio:
        call senoCalc
        add dword [n], 2
        fld1
        fstp dword [potr]
        dec dword [max]
        jnz inicio
        fld dword [senx]
        fld dword [x]
        faddp
        fstp dword [senx]


    ext:
        mov eax, 1
        mov ebx, 0
        int 0x80

    factCalc:
        mov ax,[factr]
        mul cx
        mov [factr],ax

        loop factCalc
        ret


    senoCalc:
        mov cx ,[n]
    potencia:
        fld dword [x]
        fld dword [potr]
        fmulp
        fstp dword [potr]

        loop potencia

        mov cx,[n]
        mov [factr],cx
        dec cx
        call factCalc
        call divi
        ret
    divi:
        fld dword [potr]
        fild dword [factr]
        fdivp
        fild dword [unoS]
        fmulp
        fstp dword [division]
        fild dword [unoS]
        fchs
        fistp dword [unoS]
        fld dword [senx]
        fld dword [division]
        faddp
        fstp dword [senx]
        ret

;NOTAS

;FCHS cambia el signo
;FDIVP divide en la pila
;FILD carga un entero
;FISTP quita un entero
;FADDP suma

;((-1)^n(x)^2n+1)
;----------------
;     (2n+1)!

;0.707106 radianes