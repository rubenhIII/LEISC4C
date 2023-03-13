TITLE "Verificacion de redundancia ciclica"
;Autor: Einar Naim Aguilar Santana
;Fecha: 11/03/2023
;Descripcion del Programa: Es la implementacion del algoritmo de verificacion
;                          de redundancia ciclica "CRC"
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    MSG DW 1101001110110000b ;Mensaje ocupando 16 bits - con 3 bits libres 
    MSG2 DW 1101001110110000b ;Mensaje ocupando 16 bits servira como respaldo del mensaje para la verificacion dos 
    POL DW 1011000000000000b ;Polinomio divisor ocupando   
     
    VERIFICACION_DOS DW 0 ;bandera que se activara cuando la haya concluido la verificacion uno              
        
    FLAG DW 0 ;bandera que se activara cuando la verificacion hayan concluido con exito significando que no hay error              

    
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

        MOV AX,MSG ;Coloca MSG en el registro AX   
        MOV BX,POL ;Coloca POL en el registro AX 
        MOV DX,1000000000000000b ;Se coloca este valor que servira para el enmascaramiento
        MOV CX,13 ;Contador a 13 (16 bits - 3 bits libres)

        VERIFICACION_DE_REDUNDANCIA:
        
            MOV AX,MSG ;Mueve a MSG a registro AX         
            AND AX,DX ;Enmascaramiento de bits a 0 
            CMP AX,DX ;Compara AX con DX           
            JE DIVISION_POLINOMIAL ;Si son iguales salta a etiqueta DIVISIO_POLINOMIAL         
            JMP RECORRER ;Salta a etiqueta RECORRER                                          
        
        DIVISION_POLINOMIAL: 
        
            MOV AX,MSG ;Carga del mensaje en el registro AX
            XOR AX,BX ;XOR entre el mensaje y el divisor
            MOV MSG,AX ;Guardado del mensaje modificado en mensaje  
            JMP RECORRER ;Salta a recorrer          
            
        RECORRER:
        
            SHR BX,1 ;Recorre un bit a registro BX
            SHR DX,1 ;Recorre un bit a registro DX                  
            LOOP VERIFICACION_DE_REDUNDANCIA ;Ciclar etiqueta VERIFICACION_DE_REDUNDANCIA 
            CMP MSG,0 ;Compara el los bits del mensaje con 0
            JE VERIFICADO ;Si equivalen salta a etiqueta VERIFICADO 
            JA SEGUNDA_VERIFICACION ;Si MSG es mayor a 0 se saltara a etiqueta SEGUNDA_VERIFICACION            
            
        SEGUNDA_VERIFICACION:                       
                       
            MOV AX,MSG ;Mueve lo que queda en MSG al registro AX
            ADD MSG2,AX ;Suma lo del registro AX a 
            MOV AX,MSG2 ;MSG2 se pasa al registro AX 
            MOV MSG,AX ;El contenido de AX se coloca en MSG
            MOV CX,13 ;Contador se reinicia
            MOV BX,POL ;Contenido de POL se coloca en el registro BX
            MOV DX,1000000000000000b ;Se reinicia el contenido de DX 
            CMP VERIFICACION_DOS,0 ;Compara FLAG2 con 0
            JE VERIFICACION_NO_CONCLUIDA ;Si VERIFICACION_DOS equivale a 0 significa que aun no pasa la segunda verificacion
            JA ERROR ;Si FLAG2 esta activada significa que la segunda verificacion ya a concluido y existe un error           
        
        VERIFICACION_NO_CONCLUIDA: ;Si todavia no se ha activado VERIFICACION_DOS significa que seguira la segunda verificacion
            ADD VERIFICACION_DOS,1 ;Se activa la VERIFICACION_DOS indicando que se encuentra en la segunda verificacion
            LOOP VERIFICACION_DE_REDUNDANCIA ;Cicla etiqueta VERIFICACION_DE_REDUNDANCIA                          
            
        VERIFICADO: ;Si ha pasado la verificacion la flag sera un uno
            
            ADD FLAG,1 ;FLAG se activa con 1 significando que no hubo ningun error
            .EXIT
                          
        ERROR: ;Si hay error la FLAG permanecera con 0
         
            .EXIT 
                     
    MAIN ENDP
;--------------------------

END MAIN ;Fin del Programa
