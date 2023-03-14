TITLE "Programa de Verificacion de Redundancia Ciclica (CRC)"

.MODEL SMALL ;definicion del tipo de memoria

.STACK 100h  
    ;segmento de pila 
    
.DATA      

    ;segmento de datos
    datos DB "HOLAMUNDO", 0 ;cadena de datos   
    
    Gen DB "1101", 0 ;generador   
    
    Resultado DB ?, 0 ;resultado del calculo del CRC  
    
    
.CODE
    ;segmento de codigo
   MAIN PROC ;procedimiento principal
        ;inicializacion de segmento
        ;de codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------

        ;calcular el CRC
        mov si, offset datos ;cargar direccion de datos en si
        mov di, offset Gen ;cargar direccion de generador en di
        mov cx, 8 ;configurar el contador a 8 bits (8 bits en cadena de datos)
        xor dl, dl ;limpia el registro dl

    calc_crc:
        mov al, [si] ;cargar el siguiente byte de datos en al
        xor ah, ah ;ah = 0
        mov bl, 8 ;configurar el contador a 8 bits (8 bits en byte de datos)

    calc_byte_crc:
        shr al, 1 ;desplazar a la derecha un bit
        rcr ah, 1 ;rotar a la derecha un bit
        cmp ah, [di] ;comparar ah con el primer bit del generador
        jb no_xor ;saltar si ah < primer bit del generador
        xor ah, [di+1] ;xor con el segundo bit del generador

    no_xor:
        dec bl ;decrementar contador de bits
        jnz calc_byte_crc ;saltar si el contador no es cero

        mov [si], al ;almacenar byte de datos modificado
        inc si ;incrementar direccion de datos
        loop calc_crc ;saltar si el contador no es cero

        ;el CRC se almacena en el ultimo byte de datos
        mov Resultado, dl ;almacenar resultado del calculo del CRC

        ;salir del programa
        mov ah, 4ch ;funcion de salida del programa
        int 21h ;salir del programa
   
   MAIN ENDP
   
;-------procedimientos-----


;--------------------------

END MAIN ;fin del programa

