TITLE "Programa para calcular el factorial de un número sin impresiones en consola y sin interrupciones con número predeterminado"

;Descripcion del Programa: Este programa calcula el factorial de un número utilizando un número predeterminado

COMMENT !
--------------------------
Este programa calcula el factorial de un número utilizando un número predeterminado
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA     
    numero DW 5
    factorial DW ?
    
    ;Segmento de Datos
    
.CODE        
    ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX
        
        ;Calcular el factorial del número ingresado
        MOV CX, numero  ;Inicializa el contador
        MOV BX, 1       ;Inicializa el registro que guardara las operaciones
        MOV DX, 0 ; Inicializa DX en cero antes de la primera multiplicacion     
        MOV AX, 1   ;Inicializa el acumulador en 1 para evitar hacer multiplicaciones no deseadas
        L1:       
            MUL BX  ;multiplica BX por el contenido del acumulador AX
            INC BX  ;Incrementa BX
            DEC CX ; decrementa manualmente el contador
            JNZ L1 ; si el contador no es cero, continúa el ciclo
        MOV factorial, AX
        
        ;Terminar el programa
        MOV AH,4Ch
        INT 21h
        
    MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa
