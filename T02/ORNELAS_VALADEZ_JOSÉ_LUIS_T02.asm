TITLE "VERIFICACION DE REDUNDANCIA CICICLA"
 
  
;Ornelas_Valadez_Jose_Luis_Tarea2
                       
                     
.MODEL SMALL
.STACK 100h     
.DATA
           
           
;VARIABLES DEL PROGRAMA
    
    MENSAGE DW 1101001110110000b                 ;MENSAJE QUE OCUPA 16 BITS 
    MENSAGETWO DW 1101001110110000b              ;UILIZADO COMO UN RESPALDO DEL MENSAJE DE 16 BITS
     
    POLINOU DW 1011000000000000b                 ;POLINOMIO DE DIVISOR
    BANDERA DW 0                                 ;VERIFICACION DE BANDERA (SI NO EXISTE ALGUN ERROR)    
    VERIFI_NUEVA DW 0                            ;ESTE SE DARA EN CUANDO LA VERIFICACION NUMERO UNO TERMINE                               

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;MAIN

.CODE
        
   MAIN PROC                                     ;MAIN DEL CODIGO
        MOV AX,@DATA                             ;INICIA A DS CON EL VALOR DE DIRECCION
        MOV DS,AX                                ;CALCULADA POR LA DIRECCION EN LA ETIQUETA
        MOV AX,MENSAGE                           ;MOVEMOS EL CONTENIDO DEL REGISTRO DE AX A ETIQUETA MENSAJE  
        MOV BX,POLINOU                           ;MOVEMOS EL CONTENIDO DEL REGISTRO DE BX A ETIQUETA POLINOU
        MOV DX,1000000000000000b                 ;MOVEMOS EL CONTENIDO DEL REGISTRO DE DX PARA HACER UN ENMASCARAMIENTO
        MOV CX,16                                ;MOVEMOS EL CONTENIDO DEL REGISTRO DE CX PARA HACER UN CONTADOR HASTA EL 16

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
;PROCEDIMIENTOS:

        VERIFI_REDU:
        
            MOV AX,MENSAGE                       ;MOVEMOS EL CONTENIDO DE REGISTRO AX A MENSAJE         
            AND AX,DX                            ;HACE UN ENMASCARAMIENTO CON EL REGISTRO AX Y DX 
            CMP AX,DX                            ;COMPARA AMBOS REGISTROS           
            JE DIV_POLINOU                       ;SI SON IGUALES SALTA A DIV_POLINOU        
            JMP CAMINO                           ;SALTA A EL APARTADO DE CAMINO
            

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------              
        VERIFI_NUEVA:                       
                       
            MOV AX,MENSAGETWO                    ;MOVEMOS EL CONTENIDO DE REGISTRO AX A MENSAJETWO
            ADD MENSAGE,AX                       ;SUMA EL CONTENIDO DE ETIQUETA AL REGISTRO AX
            MOV CX,16                            ;EL CONTADOR SE IRA A REINICIAR
            MOV BX,POLINOU                       ;MOVEMOS EL CONTENIDO DE REGISTRO BX A LA ETIQUETA
            MOV DX,1000000000000000b             ;SE REINICIARA EL CONTENIDO DEL REGISTRO DX CON EL VALOR HEXADECIMAL 
            CMP VERIFI_NUEVA,0                   ;COMPARA LA BANDERA A 0
            JE VERIFICADO_NC                     ;SI ES CERO, ENTONCES PARA A LA ETIQUETA
            JA ERROR                             ;SI SE VERIFICO Y DAA DIFERENTE ENTONCES MARCA ERROR                                                     


;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
        CAMINO:
        
            SHR BX,1                             ;RECORREMOS UN BIT AL REGISTRO BX
            SHR DX,1                             ;RECORREMOS UN BIT AL REGISTRO DX                  
            LOOP VERIFI_REDU                     ;CICLA LA ETIQUETA 
            CMP MENSAGE,0                        ;COMPARA EL VALOR QUE TIENE MENSAJE CON EL CERO
            JE VERIFICADO                        ;SI ES IGUAL SALTA A LA ETIQUETA 
            JA VERIFI_NUEVA                      ;SI ES MAYOR SALTA AL A ETIQUETA                     


;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        DIV_POLINOU: 
        
            MOV AX,MENSAGE                       ;MUEVE EL CONTENIDO DEL REGISTRO AX A LA ETIQUETA
            XOR AX,BX                            ;DIVISOR ENTRE REGISTROS
            MOV MENSAGE,AX                       ;MUEVE EL CONTENIDO DE EQUITE AL REGISTRO AX  
            JMP RECORRER                         ;SALTA A LA ETIQUETA
            

;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------            
        VERIFICADO:                              ;VERIFICACION PARA EL APARTADO DE LA BANDERA
            ADD BANDERA,1                        ;AGREGA A LA ETIQUETA PARA VERIFICAR SI ES POSITIVA O NO EXISTE ERROR ALGUNO
            .EXIT                                ;TERMINA O SALE

            
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
        VERIFICADO_NC:                           ;SI NO SE ACTIVA, ACTIVARA LA SIGUIENTE VERIFICACION DENTRO DEL PROGRAMA
            ADD VERIFI_NUEVA,1                   ;ACTIVA LA ETIQUETA DE VERIFICACION NUEVA
            LOOP VERIFI_REDU                     ;CICLA LA ETIQUETA                         
            
            
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------                          
        ERROR:                                   ;ETIQUETA DE ERROR CUANDO LA BANDERA SE QUEDA EN CERO
            .EXIT                                ;TERMINA O SALE
             

MAIN ENDP                                        ;TERMINA EL MAIN DEL PROGRAMA
END MAIN                                         ;TERMINA EL PROGRAMA