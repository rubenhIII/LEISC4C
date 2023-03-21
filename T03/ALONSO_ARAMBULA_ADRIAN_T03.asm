TITLE "Factorial"

;Autor:Adrian Alonso Arambula
;Fecha:20/03/2023
;Descripcion del Programa:Factorial de un numero


.MODEL SMALL;Definicion del tipo de memoria

.STACK 100h ;Segmento de Pila 
    
.DATA ;Segmento de Datos       
    size EQU 5 ;Constante, no ocupa memoria
    fact DW 0000h
    
.CODE   ;Segmento de Codigo
   
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA   ;  @Data= direccion de meoria del segmento de datos
        MOV DS,AX      ;DS DATA SEGMENT, ALMACENA LOS DATOS
;-------------------------
;-------Codigo-----------
        MOV AX,1 ;numero donde iniciara a multiplicar
        MOV CX,1 ;Contador
        
        CALL facto
        
        ;Realizando la interrupcion
        MOV AX,04Ch; valor para la interrupcion
        INT 21h    ; Interrupcion
         
         
   MAIN ENDP
   
;-------Procedimientos----- 
    facto PROC
        
        MOV BX,CX  ;Numero a multiplicar con AX y BX
        MUL BX     ;Multiplicacion
               
        INC CX
        
        CMP CX,size+1
        JE salir       ;Condicion de paro para 
        CALL facto ; Con esto se hace recursivo
        
        salir:
            MOV fact,AX;Pasar resultado a fact   
            RET
    facto ENDP

;--------------------------

END MAIN ;Fin del Programa