            TITLE "Metodo de la burbuja"

;Autor: Luis Uriel Martinez
;Fecha: 05/03/2023
;Descripcion del Programa:
;Uso de instrucciones JMP y LOOP

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    
    ;Variables
    array db 6, 3, 8, 2, 1, 9
    array_size equ 6

.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
     ; Inicializar registros
      mov cx, array_size        ; contador externo, inicialmente igual al tamaño del array
      mov si, 0                 ; indice del primer elemento del array

  aqui:
      dec cx                    ; decrementa el contador externo
  
      mov di, si                ; inicializa el indice del elemento comparado en el primer elemento
  
  aqui2:
     mov al, [array+di]      ; carga el elemento actual
     cmp al, [array+di+1]    ; compara con el siguiente elemento
    
     jbe no_intercambio            ; salta si no se necesita intercambio
     xchg al, [array+di+1]   ; intercambia los elementos
     mov [array+di], al      ; guarda el elemento anterior
    
 no_intercambio:
    inc di                   ; incrementa el indice del elemento comparado
    loop aqui2              \ ; repite hasta que se han comparado todos los elementos
  
    cmp cx, 0                ; comprueba si se han ordenado todos los elementos
    jne aqui                 ; si no, repite el ciclo externo
  
    mov ah, 4ch              ; llama a la función de salida
    int 21h

   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa