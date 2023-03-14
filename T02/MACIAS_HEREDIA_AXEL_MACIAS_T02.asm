;Tarea #2: Cyclic Redundant Check

.MODEL SMALL

.STACK 100h

.DATA 

msg DW 1101010110111001b 
var1 DW 1000001001100001b
res DW 0b
size DW 16 ;Se define el tamano del mensaje

.CODE

MAIN PROC ;Main
     MOV AX, @DATA
     MOV DS, AX 

     MOV CX, size  ;Se establece al contador el tamano del msg
     MOV AX, msg   ;Se establece el mensaje al registro acumulador
     MOV BX, var1    

loop1:
    SHL AX, 1  ;Mueve el bit mayor de msg al bit menor
    RCL DX, 1  ;Mueve el bit mayor del resultado al bit menor
    JC agregar ;Verifica si el bit mayor es 1, en caso contrario, termina

    agregar:
        ADD AX, BX 
        MOV BX, AX ;Se guarda el resultado de la suma anterior en el registro base
        XOR AX, AX ;Se limpia AX
        XOR BX, BX ;Se limpia BX
        OR AX, DX  
        MOV DX, AX ;Se Guarda el resultado de la operacion OR anterior en DX
        LOOP loop1    

        CMP DX, 0              
        JE exit

        MOV AX, 4C00h
        INT 21h

    exit:
        MOV AX, 4C00h
        MOV res, AX      
        INT 21h

    MAIN ENDP

END MAIN