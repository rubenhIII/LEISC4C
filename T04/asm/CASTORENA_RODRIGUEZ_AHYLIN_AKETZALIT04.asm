;ahylin aketzali castorena rodriguez
GLOBAL main
section .text
    finit
    main:

        sinofx:
            mov eax, 0
            mov ebx, 0
            call calcsenx
            mov ax, [ni]
            cmp ax, [miter]
            jle sinofx

    ext:
        mov eax, 1      ;paso de parametros
        mov ebx, 0      ;paso de paramteros
        int 0x80        ;manejador de interrupciones

    calcsenx:
        call denominador
        call signo
        call divicion
        call potencia
        call Opmult
        call suma
        call reset
        call incc
        ret

    signo:
        mov eax, 0
        mov ax, [sig]
        cmp ax, -1
        je positivo
        mov ax, -1
        jmp segnum
    positivo:
        mov ax, 1
    segnum:
        mov [sig], ax
        ret

    denominador:
        mov eax, 0
        mov ecx, 0
        mov ax, [ni]
        cmp ax, 0
        je firstfac
        add ax, ax
        inc ax
        mov [deno], ax
        mov cx, [deno]
        dec cx
        mov ax, 0

    factCalc:
        mov ax, [deno]
        mul cx
        mov [deno], eax
        dec cx
        cmp cx, 0
        jz bk
        call factCalc
        bk:
            ret   
    firstfac:
        mov ax, 1
        mov [deno], ax
		

    divicion:
        fld dword [numer]
        fld dword [deno]
        fdivp
        mov eax, 0
        mov ax, [sig]
        cmp ax, 1
        je salirdivi
        fld1
        fchs
        fmulp
     salirdivi:
        fstp dword [divi]
        ret

    incc:
        mov ax, [ni]
        inc ax
        mov [ni], ax
        ret


    potencia:
        ;x^(2n+1)
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov ax, [ni]
        add ax, ax
        inc ax
        mov cx, ax
    power:
        call mult
        loop power
        ret

    mult:
        fld dword [num]
        fld dword [powr]
        fmulp
        fstp dword [powr]
        ret
        
    Opmult:
        fld dword [divi]
        fld dword [powr]
        fmulp
        fstp dword [sum]
        ret

    suma:
        fld dword [sum]
        fld dword [senx]
        faddp
        fstp dword [senx]
        ret
    reset:
        fld1
      fstp dword [powr]
        ret

section .data
    numer dd 1
    sig dd -1
    deno dd 0.0
    divi dd 0.0
    multiplicador dd 0
    powr dd 1.0
    sum dd 0.0
    ni dd 0                  ;numero de iteraciones
    miter dd 5            ;numero maximo de iteraciones
    num dd 0.7853             ;pi/4
    senx dd 0.0             ;resultado

