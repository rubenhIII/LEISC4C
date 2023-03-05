
; Martinez_Chavez_Jazmin


DATA SEGMENT
    ; DECLARAR LAS VARIABLES 
    
    ARRAY_BURBUJA DB 13,11,6,4,,37,255,1,0
    C DB 8
    
DATA ENDS

SATCK SEGMENT
    DB 64 DUP(0)
SATCK ENDS

COD SEGMENT

    INICIO PROC FAR 
    ASSUME DS:DATA, CS:COD, SS:SATCK
    PUSH DS
    MOV AX, 0
    PUSH AX
    
    MOV AX, DATA
    MOV DS, AX
    MOV ES, AX
    
    ; CODIGO 
    MOV CX, 7
    MOV SI, 0
    MOV DI, 0
    
    CICLO1:
    PUSH CX 
    
    LEA SI, ARRAY_BURBUJA 
    MOV DI, SI   
    
    INC DI    
    MOV AL, [SI] 
    CMP AL, [DI] 
    JA INTERCAMBIO 
    JB MENOR 
    
    INTERCAMBIO: 
    MOV AH, [DI] 
    MOV [DI], AL 
    MOV [SI], AH 
    
    MENOR:
    ;-----------------------------------------------------------------------------
    EXIT:
