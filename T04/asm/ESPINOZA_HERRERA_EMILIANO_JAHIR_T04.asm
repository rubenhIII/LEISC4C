global main
section .data   
;EMILIANO JAHIR ESPINOZA HERRERA 
    n: dd 5 ;número de iteraciones
    x: dd 3 ;valor de x en la función
    res2n1: dd 0 ;variable para almacenar el valor de 2n+1
    fac2n1: dd 0 ;variable para almacenar el valor de (2n+1)!
    numPotencia: dd 0 ;variable para almacenar el valor de (x)^2n+1
    numNeg: dd 0 ;variable para almacenar el valor de (-1)^n
    resDiv: dd 0 ;variable para almacenar el valor de (-1)^n/(2n+1)!

section .text

main:
    mov ebx, 1
    mov [res2n1], ebx
    mov [fac2n1], ebx
    mov [numNeg], ebx
    mov ebx, 0

    call num2n1

    mov ecx, 0
    mov cx, [res2n1]
    call facto2n1

    call potencia

    jmp potenciaNeg

num2n1:
    mov eax, [n]
    shl eax, 1
    add eax, 1

    mov [res2n1], eax

    mov eax, 0

    ret

facto2n1:
    mov eax, [fac2n1]
    mul cx

    mov [fac2n1], eax

    dec cx
    cmp cx, 0
    jz bk
    call facto2n1
bk:
    mov eax, 0
    ret

potencia:
    fld dword [x]
    fld dword [x]

    mov ecx, 0
    mov ecx, [res2n1]
    dec ecx

    call potencia2
    fstp dword [numPotencia]

    ret

potencia2:
    fmul st0, st1

    loop potencia2

    ret

potenciaNeg:
    mov eax, [n]
    and eax, 1
    cmp eax, 0b
    jz pos
    jmp negativo

negativo:
    mov ebx, -1
    mov [numNeg], ebx
    jmp divMul

pos:
    mov ebx, 1
    mov [numNeg], ebx
    jmp divMul
        
divMul:
    finit
    fild dword [numNeg]
    fild dword [fac2n1]

    fdiv

    fstp dword [resDiv]

    ;Aquí se colocaría el código para imprimir el resultado

    ret
