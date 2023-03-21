TITLE   "Factorial de un numero"


;Autor: Zuriel Said Zuniga Delgadillo
;Fecha: 20/03/2023
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h ;Segmento de pila

.DATA ;Segmento de datos
        
        num DW 8
        fac DW 0
        res DW 0
        
.CODE ;Segmento de Codigo

    MAIN PROC ;Procdeimiento Principal
         ;Inicializacion de Segmento
         ;de Codigo
         MOV AX,@DATA
         MOV DS,AX 
        ;-------------------------  
        
;-------Codigo-----------
        MOV CX, num             ;mueve el contenido de num al registro CX
        MOV res, CX             ;para luego mover el contenido a la variable de resultado
        
        SUB CX, 2               ;se le resta a CX
        MOV fac, CX             ;se mueve el contenido de CX a la variable del factorial
        
        MOV AX, num
        
        CALL factorial          ;llamada al procedimiento de factorial
        
        MOV AX, 04Ch            ;forma amigable de terminar el programa
        INT 21h
        
    
    MAIN ENDP
;-------Procedimientos-----
    
    factorial PROC
        
    sum:
        ADD AX, res             ;se le suma el resultado al registro
        loop sum
        
        DEC fac                 ;decrementamos fac
        MOV CX, fac             ;movemos el resultado de la operación de nuevo al registro
        
        MOV res, AX             ;ahora tomamos el contenido del registro AX y se lo asignamos a la variable de resultado
        
        CMP fac, 0              ;se compara que fac sea igual a 0
        JE recu                 ;si la condicion se cumple salta a la llamada recursiva
        
        CALL factorial 
        
   recu:
        RET      

;-------Procedimientos-----    
    
END MAIN                    ;Fin del Programa
    
    