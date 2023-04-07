GLOBAL main

section .data
    signo dd -1             ;signo de la operacion
    denominador dd 0.0
    numerador dd 1.0
    division dd 0.0

    n dd 3                  ;n en la iteracion
    maxiter dd 8            ;numero maximo de iteraciones
    x dd 0.7853             ;pi/4
    senx dd 0.7853          ;resultado

section .text
    finit

    main:
        mov eax, 0
        mov ecx, 0
    sinofx:
        call calcsenx
        add dword [n], 2
        fld1
        fstp dword [numerador];reset de numerador
        dec dword [maxiter]
        jnz sinofx
    ext:
        mov eax, 1      ;paso de parametros
        mov ebx, 0      ;paso de paramteros
        int 0x80        ;manejador de interrupciones
;==================================================================
;
;  ██       ███████ ███████ ███    ██   ██  ██   ██  ██        ██ 
;   ██      ██      ██      ████   ██  ██    ██ ██    ██      ██  
;    ██     ███████ █████   ██ ██  ██  ██     ███     ██     ██   
;   ██           ██ ██      ██  ██ ██  ██    ██ ██    ██      ██  
;  ██       ███████ ███████ ██   ████   ██  ██   ██  ██        ██ 
;                                                               
;==================================================================
    calcsenx:
;====================[ N U M E R A D O R]==========================
        mov cx, [n]
    power:
        fld dword [x]
        fld dword [numerador]
        fmulp
        fstp dword [numerador]
        loop power
;====================[ D E N O M I N A D O R ]====================
        mov cx, [n]
        mov [denominador], cx
        dec cx
    factCalc:
        mov ax, [denominador]
        mul cx
        mov [denominador], ax
        loop factCalc
;====================[ D I V I S I O N ]==========================
        fld dword [numerador]
        fild dword [denominador]
        fdivp
        fild dword [signo]
        fmulp
        fstp dword [division]
        fild dword [signo]
        fchs
        fistp dword [signo]
;====================[ S U M A ]==================================
        fld dword [senx]
        fld dword [division]
        faddp
        fstp dword [senx]
        ret