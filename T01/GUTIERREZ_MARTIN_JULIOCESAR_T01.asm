TITLE "String Reverse"

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!
  ;tarea=checar un array de caracteres copia invertirlo
.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
  
      
;////
   text1 DB 'Hello world'
   text2 DB 13 dup(?) 
   count DW 13
;////  
  
.CODE
  
        
       
        
begin:  MOV AX,@DATA
        MOV DS,AX 
        MOV ES,AX;NUEVO 
        
        MOV CX,count ;CX=13
        MOV SI,0;source index
        MOV DI,0;destination index
        ADD DI,count
        DEC DI
        
again:  MOV AL,text1[SI]
        MOV text2[SI],al 
        inc SI
        dec DI
        loop again
        
        
        mov AH,4ch;service number  
        int 21h -  ;exit to DOS
        
        end begin
        
        
        
        

