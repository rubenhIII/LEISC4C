TITLE BURBUJA

DATOS SEGMENT

;vARAIABLE
    
   VECTOR DB  23, 14, 10, 58, 18, 6, 45, 22, 1, 100
   
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

    MOV CX, 9  ;Determinamos el tamaño del ciclo dependiendo del tamaño del arreglo
    MOV SI, 0  ;Limpiamos los Registros                                                                    
    MOV DI, 0
        
    CICLO:
        PUSH CX ;Colocamos en la pila el tamaño del arreglo
        LEA SI, VECTOR ;Pasa la dirreccion efectiva del arreglo a SI
        MOV DI, SI ;Pasamos la dirreccion anterior a DI
       
    CICLO2: 
        INC DI  ;Incrementamos el Valor de DI a 1
        MOV AL, [SI]   ;Movemos el valor de SI a AL
        CMP AL, [DI]   ;Comparamos AL con el valor de DI
        JA CAMBIO ;Si el primer numero es mayor que el segundo se manda a la etiqueta cambio
        JB MENOR  ;Si es menor se manda a la etiqueta menor
        
    CAMBIO: 
        MOV AH, [DI] ;Se mueve la parte alta de Ax a Di
        MOV [DI], AL ;Se cambia la posición del segundo por el primero
        MOV [SI], AH ;Se cambia la posición del primero por el segundo
    
    MENOR:
        INC SI ;Se incrementa el valor de SI
        LOOP CICLO2 
        POP CX   ;Se saca el tamaño del arreglo y se lo metemos en cx 
        LOOP CICLO  ;Creamos un ciclo anidado para ir comparando todas las posiciones
        
             
;FIN CODIGO

EXIT:
RET
INICIO ENDP
CODIGO ENDS

    END INICIO