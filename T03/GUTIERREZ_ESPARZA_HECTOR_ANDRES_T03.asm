TITLE "Factorial"

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    number equ 6 ;numero del cual queremos su factorial
    factanswer dw 0 ;variable para guardar el resultado
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        mov cx,number ;agregamos el numero al registro cx para indicar cuantas veces se va a repetir el loop
        mov ax,1      ;ax lo inicializamos con un uno para que la siguiente multiplicacion sea 1*n
        call factorial
        mov factanswer,ax
        mov ax,04ch
        int 21h
        
   MAIN ENDP
   
;-------Procedimientos----- 

    factorial proc
    ciclo:
        mul cx
    loop ciclo             
        ret
    factorial endp            

;--------------------------

END MAIN ;Fin del Programa