TITLE "Factorial de un numero"

;Autor:Jesus Ruvalcaba Lozano
;Fecha:20/03/2023
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   num DW 8d
   fac DW 1d
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        CALL Facto
         
        
        
   MAIN ENDP 
   
   Facto PROC
        
        MOV BX,0d     ;Le asignamos 0 al registro BX
        MOV AX,1d     ;Le asignamos 1 al registro AX para que no quede la multiplicacion en 0
    
    factorial:        ;Hacemos el procedimiento del factorial
        INC BX        ;Incrementamos BX
        MUL BX        ;Multiplicamos lo que tenemos en el registro AX por BX
        MOV fac,AX    ;Le asignamos lo que tenemos en AX a la variable factorial
        CMP BX,num    ;Comparamos si llegamos al numero deseado
        JNZ factorial ;Si no hemos llegado continuamos en la funcion
        JZ  fin       ;Si llegamos nos vamos al fin del programa
    
    fin:
        
        
        
   Facto ENDP

END MAIN ;Fin del Programa