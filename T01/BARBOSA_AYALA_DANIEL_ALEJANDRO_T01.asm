TITLE MetodoBurbujaDABA

DATOS SEGMENT

;VARAIABLE
    
   V DB  23, 14, 10, 58, 18, 6, 45, 22, 1, 100
   
;FIN VARIABLES
   
DATOS ENDS

STACK SEGMENT
    
    DB 64 DUP(0)
    
STACK ENDS

COD SEGMENT
    
INI PROC FAR
    
ASSUME DS:DATOS, CS:COD, SS:STACK
PUSH DS
MOV AX,0
PUSH AX

MOV AX, DATOS
MOV DS, AX
MOV ES, AX

;CODIGO

    MOV CX, 9
    MOV SI, 0                                                                    
    MOV DI, 0
        
    C:
        PUSH CX 
        LEA SI, V 
        MOV DI, SI 
       
    C1: 
        INC DI  
        MOV AL, [SI]
        CMP AL, [DI]
        JA CHANGE 
        JB MIN
        
    CHANGE: 
        MOV AH, [DI] 
        MOV [DI], AL 
        MOV [SI], AH 
    
    MIN:
        INC SI 
        LOOP C1 
        POP CX    
        LOOP C  
        
             
;FIN CODIGO

EXIT:
RET
INI ENDP
COD ENDS

    END INI