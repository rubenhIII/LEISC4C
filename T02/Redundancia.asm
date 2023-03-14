#fasm# 
;Sebastian Rodriguez Hernandez 


COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
    MSG DW 1101001110110000b ;Mensaje
    MSG2 DW 1101001110110000b ;Mensaje de 16  bits
    POL DW 1011000000000000b ;Polinomio divisor   


section .data
    data db 0x3f
    parity db 0      ; Inicia la paridad en 0

section .text
    global _start

_start:
    ; Contador
    MOV bl, [data] ; Carga el dato
    XOR bh, bh     ; Limpia BH
    XOR al, al 
    MOV cl, 8      ; Contaodr
count_loop:
    shr bl, 1      ; shift the data byte right by one bit
    adc al, 0      ; agrga la bandera
    loop count_loop

    ; Calculo de paridad
    MOV dl, al     ; mueve a DL
    and dl, 1      ; enmascaramiento
    jz even_parity ; Cindicion para la paridad
    MOV byte [parity], 1 ;

even_parity:

    ; Muestra datos y paridad
    MOV eax, 3 
    MOV ebx, 1     ; descripcion 
    MOV ecx, data  ; puntero al dato
    MOV edx, 1     ; longitud de datos
    int 0x80

    MOV eax, 3    
    MOV ebx, 1
    MOV ecx, parity ; puntero al bit de paridad
    MOV edx, 1
    int 0x80

    ; Salida
    MOV eax, 1     ; llamada a la salida
    XOR ebx, ebx   ; salida
    int 0x80
    
    