GLOBAL main

section .data
    sig dd -1             ;signo de la operacion
    den dd 0.0
    num dd 1.0
    divi dd 0.0
    ;2023-04-07 11:18:45
    n dd 3                  ;n en la iteracion
    max dd 8                ;maximo de iteraciones
    x dd 0.7853             ;pi/4
    senx dd 0.7853          ;resultado  

section .text
  finit
  main:
        mov eax, 0
        mov ecx, 0
    sinofx:
        call calsen
        add dword [n], 2
        fld1
        fstp dword [num];reset de numerador
        dec dword [max]
        jnz sinofx
    ext:
        mov eax, 1      ;paso de parametros
        mov ebx, 0      ;paso de paramteros
        int 0x80        ;manejador de interrupciones
;Sen X
    calsen:
        mov cx, [n]
    pow:
        fld dword [x]
        fld dword [num]
        fmulp
        fstp dword [num]
        loop pow
        ;2023-04-07 13:43:08
;########### den ############
        mov cx, [n]
        mov [den], cx
        dec cx
    factc:
        mov ax, [den]
        mul cx
        mov [den], ax
        loop factc
;########### div ############
        fld dword [num]
        fild dword [den]
        fdivp
        fild dword [sig]
        fmulp             ;2023-04-07 13:50:21
        fstp dword [divi]
        fild dword [sig]
        fchs
        fistp dword [sig]
;########### suma ############
        fld dword [senx]
        fld dword [divi]
        faddp             ;2023-04-07 14:00:16
        fstp dword [senx]
        ret