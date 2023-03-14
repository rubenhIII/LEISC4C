TITLE "Algoritmo de redundancia ciclica"

;Autor:Ricardo Daniel Alvarez Martinez
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL
.STACK 100H

.DATA
cad DW 1011000000000000b ; mensaje a ser dividido
polinomio DW 1101001110110000b ; polinomio inicial

.CODE
MAIN PROC
    MOV AX, @DATA
    MOV DS, AX 


    MOV CX, 16 ; contador que ayudara a recorrer el mensaje
    MOV BX, 16 ; lo mismo para el polinomio en el polinomio


    MOV DX, cad ;se mueve el valor de la cadena al registro


    MOV AX, polinomio ;se coloca en el registro AX el valor del polinomio

division:
    ; ver si el bit mas significativo es 1, sino para recorrer y hacer shifteo
    CMP DX, 0 ; comparar si el valor del registro es 0, o sea que se tendra que recorrer, pq se tomara a partir del 1
    JE shift ; salta si es igual a cero
    XOR AX, polinomio ; XOR del registro AX con el polinomio en caso de que sea el mas significativo 1, a partir de ahi


shift:
    SHL DX, 1 ;shiftear o mover el registro DX a la izquierda pq el bit significativo fue 0
    DEC CX   ;se decrementa el contador
             ;se decrementara hasta que sea igual a 0, es decir, que haya recorrido todo el mensaje
    JNZ division ; saltar si no es igual a cero


    MOV AX, DX ; copiar el resultado a AX
    MOV polinomio, AX

MAIN ENDP

END MAIN
