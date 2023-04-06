GLOBAL main

section .data
    numerador dd 1
    signo dd -1
    denominador dd 0.0
    divicion dd 0.0
    multiplicador dd 0
    powr dd 1.0
    sum dd 0.0




    n dd 0                  ;numero de iteraciones
    maxiter dd 8            ;numero maximo de iteraciones
    x dd 0.7853             ;pi/4
    senx dd 0.0             ;resultado

section .text
    finit

    main:
        sinofx:
            mov eax, 0
            mov ebx, 0
            call calcsenx
            mov ax, [n]
            cmp ax, [maxiter]
            jle sinofx

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
        call getdenominador
        call getsigno
        call getdivicion
        call getpotencia
        call getmult
        call getsum
        call resetpwr
        call incn
        ret

;==================================================================
;                     ____  _                   
;                    / ___|(_) __ _ _ __   ___  
;                    \___ \| |/ _` | '_ \ / _ \ 
;                     ___) | | (_| | | | | (_) |
;                    |____/|_|\__, |_| |_|\___/ 
;                             |___/             
;==================================================================
    getsigno:
        mov eax, 0
        mov ax, [signo]
        cmp ax, -1
        je positivo
    ;negativo:
        mov ax, -1
        jmp nextnumerador
    positivo:
        mov ax, 1
    nextnumerador:
        mov [signo], ax
        ret
;==================================================================
;  ____                             _                 _            
; |  _ \  ___ _ __   ___  _ __ ___ (_)_ __   __ _  __| | ___  _ __ 
; | | | |/ _ \ '_ \ / _ \| '_ ` _ \| | '_ \ / _` |/ _` |/ _ \| '__|
; | |_| |  __/ | | | (_) | | | | | | | | | | (_| | (_| | (_) | |   
; |____/ \___|_| |_|\___/|_| |_| |_|_|_| |_|\__,_|\__,_|\___/|_|   
;==================================================================
    getdenominador:
        mov eax, 0
        mov ecx, 0
        mov ax, [n]
        cmp ax, 0
        je firstfac
        add ax, ax
        inc ax
        mov [denominador], ax
        mov cx, [denominador]
        dec cx
        mov ax, 0

;==================================================================
;                ___         __           _      __
;               / _/__ _____/ /____  ____(_)__ _/ /
;              / _/ _ `/ __/ __/ _ \/ __/ / _ `/ / 
;             /_/ \_,_/\__/\__/\___/_/ /_/\_,_/_/  
;==================================================================
    factCalc:
        mov ax, [denominador]
        mul cx
        mov [denominador], eax
        dec cx
        cmp cx, 0
        jz bk
        call factCalc
        bk:
            ret   
    firstfac:
        mov ax, 1
        mov [denominador], ax
        ret
    
;==================================================================
;                    ___      _     _         
;                ___/ (_)  __(_)__ (_)__  ___ 
;               / _  / / |/ / (_-</ / _ \/ _ \
;               \_,_/_/|___/_/___/_/\___/_//_/
;==================================================================
    getdivicion:
        fld dword [numerador]
        fld dword [denominador]
        fdivp
        mov eax, 0
        mov ax, [signo]
        cmp ax, 1
        je salirdivicion
        fld1
        fchs
        fmulp
    salirdivicion:
        fstp dword [divicion]
        ret



;==================================================================
;                    _             
;                   (_)__  _______ 
;                  / / _ \/ __/ _ \
;                 /_/_//_/\__/_//_/
;==================================================================
    incn:
        mov ax, [n]
        inc ax
        mov [n], ax
        ret

;==================================================================
;              ____       _                  _       
;             |  _ \ ___ | |_ ___ _ __   ___(_) __ _ 
;             | |_) / _ \| __/ _ \ '_ \ / __| |/ _` |
;             |  __/ (_) | ||  __/ | | | (__| | (_| |
;             |_|   \___/ \__\___|_| |_|\___|_|\__,_|
;==================================================================
    getpotencia:
        ;x^(2n+1)
        mov eax, 0
        mov ebx, 0
        mov ecx, 0
        mov ax, [n]
        add ax, ax
        inc ax
        mov cx, ax
    power:
        call mult
        loop power
        ret

    mult:
        fld dword [x]
        fld dword [powr]
        fmulp
        fstp dword [powr]
        ret
        
;==================================================================
;   __  __       _ _   _       _ _                _             
;  |  \/  |_   _| | |_(_)_ __ | (_) ___ __ _  ___(_) ___  _ __  
;  | |\/| | | | | | __| | '_ \| | |/ __/ _` |/ __| |/ _ \| '_ \ 
;  | |  | | |_| | | |_| | |_) | | | (_| (_| | (__| | (_) | | | |
;  |_|  |_|\__,_|_|\__|_| .__/|_|_|\___\__,_|\___|_|\___/|_| |_|
;                       |_|                                     
;==================================================================
    getmult:
        fld dword [divicion]
        fld dword [powr]
        fmulp
        fstp dword [sum]
        ret
;==================================================================
;                ___ _   _ _ __ ___   __ _ 
;               / __| | | | '_ ` _ \ / _` |
;               \__ \ |_| | | | | | | (_| |
;               |___/\__,_|_| |_| |_|\__,_|
;==================================================================
    getsum:
        fld dword [sum]
        fld dword [senx]
        faddp
        fstp dword [senx]
        ret
;==================================================================
;                    _                      
; _ __ ___  ___  ___| |_ _ ____      ___ __ 
;| '__/ _ \/ __|/ _ \ __| '_ \ \ /\ / / '__|
;| | |  __/\__ \  __/ |_| |_) \ V  V /| |   
;|_|  \___||___/\___|\__| .__/ \_/\_/ |_|   
;                       |_|                 
;==================================================================
    resetpwr:
        fld1
        fstp dword [powr]
        ret