TITLE "Factorial del numero 5"

;Autor:Ricardo Daniel Alvarez Martinez
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    size EQU 5  ;constantes, no se pueden modificar en el programa
    serie DB 1,2,3,4,5 ;un vector que se inicializa con los numeros desde 1 hasta 5 en este caso, pues el valor de ejemplo usado en el factorial
    fact DB 1  ;la variable que almacenara el resultado inicializada en 1
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV SI,0   ;indice en 0
        MOV CX, 0  ;inicializamos el contador del ciclo
        CALL factorial
        ;despues de una llamada de un ciclo, se debe rompero o terminar el programa
        MOV AX, 04Ch
        INT 21h
         
        
        
   MAIN ENDP
   
;-------Procedimientos-----
        factorial PROC
            MOV AL, serie[SI]    ;se usa el registro AL donde se almacenara la multiplicacion y para llevar el control de los elementos del vector
            MOV BL,fact  ;registro usado para pasarle el valor del factorial cada que este vaya cambiando en el ciclo
            MUL BL     ;se hace la multiplicacion del registro BL por AL y se almacena en el registro AL como se menciono anteriormente
            MOV fact,AL  ;se pasa a la variable factorial el valor de la multiplicacion
            INC SI       ;se incrementa el indice SI para recorrer todo el vector
            INC CX       ;se incrementa el contador que ayudara a salir del ciclo
            CMP CX,size  ;compara el contador con el numero de la posicion a la que se va
            JE salir     ;se sale si la comparacion es 0
            CALL factorial    ;recursividad, vuelve a llamar a la funcion si la comparacion de cx con el tamaño del vector no es 0
            
            
            salir:
             RET ;cuando se salga se regresa   
        factorial ENDP

;--------------------------

END MAIN ;Fin del Programa