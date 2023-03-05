TITLE "Metodo de ordenacion, burbuja"

;Autor:  Cesar reyes Torres
;Fecha:  05/03/2023
;Descripcion del Programa: Metodo de la burbuja basico, de menor a mayor
    
    
COMMENT !
--------------------------
!

.MODEL SMALL 
    ;Definicion del tipo de memoria

.STACK 100h  
    ;Segmento de Pila 
    
.DATA      

    ;Segmento de Datos
     
    Tam equ 0Bh                        ;Constante, tam del vector
    Vec DB 1,3,2,4,5,7,6,8,11,9,10     ;Vector desordenado
    Aux DB 0h                          ;Auxiliar en ceros
    
.CODE
    ;Segmento de Codigo
   MAIN PROC ;Procedimiento Principal
             ;Inicializacion de Segmento
             ;de Codigo
        
        MOV AX,@DATA
        MOV DS,AX 


;-------Codigo-----------  
                       
                       
        MOV SI,0     ;Limpio index de origen
        MOV DI,0     ;Limpio index de destino
           
        MOV Cl,Tam   ;Guardamos el tam en Cl - parte baja
        MOV Ch,0     ;Limpiamos la parte alta de Cx
        DEC Cx       ;Decrementamos Cx
        JMP cicloPrincipal     ;Se inicia el ciclo principal 
 
         
;-------Procedimientos-----         
        
         
 cicloSecundario:;Segunda condicion de paro, Aqui se revisa si es necesario hacer cambios de valores 
 
        inc DI               ;Incremento de segundo index
        CMP CX,DI            ;Se compara para saber si se llego al total de bloques                   
        JLE cicloPrincipal   ;Brinca si lo que tiene Cx es menor o igual a Di (Condicion de paro 2do ciclo)
        MOV Al,vec[DI]       ;Se guarda el valor de vec[DI] en Dl
        CMP vec[DI+1],Al     ;Se compara la posicion siguiente del vector con el actual 
        JLE cambios          ;Si la posicion siguiente es mayor a la anterior, brinca
        JMP cicloSecundario  ;Se cicla asi mismo
        
 cambios:       ;Se hace el cambio de valor actual a valor siguiente mediante un auxiliar
        
        MOV Ah,vec[di]       ;Se guarda lo que tiene vec en la posicion di, hacia Ah
        MOV aux,Ah           ;Se guarda lo que tiene Ah en aux
        MOV Ah,vec[di+1]     ;Se guarda lo que tiene vec en la siguiente posicion, en Ah
        MOV vec[di],Ah       ;Hace el cambio, se guarda la siguiente posicion de vec, en la actual
        MOV Ah,aux           ;Se pasa lo que tenia aux hacia Ah
        MOV vec[di+1],Ah     ;Se Se guarda el la siguiente posicion de vec, lo que tiene actualmente
        JMP cicloSecundario  ;Se regresa a comparar   
              
 cicloPrincipal:;Aqui esta la condicion de paro principal, se llama al ciclo secundario 
 
        inc SI               ;Incrementamos nuestro index principal
        MOV DI,0             ;Se limpia nuestro index secundario
        CMP SI,Tam-1         ;Compara index principal con el tam del vector <-1 porque Si empieza desde 0>
        JLE cicloSecundario  ;Salta si es menor o igual
        MOV aux,0h           ;Limpia el aux antes de salir
                         
         
;-------------------------       
   MAIN ENDP
   



;--------------------------

END MAIN ;Fin del Programa