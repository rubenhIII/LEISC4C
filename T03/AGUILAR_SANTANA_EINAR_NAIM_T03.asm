TITLE "Factorial de un numero"

;Autor: Einar Naim Aguilar Santana
;Fecha: 18/03/2023
;Descripcion del Programa: Programa que realiza el factorial un numero con el uso de un procedimiento y recursividad
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
    num DW 6 ;Variable que guarda el numero al que se le sacara el factorial
    fac DW 0 ;Variable en la que se guardara el resultado del factorial
    
.CODE
    ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        MOV SI,1 ;El registro SI servira como multiplicador y contador ascendente para poner un limite al factorial, iniciara en 1   
        MOV fac,SI ;Se le pasara a la variable fac el valor de SI que es 1 
        CALL FACTORIAL ;Se le llama a procedimiento FACTORIAL   
        MOV AX, 04CH ;Se coloca 04CH en el registro AX
        INT 21H ;Interrupcion que termina la ejecucion del programa
        
    MAIN ENDP
   
;-------Procedimientos-----
    FACTORIAL PROC
    
        MOV AX,fac ;Guarda el valor de fac en el registro AX  
        MOV BX,SI ;Guarda el valor de SI en el registro BX
        MUL BX ;Se realiza la multiplicacion de ambos registros 
        ADD fac,AX ;Se suma el contenido del registro AX a fac 
        INC SI ;Incrementa el contador SI
        CMP SI,num ;Compara el contador y el numero al que se le sacara el factorial  
        JE SALIR ;Si coinciden ambos numero se saltara a la etiqueta SALIR    
        CALL FACTORIAL ;Vuelve a llamar a procedimiento FACTORIAL debido a la recursividad     
        
        SALIR:
            RET ;Se sale del procedimiento 
        
    FACTORIAL ENDP
    

;--------------------------

END MAIN ;Fin del Programa
