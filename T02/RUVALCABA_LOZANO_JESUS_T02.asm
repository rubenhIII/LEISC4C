TITLE "Verificacion de redundancia ciclica"

;Autor:Jesus Ruvalcaba Lozano
;Fecha:13/03/2023
;Descripcion del Programa:Verifica la redundancia ciclica basado
;en el resultado del registro DX
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    entrada DW 11010011101100b
    divisor DW 10110000000000b
      
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV CX,16             ;Asignamos al contador 16 como referente al numero de bits
        MOV AX,entrada        ;Asignamos a AX nuestro valor de entrada
        MOV BX,divisor        ;Asignamos a BX nuestro valor de divisor
        
        
    ciclo:                    ;Ajustamos un ciclo que haga 16 vueltas
        SHL AX,1              ;Movemos todos los bits a la izquierda, el bit de mayor valor pasa al final
        RCL DX,1              ;Cambia el bit de mayor valor al de menor valor
        JC procedimiento      ;Si el primer bit vale 1 entramos a la funcion 

    procedimiento:
        ADD AX,BX             ;Sumamos nuestra entrada con el divisor
        MOV BX,AX             ;Asignamos el resultado a BX
        XOR AX,AX             ;Pasamos AX a 0
        XOR BX,BX             ;Pasamos BX a 0
        OR AX,DX              ;Hacemos un OR entre la entrada y el resultado
        MOV DX,AX             ;Guardamos en DX
        LOOP ciclo            

        CMP DX, 0              
        JE final
        
    final:
        
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa
