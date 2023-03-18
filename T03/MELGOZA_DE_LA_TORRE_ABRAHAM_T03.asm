TITLE "Calculo de Exponencial"

; Autor: Melgoza de la Torre Abraham
; Fecha:
; Descripcion del Programa:

COMMENT !
--------------------------
!

.MODEL SMALL    ;Definicion del tipo de memoria

.STACK 100h     ;Segmento de Pila 

.DATA           ;Segmento de Datos
    ; -------Variables---------
    num EQU 5
    var DD num
    cont DD num
    res DD 0

    ; --------------------------

.CODE         ; Segmento de Codigo
MAIN PROC ; Procedimiento Principal
              ; Inicializacion de Segmento de Codigo
    MOV AX, @DATA
    MOV DS, AX 
    ; -------Codigo-----------
    mov CX, 0
    mov AX, 0
    mov BX, 0

    mov AX, var 
    MOV res, AX       ; guardar el resultado en la variable res
    call exponencial

    ;interrumpir el programa para detenerlo
    MOV AX,04Ch
    INT 21h
    ; --------------------------
MAIN ENDP
    ; -------Procedimientos-----

exponencial PROC
    DEC cont          ; decrementar el contador
    MOV CX, cont      ; decrementar el contador
    JZ  continue      ; si el contador es cero, terminar
    MOV AX, 0
    multiplicar:
        ADD AX, res
    loop multiplicar
    MOV res, AX
    call exponencial
    continue:
    RET

exponencial ENDP
    ; --------------------------
END MAIN ; Fin del Programa
