TITLE "Verificacion de redundancia ciclica"

;Autor: Ruben Eduardo Davila Flores
;Fecha: 13/03/2023
;Descripcion del Programa: El programa consiste en realizar el algoritmo de verificacion de redundancia ciclica
;a partir de una cadena inicial con valor binario 1101001110110000 y un polinomio binario con valor 1011000000000000 


.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
mensaje DW 1101001110110000b
polinomio DW 1011000000000000b

polinomioCopia DW 0
mensajeCopia DW 0

result DW ?  
   
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX
         
        ;-------------------------
;-------Codigo-----------
    MOV AX,mensaje
    MOV mensajeCopia,AX ;Copia del mensaje original para tener un respaldo de este mensaje
    MOV AX,0
    
    MOV AX,polinomio
    MOV polinomioCopia,AX ;Para tener un respaldo de la variable del polinomio
    MOV AX,0
    
    reinicio:;Hago un reinicio de todas las variables para la parte de la verificacion que se hace al final
    MOV BX,mensajeCopia
    MOV mensaje,BX
    MOV AX,0
    MOV BX,0
    MOV CX,0
    MOV DX,0
    
    principal:
    MOV DX,mensaje
    AND DX,1111111111111000b;se realiza el enmascaramiento de la variable mensaje sirve para quedarse con los ultimos 3 bits de mensaje
    MOV CX,0                ;reinicio de contador durante ejecucion de codigo
    MOV AX,0                ;reinicio de registro durante ejecucion de codigo
    CMP DX,0
    JE verificacion
    JMP conteoBits     ;En caso de que mensaje no sea cero saltamos hacia el conteo de los bits de la cadena

    conteoBits:
    SHL DX,1           ;Se desplaza un bit el mensaje hacia la izquierda
    JC  desplazamiento ;si existe un carry salta a la etiqueta de desplazamiento 
    INC CL             ;incremento de contador
    JMP conteoBits     ;JMP directo para usarlo como un loop
    
    desplazamiento:
    MOV AX,polinomioCopia ;Almacena una copia del polinomio en registro AX
    MOV polinomio,AX      ;Se manda la copia hacia polinomio para tener la variable como recien declarada
    SHR polinomio,CL      ;se desplaza hacia la derecha el polinomio de acuerdo a lo almacenado dentro del conteo de bits
    MOV AX,polinomio
    XOR mensaje,AX        ;Se realiza el XOR entre el mensaje y el polinomio original con ayuda de un registro
    JMP principal         ;saltamos de nuevo al principio despues de haber realizado el XOR

    verificacion:
    MOV BX,mensaje
    ADD mensajeCopia,BX

    CMP BX,0              ;Si el registro finalmente contiene un cero se finaliza en codigo
    JE  fin
    
    JMP reinicio          ;En caso de que no se vuelve a realizar todo el proceso de codigo reiniciando primero las variables

    
    fin:                    ;fin del programa
    .exit
    
             
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa    





