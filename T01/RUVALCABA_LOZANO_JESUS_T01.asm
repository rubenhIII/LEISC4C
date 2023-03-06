TITLE "Metodo de la burbuja"

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
    
   
   
   vector DB 10,25,81,14,22,1
   var1 DB 0
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX
        MOV ES,AX 
        
;-------Codigo-----------  
   
        MOV CX,7
        MOV SI,0
        
   sig:       
        DEC CX
        MOV SI,0
        CMP CX,0
        JNZ metodo
        
     
   metodo:
   
        CMP SI,CX
        JZ sig
   
        MOV AL,vector[SI]
        CMP vector[SI+1],AL
        
        JL cambio
        
        INC SI
        
        JMP metodo
        
   cambio:
   
        MOV AL,vector[SI]
        MOV var1,AL
        MOV AL,vector[SI+1]
        MOV vector[SI],AL
        MOV AL,var1
        MOV vector[SI+1],AL
        INC SI
        
        JMP metodo
    
   
       
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;F