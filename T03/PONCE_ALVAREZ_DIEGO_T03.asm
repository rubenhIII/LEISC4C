TITLE "Factorial"

;Autor:Diego Ponce Alvarez
;Fecha:20/03/2023
;Descripcion del Programa:Factorial de un numero
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    varNum DB 1 ;Se asigna una variable donde se ira guardando el resultado de la multiplicacion
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        MOV CX,5 ;Contador dependiendo el numero al que se le realizara su factorial
        
      Factorial:
          MOV AL,varNum ;El registro AL ira guardando el acumulado de cada multiplicacion y se iniciañiza en 1  
          MOV BX,CX     ;Se le pasa el valor de CX a BX para multiplicarlo con el registro AX
          MUL BX        ;Se realiza la multiplicacion entre AX y BX
          MOV varNum,AL ;El resultado pasa a la variable para irlo acumulando 
          LOOP Factorial  ;Se repetira el ciclo hasta que CX sea 0
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa