;Autor: MICHAEL GIOVANNY MIGUEL PADLLA
;Fecha: 05/03/2023
;Descripcion del Programa:
;Metodo Burbuja mismo que ordena un vector de numeros decimales
COMMENT!
------------------------
!

.MODEL SMALL ;Definicion del tipo de memoria

.STACK 100h
   ;Segmento de Pila 

.DATA
   ;Segmento de Datos 
   Vector_Datos DB 76d,40d,101d,12d,33d,1d;Elementos del vector en decimal 
   contador_cicloi DW 0 ;Conador del ciclo i
   contador_cicloj DW 0 ;Contador del ciclo j

.CODE
    ;Segmento de Codigo
   MAIN PROC;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA
        MOV DS,AX 
;-------------------------
;-------Codigo-----------
        MOV contador_cicloi,0;Al contador del ciclo i se le guarda un 0

ciclo_externoi:;Etiquea ciclo exernoi
    MOV contador_cicloj,0; Al contador del cicloj le coloca un 0   
    MOV SI,0;Al indice de origen le coloca un 0
       
 
comparar:;Etiqueta cmparar
    MOV AH,Vector_Datos[SI]; En AH se guarda lo que tiene el vector en la posicion SI
    MOV AL,Vector_Datos[SI+1];En AL se guarda lo que tiene el vector en la posicion SI+1
    CMP AH,AL;Comparador
    JG cambia_posi;Salta si lo que esta en AH es mayor que lo que esta en AL 
    

ciclo_internoj:;Etiqueta ciclo internoj
    INC SI;Incrementa SI en 1
    JMP incre_j;Salta a incre_j   
    
    
incre_i:;Etiqueta increi
    INC contador_cicloi;Incrementa en 1 el contador del cicloi
    CMP contador_cicloi,6;Comparador
    JB ciclo_externoi;Salta a ciclo_externoi, si el contador_cicloi es menor que 6, pues 6 es nuestro tamaño del vector
    JMP fin_programa;Si no se cumple salta a fin_programa 
    
    
incre_j:;Etiqueta increj
    INC contador_cicloj;Incrementa en 1 el contador del ciclo j
    CMP contador_cicloj,5;Comparador
    JB comparar;Salta a comparar si el contador del ciclo j es menor que 5 
    JMP incre_i;Si no se cumple salta a increi
   

cambia_posi:;Etiqueta cambiaposi
    MOV Vector_Datos[SI],AL;LO que hace es cambiar la posicion del menor numero con la del mayor, Guarda en el vector en SI lo que hay en AL
    MOV Vector_Datos[SI+1],AH;LO que hace es cambiar la posicion del menor numero con la del mayor, Guarda en el vector en SI+1 lo que hay en AH
    JMP ciclo_internoj;Salta al ciclo_internoj  
    

fin_programa:;Fin programa
   MAIN ENDP;Fin del main
 
;-------Procedimientos-----
;--------------------------
END MAIN;Fin del programa