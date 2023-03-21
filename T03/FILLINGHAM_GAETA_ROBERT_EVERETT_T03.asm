

TITLE ""

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!




.MODEL SMALL ;Definicion del tipo de memoria, el modo que ingresemos formara los segmentos de datos cosigo y stack de distintas maneras

.STACK 100h  
    ;Segmento de la memoria donde estara la Pila, es distinta a la instruction queue ya que ese es un registro en el CPU
    
.DATA
    ;Segmento de Datos 
    
    numero DW 8
    var1   DW 0  ;ahi estara el resultado
    factor  DW 0
 
  
.CODE
    ;Segmento de Codigo
   
   
   
   
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        
;-------Codigo-----------

        MOV CX, numero
        MOV var1, CX
        SUB CX, 2
        MOV factor, CX
        
        MOV AX, numero
        
        call factorial 
        

        
        MOV AX, 04Ch ;termina el programa y evita que continue con el resto del codigo
        INT 21h 
        
        
   MAIN ENDP   ; end procedure  
   
   factorial PROC
                
             
             
       suma: add AX, var1
             loop suma
             
             dec factor
             MOV CX, factor
             
             MOV var1, AX
             
             cmp factor, 0
             je return
             
             call factorial
             
      return: RET
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa