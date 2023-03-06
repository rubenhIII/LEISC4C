TITLE Metodo de la Burbuja

; Alba_Davila_Erik_Omar_Tarea1


DATOS SEGMENT
    ; variables
    VEC DB 19,10,7,50,24,38,255,1,0
    A DB 9
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
    
    ; Codigo----------------------------------------------------------------------
    MOV CX, 7
    MOV SI, 0
    MOV DI, 0
    
    CICLO1:
    PUSH CX ;Se pone en la pila el valor CX
    ;LEA SI, OFFSET VEC 
    LEA SI, VEC ;Se pasa la direccion efectiva de VEC a SI
    MOV DI, SI  ;Despues pasa a DI  
    
    INC DI    ;Incrementa DI para poder comprara la siguiente posicion
    MOV AL, [SI] ;El valor de SI pasa a AL
    CMP AL, [DI] ; Comparar con el valor que se encuentra en DI
    JA INTERCAMBIO ; Salta a la etiqueta si es MAYOR
    JB MENOR ; Salta a la etiqueta si es MENOR
    
    INTERCAMBIO: 
    MOV AH, [DI] ; El valor en DI se mueve a AH
    MOV [DI], AL ; El valor de AL se mueve a DI
    MOV [SI], AH ; El valor de AH pasa a SI
    
    MENOR:
    
    ; Registros
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