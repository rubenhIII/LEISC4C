;Viernes 04/Abril/2023
;programa para calcular el seno de un numero 
GLOBAL main

section .data
    senx dd 0.7853;seno
    x dd 0.7853; 
    pow dd 0.7853
    num dd 0.0
    divi dd 0.0
    de dd 0.0

    cont dd 1
    fact dd 1 
    sig dd -1
    term db 8

section .text
    finit
    main:
        mov eax, 0
        mov ecx, 0
        mov cx, [term]
    cal:
        call powe
        loop cal
    
    ext:
        mov eax, 1 
        mov ebx, 0
        int 0x80
    
    powe:
        fld dword [x]
        fld dword [pow]
        fmulp
        fstp dword [pow]
        fld dword [pow]
        fld dword [x]
        fmulp
        fstp dword [pow]
    cald:
        ;factorial *= (2 * i) * (2 * i + 1);
        mov eax,2
        mov ebx,[cont]
        mul ebx
        mov [num],eax

        mov eax,2
        mov ebx,[cont]
        mul ebx
        mov [divi],eax

        ; cargar el valor de divi en la FPU y sumar 1
        mov eax, [divi]
        mov ebx,1
        add eax,ebx
        mov [divi],eax

        mov eax, [divi]
        mov ebx, [num]
        mul ebx
        
        mov [num],eax

        mov eax, [fact]
        mov ebx, [num]
        mul ebx

        mov [fact],eax

        inc dword [cont]
    seno:
        ffree
        fld dword [pow]
        fild dword [fact]
        fdivp
        fstp dword[de]
        fild dword [sig]
        fld dword [de]
        fmulp
        ;seno += signo * potencia / factorial;
        fld dword [senx]
        faddp
        fstp dword [senx]
        fild dword [sig]
        fchs
        fistp dword [sig]
        ret