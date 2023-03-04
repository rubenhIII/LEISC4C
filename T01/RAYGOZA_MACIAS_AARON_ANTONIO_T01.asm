include emu8086.inc
TITLE "IMetodo de la Burbuja"

;Autor: Aaron Raygoza 
;Fecha: 04-03-23
;Descripcion del Programa: Metodo de la burbuja en Ensamlador
COMMENT !
--------------------------
!  

;Definicion del tipo de memoria
.MODEL SMALL                 
;Segmento de Pila       
.STACK 100h                             
;Segmento de Datos
.DATA                               
   ;Variables 
   tam equ 9h
   vec db 1,9,6,7,9,5,7,8,2  
   aux db 0h    

;Segmento de Codigo   
.CODE  

;Procedimiento Principal    
   MAIN PROC 
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------  
        
;-------Codigo-----------
 
   mov SI,0  
   
   for1: 
       inc si    
       mov bl,tam  
       mov bh,0 
       dec bx
       mov cx,bx
       mov di,0
       cmp si,tam-1 
       jle for2
       .exit
            
   for2: 
        inc di   
        cmp cx,di
        jle for1 
        mov al,vec[DI]
        cmp vec[DI+1],al
        jle movVec  
        cmp di,cx
        jle for2 
        
        
   movVec:
        mov ah,vec[di] 
        mov aux,ah
        mov ah,vec[di+1] 
        mov vec[di],ah
        mov ah,aux
        mov vec[di+1],ah 
        jmp for2
        
   MAIN ENDP
   
;-------Procedimientos-----

             

;--------------------------

END MAIN ;Fin del Programa
