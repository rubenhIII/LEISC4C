TITLE "FACTORIAL DE UN NUMERO"

;Autor: Emiliano Jahir Espinoza Herrera
;Fecha: 19/03/2023
;Descripcion del Programa: Programa que realiza el factorial un numero 
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
    numero DW 6 ;Variable que guarda el numero 
    factoria DW 0 ;Variable en la que se guardara el resultado del factorial
    
.CODE
    ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
        MOV AX,@DATA
        MOV DS,AX 
;-------Codigo-----------
        MOV SI,1 ;El registro SI se utiliza como   multiplicador y contador que asendera para la restriccion numero para  el factorial Y se  iniciara en 1   
        MOV factoria,SI ;Lo que almacena en la variable factorial se manda al registro SI
        CALL FAC ;Se manda a llamar la funcion del que se genera para el procedimiento   
        MOV AX, 04CH ;Se coloca un valor al registro AX
        INT 21H 
        
    MAIN ENDP
   
;-------Procedimientos-----
    FAC PROC
    
        MOV AX,factoria ;Guardar lo que se almaceno  en la variable al registro
        MOV BX,SI ;Guarda el valor de SI en el registro BX
        MUL BX ;Se multiplica los dos registros anteriores 
        ADD factoria,AX ;Se suma lo acumulado 
        INC SI ;Incrementa el contador SI
        CMP SI,numero   
        JE exit ;LLama a la funcion salir    
        CALL FAC ;Se vuelve a llamar a la funcion     
        
        exit:
            RET ;Se sale del procedimiento 
        
    FAC ENDP
    

;--------------------------

END MAIN ;Fin del Programa