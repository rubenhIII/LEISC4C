TITLE "Plantilla de Programa"

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
    vector DB 05h, 12h, 02h, 35h ;Vector de n elementos desordenados
    size EQU ($-vector)-1 ;Tamaño del vector
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
;Inicializacion de Segmento
;de Codigo
    MOV AX,@DATA
    MOV DS,AX 
;-------Codigo-----------
    MOV AX,5 
MOV CX, size    ;guardamos el elemento
MOV SI, 0       ;limpiamos el indice
MOV DI, 0

CICLO1:
PUSH CX
LEA SI, vector  ;direccion del vector
MOV DI, SI

CICLO2:
INC DI          ;direccion del siguiente elemento
MOV AL, [SI]    ;cargamos el primer elemento
CMP AL, [DI]    ;comparamos los elementos
JA  INTERCAMBIO       ;si el primero es mayor que el segundo salta
JB  MENOR       ;si el primero es menor que el segundo salta          

INTERCAMBIO:          ;Se intercambian los elementos
MOV AH, [DI]    ;guardamos el segundo elemento
MOV [DI], AL    ;guardamos el primero en el segundo
MOV [SI], AH    ;guardamos el segundo en el primero

MENOR:
INC SI          ;incrementamos el indice
LOOP CICLO2    ;repetimos el ciclo CX se decrementa en 1 y se salta si es 0
POP CX          ;recuperamos el valor de CX Creando ciclo anidado
LOOP CICLO1    ;repetimos el ciclo CX se decrementa en 1 y se salta si es 0

MAIN ENDP
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa