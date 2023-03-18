TITLE "Generar el factorial de un numero"

;Autor: Mariana Avila Rivera
;Fecha: 20/03/2023
;Descripcion del Programa:  
;   Calcula el factorial de un numero
;    haciendo uso de un procedimiento,interrupcion e instrucciones

.MODEL SMALL;Definicion del tipo de memoria
.STACK 100h ;Segmento de Pila     
.DATA ;Segmento de Datos       
    num EQU 7d
    fac DW 0d    
   
.CODE   ;Segmento de Codigo
;////////////////////////////////////////////  
   MAIN PROC ;Procedimiento Principal
    ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA   ;  @Data= direccion de meoria del segmento de datos
        MOV DS,AX      ;DS DATA SEGMENT, ALMACENA LOS DATOS
;-------Codigo-----------
        MOV AX,1 ;Registro que almacena el resultado
        MOV DX,1 ;Registro con el que se hace la multiplicacion
        MOV CX,1 ;Contador del factorial
        
        CALL factorial ;Salta a "facotrial" 
        
        ;Realizando la interrupcion para terminar el programa
        MOV AX,04Ch
        INT 21h    
         
   MAIN ENDP
;////////////////////////////////////////////    
;-------Procedimientos----- 
 factorial PROC
           
        INC CX      ;CX++
        MOV DX,CX   ;Actualiza DX con el siguiente numero a multiplicar 
        MUL DX      ;AX*DX Se multiplican los valores
        
        CMP CX,num
        JE return      ;Si CX==num salta a "return" sino continua           
        CALL factorial ; Recursividad, vuelve a "factorial"
    return:
        MOV fac,AX ;Guardando el resultado del factorial   
        RET        ;Regresando a donde se hizo la llamada
 factorial ENDP   
;--------------------------

END MAIN ;Fin del Programa