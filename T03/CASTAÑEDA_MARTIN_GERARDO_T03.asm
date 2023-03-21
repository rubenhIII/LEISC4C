TITLE "CALCULO DEL FACTORIAL DE UN NUMERO"

;Autor:Gerardo Castaneda Martin
;Fecha:20/03/2023
COMMENT !
--------------------------
!             

.MODEL SAMALL
org 100h

.DATA
  num dw 8      ; Numero cuyo factorial se desea calcular
  result dw 0   ; Aqui se almacenara el resultado del calculo

.CODE
;-------------------------
;-------Codigo-----------  

MAIN PROC ;Procedimiento Principal
  ; Punto de entrada del programa
   ;Inicializacion de Segmento de Codigo
  mov ax,@DATA
  mov ds,ax 
  mov ax, num
  call factorial ; Llamamos al procedimiento factorial para calcular el factorial de num
  mov result, ax ; Almacenamos el resultado en la variable result
  mov ah, 4Ch    ; Terminamos el programa
  int 21h
  
  MAIN ENDP
  
 
 
;-------Procedimientos----- 

; Procedimiento factorial
factorial:
  cmp ax, 1     ; Si el numero es 0 o 1, su factorial es 1
  jbe return_one
  push ax       ; Guardamos el valor de ax en la pila
  dec ax        ; En caso contrario, llamamos al procedimiento recursivamente para calcular el factorial 
  call factorial
  pop bx        ; Sacamos el valor del factorial parcial de la pila
  mul bx        ; Multiplicamos el resultado de la llamada recursiva por el valor de ax
return_one:
  ret           ; Devolvemos el valor del factorial en el registro AX   


;--------------------------

END MAIN ;Fin del Programa
