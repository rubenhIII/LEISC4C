            TITLE "Metodo de la burbuja"

;Autor:Estefeen Sandoval Rodriguez
;Fecha:5 de marzo 2023
;Descripcion del Programa:Metodo de la burbuja en ensamblador
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   vec DB 4, 15, 7, 19, 3, 24, 5, 9 ;Vector de datos de tamanio DB
   nciclo equ 8 ;Constante con el numero de datos del vector                    
                       
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

        MOV CX,nciclo-1 ;Declaracion de cuantas veces se realizara el ciclo en el registro CX
        MOV SI,0    ;Los registros de origen y destino se inicializan en 0    
        MOV DI,0
        
        for1:   ;Etiqueta para realizar el ciclo principal
            MOV SI,offset vec   ;Movemos la direccion de memoria del primer elemento del vector al registro de origen
            MOV DI,SI   ;Movemos la misma direccion de memoria al registro de destino
            
        for2:   ;Etiqueta para realizar el segundo for
            INC DI  ;Incrementamos el indice de origen para tener la direccion del segundo elemento del vector
            MOV AL,[SI] ;Movemos el contenido del primer elemento del vector al registro AL
            CMP AL,[DI] ;Comparamos el contedido del primer elemento con el segundo elemnto         
            JB salto    ;Salta a la etiqueta salto si el contenido del primer elemento es menor que el segundo 
            MOV AH,[DI] ;Si el contenido del priemro es mayor intercambiamos los 
            MOV [DI],AL
            MOV [SI],AH
            
        salto:  ;Etiqueta para cuando el contenido del primer elemento es menor que el segundo
            INC SI  ;Incrementa el indice de origen para tener la direccion del segundo elemento
            CMP SI, nciclo-1    ;Compara el indice de origen con el tamanio del vector
            JB for2 ;Salta de nuevo al segundo for si es que todavia no se ha terminado de recorrer el vector
            LOOP for1   ;Salta al primer for si se termino la primera pasada por los datos
            
                
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa
