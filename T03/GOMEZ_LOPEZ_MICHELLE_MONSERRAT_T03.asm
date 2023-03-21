TITLE "Factorial"

;Autor:Michelle Monserrat Gomez Lopez
;Fecha:20/03/2023
;Descripcion del Programa: Realizar un programa con el factorial de un 
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
    
   size DW EQU 5d
   serie DW 0  
  
 
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        MOV ES,AX
        ;-------------------------
;-------Codigo-----------
     
        MOV AX, size     ;movemos lo que tenemos en size a AX
        MOV CX, 1        ;movemos 1 a CX, mas adelante servira para la multiplicacion
       
       CALL Factorial ;llamamos a la funcion  
       
       MOV AX,04Ch ;llamamos a una interrupcion
       INT 21H      ;interrupcion
        
        
        
   MAIN ENDP
   
;-------Procedimientos-----  


        

    Factorial PROC     
             
           
          
        MUL CX          ;hacemos la multiplicacion  
       
        INC CX  ;incrementa al contador  
       
        CMP CX, size  ;compara si el contador si ya tiene el mismo valor de size
        
        JE salir          ;sale si se cumple
        CALL Factorial    ;vuelve a llamar a Factorial
        
     salir:
     
      MOV serie, AX ;movemos lo de el registro AX a serie
        
    RET 
    Factorial ENDP


;--------------------------

END MAIN ;Fin del Programa