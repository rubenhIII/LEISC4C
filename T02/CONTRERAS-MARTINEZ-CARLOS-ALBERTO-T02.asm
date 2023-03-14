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
   var1 DB 5,4,3,2,1
   aux DB 0
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
  
 MOV SI,0;registro que comparara cada posicion del vector
 
 
 COMPARA:
 MOV AL,var1[SI];se comparan los valores de la
                ;posicion actual con la siguiente posicion
 
 CMP AL,var[SI+1]
  
 JNL CAMBIO;si el anterior no es mas grande que el siguinete salta a cambio 
 
 INC SI;incrementa si para comparar la siguiente posicion
 
 JMP COMPARA
 
 
 CAMBIO:        
 MOV AL,var1[SI];se realiza el intercambio
 MOV aux,AL
        
 MOV AL,var1[SI+1]
 MOV var1[SI],AL
 
 MOV AL,aux
 MOV var1[SI+1],AL;se guarda el valor mas grande en la siguiente posicion
 
 DEC SI;se decrementa para realizar la siguiente comparacion

 JMP COMPARA        
         
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa