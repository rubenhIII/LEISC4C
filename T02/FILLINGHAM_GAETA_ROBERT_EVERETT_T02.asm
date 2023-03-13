

TITLE "EXAMEN ROBERT EVERETT"

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!




.MODEL SMALL ;Definicion del tipo de memoria, el modo que ingresemos formara los segmentos de datos codigo y stack de distintas maneras

.STACK 100h  
    ;Segmento de la memoria donde estara la Pila, es distinta a la instruction queue ya que ese es un registro en el CPU
    
.DATA
    ;Segmento de Datos
   Var1 DB "ROBERTEVERETT"  ; Vector de caracteres original   
   Var2 DB  0 DUP(14)       ; Vector que recibira el original pero en minusculas
   Size DB  14              ; Variable que se usa para tratar el tamaño del vector
  
   
.CODE
    ;Segmento de Codigo

                 
   
   
   
   MAIN PROC ;Procedimiento Principal
        
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        
;-------Codigo-----------

         MOV CX, 0      ;Se va a mover un bloque a una palabra, por lo tanto se debe limpiar con ceros el registro
         MOV CL, Size   ;CX vale el tamaño del vector, esto para poder recorrer el vector con loop
         MOV SI, 0      ;Limpiamos el valor del regsitro indice SI
         
         
                              ;Aqui es donde inicia el procedimiento de cada caracter del vector, por eso tiene la etiqueta
Transform:  MOV AL, var1[si]  ;Le pasamos al nible bajo del Registro AX el valor del vector en la posicion SI, se hace con direccionamiento indexado (offset de la variable + valor de SI) 
            ADD AL, 32        ;Le sumamos 32 al valor ascii para que ahora valga su equivalente en minusculas
            MOV VAR2[SI], AL  ;El valor del registro AX nible bajo lo paso al vector destino en la misma posicion que el original
            
            inc SI             ;Se incrementa SI para que ahora el direccionamiento se de en el siguiente bloque
            
            loop Transform     ;Repetir Size (14) veces el procedimiento    
        
        
   MAIN ENDP   ; end procedure
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa