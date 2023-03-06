TITLE "Metodo de la Burbuja Tarea 1"

;Autor:Frida Ximena Escamilla Ramirez
;Fecha:05 Marzo 2023
;Descripcion del Programa: Ordenamiento de la burbuja
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   vec DB 5,9,7,4,3,6,8,2 ; este es el vector a ordenar
   nciclo equ 8;constante del mismo tam del vector
    
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
        MOV CX,nciclo-1 ;veces a realizar ciclo
        MOV SI,0 ;registros de origen y destino
        MOV DI,0
        
        ciclo1: ;1er ciclo
            MOV SI,offset vec;1er elemento al registro origen
            MOV DI,SI ;1er elemento al registro destino
            
        ciclo2: ;2do ciclo
            INC DI ;incrementar dest para tener el del 2do elem
            MOV AL,[SI] ;mover 1er elem a AL
            CMP AL,[DI] ;comparar 1er elem y 2do elem
            JB salto ;salta si el 1er elem es menor que 2do elem
            MOV AH, [DI] ;si es mayor intercambiar
            MOV [DI], AL
            MOV [SI],AH
            
        salto: ;cuando es menor el 1er elem que el 2do elem  
            INC SI; incrementar origen para tener el 2do elem
            CMP SI, nciclo-1 ;compara el origen    
            JB ciclo2 ;salta al 2do ciclo
            LOOP ciclo1 ;salta al 1er ciclo
            
         
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa