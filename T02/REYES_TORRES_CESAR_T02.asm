     TITLE "Cyclic redundancy check"

;Autor: Cesar Reyes Torres
;Fecha: 11/03/23
;Descripcion del Programa: Implementacion de algoritmo para detectar
                         ; cambios accidentales en los datos (CRC)

COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos 
     
     ;constantes
    
     ;variables     
    Message       DW 1101001110110000b    ;16 bits   ultimos tres poli.
    Polynomial    DW 1011000000000000b    ;16 bits
                  
    MessageOrig   DW 0h     ;Almacena el Mensaje Original
    PolynomResult DW 0h     ;Almacena la codificacion obtenida
    
    moves         DB 0h     ;Auxiliar para obtener numero de desplazamientos
   
.CODE  ;Segmento de Codigo
    
   MAIN PROC ;Procedimiento Principal
             ;Inicializacion de Segmento de Codigo  
        
        MOV AX,@DATA
        MOV DS,AX 
        
;-------Codigo-----------
        
        MOV CX,Message       
        MOV MessageOrig,CX  
        
        XOR CX,CX
        XOR SI,SI
        XOR DI,DI
      
        MOV DX,Polynomial    
        JMP CRC-algorithm   
                             
;-------Procedimientos----- 


CRC-algorithm:
        
        MOV AX,Message            
        AND AX,1111111111111000b  
        CMP AX,0h                 
        JE  Verification           
                   
        JMP shifting              
         
shifting:  
             
        MOV SI,0h                
        MOV BX,message      
       
        LOOP displacement  
        
   help:   
        MOV CL,moves        
        MOV moves,0h         
        
        MOV Polynomial,DX   
        SHR Polynomial,CL   
        
        MOV CX,Polynomial   
        XOR Message,CX      
       
        JMP CRC-algorithm   
        

displacement: 

        SHL BX,1                  
        JC help             
                  
        INC SI              
        INC moves           
        JMP displacement    


Verification:  
        
        MOV CX,Message
        AND CX,0000000000000111b 
        CMP CX,0h                
        JE  leave                
        
        INC DI     
        CMP DI,01h  
        JA  error  
            
        MOV CX,Message
        MOV PolynomResult,CX   
        MOV CX,MessageOrig     
        OR  CX,PolynomResult  
        
        MOV Message,CX         
        
        JMP CRC-algorithm      
                               
leave:
        .exit 
        
        
error:  
        AND Message,0h
        AND MessageOrig,0h
        AND Polynomial,0h 
        AND PolynomResult,0h 
        .exit
        
;-------------------------
       
   MAIN ENDP
   


END MAIN ;Fin del Programa