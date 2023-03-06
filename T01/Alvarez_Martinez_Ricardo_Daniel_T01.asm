TITLE "Metodo Burbuja"

;Autor:
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
   Var1 DB "HOLAMUNDO"
   VECBUR DB 17, 9, 76, 0, 81, 145, 19, 56 ;vector de tipo byte (8 bits, 8 valores)
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
        MOV CX, 7 ;uso del registro contador hace 7 comparaciones
        MOV SI, 0  ;se inicializan en 0 los indices de comparacion
        MOV DI, 0   ;o en su defecto se limpian en dado caso de que tuvieran valores
        
        ciclo1:
        PUSH CX ;push coloca algo en una pila, en este caso coloca en la pila el contador (de 7)
        MOV SI, OFFSET VECBUR ;pasa la direccion efectiva del arreglo a SI,no pasa los valores del arreglo, sino la direccion donde se encuentra la variable o arreglo, seria como un puntero en un lenguaje de alto nivel -- LEA SI, VECBURB hace lo mismo que esta instruccion  
        MOV DI, SI ;pasa a DI lo que tiene SI, o sea la direccion
        
        ciclo2:
        INC DI ;se incrementa uno de los indices para empezar a comparar la primera poscion del arreglo SI, con la segunda del mismo que se oioncremento DI
        MOV AL, [SI] ;cuando tiene los corchetes, indica que se pasa el valor que tiene la variable, en este caso el indice, no la direccion como se paso anteriormente, pasa la primera posicion a AL, que es 17
        CMP AL, [DI] ;hace la comparacion que tiene  AL (17) con el valor de DI (pq tiene corchetes, que seria 9)
        JA Intercambio ;salta (a la etiqueta intercambio) si AL es mayor que DI 
        JB Menor ;si es menor, se dirige a la etiqueta Menor
        
         
        Intercambio:
        ;se produce el intercambio
        MOV AH, [DI] ;se almacena en AH el valor de DI
        MOV [DI], AL ;mueve a DI el valor de AL, o sea 15
        MOV [SI], AH ;mueve a SI el valor de AH, que vendria siendo el valor que almacenaba DI previamente antes del intercambio
        
        Menor:
        INC SI ;se incrementa SI 
        LOOP ciclo2 ;salta a la etiqueta ciclo2 si CX no es 0, loop decrementa a CX en 1 cada vez, por default
        POP CX ;saca de la pila el valor de CX, lo libera para almacenar su nuevo valor en la sig instruccion
        LOOP ciclo1 ;despues en ciclo 1 almacena en la pila otra vez el contador que valdria CX-1 por default, esto repite el ciclo las veces que necesita comparar posicion por posicion
         
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa