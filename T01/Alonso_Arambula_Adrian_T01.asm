TITLE "Prueba de metodo burbuja"

;Autor:Adrian Alonso Arambula
;Fecha:05/03/2023
;Descripcion del Programa:Una forma de hacer el metodo de burbuja
COMMENT !
--------------------------
!
.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   vec DB 05h,09h,03h,08h,01h,04h
   vecs EQU ($-vec)
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX         
        ;-------------------------
;-------Codigo-----------
        MOV BX, OFFSET vec
        MOV CX, vecs
        one_loop:
            ;Decrementar el contador
            dec cx

            ;Iterar sobre el arreglo y comparar cada par de elementos
            mov si, 0 ; índice de inicio del arreglo
            inner_loop:
                ; Comparar el elemento actual con el siguiente
                mov al, [bx+si]
                cmp al, [bx+si+1]
                jbe no_swap;salta si es menor o no es igual a 

                ;Intercambiar los elementos
                xchg al, [bx+si+1]
                mov [bx+si], al

                no_swap:
                    ;Incrementar el índice
                    inc si
                    cmp si, cx
                    jb inner_loop

                ;Salir del ciclo exterior si todos los elementos estan ordenados
                cmp cx, 0
                jz done

                ;Volver al principio del arreglo y repetir el ciclo exterior
                jmp one_loop  
        done:
         mov ah, 4ch
         int 21h
    
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa