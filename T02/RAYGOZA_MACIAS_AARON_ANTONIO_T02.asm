include emu8086.inc
TITLE "Redundancia Ciclica"

;Autor: Aaron Raygoza 
;Fecha: 13-03-23
;Descripcion del Programa: Calculo CRC
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
   msg dw 1101001110110000b 
   dib dw 1011000000000000b
   pol dw 0000000000001110b  
   res dw 1101001110110000b


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
   mov cx,12
   jmp p1 
      
   MAIN ENDP
   
;-------Procedimientos-----
  
    
    
  p3:
    inc cl
    mov pol,ax
    shl ax,1 
    cmp pol,ax
    jnb p3
    ret 
    
    
  p1:
    mov ax,res
    xor ax,dib
    mov res,ax
    mov bx,cx
    mov cx,0
    call p3
    shr dib,cl
    mov cx,bx
    
  loop p1 
  
  p2:
    mov ax,msg
    mov pol,0Eh
    mov ax,pol
    xor ax,dib
    mov msg,ax 
      
;--------------------------

END MAIN ;Fin del Programa

;No lo entendi del todo