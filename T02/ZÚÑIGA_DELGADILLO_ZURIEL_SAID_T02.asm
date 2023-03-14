TITLE   "Verificacion de Redundancia Ciclica"


;Autor: Zuriel Said Zuniga Delgadillo
;Fecha: 13/03/2023
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h ;Segmento de pila

.DATA ;Segmento de datos
        
        msj DW 1101001110110000b        ;Mensaje con 3 bits libres
        
        pol DW 1011000000000000b        ;Divisor de la operacion
        
        flag DW 1000000000000000b       ;Verificador                 ;Bandera para la verificiacion
   
.CODE ;Segmento de Codigo

    MAIN PROC ;Procdeimiento Principal
         ;Inicializacion de Segmento
         ;de Codigo
         MOV AX,@DATA
         MOV DS,AX 
        ;-------------------------  
        
;-------Codigo-----------
    ;Inicializamos los registros y agregamos un contador
    MOV AX, msj                 
    MOV BX, pol
    MOV DX, flag
    MOV SI, 0d
    
pos:
    CMP SI, 12d                 ;Compara la posicion en contador
    JG val                      ;Si SI => 12 hace un salto a val
    
    CMP AX, DX                  ;Compara los registros donde guardamos el mensaje y la flag
    JGE opeXOR                  ;Si el contenido de msj sigue siendo => a la flag hace un salto a opeXOR
    
    INC SI                      ;Cuando sea menor incrementara el contador
    SHR DX, 1                   ;Shift a la flag
    SHR BX, 1                   ;Shift al divisor
    JMP pos                 
    
val:
    CMP AX, 0000000000000000b   ;Compara si msj = 0
    JE salir                    ;Si se cumple, el programa acaba
    
    OR AX, msj                  ;Enmascara el residuo de msj con su valor original
    MOV BX, 1011000000000000b   ;Las variables
    MOV DX, 1000000000000000b   ;vuelven a tener
    MOV SI, 0d                  ;su valor original
    
    JMP pos                     

opeXOR:
    XOR AX, BX                  
    INC SI                      ;Incrementamos el contador
    SHR BX, 1                   ;Shift al divisor
    SHR DX, 1                   ;Shift a la flag
    JMP pos
    
salir:      

    MAIN ENDP
    
END MAIN                    ;Fin del Programa
    
    