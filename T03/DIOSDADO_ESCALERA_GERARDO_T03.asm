TITLE "Factorial"

; Autor: Gerardo Diosdado Escalera
; Fecha: 
; Descripcion del Programa:

COMMENT !
--------------------------
!

.MODEL SMALL ; Definicion del tipo de memoria

.STACK 100h ; Segmento de Pila 

.DATA ; Segmento de Datos
    factorial DW 7

.CODE ; Segmento de Codigo
    MAIN PROC ; Procedimiento Principal
        ; Inicializacion de Segmento de Codigo
        MOV AX, @DATA
        MOV DS, AX 

        ; -------Codigo-----------
        MOV AX, factorial   ; AX = factorial
        MOV BX, AX  ; BX = AX 
        DEC BX      ; BX = AX - 1
        CMP BX, 0   ; Comparacion para los casos de factorial de 0 y 1
        JLE uno     ; Si AX es 1 o 0, se salta a la etiqueta uno (factorial = 1)
        CALL FACT   ; Si AX es mayor que 1, se llama al procedimiento FACT
        JMP salida

    uno:
        MOV AX, 1
        MOV factorial, AX   ; factorial = 1

        ;--------Salida-----------
    salida:
        MOV AX, 04Ch
        INT 21h
    MAIN ENDP

    ; -------Procedimientos-----
    FACT PROC  
        MOV AX, AX 
        MOV BX, BX
        MUL BX              ; AX = AX * BX
        MOV factorial, AX   ; factorial = AX
        DEC BX          ; Se decrementa BX que es el contador
        CMP BX, 1   ; Se compara BX con 1
        JLE salir   ; Si BX es 1 o menos, se sale del procedimiento
        CALL FACT   ; Si BX es mayor que 1, se llama al procedimiento FACT

    salir:
        RET
    FACT ENDP

END MAIN ; Fin del Programa
