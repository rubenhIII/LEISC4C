TITLE "Bubble Sort"

;Autor:
;Fecha:
;Descripcion del Programa:
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
           
.DATA
    ;Segmento de Datos
    VecByte DB 0FFh, 0AAh, 008h, 001h, 0AFh, 01Ah, 0CDh, 088h
    count = ($-VecByte)
   
.CODE
    ;Segmento de Codigo     
    
    MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo  
            
        MOV AX, @DATA
        MOV DS, AX 
;-------Codigo-----------        
        mov bx,count-1
        mov di, 0
        mov si, 0

loop2:  ;inicio del loop donde se comparan las posiciones del vector
        mov ah, vecbyte[0][si]
        mov al, vecbyte[0][si + 1]
        cmp ah, al
        ja swap
        jmp cmploop
        
swap:   ;realiza el intercambio de los valores.
        mov dh,ah
        mov ah,al
        mov al,dh                
        
        mov vecbyte[0][si], ah
        mov vecbyte[0][si + 1], al

cmploop:;maneja el ciclo del loop
        add si,1
        mov cx,bx
        sub cx,di
        
        cmp si,cx
        jb loop2
        mov si,0
        add di,1
        cmp di,bx
        jb loop2
        
    MAIN ENDP
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa