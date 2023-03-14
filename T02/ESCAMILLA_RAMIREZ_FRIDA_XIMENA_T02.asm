TITLE "Tarea 02"

;Autor:Frida Ximena Escamilla Ramirez
;Fecha:13 Marzo 2023
;Descripcion del Programa: 
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   wordm DW 1011001010011000b
   wordd DW 1011000000000000b
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------

       MOV CX, 12       ;cargar 12 a cx para iniciar el ciclo  
       MOV AX, wordm    ;cargar en ax lo que hay en wordm
       MOV BX, wordd    ;cargar en bx lo que hay en wordd
        
       ciclo:   ;etiqueta del inicio del ciclo
            
           XOR AX, BX    ;codifica lo que hay en ax y bx  
           MOV wordm, AX ;cargar lo que hay en ax en wordm
           OR AX, BX     ;or entre ax y bx, si cualquiera 
           MOV wordm, AX ;cargar lo qye hay en ax a wordm  
           SHR BX, 1     ;realizar 1 shift 
           MOV wordd, BX ;cargar en wordd lo que hay en bx     
           LOOP ciclo    ;repetir las instrucciones en ciclo  
    
       XOR AX, BX        ;repetir xor entre ax y bx
       AND AX, 111b      ;realizar and y se almacenara en ax
       MOV wordm, AX     ;cargar en wordm lo que hay en ax   
       
               
   MAIN ENDP

   
;-------Procedimientos-----


;--------------------------

END MAIN ;Fin del Programa