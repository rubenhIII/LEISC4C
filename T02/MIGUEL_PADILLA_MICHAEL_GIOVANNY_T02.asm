TITLE "Calculo del CRC"

;Autor:Michael Giovanny Miguel Padilla
;Fecha:13/03/2023
;Descripcion del Programa:
;Realizar el calculo del CRC entre un mensaje y un polinomio ademas de la correcta validacion del mensaje recibido
;El codigo esta basado en este articulo: https://en.wikipedia.org/wiki/Cyclic_redundancy_check
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos   
    
    mensajeOriginal DW 1101001110110000b;Mensaje original sin modificaciones 
    copia DW 1101001110110000b;Copia usada para ir aplicando Xor entre esta y el polinomio
    polinomio DW 1011000000000000b;POlinomio usado como divisor
    resultado DW 0b;Empleado para almacenar el resultado de la division 
    enm DW 1111000000000000b;Empleado para trabajar con los 4 bits necesarios
    enm2 DW 0FFFCh;Empleado para comprobar si el mensaje es 0b
    
    ;Usados para la verificacion  
    copia2 DW 1101001110110000b;Copia usada para ir aplicando Xor entre esta y el polinomio
    polinomio2 DW 1011000000000000b;POlinomio usado como divisor
    ;resultado2 DW 0b;Empleado para almacenar el resultado de la division 
    enm3 DW 1111000000000000b;Empleado para trabajar con los 4 bits necesarios
    
    
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
prueba1:;Prueba1            
        MOV BX, copia;Mueve lo que tiene copia al registro BX, en este caso la copia del mensaje original
        MOV DX, polinomio;Mueve al registro DX el polinomio, mismo que sera el divisor del mensaje
        MOV AX, copia;Mueve al registro AX lo que tiene copia, lo cual tambien es el mensaje y es el que se usa para enmascarar y tomar los bits a usar
        AND AX, enm;Se hace el enmascaramiento y se guarda en AX, ahi ya solo se esta trabajando con los 4 bits que se emplearan 
        
        XOR AX, DX;Xor entre AX y el polinomio
        XOR BX, DX;Xor entre BX y el polinomio
        
        MOV copia, BX;Mueve a copia o que tiene BX
        CMP AX, 0b;Compara si el enmascaramiento usado en AX es 0b
        
        JE Mov4;En caso de ser igual a 0b, como en el ejemplo tomado de Wikipedia, desplazamos a la derecha 4 veces hasta llegar al primer 1 ->00000001101100 00<- y de ahi nuevamente hacer el Xor con el polinomio 
        JMP Mov1; Si no salta a la etiqueta Mov1 que solamente desplaza a la derecha 1 vez el polinomio y el enmascaramiento que solo ayud a tomar los bits a trabajar
        
        
Mov1:;Mov1
        SHR DX, 01b; Realiza un desplazamiento logico a la derecha
        MOV polinomio, DX;Dicho desplazamiento es pasado al polinomio
        
        MOV DX, enm;Mueve a DX el enmascaramiento, esto ara tambien desplazarlo
        SHR DX, 01b;Realiza 1 desplazamiento logico a la derecha en el enmascaramiento
        
        MOV AX, DX;Mueve a AX el desplazamiento previamente mencionado 
        MOV enm, AX;Ahora mueve a enm(Enmascaramiento) lo que hay en AX, lo cual seria 1 desplazamiento logico a la derecha
           
        JMP Comprobacion;Salta a comprobacion, mas que nada para saber cuando tiene que terminar el algoritmo
                               
                               
        
Mov4:;Mov4 
        SHR DX, 04h;Realiza 4 desplazamientos logicos hacia la derecha en DX
        MOV polinomio, DX;Mueve al polinomio lo que hay en DX 
        
        MOV DX, enm;A DX se le coloca lo que hay en enm(enmascaramiento)
        SHR DX, 04h;Ahora en DX hacemos dichos desplazamientos
        
        MOV AX, DX;Movemos a AX lo que hay en DX 
        MOV enm, AX;Finalmente en emn reflejamos dichos desplazamientos
        
        JMP Comprobacion;Salta a comprobacion, mas que nada para saber cuando tiene que terminar el algoritmo      
                      
                      
        
Comprobacion:;Comprobacion            
        MOV CX,BX;Mueve al registro CX lo que hay en el registro BX, en este caso es nuestro mensaje    
        AND CX,enm2; Este enmascaramiento es utilizado para solamente quedarnos con el mensaje y no con resto(residuo)
        MOV resultado, CX;Refleja en resultado lo que actualmente hay en el registro CX despues del enmascaramiento
        JMP compara;Salta a la etiqueta compara
             
         
         
Validacion:;Validacion
        CMP BX, 0b;Comprueba si BX es 0b
        JNE Val2;Si es distinto de 0, salta a Val2
        JMP fin_Programa;Si es 0, indica una validacion exitosa 
        ;En base a lo visto e investigado, este seria el algoritmo empleado para el calculo del CRC, esta basado en la pagina Wikipedia proporcionada por el profesor  
        
        
        
Val2:;Val2 
        MOV CX, copia2;Mueve a CX lo que hay en nuestra variable copia2, la cual es nuevamente el mensaje
        MOV copia, CX;Mueve a copia(Variable original) lo que hay en el registro CX, en este caso el mensaje
        
        MOV CX, polinomio2;Mueve a CX lo que hay en la variable polinomio2, la cual es nuevamente el polinomio
        MOV polinomio, CX;Mueve a polnomio(Variable original) lo que hay en CX, en este caso el polinomio
        
        MOV CX, enm3;Mueve a CX lo que hay en la variable enm3, la cual es el enmascaramiento empleado para trabajar con bloques de 4 bits
        MOV enm, CX;Mueve a enm(Variable original lo que hay en CX
        
        ADD copia, BX;Agrega al mensaje(copia) el residuo obtenido en la primera comprobacion ->0000000000000010b
        
        JMP prueba1;Sala al ciclo inicial que es prueba1 
        
        
        
compara:;Compara 
        CMP CX,0b;Compara el registro con 0b, 
        JNE prueba1; Si este todavia no contiene 0b, aun hay calculos por relizar y regresa al ciclo inicial que es prueba1 
        
        ;La validez de un mensaje recibido se puede verificar fácilmente realizando el cálculo anterior nuevamente, esta vez con el valor de verificación agregado en lugar de ceros. El resto debe ser igual a cero si no hay errores detectables.
        JMP Validacion
             
        
        
        
fin_Programa:;Fin_programa
        
   MAIN ENDP;Terminacion del Main
   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa



