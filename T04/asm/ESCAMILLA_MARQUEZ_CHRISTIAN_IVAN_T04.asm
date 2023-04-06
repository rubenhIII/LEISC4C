GLOBAL main
;Profesor, el programa lo hicimos entre un compañero y yo
;No se si haya problema en ello, es que llevabamos toda la semana trabajando juntos
;en este trabajo y aparte otros trabajos de otras materias
;Nuestros nombres son:
;-Christian Iván Escamilla Márquez
;-Aaron Antonio Raygoza Macias

;Esperamos que no haya problema el que hayamos trabajado juntos en el codigo, ya que si estuvimos varios dias intentandolo
;Tambien le dejamos un correo por si acaso, gracias de antemano
section .text
    main:
        ;mov 
        mov dword[factroial], 1
        mov dword[powr], 0
        finit
        fild dword[powr]
        fld dword [aux]
        fadd
        fstp dword[powr]

        call fun2n

        mov eax, [two]
        mov [base], eax
        call factos

        mov ebx, [two]
        mov [pown], ebx
        mov eax, [x]
        mov [powb], eax
        call pot

        call s1

        call sumat

        
        finit
        fld dword[temp]
        fld dword[senx]
        fadd
        fstp dword[senx]

        inc dword [n]
        cmp dword [n], 5
        jne main
        jmp ext

    ;factorial
    factos:
        mov ecx, 0
        mov cx, [base]
        call factCalc
        ret

    factCalc:
        mov eax, [factroial]
        mul cx
        mov dword[factroial], eax
        dec cx
        cmp cx, 0
        jz bk
        call factCalc
        bk:
        ret

    ;potencia
    pot:
        mov ecx, 0
        mov cl, [pown]

    c1:
        call mult
        loop c1
        ret


    mult:
        finit
        fld dword [powb]  ;Carga en pila
        fld dword [powr]  ;Carga en pila
        fmulp       ;multiplica f01*f02
        fstp dword [powr]  ;carga a memoria el resultado
        ret

    ;signo
    s1:
        mov ecx, [n]
        mov eax, [res]
        mov ebx, [signo]
        call llam
        ret

    llam:
        cmp cx, 0
        jz sign
        mul ebx
        mov [res], eax
        dec cx
        call llam
        sign: 
        ret

    ;2n+1
    fun2n:
        mov eax, [n]
        mov ebx, 2
        mul ebx
        inc eax
        mov [two], eax
        ret

    sumat:
        finit
        fild dword [res]  ;Carga en pila
        fld dword [powr]  ;Carga en pila
        fmulp       ;multiplica f01*f02
        fild dword [factroial]
        fdiv
        fst dword [temp]
        ret

    ext:
        mov ecx, 1
        mov ebx, 0
        int 0x80
    
section .data
    ;factorial
    factroial: DD 1   ;resultado
    base: DD 0          ;factorial del numero

    ;potencia
    powr: DD 1     ;Resultado de la potencia
    pown: DB 0       ;Potencia
    powb: DD 0       ;Base

    ;signo
    signo: DD -1      ;(-1)
    res: DD 1      ;resultado

    ;Senx
    senx: DD 0     ;resultado final
    two: DD 1      ;2n+1
    x: DD 0.7853      ;x
    n: DD 0        ;n
    temp: DD 0
    aux: DD 1.0