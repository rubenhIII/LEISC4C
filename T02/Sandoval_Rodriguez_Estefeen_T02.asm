TITLE "Algoritmo CRC
"

;Autor:Estefeen Sandoval Rodriguez
;Fecha:13 de marzo de 2023
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   mensaje DW 1011001010011000b
   polinom DW 1011000000000000b
   
   ciclo EQU 12
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
                         
       MOV AX,0 ;Inicializamos los registros AX y BX en 0
       MOV BX,0
                         
       MOV CX,ciclo    ;Movemos al registro CX lo que contiene la constante ciclo, que es el tamanio de bits
       MOV AX,mensaje  ;Movemos al registro AX lo que contiene mensaje
       MOV BX,polinom  ;Movemos al registro BX lo que contiene polinom 
       
       FOR: ;Etiqueta para realizar el ciclo      
           XOR AX,BX   ;Realizamo xor de lo que esta en AX con BX para empezar el proceso de simulacion de division
           OR AX,BX    ;Realizamos un or de AX con BX    
           MOV mensaje,AX  ;Movemos lo que esta en AX a mensaje para guardarlo  
           SHR BX,1    ;Hacemos shift en el polinomio para recorrerlo  
           MOV polinom,BX   ;Movemos a polinomio lo que esta en BX     
           LOOP FOR    ;Hacemos que el ciclo se repita un numero de veces igual al tamanio   
    
       XOR AX,BX   ;Hacemos el ultimo xor para terminal de recorrer     
       AND AX,111b ;Hacemos un and para eliminar los unos restantes del mensaje     
       MOV mensaje,AX   ;Movemos a mensaje lo que hay en el registro AX        
               
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa