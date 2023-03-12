TITLE "Validacion CRC"

; Autor: Melgoza de la Torre Abraham
; Fecha:
; Descripcion del Programa:

COMMENT !
--------------------------
!

.MODEL SMALL    ;Definicion del tipo de memoria

.STACK 100h     ;Segmento de Pila 

.DATA           ;Segmento de Datos

   mensaje1 DW 1101001110110000b ; Mensaje + 3 bits de relleno;
   divisor1 DW 1011000000000000b ; Divisor
   mascara1 DW 1000000000000000b ; Mascara
   resulta1 DW 1101001110110000b ; Mensaje + 3 bits de relleno

   mensaje2 DW 1101001110110000b ; Mensaje inicializado en 0
   flag     DW 0                 ; Flag par validar crc

.CODE; Segmento de Codigo
    MAIN PROC ; Procedimiento Principal
    ; Inicializacion de Segmento de Codigo
    MOV AX, @DATA
    MOV DS, AX 
    MOV AX, 5 
    ; -------Codigo-----------

      MOV CX, 13          ; Numero de iteraciones a realizar
      MOV AX, mensaje1    ; Carga del mensaje en el registro AX
      MOV BX, divisor1    ; Carga del divisor en el registro BX
      MOV DX, mascara1    ; Inicializacion del registro DX
loop: 
      MOV AX, resulta1    ; Carga del mensaje en el registro AX
      AND AX, DX          ; AND entre el mensaje y la mascara
      CMP AX, DX          ; Comparacion entre el mensaje y 1
      JE division
      JMP continue        ; Salto a la siguiente iteracion
division:
      MOV AX, resulta1    ; Carga del mensaje en el registro AX
      XOR AX, BX          ; XOR entre el mensaje y el divisor
      MOV resulta1, AX    ; Guardado del mensaje modificado en mensaje2
continue:
      SHR BX, 1
      SHR DX, 1
      LOOP loop   
      
      CMP resulta1, 0     ; Si son iguales la validacion es correcta
      JE  exit

      MOV AX, resulta1    ; Carga del mensaje en el registro AX
      OR  mensaje2, AX    ; OR entre el mensaje y el resultado
      MOV AX, mensaje2    ; Carga del mensaje en el registro AX
      MOV resulta1, AX    ; Guardado del mensaje modificado en mensaje2 para volver a operar
      MOV BX, divisor1    ; Carga del divisor en el registro BX
      MOV DX, mascara1    ; Inicializacion del registro DX
      MOV CX, 13          ; Numero de iteraciones a realizar
      JMP loop
exit:
      MOV flag, 1         ; Flag de validacion

    ; --------------------------

    MAIN ENDP
    ; -------Procedimientos-----

    ; --------------------------
END MAIN ; Fin del Programa
