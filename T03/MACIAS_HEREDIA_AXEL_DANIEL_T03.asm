TITLE "Factorial"

;Autor:
;Fecha:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    Var1 DW 5 ;En caso de buscar el factorial de cualquier otro numero, se cambia el valor de num
    multi1 DW 1
    multi2 DW 1
    fact DW ? ;Esta variable sirve para ver el progreso del programa
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
   
   MOV CX,Var1
   
   factorial:
        MOV AX,multi1 ;Agregamos a AX el valor a multiplicar
        MOV DX,multi2 ;Agregamos a DX el valor multiplicador
        MUL DX ;Realiza la multiplicacion del contenido del registro AX, por el DX
        MOV multi1,AX ;Actualiza el valor del multi1
        INC multi2 ;Le suma 1 al valor actual del multiplicador para el siguiente ciclo
        MOV fact,AX ;Almacena el valor del ciclo en la variable fact para ver el avance
        LOOP factorial
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa