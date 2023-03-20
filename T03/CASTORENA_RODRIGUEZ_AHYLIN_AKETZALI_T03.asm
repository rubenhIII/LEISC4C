TITLE "factorial"

;Autor:
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
      
      MUL CX
      MOV factorial,AX 
      DEC CX
      
      CMP  CX,numero
      JLE  eti
      CALL factori     
      
      
 eti:   
     MOV AX,factorial
     RET 
    
;fibonacci ENDP                
                           
;--------------------------

END MAIN ;Fin del Programa