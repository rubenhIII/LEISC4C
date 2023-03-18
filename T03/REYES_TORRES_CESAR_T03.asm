;Copyright (c) 2023, Cesar Reyes Torres <> All rights reserved. 
 TITLE "Factorial de un numero"

;Autor: Cesar Reyes Torres
;Fecha: 17/03/2023
;Descripcion del Programa: Implementacion de algoritmo para calcular el factorial 
                         ; de un numero usando procedimientos (recursividad).
                         ; Restringido a un digito < 9
COMMENT !
--------------------------
!

.MODEL SMALL

.STACK 100h          

.DATA  

    NUM    DW 8             ;Valor dado             
    RESULT DW 0b            ;Se almacena resultado     
    
.CODE
   MAIN PROC  
    
        MOV AX,@DATA
        MOV DS,AX 
        
        MOV AX,NUM          ;Se guarda valor inicial en AX - Para su multiplicacion
        CALL FACTORIAL      ;Llamada principal 
        MOV AX,04Ch         
        INT 21h             ;Interrupcion para salir (usando valor de AX)
            
   MAIN ENDP   
                 
                 
   FACTORIAL PROC 
        
        SUB NUM,1           ;Restamos 1 a NUM - (n-1) hasta llegar a cero
        CMP NUM,0           ;Si llega a cero se termina el ciclo
        JE  RETURN
        MOV DX,NUM          ;Movemos NUM a DX
        MUL Dx              ;Se multimplica bit a bit usando registro AX y DX en este caso.
                            ;El resultado se ira a AX <En caso de ser un numero grande se
                            ;divide en AX y DX.
        CALL FACTORIAL      ;Parte recursiva  
        
     RETURN:
        MOV RESULT,AX       ;Guardamos el valor final en RESULT
        RET  
         
   FACTORIAL ENDP
   

;--------------------------

END MAIN ;Fin del Programa