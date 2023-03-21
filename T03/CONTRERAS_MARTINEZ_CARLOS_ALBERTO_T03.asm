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
   numero EQU 6
   
   aux DW 0
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------   
        MOV AX,0
        MOV SI,0
        CALL factorial 
        
        MOV aux,AX
        MOV AX,04Ch ;para detener el programa
        INT 21h
         
   MAIN ENDP
   
;-------Procedimientos-----
   factorial PROC
     
    
     CMP SI,NUMERO + 1 ; el programa realiza n + 1 comparaciones, por eso se coloca "numero + 1"
     JL fac ;si SI no es el mismo numero que "numero" salta a "fac"
     JMP salida
     
    fac:
     
     MOV BX,SI
     MUL BX ; multiplica lo que hay en AX x BX  
     
     CMP AX,0 ;si la  multiplicacion resulto no ser 0 ve a llamada para repetir el proceso
     JNZ llamada
     
     INC AX ;si la multiplicacion fue 0, AX sera = 1
    
     
     llamada:  
     
     INC SI
     
     MOV aux,AX  
     
     CALL factorial ;llamada recursiva del programa  
         
    
    salida:
    
    RET
   factorial ENDP

;--------------------------

END MAIN ;Fin del Programa