TITLE "CRC"

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
           
.DATA
    ;Segmento de Datos
    msg dw 1101001110110000b
    divisor dw 1011000000000000b
   
.CODE
    ;Segmento de Codigo     
    
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo  
            
        MOV AX, @DATA
        MOV DS, AX 
;-------Codigo-----------
        mov ax,0
start:       
        add ax,msg  ;sumamos el menjase con lo que tiene el registro ax. Al momento de la validacion va a sumarse el mensaje con los tres bits para la validacion, 
        mov di,divisor ;se reinicia la posicion de los bit que se movieron con el shifting
        mov bx,0f000h  ;se reinicia la posicion de los bit que se movieron con el shifting
cycle:  ;este en el loop principal donde se hace el algoritmo CRC 
        mov dx,ax ;copiamos el mensaje al registro dx     
        and dx,bx ;hacemos un enmascaramiento en donde obtenemos los cuatro bits para la operacion xor
        
        sub ax,dx ;desasignamos los 4 bits correspondientes       
        xor dx,di ;hacemos la oparecion xor con el divisor
        add ax,dx ;ahora se los volvemos a asignamos los 4 bits
        
        cmp dx,0  ;si despues de la operacion xor el registro termina en ceros entonces movemos los bits 4 casillas a la derecha
        jnz shiftonce
        shr bx,4
        shr di,4
        jmp continue
        
shiftonce: ;solo se hace shift una vez al contrario de la arriba que se hace cuatro veces       
        shr bx,1
        shr di,1
continue:            
        mov cx,ax    
        and cx,1111111111111000b ;enmascaramiento para quedarnos con solo la parte del mensaje
                
        cmp cx,0  ;comprobamos si el mensaje esta en ceros en caso de ser verdad quiere decir que el algoritmo termino
        jnz cycle
         
        cmp ax,0      ;si el registro termina en cero quiere decir que termino la validacion del mensaje.
        jnz  start    ;si no es cero quiere decir que termino apenas el algoritmo y ahora debe segir la validacion    

        
    MAIN ENDP
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa