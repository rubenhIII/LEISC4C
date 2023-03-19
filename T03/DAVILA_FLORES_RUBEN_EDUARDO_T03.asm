TITLE "Factorial de un numero"

;Autor:Ruben Eduardo Davila Flores
;Fecha:18/03/2023
;Descripcion del Programa:El programa consiste en sacar el factorial de un numero 
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    
    num EQU 5d ;numero del que se desea el factorial en este caso puse 5 pero se puede modificar
    
    factorial DW 0 ;variable donde se almacenara el resultado                
                      
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------  
   
   MOV SI,num   ;contador para ciclo principal
   MOV DI,num-1 ;Se inicializa DI con num-1 para que se realice la primera multiplicacion
   
   MOV CX,num   ;Se almacena el numero del que se desea el factorial para primera multiplicacion
   MOV DX,num   ;Inicializacion de DX
   
   
   principal:   ;funcion principal (lo uso como un main)
   
   CALL facto   ;llamada hacia facto
   
   MOV DX,factorial  ;se copia el resultado de la operacion a DX que sirve como auxiliar para copiar
   MOV CX, DX        ;se copia el resultado para que en la siguiente vuelta del factorial se multiplique el resultado de la operacion por DI-1 que es el valor siguiente dentro de la operacion del factorial
   
   CMP SI,1          ;comparacion de SI con 1 para saber cuando parar
   
   JA principal      ;Cuando SI>1 se sigue realizando la operacion del factorial
   JE fin            ;Cuando SI=1 se termina el ciclo por lo que se para el programa
   
   fin:
   .exit             ;con .exit se detiene el proceso del programa cuando finaliza las operaciones
        
        
   MAIN ENDP
   
;-------Procedimientos-----
   
facto PROC
     
     MOV AX,CX ;almacena el primer valor que se desea multiplicar
     MOV BX,DI ;almaceno el segundo valor que se va a multiplicar por el primero 
     MUL BX    ;se realiza la operacion de la multiplicacion
     
     DEC SI    ;se decrementa SI para poder ir realizando la comparacion de principal y que exista condicion de paro
     DEC DI    ;se decrementa DI para que el resultado de la multiplicacion siguiente se multiplique por el siguiente numero dentro de la operacion del factorial
     
     MOV factorial,AX ;mueve el resultado de la multiplicacion hacia variable factorial, se usa AX ya que el resultado de MUL se almacena en AL
     
     ret ;retorno
        
facto ENDP 

;--------------------------

END MAIN ;Fin del Programa