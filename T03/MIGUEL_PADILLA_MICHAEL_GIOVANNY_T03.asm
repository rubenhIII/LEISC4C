                                                TITLE "Factorial de un numero <9"

;Autor:Michael Giovanny Miguel Padilla
;Fecha:18/03/2023
;Descripcion del Programa:
;Programa que calcula el factorial de un numero, supongo que por el tamaño de los registros, dicho factorial solo se calcula de numeros menores a 9
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos   
    
    fact EQU 8d;Fact almacena un 8 en decimal
    Resultado DW 0;Resultado guardara el resultado del factorial
    
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        MOV ES, AX
        ;-------------------------
;-------Codigo-----------  
        MOV AX, fact;Movemos al registro AX lo que hay en fact, que en este caso es un 8
        MOV CX, fact-1;Movemos a nuestro contador CX lo que hay en fact-1, en este caso seria un 7
        
        CALL factorial;Llamada a la funcion factorial 
        ;Interrupcion
        MOV AX, 04Ch
        INT 21h;Cortar el programa, para que no se cicle->Interrupcion 21
        
   MAIN ENDP;Terminacion del Main
   
;-------Procedimientos

factorial PROC;Funcion factorial 
        MUL CX;La instruccion MUL lo que hace es multiplicar el valor almacenado en el registro que se le da como operando en este caso CX por el valor que se encuenre almacenado en el regisro AX 
        MOV Resultado, AX;Movemos lo que contiene AX a nuestra variable resultado
        MOV AX, Resultado;Movemos al regustro AX el resultado de la multiplicacion realizada previamente
        DEC CX;Decrementamos nuestro contador CX

        CMP CX, 0;Compara si CX es igual a cero
        JE salir_factorial;Si es igual a cero, salta a la etiqueta salir_factorial
        CALL factorial;Si no es igual a cero, vuelve a llamar a factorial
         
salir_factorial:;Etiqueta salir_factorial
        RET;Realiza un retorno de subrutina
                          
factorial ENDP;Fin de factorial
;--------------------------

END MAIN ;Fin del Programa



