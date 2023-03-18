include emu8086.inc
TITLE "Factorial"

;Autor: Aaron Raygoza 
;Fecha: 13-03-23
;Descripcion del Programa: Factorial con Recursividad
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
   num equ 7h
   res dw  1h


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
   mov si,1
   mov cx,0
   
   call factorial
   
   mov ax,04Ch
   int 21h
      
   MAIN ENDP
   
;-------Procedimientos-----
  
   factorial proc
   
   mov ax,res
   mov bx,si
   mul bx
   mov res,ax
   inc cx
   inc si
   
   cmp cx,num
   je  salir
   
   call factorial
    
   salir: 
   ret
   factorial endp   
;--------------------------

END MAIN ;Fin del Programa
