#fasm#

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
   Var1 DB "HOLAMUNDO"  ; declaracion de variables    
   Var2 DD 0AABBh
.CODE
    ;Segmento de Codigo
   
   
   
   
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        
;-------Codigo-----------

        MOV AX,5 
        
        
   MAIN ENDP   ; end procedure
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa