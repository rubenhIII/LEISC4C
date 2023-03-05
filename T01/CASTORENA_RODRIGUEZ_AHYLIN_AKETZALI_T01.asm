TITLE "Tarea metodo de la Burbuja"

;Autor: Ahylin Aketzali Castorena Rodriguz
;Fecha: 
;Descripcion del Programa:
;   Se utiliza el metodo de la burbuja para ordenar un array/vector de numeros

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h
    ;Segmento de Pila 

.DATA
    ;Segmento de Datos 

   vec DB 37d,12d,63d,18d,21d,4d,56d  ;guarda numeros en decimal

.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA
        MOV DS,AX 
;-------------------------
;-------Codigo-----------
    MOV BX,7

ciclo:;vuelve a hacer el recorrido cuando detecta un cambio

    MOV CX,6   ;6 por ser el num. de elementos en el vector

    MOV SI,0 ; donde empieza numero del vector
    MOV DI,1 ;donde empieza numero del vector

    ciclo1:

            MOV AH,vec[SI] ;Se guarda el num
            MOV AL,vec[DI] ;Se guarda el num+1

            CMP AH,AL ;compara los registros AH Y AL
            JA movimiento ; SI>DI(SI+1)? SI=salta a cambio y si NO=sigue 
                ;JB en caso contrario  SI<DI(SI+1)? SI=salta a cambio y si NO=sigue
                 ;con esto quedaria de mayor a menor 

    ciclo2:

            INC SI  ;Incrementa posicion 1
            INC DI  ;Incrementa posicion 2
            DEC CX  ;Decrementa contador

        OR CX,0 ;Compara CX y el 0
        JNZ ciclo1 ;salta a ciclo1 si CX!=0

        DEC BX  ;decrementa 
        CMP BX,0 ;Con CMP compara el resultado cuando es cero o cuando ambos son cero
        JNZ ciclo ; salta de nuevo al ciclo cuando hay cambio


        JMP fin ;Salta para terminar

movimiento:
    ;acomoda el numero menor

    MOV vec[SI],AL  ;Se guarda el numero menor
    MOV vec[DI],AH  ;Se guarda el numero mayor

    JMP ciclo2 ;

 fin:

   MAIN ENDP
 
;-------Procedimientos-----
;--------------------------

END MAIN ;Fin del Programa
