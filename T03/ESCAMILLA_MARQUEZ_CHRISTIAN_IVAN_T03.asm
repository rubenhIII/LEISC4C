TITLE "Plantilla de Programa"

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
   Fact DW 5 ;Numero del que queremos el factorial
   Res DW 0 
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento
        ;de Codigo
        MOV AX,@DATA
        MOV DS,AX 
        ;-------------------------
;-------Codigo-----------
        
        MOV AX, 0  ;Cargamos a AX un cero
        MOV BX, 0  ;Cargamos a BX un cero
        MOV DX, 1  ;Cargamos a DX un uno ya que ahi se va a multiplicar el resultado entonces no puede ser 0
        JMP inicio ;Saltamos a inicio
        
        
   MAIN ENDP
   
;-------Procedimientos-----
 inicio:
        CALL factorial ;Llamamos a la etiqueta factorial
        CMP Fact, 1    ;Comparamos si el valor factorial es 1 ya que no puede ser 0
        je fin         ;Si es uno acabamos el programa
        DEC Fact       ;Si no decrementamos en uno la variable Fact
        JMP inicio     ;Loop
        
        
factorial: 
        MOV AX, Fact    ;Movemos a AX lo que tiene Fact ya que ahi se verá reflejado el resultado
        MUL DX          ;Multiplicamos lo que tiene AX por lo que tiene DX, al principio será por uno, despues será por el resultado almacenado
        MOV DX, AX      ;Le cargamos a DX el resultado
        MOV Res, AX     ;Observamos el cambio en la variable
        RET             ;Regresa de donde fue llamado
fin:
;--------------------------

END MAIN ;Fin del Programa