TITLE "Calculo de factorial"

;Autor:Asly Lizbeth Salinas Morales
;Fecha:20/03/2023
;Descripcion del programa: El programa debe de hacer el calculo de un factorial 
COMMENT !
 
!
.MODEL SMALL  ;Definicion del tipo de memoria

.STACK 100h 
    ;segmento de pila
.DATA
   ;Segmento de pila
   size EQU 10 
   serie DB 0,1, size-2 DUP(0)
   
.CODE
 ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
    ;Inicializacion de Segmento
    ;de codigo
    MOV AX, @DATA             
;-----------------------------------
;-------------Codigo-------------------
    
    CALL numfactorial  
    
    MOV AH, 1;pide al usuario el numero
    INT 21h  ;llama a la funcion
    MOV BL,AL;guarda el numero en AL
    MOV CX,1 ;inicializa el contador
    
    MAIN ENDP  

;-----------Procedimiento--------------
    numfactorial PROC
    SUB AL, '0' 
    MOV CX,1 ;nos inicializa el contador
    MUL CX ;multiplica  
    INC CX ;incrementa
    
    JLE salir
    
    CALL numfactorial
    MOV AH, 2 ;nos imprime el resultado
    MOV DL,'!';imprime el signo
    INT 21H   ;llamada a la salida entandar
    
  salir:
              
    RET
    numfactorial ENDP

;------------------------
END MAIN