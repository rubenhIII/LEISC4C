TITLE "METODO DE VERIFICACION DE REDUNDANCIA - CICLICA"

;Ornelas_Valadez_Jose_Luis_Tarea2


.MODEL SMALL
.STACK 100h  
.DATA
    
    ;Variables     
    Mensaje       DW 1101001110110000b    ;16 bits   ultimos tres poli.
    MensajeUnic   DW 0h                   ;Almacena el Mensaje Original
    Polinomio     DW 1011000000000000b    ;16 bits
    PolinomioResultado DW 0h              ;Almacena la codificacion obtenida
    movidas          DB 0h                   ;Auxiliar para obtener numero de desplazamientos


;--------------------------------------------------------------------------------------------------------------------------------------------------------------------   
.CODE

MAIN PROC                                 ;Procedimiento Principal 
      
        MOV AX,@DATA                      ;INICIANDO A "AX" CON EL VALOR DIRECCIONADO EN "DATA"
        MOV DS,AX                         ;HACE EL CALCULO POR LA DIRECCION
        
        MOV CX,Message                    ;MUEVE EL CONTENIDO A MENSAJE
        MOV MensajeUnic,CX                ;MUEVE LO QUE CONTIENE AL REGISTRO CX
        
        XOR CX,CX                         ;ESTE SERIA EL QUE TIENE EL MENSAJE
        XOR SI,SI                         ;ESTE ES EL DIVIDE
        XOR DI,DI                         ;ESTE LO VERIFICA
      
        MOV DX,Polinomio                  ;MUEVE EL REGISTRO DX A POLINOMIO
        JMP MVRC-algoritmo                ;LLAMA A LA FUNCION MVRC-ALGORITMO
        
MAIN ENDP                                 ;TERMINA EL MAIN      
END MAIN                                  ;TERMINA EL PROGRAMA
                             
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------
;PROCESO PARA VERIFICACION:

MVRC-algoritmo:
        
        MOV AX,Mensaje                    ;MUEVE EL REGISTRO AX A MENSAJE
        AND AX,1111111111111000b          ;CONJUNCION DE OPERADORES EN AX CON EL VALO HECADECIMAL
        CMP AX,0h                         ;COMPARA EL OPERADOR DEL REGISTRO AX CON 0H
        JE  Verificacion                  ;SALTA SI ES IGUAL A 0 A VERIFICACION
        JMP cambio                        ;HACE UN SALTO A CAMBIO
        
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------         
cambio:  
             
        MOV SI,0h                         ;MUEVE EL REGISTRO SI A 0H
        MOV BX,Mensaje                    ;MUEVE EL REGISTRO BX A LA ETIQUETA MENSAJE                                                                           
        LOOP desplasamiento               ;UN CICLO EN DESPLAZAMIENTO 
        
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------    
ayuda:   
        MOV CL,movidas                    ;MUEVE EL REGISTRO CL A LA ETIQUETA MOVIMIENTOS
        MOV movidas,0h                      ;MUEVE MOVIMIENTOS A 0H
        
        MOV Polinomio,DX                  ;MUEVE POLINOMIO AL REGISTRO DX
        SHR Polinomio,CL                  ;DESPLAZA EL OPERADOR DE LA IZQUIEDA DE LA ETIQUETA POLINOMIO A REGISTRO CL
        
        MOV CX,polinomio                  ;MUEVE EL REGISTRO CX A POLINOMIO
        XOR Mensaje,CX                    ;HACE DISYUNDACION DE LOS OPERADORS DE LA ETIQUETA MENSAJE AL REGISTRO CX
       
        JMP MVRC-algoritmo                ;SALTA A LA FUNCION MVRC
        
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------
desplasamiento: 

        SHL BX,1                          ;DESPLAZA EL OPERADOR A LA IZQUIEDA 1 AL REGISTRO BX
        JC ayuda                          ;SALTA LA CONDICIONAL AYUDA
                  
        INC SI                            ;INCREMENTA AL REGISTRO SI
        INC movidas                       ;INCREMENTA A MOVIMIENTOS           
        JMP desplasamiento                ;SALTA HACIA LA FUNCION DESPALSAMIENTO

;--------------------------------------------------------------------------------------------------------------------------------------------------------------------
verificacion:  
        
        MOV CX,Mensaje                    ;MUEVE EL REGISTRO CX A MENSAJE
        AND CX,0000000000000111b          ;CONJUNCION DE OPERADORES EN CX CON EL VALO HECADECIMAL
        CMP CX,0h                         ;COMPARA EL OPERADOR DEL REGISTRO CX CON 0H
        JE  salida                        ;SALTA SI ES IGUAL A 0 A LA SALIDA
        
        INC DI                            ;INCREMENTA EL REGISTRO DI
        CMP DI,01h                        ;
        JA  error                         ;SALTA SI ES QUE LA BANDERA ESTA DESACTIVADA VA A ETIQUETA ERROR
            
        MOV CX,Mensaje                    ;MUEVE EL CONTENIDO DE CX AL MENSAJE
        MOV PolinomioResultado,CX         ;MUEVE LO QUE TIENE POLINOMIORESULTADO AL REGISTRO CX
        MOV CX,MensajeUnic                ;MUEVE LO QUE TIENE CX AL MENSAJEUNICO
        OR  CX,PolinomioResultado         ;COMPRAR SI ES MAYOR O IGUAL QUE EL REGISTRO CX Y EL REGISTRO POLINOMIORESULTADO
        
        MOV Mensaje,CX                    ;MUEVE LO QUE TIENE MENSAJE AL REGISTRO CX
                                          
        JMP MVRC-algoritmo                ;SALTA HACIA LA FUNCION MVRC 
          
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------                               
salida:
        .exit                             ;SALE 
                     
;--------------------------------------------------------------------------------------------------------------------------------------------------------------------       
error:  
        AND Mensaje,0h                    ;CONJUNCION DE OPERADORES EN MENSAJE
        AND MensajeUnic,0h                ;CONJUNCION DE OPERADORES EN MENSAJEUNICO
        AND Polinomio,0h                  ;CONJUNCION DE OPERADORES EN POLINOMIO
        AND PolinomioResultado,0h         ;CONJUNCION DE OPERADORES EN POLINOMIORESULTADO
        .exit                             ;SALE
