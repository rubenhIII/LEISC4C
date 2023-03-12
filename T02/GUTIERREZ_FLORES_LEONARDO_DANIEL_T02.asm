TITLE "Plantilla de Programa"

;Autor: Leonardo Daniel Gutierrez Flores
;Fecha: 11/03/2023
;Descripcion del Programa:Realizar la implementacion del algoritmo de Verificacion de Redundancia
;TODO EL PROCESO SE MUESTRA EN LOS REGISTROS NO EN LAS VARIABLES
COMMENT !
--------------------------
!
.MODEL SMALL ;Definicion del tipo de memoria
.STACK 100h  
    ;Segmento de Pila     
.DATA
    ;Segmento de Datos
   Origin DW 1101001110110000b;Se declara el mensaje a comprobar
   Compare DW 1011000000000000b;Se declara el mensaje divisor
   Aux DW 0000000000000000b;Se declara un auxiliar de comprobacion
   Zero DW 1000000000000000b;Se declara una variable para comprobar si es uno la posicion actual
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        MOV SI,0 ;Se guarda en el registro SI un 0 para llevar el contador
        MOV BX,Origin;Se guarda en el registro BX lo que tiene Origin
        MOV DX,Zero;Guardamos en DX Zero para hacer las comprobaciones
        MOV CX,Compare;Guardamos asi mismo Compare en CX  
   MAIN ENDP
;-------Procedimientos----- 
INI:   
        XOR BX,CX;Hacemos una operacion logica tipo XOR
INCR:        
        SHR CX,1;Movemos lo que tenemos en nuestro registro CX un bit a la derecha para comparar posteriormente
        SHR DX,1;Igualmente para DX, en este es para la comprobacion de los 0
        INC SI;Incrementamos nuestro contador
        CMP DX,BX;Buscamos el primer 1 con esta comparacion
        JA INCR;Si el registro DX es mayor a BX significa que es un 0 asi q volvemos a INCR
        CMP SI,12;Comparamos SI con 12 para saber si ya recorrio todo el numero
        JA Part2;Si ya recorrio todo el numero brincamos a la parte 2
        JMP INI;Si no lo ha recorrido regresamos al inicio de la comparacion
Part2:
        CMP BX,AUX;Comparamos si BX esta en ceros
        JE FIN;Si lo esta terminamos el programa
        ADD BX,Origin;Si no esta en ceros le sumamos a AX Origin
        MOV SI,0;Receteamos nuestro contador SI
        MOV DX,Zero;Receteamos nuestro registro DX con la variable Zero
        MOV CX,Compare;Receteamos nuestro registro CX con la variable Compare
        JMP INI;Regresamos al inicio luego de recetear todo
;--------------------------
FIN:
END MAIN ;Fin del Programa