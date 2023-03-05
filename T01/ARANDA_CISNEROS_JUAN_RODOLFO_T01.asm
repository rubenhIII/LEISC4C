;Autor: Juan Rodolfo Aranda Cisneros
;Fecha: 05/03/2023


DATOS SEGMENT
    ; VARIABLES
    BURBUJA DB 12, 23, 67, 89, 255
    ;--------------------------------------------------------------------------
DATOS ENDS

PILA SEGMENT
    DB 64 DUP(0)
PILA ENDS

CODIGO SEGMENT

    INICIO PROC FAR ;NEAR Y FAR
    ASSUME DS:DATOS, CS:CODIGO, SS:PILA
    PUSH DS
    MOV AX, 0
    PUSH AX
    
    MOV AX, DATOS
    MOV DS, AX
    MOV ES, AX
    
    ; CODIGO---------------------------------------------
    MOV CX, 7
    MOV SI, 0
    MOV DI, 0
    
    CICLO1:
    PUSH CX ;PONER EN LA PILA EL VALOR DE CX
    LEA SI, ARRAY_BURBUJA ;PASAR LA DIRECCION EFECTIVA DEL ARREGLO A SI
    MOV DI, SI  ;Y LUEGO PASARLA A DI  
           
    CICLO2:      
    INC DI    ;INCREMENTAR DI PARA PODER COMPARAR LA SIGUIENTE POSICION
    MOV AL, [SI] ;PASAR EL VALOR QUE SE ENCUENTRA EN LA DIRECCION DE SI A AL
    CMP AL, [DI] ; COMPARAR CON EL VALOR QUE SE ENCUENTRA EN LA POSICION DE DI
    JA INTERCAMBIO ; SALTA A LA ETIQUETA SI ES MAYOR
    JB MENOR ; SALTA A LA ETIQUETA SI ES MENOR
    
    INTERCAMBIO: 
    MOV AH, [DI] ; MUEVE EL VALOR QUE SE ENCUENTRA EN DI A AH
    MOV [DI], AL ; MUEVE EL VALOR DE AL A LA POSICION DE DI
    MOV [SI], AH ; PASA EL VALOR DE AH A LA POSICION DE SI
    
    MENOR:  
    INC SI
    LOOP CICLO2 
    POP CX
    LOOP CICLO1
    
    ;---------------------------------------------------------------
    EXIT:
    RET
    INICIO ENDP
CODIGO ENDS 
END INICIO
