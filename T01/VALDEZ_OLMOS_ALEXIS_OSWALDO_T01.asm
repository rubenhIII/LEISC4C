  TITLE "METODO DE LA BURBUJA"
  ;AUTOR:ALEXIS OSWALDO VALDEZ OLMOS 
  ;FECHA 02/03/2023
  ;DESCRIPCION DEL PROGRAMA 
  ;PROGRAMA QUE REALIZA EL METODO DEL BURBUJA EN LENGUAJE ENSAMBLADOR
  
;Ordenar una cadena por el metodo de la burbuja
 ;EM


 org 100h
 
 
 mov contador1,1 ;SE INICIALIZA EL PRIMER CONTADOR EN 1
 mov contador2,0 ;SE INICIALIZA EL PRIMER CONTADOR EN 2
 
 
 
 ;ciclo para recorrer todo el arreglo n veces donde n es el tamaño de la cadena
 
 ciclo1: 
 cmp contador1,16     
 jb ciclo2
 mov bx,0                                                               
 mov si,0
 jae resultado 
 
 
 ;Ciclo donde se comprueba cada posicion con la consiguiente
 ciclo2:
 mov dx,16
 sub dx,contador1
 cmp dx,contador2
 ja comparar
 inc contador1
 mov contador2,0
 jmp ciclo1
 
 
 ;Comparar cual de las dos posiciones es mayor
 comparar:
 mov  si,contador2
 mov al,cad[si]
 mov bl,cad[si+1]
 mov [si],al
 mov [si+16],bl
 cmp al,bl
 ja mayor 
 inc contador2
 jmp ciclo2
 
 
 ;Si es mayor la poscicion 1 se intercambia con la 2
 mayor:                 
 mov auxiliar,al
 mov al,bl
 mov bl,auxiliar
 mov cad[si],al
 mov cad[si+1],bl
 inc contador2
 jmp ciclo2
 
 
 
 ;Imprime el resultado en la memoria 
 resultado:
 mov al,cad[si]
 mov [si+32],al
 inc si
 cmp si,16
 jae fin    ;FINALIZA O CONCLUYE EL PROGRAMA
 jb resultado
 
 
 
 
 fin:
 ret
 
 
 ;Variables contadores y cadena a ordenar
 auxiliar db ?
 contador1 dw ?
 contado2 dw ?
 cad db "a4d8r6l1f5we9y2q"    ;CADENA A ORDENAR 
 