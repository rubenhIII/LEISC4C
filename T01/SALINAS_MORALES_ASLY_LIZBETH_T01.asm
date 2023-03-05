 ;Metodo de la burbuja  
  
; SALINAS_MORALES_ASLY_LIZBETH


DATA SEGMENT
    ; Declaracion de variables
    
    ARRAY_BURBUJA DB 17,14,10,9,7,35,255,1,0
    D DB 8
    
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
    
    ; Codigo 
    
    MOV CX, 7
    MOV SI, 0
    MOV DI, 0
    
    CICLO1:
    PUSH CX 
    
    LEA SI, ARRAY_BURBUJA 
    MOV DI, SI   
    
    INC DI    ;incrementa 
    MOV AL,[SI] 
    CMP AL,[DI] 
    JA MAY  ;salta si es mayor
    JB MENOR      ;salta si es menor 
    
    MAY: 
    MOV AH, [DI] 
    MOV [DI], AL 
    MOV [SI], AH 
    
    MENOR:
    
    ;-----------------------------------------------------------------------------
   
    EXIT:
