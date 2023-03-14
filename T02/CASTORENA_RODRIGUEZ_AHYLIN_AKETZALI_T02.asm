TITLE "TAREA2"

;Autor:Ahylin Aketzali Castorena Rodriguez
;Fecha:
;Descripcion del Programa: 

.MODEL SMALL;Definicion del tipo de memoria

.STACK 100h ;Segmento de Pila 
    
.DATA ;Segmento de Datos       
original DW 1101001110110000b;MENSAJE ORIGINAL
;variables a utilizar
    var1 DW 1101001110110000b 
    var2 DW 1011000000000000b
    var3 DB 00000000000
    
.CODE
   
   MAIN PROC ;Procedimiento Principal
  
        MOV AX,@DATA   
        MOV DS,AX      
;----------------------------------------------------------------------------------------------
;-------Codigo--------------------------------------------------------------------------------- 
comienzo:
      
      MOV AX,var1
      XOR AX, var2;se realiza la operacion "original xor var2"
      OR AX,0; compara
      JNA fin ;salta 
      
actualiza:
      MOV var1,AX ;actualiza el valor de la variable
      MOV CL,0 ;Es un contador 
      MOV CH,var3 ;tambien se utiliza como contador diferente
                        
desplaza:
      SHL AX,1 ;reccore un 1 bit a la izquierda 
      INC CL
      JNBE desplaza ;salta si es 0  
      DEC CL 
      MOV AX,var1; Actualiza el valor del registro AX
      
desplazaV:; 
      MOV var3,CL ;actualiza valor de la variable
      SUB CL,CH ; resta
      MOV BX,var2
      SHR BX,CL ;recorre la cantidad n de bits a la derecha
      MOV var2,BX ;Actualiza el valor dela variable
      JMP comienzo ;Salta para repetir el ciclo  
     

comprueba:  
      MOV AX,original 
      ADD AX,var1 
      MOV var1,AX;actualiza el valor de la variable  
       
reinicioVar:
      MOV var3,00000000000;Se reinicia la varable    
      MOV var2,1011000000000000b;tambien se reinicia la variable 
      MOV DL,1 
      JMP comienzo ;Salta a la etiqueta comienzo para repetir el ciclo
        
fin:
      OR DL,0;compara
      JNA comprueba;salta 
      MOV var1,AX;actualiza el valor de la variable
    
;-------Procedimientos-----------------------------------------------------------------------
;--------------------------------------------------------------------------------------------

END MAIN ;Fin del Programa