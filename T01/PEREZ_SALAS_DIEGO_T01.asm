TITLE "Metodo de la burbuja"

;Autor: Diego Perez Salas
;Programa que realizara el metodo de la burbuja en lenguaje ensamblador
;-----------------------------------------------------------------------

.MODEL SMALL ;Tipo de memoria

.STACK 100h  ;Segmento de Pila 

.DATA  ;Segmento de Datos
    VEC DB 23, 3, 56, 73, 15, 27, 78, 99 ;Elementos vector

.CODE ;Segmento de Codigo
    
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        MOV AX,@DATA                                   
        MOV DS,AX 


;-------Codigo-----------

        MOV AX,2  
        
        MOV CX,5 ;Contador CX, equivale al numero de comparaciones que se haran en el arreglo
                 ;Tamano del arreglo menos 1
        MOV SI,0 ;Inicializado en 0
        MOV DI,0 ;Inicializado en 0
        
    FOR01: ;Es el ciclo externo anidado
        PUSH CX ;Se empuja el valor de CX en la pila
        MOV SI,OFFSET VEC ;Direccion de VEC a SI  
        MOV DI,SI ;Direccion de SI a DI
           
    FOR02: ;Es el ciclo interno anidado     
        INC DI ;Incrementa DI
        MOV AL,[SI] ;Valor SI a AL
        CMP AL,[DI] ;Compara valores
        JA INTERCAMBIO ;Si AL es mayor se pasara a INTERCAMBIO
        JB MENOR ;Si AL es menor se pasara a MENOR
        
    INTERCAMBIO:;Cambio de posiciones
        MOV AH,[DI] ;Mueve el valor de DI a AH
        MOV [DI],AL ;Mueve el valor de AL a DI
        MOV [SI],AH ;Mueve el valor de AH a SI
        
    
    MENOR: ;Si el valor de DI es menor 
        INC SI ;Incrementa SI 
        LOOP FOR01
        POP CX ;Saca el valor CX de la pila
        LOOP FOR02 
        
    MAIN ENDP

END MAIN



