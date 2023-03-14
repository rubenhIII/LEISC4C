TITLE " VERIFICACION DE REDUNDANCIA  CICLICA "
;Autor: Emiliano Jahir Espinoza Herrera
;Fecha: 12/03/2023
;Descripcion del Programa:  REDUNDANCIA  CICLICA CRC
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    Mensaje1 DW 1101001110110000b ;MENSAJE CON 13 BITS 
    Mensaje2 DW 1101001110110000b 
    Polimonio DW 1011000000000000b ;  EL MENSAJE QUE SE DIVIDE 
     
    Verificacion2 DW 0 ;SE INICIARA LA BANDERA EN CUANTO SE VERIFIQUE EL UNO              
        
    Fam2 DW 0            ;SE INICIARA LA BANDERA CUANDO UNA VEZ TERMINE LA VERIFICACION 
    
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;PROCEDIMIENTO  DEL MAIN 
        MOV AX,@DATA
        MOV DS,AX 
;-------Codigo-----------

        MOV AX,Mensaje1 ;SE COLOCA EL  MENSAJE  EN NUESTRO REGISTRO AX   
        MOV BX,Polimonio ;SE COLOCA POL EN NUESTRO REGISTRO  AX 
        MOV DX,1000000000000000b ;SE PONE EL VALOR PARA EL ALMACENAMIENTO 
        MOV CX,13 ;EL CONTADOR CONTARA HASTA  13 BITS 

        VerificacionR:
        
            MOV AX,Mensaje1 ;COLOCA  EL MENSAJE AL REGISTRO AX         
            AND AX,DX ;SE HACE LOS BITS A AL VALOR 0
            CMP AX,DX ;COMPARA NUESTROS 2 REGISTROS AX Y DX           
            JE Division  ;SALTO  DE LA ETIQUETA       
            JMP recorre ;IGUAL SALTA LA ETIQUETA                                          
        
        division: 
        
            MOV AX,Mensaje1 ;ALMACENA EL MENSAJE EN EL REGISTRO AX 
            XOR AX,BX ;DIVIDE EL MENSAJE 
            MOV Mensaje1,AX ;GUARDA LA MODIFICACION DEL MENSAJE  
            JMP recorre ;SALTA LA ETIQUETA       
            
        recorre:
        
            SHR BX,1 ;RECORRE SOLO 1 BITS EN EL REGISTRO BX
            SHR DX,1 ;RECORRE SOLO 1 BITS EN EL REGISTRO DX                 
            LOOP VerificacionR ;VA CICLANDO LA ETIQUETA  
            CMP Mensaje1,0 
            JE VERIFICADO 
            JA Verificacion_dos           
            
        Verificacion_dos:                    
                       
            MOV AX,Mensaje2 ;REGISTRA EL MENSAJE 2 AL REGISTRO AX
            ADD Mensaje1,AX ;ACUMULA EN MENSAJE 2 AL REGISTRO AX
            MOV CX,13 ;EL CONTADOR SE INCIA DE NUEVO 
            MOV BX,Polimonio ;ALMACENA EL MESNAJE DEL POL AL REGISTRO BX
            MOV DX,1000000000000000b 
            CMP Verificacion2,0 
            JE VERIFICACION_NO_CONCLUIDA 
            JA error            
        
        VERIFICACION_NO_CONCLUIDA: 
            ADD Verificacion2,1 
            LOOP VerificacionR ;SE CICLA LA ETIQUETA VERIFICACION_DE_REDUNDANCIA                          
            
        VERIFICADO: 
            
            ADD Fam2,1 
            .EXIT            ;SE SALE DE PROGRAMA
                          
       error: ;SI HAY ERRORES SE PONE EL  0
         
            .EXIT 
                     
    MAIN ENDP
;--------------------------

END MAIN ;FIN DEL PROGRAMA 
