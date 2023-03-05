TITLE "metodo de la burbuja -ordenado de mayor a menor-"
.MODEL SMALL ;Definicion del tipo de memoria
.STACK 100h  
    ;Segmento de Pila
.DATA     
    ;Segmento de Datos
    vec DB 60d, 26d, 33d, 40d    ;asignamos numeros al vector
    tam equ $-vec  ;obtenemos el tamaño del vector   
.CODE        
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA
        MOV DS,AX
        ;-------------------------
        ;-------Codigo-----------
ini:        
        MOV BX, tam;guardamos nuestro tamaño en BX
        DEC BX  ;decrementamos DX                            
        MOV SI, 0 ;guardamos la pocicion inicial del vector SI
        MOV DI, 1 ;guardamos la pocicion final del vector SI
compare:
        MOV CH, vec[SI] ;guardamos en un "auxiliar" el valor de la pocicion de SI del vector
        MOV CL, vec[DI] ;guardamos en un "auxiliar" el valor de la pocicion de DI del vector
        CMP BX, 0  ;compara el tamaño de nuestro vector y 0
        JE fin     ;si es 0 el tamaño termina el codigo              
        CMP CH, CL ;compara el numero en CH y el de CL                 
        JB  ciclar ;si el de la izquierda es menor brinca a JB
        MOV vec[SI], CL ;almacena en la pocicion SI lo que tiene CL en este caso DI
        MOV vec[DI], CH ;almacena en la pocicion DI lo que tiene CH en este caso SI
        CMP BX, 0  ;compara si BX es igual a 0
        JE fin     ;si lo es bringa al final
        JMP ini    ;si no bringa al inicio
ciclar:
        INC DI ;incrementa la pocicion DI
        INC SI ;incrementa la pocicion SI
        DEC BX ;decrementa la pocicion DI                             
        JMP compare ;brinca al compara
fin:
   MAIN ENDP ;termina el programa