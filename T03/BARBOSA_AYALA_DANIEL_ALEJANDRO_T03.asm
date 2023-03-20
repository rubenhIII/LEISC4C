TITLE "Factorial de un numero"

;Autor:Daniel Alejandro Barbosa Ayala
;Fecha:20/03/2023
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    num DW 5 ;En caso de buscar el factorial de cualquier otro numero, se cambia el valor de num
    multiplicando DW 1
    multiplicador DW 1
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
   
   MOV CX,num
   
   factorial:
        MOV AX,multiplicando ;Le da el valor del multiplicando al registro AX
        MOV DX,multiplicador ;Le da el valor del multiplicador al registro DX
        MUL DX ;Realiza la multiplicacion del contenido del registro AX, por el DX
        MOV multiplicando,AX ;Actualiza el valor del multiplicando para el siguiente ciclo
        INC multiplicador ;Le suma 1 al valor actual del multiplicador para el siguiente ciclo
        MOV fact,AX ;Almacena el valor del ciclo en la variable fact para ver el avance
        LOOP factorial
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa