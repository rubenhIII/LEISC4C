TITLE "Plantilla del programa"

;Autor:
;Fecha:
;Descripcion del programa 
COMMENT !
 
!
.MODEL SMALL  ;Definicion del tipo de memoria

.STACK 100h         
    ;segmento de pila  
.DATA
   ;Segmento de pila
   size EQU 7d ; aqui va el numero hasta el cual queremos hacer el factorial
   serie Dw 0; en la DW es donde se almacenara nuestro resultado 
   
.CODE
 ;Segmento de Codigo
    MAIN PROC ;Procedimiento Principal
    ;Inicializacion de Segmento
    ;de codigo
    MOV AX, @DATA
    ;MOV AX, 0
    MOV DS, AX
             
;-----------------------------------
;-------------Codigo-------------------
    MOV SI, size ;es un contador
    MOV DI,size-1 ;DI se inicizaliza y size-1
    
    MOV CX, size ;Se guarda el numero con que queremos hacer la serie del factorial
    MOV DX, size ; DX se inicializa  
    
    fun1:
    
    CALL fact ;aqui llamamos a fact   
    MOV DX,serie ;el resultado se guarda en DX
    MOV CX, DX ; aqui se copea el resultado 
    
    CMP SI,1 ;aqui se hace una instruccion de paro, para poder saber cuando se detendra
    JA fun1 ;si SI > 1 las operaciones se seguiran realizando
    JE fin ;si SI = 1 aqui se terminara el ciclo
    
    fin:
    .exit ; fin de programa
   
    MAIN ENDP  

;-----------Procedimiento--------------
    fact PROC
    MOV AX, CX ; guarda el 1er valor que se quiere multiplicar
    MOV BX,DI; aqui guarda el 2do val, porque este se multiplicara por el 1er
    MUL BX ; aqui se hace la multiplicacion
       
    DEC SI ;se decrementa SI para comparar   
    DEC DI ;se descrementa DI 
    
    MOV serie, AX   aqui se mueve el resultado de la multiplicacion
              
    RET
    fact ENDP

;------------------------
END MAIN