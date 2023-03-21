TITLE "factorial"

;Autor:  Julio Cesar Gutierrez Martin
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!
  
.MODEL SMALL ;Definicion deltipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
  
      
;////
  
   resultado dw 1;una variable donde siempre guardar el resultado y para empezar la multiplicacion, por eso esta en 1
   n  EQU 6 ;aqui se pone de que numero se quiere el factorial
   i dw 1 ;como un contador
  
;////  
  
.CODE      
        MOV AX,@DATA
        MOV DS,AX 
        MOV ES,AX;NUEVO  
       mov cx,n-1   ;aqui se pone la condicion de paro que es cx, que siempre se va a repetir mi procedimiento el numero que se quiere factorial menos 1
      
           
main PROC   ;main
       
      call factorial ;se llama la funcion
      mov ax, 04Ch;interrupcion
      int 21h 
        
    main ENDP 


factorial PROC 
     inc i  ;cada vez que se ejecuta factorial se incrementa para despues ser multiplicado por resultado
     mov ax,i
     mov bx, resultado
     mul bx
     mov resultado,ax
     
     dec cx ;aqui se decrementa cx para que se cumpla la condicion de paro
     cmp cx, 0
     je return
     CALL factorial  ;se llama recursivamente con el incremento de i y el decremento de cx para que se ejecute correctamente
return: 
    RET
    factorial ENDP 
   
         

        
    
        
        
        
        
        
        
        

