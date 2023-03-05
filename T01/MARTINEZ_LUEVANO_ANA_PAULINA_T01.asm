TITLE "Metodo de la burbuja"

;Autor:Ana Paulina Mtz. Luevano
;Fecha:05/03/2023
;Descripcion del Programa:Ordenar un el contenido de un vector de menor a mayor.
COMMENT !
--------------------------
!
.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 

.DATA 
    ;segmento de datos
    vector DB 05h, 08h, 07h, 01h, 03h , 02h, 06h
    tam EQU ($-vector)

.CODE
    ;segmento de codigo  
      MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX         
        ;-------------------------
;-------Codigo-----------   
        MOV BX, OFFSET vector; manda el vector a Bx
        MOV CX, tam    ;CX=tam
         
   
ciclo_exterior:  
    DEC CX         ;comienza en la posicion 0 y va cambiando 
    MOV SI, 0        ;inicia en 0 para el vector  
    
ciclo_interior:
    MOV al, [BX+si];al=posicion actual
    CMP al, [BX+si+1];compara si la posicion actual es menor a la posicion siguiente
    JLE incrementa ;si se cumple la condicion salta a la etiqueta  
    ;intercambia los numeros 
    xchg al, [BX+si+1] 
    MOV [BX+si], al  
    
incrementa:;cambia de posicion para poder comprar el siguiente par de numeros
    INC si
    CMP si, CX; revisa si ya se llego al final del vector
    JB  ciclo_interior;si aun no se llega al final del vector va a la etiqueta   
    ;regresa al inicio 
    CMP CX, 0
    JZ fin ; si nos encontramos en la posicion 0 del vector salta a fin 
    JNZ ciclo_exterior ;si no es igual a 0 
    ;MOV CX, 0
 

    ; finalizar el programa 
fin:
    mov ah, 4ch
    int 21h