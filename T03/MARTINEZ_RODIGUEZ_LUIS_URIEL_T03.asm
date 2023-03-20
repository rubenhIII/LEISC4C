                    
;Autor: Luis Martinez

;Descripcion del Programa:

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    
    ;Variables
  Resultado DW 0 ;
    
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
  MOV AX, 1 
  MOV CX, 5; numero al que se le calculara el factorial
  MOV BX, OFFSET resultado 

   Aqui:
    MUL CX  
    DEC CX 
    JNZ Aqui 

    MOV [BX], AX    
       
        
        
    
   MAIN ENDP
   
;-------Procedimientos-----
       


;--------------------------

END MAIN ;Fin del Programa