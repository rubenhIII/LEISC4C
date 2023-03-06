TITLE "Metodo de la burbuja"

;Autor: Zuriel Said Zuniga Delgadillo
;Fecha: 05/03/2023
;Descripcion del Programa: Metodo de la burbuja
COMMENT !
--------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA
    ;Segmento de Datos
   Var1 DB  01h, 04h, 05h, 08h, 02h, 07h, 06h, 03h, '$'  ;vector 
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        ;Inicializacion de registros
        MOV SI, 00h
        MOV DI, 00h
        MOV CX, 00h 
        print 'Vector desordenado: ' 
impr1:   
        cmp Var1[SI], '$'   ;compara si es el final del vector
        je cont             ;si es el final del vector salta a cont
        print '('           
        mov ah, 02h         ;funcion que imprime un caracter en pantalla
        mov DL, Var1[SI]    ;mueve a DL lo que hay en Var1[SI]
        add DL, 30h         ;se agrega 30h para que coincida el numero con su codigo ASCII
        int 21h             ;imprime en pantalla el caracter
        add SI, 1           ;incrementa en 1 a SI
        print ') '          
        jmp impr1           ;loop
                                 
         
         
cont:   ;contador de elementos en el vector
        cmp Var1[DI], '$'
        je  agr   ;si es el ultimo elemento salta a agr
        inc CX    ;si no, incrementa CX
        inc DI    ;incrementa DI
        jmp cont  ;regresa a "cont" con un salto, asi incrementa DI

agr: 
        MOV AX, CX  ;cargamos a AX lo que hay en CX
        MOV BX, CX  ;cargamos a BX lo que hay en CX
        MUL BX      ;multiplicamos el registro AX por el registro BX (tecnicamente seria CX al cuadrado, esto para simular 
                    ;los dos ciclos for del metodo de la burbuja)
        MOV CX, AX  ;cargamos a CX el resultado de la multiplicacion 
        MOV AX, 00h ;le ponemos valor de 0 a AX
        MOV BX, 00h ;le ponemos valor de 0 a BX
        MOV DI, 00h ;le ponemos valor de 0 a DI
        MOV SI, 00h ;le ponemos valor de 0 a SI
        jmp ord
ord:
        MOV AL, Var1[DI]    ;pasamos a AL lo que hay en Var1 en su posicion DI
        MOV BL, Var1[DI+1]  ;pasamos a BL lo que hay en Var1 en su posicion DI
        cmp Var1[DI], '$'   ;comparamos si es el final del vector
        je val              ;en dado caso que si brinca a val
        cmp AL, BL          ;sino compara los valores entre AL y BL
        jg may              ;si AL > BL entra a may
        cmp CX, 01h         ;sino compara CX con 0
        je fin              ;si CX es 0 entra a fin
        inc DI              ;sino incrementa DI
        loop ord            ;decrementa en 1 CX y hace loop  
        
may:    ;aqui hace el metodo de ordenacion
        MOV BH, AL          ;mueve a BH(AUX) lo que hay en AL(Var1[DI])
        MOV Var1[DI], BL    ;mueve a Var1[DI] lo que hay en BL(Var1[DI+1]
        MOV Var1[DI+1], BH  ;mueve a Var[DI+1] lo que hay en BH(AUX)
        inc DI              ;incrementa en uno DI
        MOV BX, 00h         ;le da el valor de 0 a BX
        MOV AX, 00h         ;le da el valor de 0 a AX
        jmp ord             ;regresa a ord
val: 
        MOV DI, 00h         ;le mueve a DI el valor de 0
        jmp ord             ;regresa a ord   

fin:
        printn              ;salto de linea
        print 'Vector ordenado: ' ;imprime a pantalla
        jmp impr                  ;salta a impr
impr:   
        cmp Var1[SI], '$'         ;compara si es el final del vector
        je salir                  ;si es el final sale del programa
        print '('                 
        mov ah, 02h               ;funcion que imprime un caracter en pantalla
        mov DL, Var1[SI]          ;mueve a DL lo que hay en Var1[SI]
        add DL, 30h               ;le agregamos un 30h (48 en decimal) para que coincida el numero con su codigo ASCII
        int 21h                   ;imprime en pantalla el caracter
        inc SI                    ;incrementa en 1 a SI
        print ') '                
        jmp impr                  ;loop

salir: 
        
   MAIN ENDP

END MAIN ;Fin del Programa
