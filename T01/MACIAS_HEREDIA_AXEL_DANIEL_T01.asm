TITLE BURBUJA

DATOS SEGMENT

;vARAIABLE
    
   VECTOR DB  27, 9, 3, 20, 50
   
;FIN VARIABLES
   
DATOS ENDS

PILA SEGMENT
    
    DB 64 DUP(0)
    
PILA ENDS

CODIGO SEGMENT
    
INICIO PROC FAR
    
ASSUME DS:DATOS, CS:CODIGO, SS:PILA
PUSH DS
MOV AX,0
PUSH AX

MOV AX, DATOS
MOV DS, AX
MOV ES, AX

;CODIGO

    MOV CX, 5  ;declaramos el tamanio del ciclo dependiendo el arreglo
    MOV SI, 0                                                                      
    MOV DI, 0
        
    CICLO:
        PUSH CX ;creamos una pila del tamanio del arreglo
        LEA SI, Vector
        MOV DI, SI 
       
CICLO2: 
    INC DI  ;incrementamos el valor de DI
    MOV AL, [SI]   ;cambiamos de lugar lo de SI a AL
    CMP AL, [DI]   ;comparamos AL con el valor de DI
    JA CAMBIO ;si el numero es mayor que el segundo se llama la etiqueta cambio
    JB men  ;si es menor se manda a la etiqueta menor
        
CAMBIO: 
    MOV AH, [DI] ;se mueve AH a DI
    MOV [DI], AL ;intercambiamos la posicion del segundo con la de el primero
    MOV [SI], AH ;intercambiamos la posicion del primero con la de el segundo
 
men:
    INC SI ;incrementamos el valor de SI
    LOOP CICLO2 
    POP CX   ;se saca el tamanio del arreglo y se lo metemos en CX 
    LOOP CICLO ;otro ciclo para verificar las posiciones
        
             
;FIN CODIGO

EXIT:
RET
INICIO ENDP
CODIGO ENDS

    END INICIO