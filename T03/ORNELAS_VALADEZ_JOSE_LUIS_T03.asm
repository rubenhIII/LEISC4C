TITLE "FACTORIAL DE UN NUMERO"


;Jose Luis Ornelas Valadez



.MODEL SMALL                    ;TIPO DE MEMORIA
.STACK 100h                     ;SEGMENTO DE PILA
.DATA                           ;SEGMENTO DE DATOS

;VARIABLES:

 NUM EQU 12                     ;VARIABLE NUM - EQU - EXPRESION
 FAC DW 0                       ;VARIABLE FAC - DEFINE WORD - EXPRESION

;----------------------------------------------------------------------------------------
;MAIN:

.CODE                           ;SEGMENTO DEL CODIGO

MAIN PROC                       ;PROCEDIMIENTO PRINCIPAL DEL PROGRAMA
    MOV AX,@DATA                ;MUEVE 
    MOV DS,AX                   ;MUEVE EL SEGMENTO DE DATOS AL REGISTRO AX
    MOV ES,AX                   ;MUEVE EL SEGMENTO EXTRA DE DATOS AL REGISTRO AX
    MOV AX,NUM                  ;MUEVE LO QUE TENGAMOS EN EL REGISTRO AX A LA VARAIBLE NUM
    MOV CX,NUM-1                ;MUEVE LO QUE TENGAMOS EN EL REGISTRO CX A LA VARIABLE NUM QUE RESTA 1
    
    CALL FACTORIAL              ;LLAMA LA FUNCION DE FACTORIAL  
    MOV AX,04CH                 ;CREA UNA INTERRUPCION EN EL PROGRAMA 
    INT 21H                     ;UNA INTERRUPCION DE LA ANTERIOR
     
    MAIN ENDP                   ;TERMINO DEL PROGRAMA PRINCIPAL


;----------------------------------------------------------------------------------------
;PROCEDIMIENTO:

    
FACTORIAL PROC
    
    MUL CX                      ;SE HACE LA OPERACION DE MULTIPLICAR CON EL MULTIPLICADOR 
    MOV FAC,AX                  ;SE MUEVE LO QUE SE TIENE EN EL REGISTRO AX A LA VARIABLE
    DEC CX                      ;DECREMENTAMOS LO QUE TENGAMOS EN EL REGISTRO CX
    CMP CX,NUM                  ;SE HACE UNA COMPARACIO SI EL REGISTRO CX ES IGUAL QUE AL NUMERO
    JLE RESU                    ;SALTA A LA ETIQUETA ASIGNADA
    CALL FACTORIAL              ;LLAMA A LA FUNCION FACTORIAL
    

RESU:
    MOV AX,FAC                  ;MOVEMOS EL CONTENIDO DE FACT AL REGISTRO AX
    RET                         ;HACE UN RETORNO
    
    END MAIN                    ;TERMINA EL PROGRAMA                                                                                                                                                                                                                               