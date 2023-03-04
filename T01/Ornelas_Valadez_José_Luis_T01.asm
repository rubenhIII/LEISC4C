TITLE METODO DE LA BURBUJA

; Ornelas_Valadez_Jose_Luis_Tarea1


DATOS SEGMENT
    ; DECLARAR LAS VARIABLES AQU?
    ;16,15,14,255
    ;14 15 16 255
    ARRAY_BURBUJA DB 15,12,8,5,,37,255,2,0
    A DB 8
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
    
    ; CODIGO DE NUESTRO PROGRAMA AQUI---------------------------------------------
    MOV CX, 7
    MOV SI, 0
    MOV DI, 0
    
    CICLO1:
    PUSH CX ;PONER EN LA PILA EL VALOR DE CX
    ;LEA SI, OFFSET ARRAY_BURBUJA 
    LEA SI, ARRAY_BURBUJA ;PASAR LA DIRECCION EFECTIVA DEL ARREGLO A SI
    MOV DI, SI  ;Y LUEGO PASARLA A DI  
    
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
    
    ; REGISTROS DE ENSAMBLADOR
    ;8086 CPU has 8 general purpose registers, each register has its own name:
    
    ; AX - the accumulator register (divided into AH / AL).
    ; BX - the base address register (divided 
    ; CX - the data register (divided into DH / DL)
    
    ; SI - source index register.
    ; DI - destination index register.
    ; BP - base pointer.
    ; SP - stack pointer.
    
    ;-----------------------------------------------------------------------------
    EXIT: