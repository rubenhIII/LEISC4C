section .rodata
    ; pi: dq 3.1415926535897932
    maxiter: dq 7.0
    minusone: dq -1.0

section .data
    input: dq 4.0
    base: dq 0.0
    output: dq 0.0
    senx: dq 0.0
    n: dq 0.0

    ebase: dq 0.0
    exp: dq 0.0
    eoutput: dq 1.0

    foutput: dq 1.0
    fbase: dq 0.0
    findex: dq 0.0

section .text
    global main
    main:
        finit
        mov eax, 23
        fldpi
        ; fld qword [pi]
        fld qword [input]
        fdiv
        fstp qword [input]
        call calcSin
    exit:
        mov eax, 01h
        mov ebx, 00h
        int 80h

    calcSin:
        ;(-1)^n
        fld qword [minusone]
        fstp qword [ebase]
        fld qword [n]
        fstp qword [exp]
        call startExp
        ;(2n+1)!
        fld qword [n]
        fld1
        fld1
        fadd
        fmul
        fld1
        fadd
        fst qword [base]
        fstp qword [fbase]
        ;factorial
        call fact
        ;division
        fld qword [eoutput]
        fld qword [foutput]
        fdiv
        fstp qword [output]
        ;x^(2n+1)
        fld qword [input]
        fstp qword [ebase]
        fld qword [base]
        fstp qword [exp]
        call startExp
        ;multiplicacion
        fld qword [output]
        fld qword [eoutput]
        fmul
        fst qword [output]
        ;sumatoria
        fld qword [senx]
        fadd
        fstp qword [senx]
        fld qword [n]
        fld qword [maxiter]
        fcompp
        fstsw ax
        fld qword [n]
        fld1
        fadd
        fstp qword [n]
        and eax, 0100011100000000b
        cmp eax, 0000000000000000b
        jne bk2
        call calcSin
    bk2:
        ret

    startExp:
        fld1
        fstp qword [eoutput]
        fldz
        fld qword [exp]
        fcompp
        fstsw ax


        and eax, 0100011100000000b
        cmp eax, 0000000000000000b
        je notazero
        fld1
        fstp qword [eoutput]
        ret
    notazero:
        fld qword [eoutput]
        fld qword [ebase]
        fmul
        fstp qword [eoutput]
        fldz
        fld qword [exp]
        fld1
        fsub
        fst qword [exp]
        fcompp
        fstsw ax
        and eax, 0100011100000000b
        cmp eax, 0100000000000000b
        je bk
        call notazero
    bk:
        ret

    fact:
        ; mov ecx, [fbase]
        
        fld qword [fbase]
        fld1
        fld1
        fadd
        fcompp
        fstsw ax
        and eax, 0100011100000000b
        cmp eax, 0000000000000000b
        fld1
        fstp qword [foutput]
        jne canProceed
        ret
    canProceed:
        fld qword [fbase]
        fstp qword [findex]
    factCalc:
        fld qword [foutput]
        fld qword [findex]
        fmul
        fstp qword [foutput]
        
        fld1
        fld qword [findex]
        fld1
        fsub
        fst qword [findex]
        fcompp
        fstsw ax
        and eax, 0100011100000000b
        cmp eax, 0100000000000000b
        je bk1
        call factCalc
    bk1:
        ret