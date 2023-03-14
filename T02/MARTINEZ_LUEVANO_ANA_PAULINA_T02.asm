        TITLE "Generador de CRC"

;Autor:Ana Paulina Mtz. Luevano
;Fecha:Lunes 13/marzo/2023
;Descripcion del Programa:
COMMENT !
usar la verificacion de redundancia ciclica 
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    

.DATA ;segmento de Datos 

    msg DW     1101001110110000b
    divisor DW 1011000000000000b; el divisor del mismo tamaño que el mensaje 
    
    CRC DW     1000000000000000b  
    
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV AX,msg;se pasa el mensaje al registo AX
        MOV BX,divisor; pasamos el divisor al registro BX
        MOV CX,0 ;sera nuestro contador
        MOV DX,CRC; esta cantidad actuara como nuestro verificador 
  
 calculo_CRC:
  
        XOR AX,BX;se realiza la operacion de XOR entre el divisor y el mensaje
        INC CX   ;se incrementa el contador
        SHR BX,1 ;se desplaza el divisor a la derecha
        SHR DX,1 ; se desplaza el verificador a la derecha
        JMP validacion1;se va a actualizar la posicion 
        
  validacion1:
        
        CMP CX,13d ;que es por lo 16 bits del mensaje + los 3 bits que quedan libre
        JG  inicializacion ; si el contador es mayor a 12 se pasa a la etiqueta validacion2
        CMP AX,DX ; se compara para verificar el mensaje
        JGE calculo_CRC ;si el mensaje resulta ser igual o mayor al verificador se pasa al enmascaramiento 
        INC CX ; se incrementa el contador
        SHR BX, 1; pasa al siguiente bit
        SHR DX, 1; pasa al siguiente bit 
        jmp validacion1
  
 inicializacion:
        CMP AX,0 ;revisa si el mensaje no a llegado a 0 para detenerse
        JE  fin  ; si AX=0 se termina
        OR AX, msg; se hace una operacion OR con el mensaje guardado en AX y el original
        MOV BX, 1011000000000000b ; se reinicia el divisor
        MOV DX, 1000000000000000b ; reinicia el verificador 
        MOV CX, 0 ; en contador se reinicia
        JMP validacion1 ; salta a la etiqueta de validacion1
        
  
   
        
        
        
 fin:      
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa