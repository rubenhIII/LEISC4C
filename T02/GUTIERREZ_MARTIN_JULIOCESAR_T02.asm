COMMENT !
--------------------------
!
 
.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
  
      
;////
    msg dw 1001110110000000b
    poli dw 1011000000000000b  
    count dw 13
    
;////  
  
.CODE
         
begin:   MOV AX,@DATA
        MOV DS,AX 
        MOV ES,AX;NUEVO 
        mov ax,poli
        
         mov cx, count
aqui:   xor msg,ax   
shift:   
        shl msg,1
        jnc shift 
        shr msg,1
        or msg,1000000000000000b
        
        loop aqui
        
        
        mov AH,4ch;service number  
        int 21h -  ;exit to DOS
        
        end begin
        
        
        
        

