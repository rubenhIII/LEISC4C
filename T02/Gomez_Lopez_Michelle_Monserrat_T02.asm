TITLE "Verifiacion de Redundancia Ciclica"

;Autor:Michelle Monserrat Gomez Lopez
;Fecha:13/03/23
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
    
      mensaje1 DW 1101001110110000b ;Mensaje 1 

      
      
      polinomio DW 1011000000000000b ;Divisor  
      
      
      band DW     1000000000000000b  ;Verifica
      
       
   
.CODE
    ;Segmento de Codigo 
    
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo 
        
        MOV AX,@DATA
        MOV DS,AX  
        
        ;-------------------------
;-------Codigo-----------

       MOV AX, mensaje1                 
       MOV BX, polinomio
       MOV CX, 0
       MOV DX, band 
       
       
Verificacion:

       CMP AX, 0                   ;Comparacion del mensaje1=0
       JE exit                     ;Para salir si se cumple
        
       OR AX, mensaje1             ;Enmascara lo que queda del mensaje con el original
       MOV BX, 1011000000000000b   ;Variables
       MOV DX, 1000000000000000b   
       MOV CX, 0                  ;Valor original
        
       JMP Lugar
       
       
Lugar:
       CMP CX, 13d                 ;Hace comparacion a la posicion del contador
       JG Verificacion                      ;DXI => 12 salta a Verificaion
       
       CMP AX, DX                  ;Compara los registros donde guardamos el mensaje y la flag
       JGE OXOR                    ;Si el Mensaje1 => a Ban salta a OXOR
        
       INC CX                      ;Incrementa contador
       SHR BX, 1                   
       SHR DX, 1                   
       JMP Lugar                   ;Regreamos a Brincar
       
       
OXOR:
    XOR AX, BX                  ;Realiza operacion XOR
    INC CX                      ;Se hace un incremento al contador
    SHR BX, 1                   ;Desplazamiento a la derecha
    SHR DX, 1                   
    JMP Lugar                   ;Brincamos a Lugar
    
exit:
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa