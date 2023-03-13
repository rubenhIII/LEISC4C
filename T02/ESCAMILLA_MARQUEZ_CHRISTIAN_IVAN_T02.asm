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
   Var1 DW 1101001110110000b
   Var2 DW 1011000000000000b
   Var3 DW 0000000000000111b
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

       MOV CX, 12    ;cargamos un 12 para hacer loop ya que DW es de 16 bits, pero los ultimos 3 son el resultado
                     ;entonces 16-3=13, pero como al final haremos el XOR final sin hacer un OR lo dejamos en 12
       MOV BX, Var2  ;cargamos a BX lo que hay en Var2
       MOV AX, Var1  ;cargamos a AX lo que hay en Var1
crc:       
       XOR AX, BX     ;hacemos el XOR para simular la division entre el polinomio y el divisor
       MOV Var1, AX   ;observamos el cambio que se hace
       OR AX, BX      ;hacemos un OR entre AX y BX
       MOV Var1, AX   ;observamos el cambio
       SHR BX, 1      ;recorremos un bit lo que tiene BX
       MOV Var2, BX   ;observamos el cambio
       loop crc       ;loop (CX-1)
fin:
    XOR AX, BX        ;hacemos el XOR final para que sean los 13 que deberian de ser
    AND AX, Var3      ;hacemos un AND para quitar todos los unos
    MOV Var1, AX      ;observamos el resultado        
               
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa