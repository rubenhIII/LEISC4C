TITLE "Factorial"

;Autor: Leonardo Daniel Gutierrez Flores
;Fecha: 19/03/2023
;Descripcion del Programa:Obtener facctorial de un numero

.MODEL SMALL;Definicion del tipo de memoria
.STACK 100h ;Segmento de Pila     
.DATA ;Segmento de Datos
    result DW 0d    
   
.CODE   ;Segmento de Codigo
;////////////////////////////////////////////  
   MAIN PROC ;Procedimiento Principal
    ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA   ;  @Data= direccion de meoria del segmento de datos
        MOV DS,AX      ;DS DATA SEGMENT, ALMACENA LOS DATOS     
;-------Codigo-----------
        MOV AX,1;Guardamos en nuestra registro AX un uno para que a la hora de multiplicar sea correcto
        MOV CX,7;Guardamos el valor a factorisar en nuestro regristro CX
        CALL fact;Llamamos a la subrutina fact para empezar el proceso
        MOV AX,04Ch;ponemos esto para poder terminar la copilacion de nuestro programa
        INT 21h   
MAIN ENDP
    fact PROC
        INI:  
        MUL CX;Multiplicamos lo que tenemos en nuestro registro CX con lo que tiene AX
        DEC CX;Decrementamos lo que tiene el registro CX en uno
        CMP CX,0;Comparamos si CX es igual a 0 para terminar nuestro programa
        JA INI;Si es igual a 0 terminamos el ciclo
        MOV result,AX; Movemos lo que tiene nuestro registro AX a nuestra variable de resultado   
        RET;Regresamos al main desde donde llamaron a la funcion factorial          
    fact ENDP
END MAIN ;Fin del Programa