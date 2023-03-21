            TITLE "Factorial de un numero"

;Autor:Estefeen Sandoval Rodriguez
;Fecha:20 de marzo de 2023
;Descripcion del Programa:Es un programa donde calculas el factorial de un numero dado

.MODEL SMALL 

.STACK 100h  
        
.DATA
    num DW 8    ;El factorial del numero que queremos sacar        
    factor DW 0 ;Donde se va a almacenar el valor del factorial
    
.CODE
    
   MAIN PROC         
        MOV AX,@DATA
        MOV DS,AX 
        
;-------Codigo-----------
        MOV AX, 0 ;Inicializamos en 0 los registros AX y BX
        MOV BX, 0
        MOV CX, 1 ;Inicializamos el registro CX en 1 para comparalo posteriormente
        
        MOV AX, num  ;Movemos el valor del factorial que deseamos al registro AX
        CALL factorial  ;Llamamos al procedimeinto "factorial"
       
        INT 21h ;Interrupcion para terminar el programa
        
   MAIN ENDP
   
;-------Procedimientos-----
        
       factorial: ;Etiqueta para que se haga el proceso del factorial
         DEC num ;Decrementamos el valor de num para conseguir el numero anterior al deseado
         MOV BX, num ;Movemos el valor anterior del factorial al registro BX
         MUL BX  ;Multiplicamos el primer valor en AX por el segundo valor en BX
         MOV factor, AX  ;Movemos el resultado a la variable factor
         CMP num, CX  ;Comparamos el valor del num con lo que hay en el registro CX
         JE return  ;Si es que llega a 1 saltamos a la etiqueta return
         CALL factorial  ;Si no es igual aun volvemos a repetir el proceso
         
        return:  ;Etiqueta para regresar desde donde se llamo
          RET
;--------------------------

END MAIN ;Fin del Programa