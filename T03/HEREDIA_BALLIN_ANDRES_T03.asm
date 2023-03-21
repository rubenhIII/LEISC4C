TITLE "Plantilla de Programa"

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
        fac1 DW 05d
        con  DW 05d
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
 
        MOV AX,fac1
        
        CALL FAC
        
        MOV fac1,AX
        
        MOV BX,04Ch
        INT 21h          
        
   MAIN ENDP
   
;-------Procedimientos-----
   FAC  PROC
        
    fl: 
        DEC con              
        
        MOV BX,con
        MUL BX
        
        
        
        CMP con,1
        JNE  fl
        
        RET
        
   FAC  ENDP

;--------------------------

END MAIN ;Fin del Programa