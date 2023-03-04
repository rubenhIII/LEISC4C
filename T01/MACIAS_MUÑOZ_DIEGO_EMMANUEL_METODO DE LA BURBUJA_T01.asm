TITLE "Programa que implementa el metodo de la burbuja"

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA     
    ;Segmento de Datos
    array db 9, 2, 7, 5, 4, 3, 6, 8, 1    ; Array a ordenar
    size equ $-array                   ; Tamaño del array
        
.CODE        
    ;Segmento de Codigo
    
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX
        
         
        ;-------------------------
        ;-------Codigo-----------
        mov cx, size                        ; Establecer el contador de bucles externos
        dec cx                              ; Decrementar en uno el contador para evitar que se salga del rango
        mov si, 0                           ; Inicializar el indice externo a cero

bucle_externo:
        mov cx, size                        ; Establecer el contador de bucles internos
        dec cx                              ; Decrementar en uno el contador para evitar que se salga del rango
        mov di, 0                           ; Inicializar el indice interno a cero

bucle_interno:
        mov al, array[di]                   ; Cargar el primer valor
        cmp al, array[di+1]                 ; Comparar con el siguiente valor
        jle no_swap                         ; Saltar si estan en el orden correcto

        ; Intercambiar los valores
        mov bl, array[di+1]
        mov array[di+1], al
        mov array[di], bl

no_swap:
        inc di                              ; Incrementar el indice interno
        loop bucle_interno                  ; Volver al bucle interno mientras el contador no sea cero

        inc si                              ; Incrementar el indice externo
        loop bucle_externo                  ; Volver al bucle externo mientras el contador no sea cero  
        
        
        mov ah, 4ch
        int 21h

   MAIN ENDP
   
;-------Procedimientos-----
;--------------------------

END MAIN ;Fin del Programa