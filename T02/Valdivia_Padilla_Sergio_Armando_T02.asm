TITLE "Plantilla de Programa"

;Autor: Valdivia Padilla Sergio Armando
;Fecha: 12/Marzo/2023
;Descripcion del Programa: Implementacion del algoritmo de Verificacion de Redundancia
;--------------------------

.MODEL SMALL ;Definicion del tipo de memoria

    ORG 100h   

.DATA

.CODE
;-------Codigo-----------

    INICIO:
        mov bx, 1234h   ; Establecemos el Dato a Calcular 0x1234
        
        xor cx, cx      ; Limpiamos CX
        mov cl, 16      ; Se Inicializa el contador de 16 bits 
        
        xor dx, dx      ; Limpiamos DX
        mov dx, bx      ; Guardamos el dato en DX
        
    CRC:
        xor ax, ax      ; Limpiamos AX
        shl dx, 1       ; Desplazar el dato a la izquierda 1 bit
        
        jnc OBTENERXOR  ; Saltamos si el flag no está establecido
        xor ax, 1021h   ; Realizamos XOR con 0x1021
        
    OBTENERXOR:
        xor bx, ax      ; OBTENEMOS XOR del resultado con el valor de CRC
        
        loop CRC
        
        mov ah, 4Ch     ; Salimos del Programa
        int 21h
    
END  ;Fin del Programa