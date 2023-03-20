TITLE "FACTORIAL"

;Autor:Frida Ximena Escamilla Ramirez
;Fecha:20 Marzo 2023
;Descripcion del Programa: Factorial de un numero
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA 
    ;Segmento de Datos 
    RESU DB 1
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV CX,4 ;factorial de 4  
        CALL for ;llamada al ciclo   
        MOV AX,04Ch ;interrupcion
        INT 21h 
        
   MAIN ENDP
   
;-------Procedimientos-----
             
        for PROC
          MOV AL, RESU ;mover a al el resultado que es 1 
          MOV BL, CL  ; lo que tenga la parte baja de cx, moverlo a la parte baja de bx
          MUL BL       ;multiplicar registro bl
          MOV RESU, AL  ; guardar resultado   
          
        LOOP  for
        
             
          
        salir: 
        RET
        for ENDP

;--------------------------

END MAIN ;Fin del Programa