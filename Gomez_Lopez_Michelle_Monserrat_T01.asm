       
 ;Autor: Michelle Monserrat Gomez Lopez
 ;Fecha: 05/03/23
                                      
; Programa:
;   Metodo de la burbuja para ordenar un vector

.MODEL SMALL ; tipo de memoria

.STACK 100h
    ;Segmento de Pila 

.DATA
    ;Segmento de Datos 

   vecA DB 12d,38d,5d,69d,19d,31d  ;numeros guardados en el vector

.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA
        MOV DS,AX 
;-------------------------
;-------Codigo-----------
    MOV AX,6

 etapa0:;al detectar cambio repite el recorrido

    MOV BX,5   ;6 por los elementos en el vector

    MOV SI,0   ;empieza en la posicion 0
    MOV DI,1   ;empieza en la posicion 1

    etapa1:

            MOV AH,vecA[SI] ;Se guarda el num
            MOV AL,vecA[DI] ;Se guarda el num+1

            CMP AH,AL
            JB cambiar ; salta si esta debajo

         continuar:

            INC SI  ;Incrementa a la posicion 1
            INC DI  ;Incrementa a la posicion 2
            DEC BX  ;Decrementa el contador

        OR BX,0 ;Compara BX y 0
        JNZ etapa1 ;salta a etapa1 si BX!=0

        DEC AX
        OR AX,0 ; con el OR es una forma de comparar
        JNZ etapa0; salta a "etapa0" cuando AX!=0


        JMP fin ;Salta para finalizar

cambiar:
    ;Moviendo el numero mayor

    MOV vecA[SI],AL  ; guarda el numero mas grande
    MOV vecA[DI],AH  ; guarda el numero mas pequeno

    JMP continuar

 fin:

   MAIN ENDP
 
;-------Procedimientos-----
;--------------------------

END MAIN ;Fin del Programa