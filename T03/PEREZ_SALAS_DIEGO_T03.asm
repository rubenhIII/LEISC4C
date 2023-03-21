TITLE "Factorial de un numero"

;Autor: Diego Perez Salas
;Fecha:20/03/2023
;Descripcion del Programa: Realizar un programa en lenguaje ensamblador que realize el calculo del factorial de un número utilizando procedimientos y recursividad 
;---------------------------------------------------------------

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    
    contador EQU 8d ;variable que se usara para obtener el numero factorial
    
    factorial DW 0 ;variable que almacena el resultado factorial   
              
                      
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 

;-------Codigo-----------  
   
   MOV SI,contador  ;es el contador del ciclo
   MOV DI,contador-1     ;DI inicia con num-1 para que realice la multiplicacion
   MOV CX,contador  ;Almacena el num que vamos a obtener el valor factorial
   MOV DX,contador  
   
   
   procedimiento:   
   
   CALL proceso   
   MOV DX,factorial  ;copiamos el resultado
   MOV CX, DX        ;copiamos el resultado hacia la siguiente multiplicacion   
   CMP SI,1          ;compara SI con 1   
   JA procedimiento  ;realiza la operacion factorial
   JE salida           ;finaliza el programa cuando SI=1
   
   salida:
   .exit             ;finalizamos el programa
        
        
   MAIN ENDP
   
;-------Procedimientos-----
   
proceso PROC
     
     MOV AX,CX        ;nos ayuda a almacenar el primer valor
     MOV BX,DI        ;se encarga de almacenar el segundo valor
     MUL BX           ;multiplica el primer valor por el segundo valor    
     DEC SI           ;Reduce SI para comparar
     DEC DI           ;Reduce DI para seguir multiplicando el resultado por el siguiente valor   
     MOV factorial,AX ;utilizamos AX para que el resultado se almacene en AL    
     ret 
        
proceso ENDP 

;--------------------------

END MAIN ;Fin del Programa