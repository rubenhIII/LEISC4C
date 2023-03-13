                                ;VERIFICACION DE REDUNDANCIA CICLICA
                                      ;GERARDO CASTANEDA MARTIN

.MODEL SMALL  ;Definicion del tipo de memoria

.STACK 100h   ;Segmento de Pila 

.DATA         ;Segmento de Datos

    mensaje DW 1101010110111001b ; Mensaje
    divisor DW 1000001001100001b ; Divisor
    tamano_mensaje DW 16         ; Tamaño del mensaje en bits

.CODE         ; Segmento de Codigo

    MAIN PROC ; Procedimiento Principal

        ; Inicialización de Segmento de Código
        MOV AX, @DATA
        MOV DS, AX 

        MOV CX, tamano_mensaje  ; Numero de iteraciones a realizar
        MOV AX, mensaje         ; Carga del mensaje en el registro AX
        MOV BX, divisor         ; Carga del divisor en el registro BX

        ; Realiza la operacion de division CRC
    loop: 
        SHL AX, 1              ; Desplaza el bit mas significativo del mensaje al bit menos significativo
        RCL DX, 1              ; Desplaza el bit mas significativo del resultado al bit menos significativo
        JC adddivisor          ; Si el bit más significativo del resultado es 1, suma el divisor al resultado

        ; Si el bit mas significativo del resultado es 0, no se hace nada

    adddivisor:
        ADD AX, BX              ; Suma el divisor al mensaje
        MOV BX, AX              ; Guarda el resultado en BX
        XOR AX, AX              ; Limpia AX
        XOR BX, BX              ; Limpia BX
        OR AX, DX               ; OR entre el resultado y el mensaje
        MOV DX, AX              ; Guarda el resultado en DX
        LOOP loop               ; Siguiente iteracion

        ; Si el resultado es cero, la validacion es exitosa
        CMP DX, 0              
        JE exit

        ; Si no, la validacion ha fallado
        MOV AX, 4C00h
        INT 21h

    exit:
        ; ------------------
        MOV AX, 4C00h          ; Salida del programa
        INT 21h

    MAIN ENDP
    ; ----------------------

END MAIN ; Fin del Programa
