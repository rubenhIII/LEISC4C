;Tarea #2: Cyclic Redundant Check - Daniel Alejandro Barbosa Ayala

.MODEL SMALL

.STACK 100h

.DATA 

msg DW 1101010110111001b 
var DW 1000001001100001b
tam DW 16 ;Se define el tamano del mensaje final

.CODE

MAIN PROC ;Main
     MOV AX, @DATA
     MOV DS, AX 

     MOV CX, tam  ;Se manda el tamano final al registro contador
     MOV AX, msg  ;Se manda el manesaje al registro acumulador
     MOV BX, var  ;Se manda var al registro base  

    loop:;Loop del CRC 
    SHL AX, 1 ;Mueve el bit mayor de msg al bit menor
    RCL DX, 1 ;Mueve el bit mayor del resultado al bit menor
    JC addvar ;Verifica si el bit mayor es 1, en caso contrario, termina

    addvar:
        ADD AX, BX ;Suma el var al msg
        MOV BX, AX ;Guarda el resultado en el registro base
        XOR AX, AX ;Borra AX
        XOR BX, BX ;Borra BX
        OR AX, DX  ;Hace la operacion OR con var y msg
        MOV DX, AX ;Guarda el resultado en DX
        LOOP loop    

        CMP DX, 0              
        JE exit

        MOV AX, 4C00h
        INT 21h

    exit:
        MOV AX, 4C00h       
        INT 21h

    MAIN ENDP

END MAIN