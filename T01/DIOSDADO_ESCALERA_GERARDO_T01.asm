TITLE "Plantilla de Programa"

; Autor: Gerardo Diosdado Escalera
; Fecha:
; Descripcion del Programa: Ordenamiento de la burbuja con un un vector con variables de tipo byte.

COMMENT !
--------------------------
!

.MODEL SMALL ; Definicion del tipo de memoria

.STACK 100h ; Segmento de Pila 

.DATA ; Segmento de Datos
   vector DB 5, 4, 3, 2, 1 ; Vector de 5 elementos
   size EQU $ - vector

.CODE ; Segmento de Codigo
   MAIN PROC ; Procedimiento Principal
      ; Inicializacion de Segmento de Codigo
      MOV AX, @DATA
      MOV DS, AX

      ; -------------------------
      ; -------Codigo-----------
      ; -------------------------
      MOV BX, size; Cantidad de elementos del vector
      MOV CX, 0; Iterador externo
      MOV DX, 0; Iterador interno
      MOV AL, 0; Variable temporal
   exterior:
      CMP CX, BX; Comparacion de iterador externo con la cantidad de elementos del vector
      JGE fin; Si el iterador externo es mayor o igual a la cantidad de elementos del vector, se termina el ciclo
      JMP interior; Si no, se continua con el ciclo interno
      INC CX; Incremento del iterador externo
   interior:
      CMP DX, BX; Comparacion de iterador interno con la cantidad de elementos del vector
      JGE exterior; Si el iterador interno es mayor o igual a la cantidad de elementos del vector, se termina el ciclo
      MOV AL, vector[DX]; Se copia el valor del vector en la variable temporal
      CMP AL, vector[DX + 1]; Comparacion de la variable temporal con el valor del vector en la siguiente posicion
      JLE no_cambio; Si el valor de la variable temporal es menor o igual al valor del vector en la siguiente posicion, no se hace ningun cambio
      MOV vector[DX], vector[DX + 1]; Se copia el valor del vector en la siguiente posicion en la posicion actual
      MOV vector[DX + 1], AL; Se copia el valor de la variable temporal en la siguiente posicion del vector
      INC DX; Incremento del iterador interno
      JMP interior; Se continua con el ciclo interno

   no_cambio:
      INC DX; Incremento del iterador interno
      JMP interior; Se continua con el ciclo interno

   fin:

   MAIN ENDP
   ; -------Procedimientos-----
   ; --------------------------

END MAIN ; Fin del Programa
