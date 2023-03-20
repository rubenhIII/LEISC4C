TITLE "factorial"

;Autor:AHYLIN AKETZALI CASTORENA RODRIGUEZ
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   numero EQU 3d;numero en decimal del cual calcularemos el factorial
   factorial DW 0d                           
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        ;MOV AX,0
        MOV DS,AX
        MOV ES,AX
         
        ;-------------------------
;-------Codigo-----------

        MOV AX,numero ;movemos al registro lo de nuestra variable numero
        MOV CX,numero-1
        
        CALL factori ; llamamos a la etiqueta factori
        
        MOV AX,04Ch; es una interrupcion 04Ch
        INT 21h;interrupcion
        
        
   MAIN ENDP
   
;-------Procedimientos-----

 factori PROC
      
      MUL CX ; aqui se hace la operacion de multiplicar
      MOV factorial,AX ; mover lo que tiene el registro AX a la variable factorial
      DEC CX ; decrementa el contador
      
      CMP  CX,numero ;compara si es igual a nuestro numero
      JLE  eti ;salta a la etiqueta eti
      CALL factori ; llama a factori     
      
      
 eti:   
     MOV AX,factorial ;Movemos al registro AX el resultado de la multiplicacion
     RET ;retorna
    
;fibonacci ENDP                
                           
;--------------------------

END MAIN ;Fin del Programa
