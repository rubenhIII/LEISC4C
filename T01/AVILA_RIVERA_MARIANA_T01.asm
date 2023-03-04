TITLE "Metodo de la Burbuja"

;Autor: MARIANA AVILA RIVERA
;Fecha: 05/03/2023
;Descripcion del Programa:
;   Se utiliza el metodo de la burbuja para ordenar un array de numeros

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
    
   vec1 DB 56d,60d,15d,81d,21d  ;guardando numeros en decimal
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA
        MOV DS,AX 
;-------------------------
;-------Codigo-----------
        
      
siSwitch:;vuelve a hacer el recorrido cuando detecta un cambio
    MOV BX,0    ;Registro usado para detectar si ocurre switch
                ;BX==0 ->No hubo switch.  BX!=0 ->Hubo un switch
                
    MOV CX,5-1    ;5 por ser el num. de elementos en el vector
        
    MOV SI,0 ;
    MOV DI,1 
    
    ciclo1:

        MOV AH,vec1[SI] ;Se guarda el num
        MOV AL,vec1[DI] ;Se guarda el num+1
        
        CMP AH,AL; SI>DI(SI+1)? SI=salta a cambio, NO=sigue
        JA cambio   
        
     continua:
                    
        INC SI  ;Incrementa posicion 1
        INC DI  ;Incrementa posicion 2          
        DEC CX  ;Decrementa contador
        
        CMP CX,0 ;Compara CX y 0
        JNZ ciclo1 ;salta a ciclo1 si CX!=0
        
        OR BX,0 ;Con OR el resultado es cero cuando ambos son cero   
        JNZ siSwitch; salta a "siSwitch" cuando BX!=0
                    ;es decir, cuando hubo un cambio
        
        JMP fin ;Salta para terminar
          
cambio:
    ;Moviendo el numero menor
    
    MOV vec1[SI],AL  ;Se guarda el numero menor
    MOV vec1[DI],AH  ;Se guarda el numero mayor     
    
    MOV BX,1 ;Guarda un 1 en BX para indicar que hubo un switch
    
    JMP continua
            
 fin:
        
   MAIN ENDP
 
;-------Procedimientos-----
;--------------------------

END MAIN ;Fin del Programa
