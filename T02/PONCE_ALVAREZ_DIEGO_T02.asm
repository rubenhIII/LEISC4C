TITLE "Redundancia Ciclica"

;Autor:Diego Ponce Alvarez
;Fecha:13/03/2023
;Descripcion del Programa:Redundancia Ciclica
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    Entrada DW 1101001110110000b ;Entrada del programa  
    Divisor DW 1011000000000000b ;Divisor que divide a la entrada
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        MOV AX,Entrada ;Inicializacion de nuestros regitros   
        MOV BX,Divisor ; 
        MOV DX,1000000000000000b ;Rigistro para realizar el enmascarmiento 
        MOV CX,13 ; 

        FOR1:
        
            MOV AX,Entrada ;Se coloca al registro AX nuestra entrada         
            AND AX,DX ;Enmascara los bit 1 a 0, segun corresponda
            CMP AX,DX ;Compara la Entrada con el Divisor           
            JE Enmascaramiento  ;Si son iguales se dirige a realizar la divison de la entrada       
            JMP Shifteo ;si no, continua con el siguiente bit (shiftear cada uno de estos)                                          
        
        Enmascaramiento: 
        
            MOV AX,Entrada ;Inicializa en el registro AX lo que tenemos en Entrada 
            XOR AX,BX ;Realiza la divison de la Entrada con ayuda de nuestro divisor
            MOV Entrada,AX ;Almacena en Entrada el resultado de la division  
            JMP Shifteo ;Y continua con el siguiente bit (shiftear cada uno de estos)       
            
        Shifteo:
        
            SHR BX,1 ;Shiftea hacia la derecha el registro BX
            SHR DX,1 ;Shiftea hacia la derecha el registro DX                 
            LOOP FOR1 ;Regresa a realizar el mismo procedimiento   
             
             
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa