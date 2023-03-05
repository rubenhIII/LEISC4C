TITLE "Metodo de la Burbuja"

;Autor:Ruben Eduardo Davila Flores
;Fecha:03/03/2023
;Descripcion del Programa:El programa consiste en hacer el metodo de ordenamiento de la burbuja
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   vec DB  35d,5d,6d,1d,12d,23d 
   
   conti DW 0 ;contador para ciclo externo
   contj DW 0 ;contador para ciclo interno
   
   
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

;Inicializo contadores en 1 y 0 para poder ir comparando posiciones
MOV conti,1
MOV contj,0

cicloexterno:

CMP conti,6  
JB  ciclointerno ;Salto hacia el ciclo interno mientras conti < 6
JMP finprograma

ciclointerno:
MOV DX,5
CMP DX,contj ;Se comprueba si la resta es mayor a contj
JA comparacion  ;Salta a comparar en caso de que lo del registro DX sea mayor a cont2
INC conti    ;Incremento de cont1 despues de que no se cumpla el salto anterior
MOV contj,0  ;Reinicio a 0 el cont2 para una nueva vuelta del ciclo1
JMP cicloexterno   ;Regreso al ciclo1



comparacion:
MOV SI,contj    ;Movemos la cantidad de contj a SI para usarlo como un indice en la comparacion
MOV AL,vec[SI]  ;En la parte baja de AX se pone el valor que se encuentra en la posicion contenida en SI
MOV AH,vec[SI+1];En BL se pone el valor que se contiene en la siguiente posicion
CMP AL,AH       ;Se compara cual de los dos valores es mayor
JA cambiomayor        ;Salta a mayor en caso de que el valor contenido en AL sea mayor al de AH
INC contj
JMP ciclointerno      ;Retorno hacia ciclointerno


cambiomayor:
MOV CL,AL       ;Al auxiliar se le mueve el valor contenido en AL
MOV AL,AH       ;Mueve a AL lo contenido en AH ya que en este caso lo de AH es menor
MOV AH,CL      ;Mueve a BL el valor que antes se contenia en AL usando aux como ayuda para un intercambio
MOV vec[SI],AL  ;Al vector en la posicion SI se le ingresa el valor contenido en AL para el ordenamiento
MOV vec[SI+1],AH;En la posicion siguiente se le ingresa lo contenido en BL para finalizar el cambio
INC contj       ;Incremento del contador 2 para avanzar en la comparacion con proximas posiciones
JMP ciclointerno      ;Salto para regreso hacia el ciclointerno

    
finprograma:          
                
        
   MAIN ENDP
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del ProgramaE