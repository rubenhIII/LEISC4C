TITLE "Metodo de la Burbuja"

;Autor:Diego Ponce Alvarez
;Fecha:05/03/2023
;Descripcion del Programa:Metodo de la Burbuja
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   VecBurbuja DB 11,6,34,45,28,29,18
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        MOV CX,6 ;Inicializacion de contador
        
        
        FOR1:
            PUSH CX  ;Poner en la pila el valor de nuestro registro CX
            MOV SI,0 ;Refresh de los registros de indice
            MOV DI,0
            
        FOR2:     
            INC DI       ;Incrementar a DI para comparar con la siguiente posicion
            MOV AL,VecBurbuja[SI]  ;Mover al registro AL el valor que se encuentra en la posicion SI 
            CMP AL,VecBurbuja[DI]  ;Comparar el valor de AL con el valor que se encuentra en la posicion DI
            JA ACOMODO ;Si es mayor AL salta al acomodo del vector
            JB MENOR   ;Si es menor salta a la etiqueta menor
            
        ACOMODO:
            MOV AH,[DI]   ;Mover al registro AH lo que contenga la posicion DI
            MOV [DI],AL   ;Mover a la posicion DI lo que contenga el registro AL
            MOV [SI],AH   ;Mover a la posicion SI lo que contenga el registro AH
        
        MENOR:
            INC SI    ;Incrementa SI para seguir comparando con las siguientes posiciones
            LOOP FOR2 ;Decrementa CX y salta al FOR2, mientras CX!=0   
            POP CX    ;Saca de la pila CX con el valor que le asignamos por default(6)
            LOOP FOR1 ;Se decrementa CX y vuelve al FOR1
            
                                                    
            
   
   
         
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa