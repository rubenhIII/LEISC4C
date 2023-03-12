TITLE "CRC"

; Autor: Gerardo Diosdado Escalera
; Fecha: 12 Marzo 2023
; Descripcion del Programa: Cyclic Redundancy Check

COMMENT !
--------------------------
!

.MODEL SMALL ; Definicion del tipo de memoria

.STACK 100h ; Segmento de Pila 

.DATA ; Segmento de Datos
   mensaje DW 1101001110110000b
   divisor DW 1011000000000000b
   verificador DW 1000000000000000b

.CODE ; Segmento de Codigo
   MAIN PROC ; Procedimiento Principal
      ; Inicializacion de Segmento de Codigo
      MOV AX, @DATA
      MOV DS, AX 

      ; -------------------------
      ; -------Codigo-----------
      MOV AX, mensaje
      MOV BX, divisor
      MOV DX, verificador
      MOV SI, 0d ; Contador

   posicion:
      CMP SI, 12d
      JG validacion  ; Si el contador es mayor a 12, se pasa a la validacion 
      CMP AX, DX
      JGE operacion  ; Si el mensaje es mayor o igual al verificador, se pasa a la operacion          
      INC SI         ; Si no, se incrementa el contador
      SHR DX, 1      ; Se desplaza el verificador a la derecha
      SHR BX, 1      ; Se desplaza el divisor a la derecha
      JMP posicion   ; Se vuelve a comprobar la posicion
   
   operacion:        
      XOR AX, BX     ; Se realiza la operacion XOR
      INC SI         ; Se incrementa el contador
      SHR BX, 1      ; Se desplaza el divisor a la derecha
      SHR DX, 1      ; Se desplaza el verificador a la derecha
      JMP posicion   ; Se salta a la posicion

   validacion:    
      CMP AX, 0000000000000000b
      JE fin                     ; Si el mensaje es igual a 0, se termina el programa
      OR AX, mensaje             ; Enmascaramiento del mensaje resultante con el mensaje original
      MOV BX, 1011000000000000b  ; Se reinicia el divisor
      MOV DX, 1000000000000000b  ; Se reinicia el verificador
      MOV SI, 0d                 ; Se reinicia el contador
      JMP posicion               ; Se salta a la posicion
   
   fin: 
   
   MAIN ENDP
   ; -------Procedimientos-----
   ; --------------------------

END MAIN ; Fin del Programa
