#fasm#

       TITLE "Plantilla de Programa"

;Autor: SRH
;Fecha: 20-03-23

COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
   
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo        
        
        MOV AX,@DATA
        MOV DS,AX                   
        
;-------Codigo-----------
        
        MOV CX, 0 
                
   ENCODE:               
        ; Procedimiento
        MOV eax, 4
        MOV ebx, 1
        MOV ecx, msg
        MOV edx, 16
        INT 0x80  
        
        
        
        MOV eax, 3
        MOV ebx, 0
        MOV ecx, num
        MOV edx, 2
        MOV 0x80
        
    
        MOV eax, 0
        MOV bl, [num]
        SUB bl, '0'
        MOV cl, [num+1]
        SUB cl, '0'
        MOV ebx, eax
        MOV eax, ecx
        shl ebx, 1
        add eax, ebx
        
        ; llamada a la factorial
        push eax
        call factorial                
        
        
   EXIT:
              
   MAIN ENDP
   
;-------Procedimientos----- 


        MOV eax, 4
        MOV ebx, 1
        MOV ecx, result_msg
        MOV edx, 22
        push dword [num]
        push eax
        call printf
        add esp, 8 
        
        
        MOV eax, 1
        XOR ebx, ebx
        INT 0x80   
        
        ;Factorial
        
        CMP dword [esp], 0
        je .done
        CMP dword [esp], 1
        je .done

        dec dword [esp]
        push dword [esp]
        call factorial

        MOV ebx, dword [esp+4]
        imul ebx, dword [esp]
        MOV dword [esp], ebx  
        
        .done:
        RET

;--------------------------

END MAIN ;Fin del Programa  
    