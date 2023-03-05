TITLE "Metodo de la burbuja"

;Autor: Einar Naim Aguilar Santana
;Fecha: 04/03/2023
;Descripcion del Programa:
;Es un programa que realizara el metodo de la burbuja en lenguaje ensamblador
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
.DATA
    ;Segmento de Datos
    VEC DB 12, 1, 2, 3, 54, 240, 100, 21, 13, 24 ;Elementos del vector en este caso es de 10
.CODE
    ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA                                   
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV AX,5  
        
        MOV CX,9 ;Contador CX a 9 que equivale al numero de comparaciones que se haran en el arreglo
                 ;Tamano del arreglo menos 1
        MOV SI,0 ;SI inicializado en 0
        MOV DI,0 ;DI inicializado en 0
        
    FOR_I: ;Etiqueta FOR_I sera utilizada en un loop, sera el ciclo externo anidado utilizado en el metodo de la burbuja
        PUSH CX ;Se empuja el valor de CX a la pila
        MOV SI,OFFSET VEC ;Pasar direccion de VEC a SI  
        MOV DI,SI ;Pasar la direccion de SI a DI
           
    FOR_J: ;Etiqueta FOR_J sera utilizada en un loop, sera el ciclo interno anidado utilizado en el metodo de la burbuja      
        INC DI ;incrementara DI para comparar la siguiente posicion del arreglo
        MOV AL,[SI] ;Pasar valor SI a AL
        CMP AL,[DI] ;Compara el valor de DI con AL
        JA INTERCAMBIO_VAlORES ;Si AL es mayor se saltara a INTERCAMBIO
        JB MENOR ;Si AL es menor al se saltara a MENOR
        
    INTERCAMBIO_VALORES: ;Se intercambian las posiciones
        MOV AH,[DI] ;Se mueve el valor de DI a AH
        MOV [DI],AL ;Se mueve el valor de la AL a la posicion DI
        MOV [SI],AH ;Se mueve el valor de AH a la posicion SI
        
    
    MENOR: ;Si el valor de DI es menor 
        INC SI ;Incrementa SI 
        LOOP FOR_J ;Se ciclara el FOR_J
        POP CX ;Se saca el valor CX de la pila
        LOOP FOR_I ;Se ciclara la etiqueta FOR_I
        
    MAIN ENDP

END MAIN ;Fin del Programa