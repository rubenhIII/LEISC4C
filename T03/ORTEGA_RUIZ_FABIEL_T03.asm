TITLE "Factorial de numero"               

;Autor: Fabiel Ortega Ruiz
;Fecha: 19/03/2023
;Descripcion del programa: Programa que realiza el calculo del factorial de un numero    

COMMENT!
---------------------------------------------------------------------------------------
!

.MODEL SMALL

.DATA
    num db 5    ; numero para calcular el factorial
    fact dw 1   ; resultado inicial del factorial  
    
_start:
    ; carga el numero en el registro AX
    MOV AX, [num]

    ; inicializa el contador en el registro CX
    MOV CX, AX

    ; realiza el bucle de multiplicación
    mult_loop:
        ; multiplica el factorial parcial por el contador actual
        IMUL CX, [fact]

        ; decrementa el contador
        DEC CX

        ; salta al final del bucle si el contador es cero
        JZ mult_end

        ; salta al principio del bucle si el contador no es cero
        JMP mult_loop

    mult_end:
        ; almacena el resultado en la variable fact
        MOV [fact], CX

        ; finaliza el programa
        MOV EAX, 1
        XOR EBX, EBX
        INT 0x80
