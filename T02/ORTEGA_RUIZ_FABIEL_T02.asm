;FABIEL ORTEGA RUIZ 4C
;"ALGORITMO CRC"

.MODEL SMALL ;Se define el tipo de memoria

.STACK 100h ;Pila 
    
.DATA
    Dato1 DW 1101001110110000b ;Dato de bits 
    Dato2 DW 1101001110110000b 
    Division DW 1011000000000000b ;
     
    Comprueba1 DW 0 ;Inicia en uno            
        
    Conjunto DW 0   ;Verificacion
    
    
.CODE
   MAIN PROC
        MOV AX,@DATA
        MOV DS,AX 


        MOV AX,Dato1 ;Dato1 es enviado a AX
        MOV BX,Division ;Division se manda a BX 
        MOV DX,1000000000000000b ;Alamcena
        MOV CX,13 ;Timer de 13 bits

        Comprobacion:
        
            MOV AX,Dato1 ;Envia el Dato1 a AX        
            AND AX,DX ;Bits en cero
            CMP AX,DX ;Compara AX y DX         
            JE Divisionn      
            JMP mueve ;Etiqueta saltada                                         
        
        Divisionn: 
        
            MOV AX,Dato1 ;Guarda Dato1 en AX 
            XOR AX,BX ;Particiona el dato
            MOV Dato1,AX ;Se alamacena el Dato1
            JMP mueve ;Etiqueta saltada     
            
        mueve:
        
            SHR BX,1 ;Mueve un bit a BX
            SHR DX,1 ;Mueve un bit a DX                
            LOOP Comprobacion ;Etiqueta retornando
            CMP Dato1,0 
            JE VERIFICADO 
            JA Comprobacionn2           
            
        Comprobacionn2:                    
                       
            MOV AX,Dato2 ;Se registra el Dato2 a AX
            ADD Dato1,AX ;Se envia el Dato1 a AX
            MOV CX,13 
            MOV BX,Division ;Se guarda Division en BX
            MOV DX,1000000000000000b 
            CMP Comprueba1,0 
            JE VERIFICACION_NULA 
            JA error            
        
        VERIFICACION_NULA: 
            ADD Comprueba1,1 
            LOOP Comprobacion ;Retorna la etiqueta                         
            
        VERIFICADO: 
            
            ADD Conjunto,1 
            .EXIT        
                          
       error: ;En caso de error es cero
         
            .EXIT 
                     
    MAIN ENDP
END MAIN 
