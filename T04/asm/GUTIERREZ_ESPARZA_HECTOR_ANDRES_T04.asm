section .rodata
    maxiter: dd 5

section .data
    input: dd 4.0
    ioutput: dd 0.0
    senx: dd 0.0
    n: dd 0

    sign: dd -1

    ebase: dd 0.0
    exp: dd 0
    poutput: dd 1.0

    foutput: dd 1
    fbase: dd 0

section .text
    global main
    main:
        mov dword [n], 0
        mov eax, 0
        call calcinput
        call calcsin
    exit:
        mov eax, 01h
        mov ebx, 00h
        int 80h

    calcinput:
        finit
        fldpi
        fld dword [input]
        fdiv
        fstp dword [input]
        ret

    changesign:
        cmp dword [sign], 1
        je negate
        mov dword [sign], 1
        ret
    negate:
        mov dword [sign], -1
        ret

    calcexp:
        mov ax, [n]
        mov bl, 2
        mul bl
        add ax, 1
        mov [exp], ax
        ret

    calcsin:
        ;(-1)^n
        call changesign
        ;(2n+1)
        call calcexp
        ;factorial
        mov [fbase], ax
        call calcfact
        ;[]/[]
        fild dword [sign]
        fild dword [foutput]
        fdiv
        fstp dword [ioutput]
        ;x^(2n+1)
        fld dword [input]
        fstp dword [ebase]
        call calcpow
        ;[]*[]
        fld dword [ioutput]
        fld dword [poutput]
        fmul
        fst dword [ioutput]
        ;x - x^3/3!+...
        fld dword [senx]
        fadd
        fstp dword [senx]
        inc dword [n]
        mov eax, [maxiter]
        cmp eax, [n]
        jae calcsin
        ret

    calcpow:
        fld1
        fstp dword [poutput]
        mov ecx, [exp]
        cmp dword [exp], 0
        jne powCalc
        ret
    powCalc:
        fld dword [poutput]
        fld dword [ebase]
        fmul
        fstp dword [poutput]
        loop powCalc
        ret

    calcfact:
        mov dword [foutput], 1
        mov ecx, [fbase]
    factCalc:
        mov eax, [foutput]
        mul ecx
        mov [foutput], eax
        loop factCalc
        ret