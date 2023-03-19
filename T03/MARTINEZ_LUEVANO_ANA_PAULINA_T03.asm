      TITLE "FACTORIAL"

;Autor:Ana Paulina Mtz. Luevano
;Fecha:17/marzo/2023
;Descripcion del Programa:
COMMENT !
hacer un programa que obtenga el factorial de un numero 
usando la recursividad.

!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   
    NUM EQU 03d ;numero del cual se obtendra en factorial
    FinalR DW 0;lugar donde se almacenara el resultado final
    Ciclo DW NUM;numero del ciclo interno para obtener el factorial
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        
        
        MOV BX,NUM;se mueve el valor de NUM al registro BX
 Resultado:: ;etiqueta global
        
        dec ciclo  ;decrementa el ciclo externo
        CMP ciclo,0;compara para saber si el ciclo llego a su final
        JE  salir  ;si es igual a 0 salta a la etiqueta salir
        MOV AX,0   ;le asignamos al registro AX el valor de 0
        CALL factorial ;llama a la funcion factorial
       
       
        MOV FinalR,BX ;se mueve el valor que tiene BX a la variable FinalR
        MOV AX, 04Ch  ;es una interrupcion para terminar el programa
        INT 21h ;tambien es una interrupcion 
        
        
   MAIN ENDP
   
;-------Procedimientos-----  

factorial PROC  
    
      MOV CX,ciclo ;se pasa el valor del ciclo al regitro CX que sera otro contadorinterno
      CMP CX,0     ;comparamos el contador para verificar si no llego a su final
      JE  salir    ;si el contaodr es igual a 0 salta a salir
      
operacion:
      ADD AX,BX    ;suma lo que tiene el registro AX y BX ademas de que guarda el resultado en AX
      CMP CX,0     ;compara el contador 
      dec CX       ;decrementa el contador interno
      JNE operacion;si no es igual a 0 salta a la etiqueta operacion de forma recursiva
      MOV BX,AX    ;mueve el valor del registro AX al BX
      JE  Resultado;si es igual a 0 salta a la etiqueta resultado 

salir:
    RET 
    ;ADD FinalR,4 
    MOV AX, 04Ch ;es una interrupcion para terminar el programa
    INT 21h ;tambien es una interrupcion 
    factorial ENDP
   

;--------------------------

END MAIN ;Fin del Programa