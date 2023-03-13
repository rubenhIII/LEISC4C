TITLE "ALGORITMO CRC"

;Autor: Luis Uriel Martinez Rodriguez 
;Fecha: 12/03/2023
;Descripcion del Programa: programa en el cual implementamos el algoritmo crc que verifica la integradiad de los datos
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    mensaje db "Hola mundo", 0
    polinomio db 13h
    tamano dw 11
    crc db ?
    
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
      mov al, mensaje[0]
      mov bl, polinomio

      mov cx, tamano
      mov si, 1

      bucle:
      mov dl, mensaje[si]
      xor dl, al
      mov al, bl
      div dl
      xor al, ah
      mov ah, 0
      inc si
      loop bucle

      mov dl, 0
      mov crc, al

      mov ah, 4ch
      int 21h
      ret
        
      
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa