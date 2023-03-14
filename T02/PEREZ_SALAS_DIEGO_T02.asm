TITLE "VERIFICACION DE REDUNDANCUA CICLICA"
;Autor:Diego Perez Salas
;Fecha:12/03/2023
;Descripcion del programa:CRC
;------------------------------------------------

.MODEL SMALL ;Definicion de memoria

.STACK 100h ;Segmento de Pila
    
.DATA ;Segmento de Datos
    opc DW 1101001110110000b ;Datos de 13 Bits
    opc2 DW 1101001110110000b 
    division1 DW 1011000000000000b
    
    Ver2 DW 0 ;Condicion para activar la segunda bandera
    
    Fam2 DW 0          ;Validacion

.CODE  ;Segmento de Codigo
   MAIN PROC 
        MOV AX,@DATA
        MOV DS,AX
;------------------------
        
        MOV AX,opc ;Opc se dirige a AX
        MOV BX,division1 ;Division se dirige a AX
        MOV DX, 1000000000000000b ;Valor del almacenamiento
        MOV CX,13 ;Contador de bits
        
        Ver_uno:
            MOV AX, opc
            AND AX,DX ;Al valor 0
            CMP AX,DX ;Compara los registros
            JE division ;Salto a la etiqueta
            JMP desplazamiento
            
        division:
            MOV AX, opc;Registro en AX
            XOR AX,BX ;Division del mensaje
            MOV opc,AX ;Realiza el ajuste o actualizacion del registro
            JMP desplazamiento 
            
        desplazamiento:
            SHR BX,1 ;Desplaza 1 bits
            SHR DX,1 ;Desplaza 1 bits
            LOOP Ver_uno ;Se realizan ciclos
            CMP opc,0
            JE VERIFICADO
            JA Ver_dos
        
        Ver_dos:                    
                       
            MOV AX,opc2 ;Escribe el dato
            ADD opc,AX 
            MOV CX,13 ;Contador vuelve a iniciar
            MOV BX,division1 
            MOV DX,1000000000000000b 
            CMP Ver2,0 
            JE Verificacion_ERROR 
            JA error            
        
        VERIFICACION_ERROR:  
            LOOP Ver_uno                         
            
        VERIFICADO: 
            
            ADD Fam2,1 
            .EXIT           
                          
       error: ;Si se tienen errores pondremos el 0
         
            .EXIT 
                     
    MAIN ENDP

END MAIN ;Fin del programa