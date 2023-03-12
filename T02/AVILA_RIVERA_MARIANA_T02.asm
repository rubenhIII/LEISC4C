TITLE "Generador de CRC (Verificacion de redundancia ciclica)"

;Autor:Mariana Avila Rivera
;Fecha:13/03/2023
;Descripcion del Programa: 
;   Algoritmo para generar la CRC de un mensaje
;   Para verificar que los valores del mensaje no cmabiaron


.MODEL SMALL;Definicion del tipo de memoria

.STACK 100h ;Segmento de Pila 
    
.DATA ;Segmento de Datos       
    mensaje DW 1101001110110000b;Mensaje al que se le agregaron 3 ceros al final (msg+000)
                                ; se el agregaron 3 ceros porque se quiere un CRC de 3 bits
    CRC     DW 1101001110110000b 
    divisor DW 1011000000000000b;El divisor de la operacion
    desp    DB 0 ;Para llevar un control del desplazamiento

.CODE   ;Segmento de Codigo
   
   MAIN PROC ;Procedimiento Principal
        ;Inicializacion de Segmento de Codigo
        MOV AX,@DATA   ;  @Data= direccion de meoria del segmento de datos
        MOV DS,AX      ;DS DATA SEGMENT, ALMACENA LOS DATOS
;-------------------------
;-------Codigo----------- 
      MOV DL,0

OperXOR: ;Se realiza XOR -> (mensaje XOR divisor)
      
      MOV AX,CRC
      XOR AX, divisor ; Se realiza: (AX)XOR(divisor), o bien, (CRC)XOR(divisor)
      
      CMP AX,0 ;Condicion de paro, Si AX==0 se detiene
      JE  fin  ;Salta si AX==0
      
      MOV CRC,AX ;Se actualiza el valor de CRC
      
      MOV CL,0 ;Se utiliza como un contador,CL= desplazamiento total 
      MOV CH,desp ;Se utiliza como contador para saber cuanto se a desplazado el divisor
                        
desplaza:; Se desplaza el mensaje hasta encontrar un 1 para sbaer cuanto desplazr al divisor
      SHL AX,1 ; corrimiento de 1 bit hacia la izquierda 
      INC CL
      JNC desplaza ;salta si CF==0 (CF=la bandera de carry) 
      
      DEC CL
      MOV AX,CRC; Actualiza el valor de AX con la nueva version de CRC
      
desplazaD:; Se desplaza el divisor
      MOV desp,CL ;actualiza el desplazamiento total
      SUB CL,CH ;Ahora CL tiene el desplazamiento que debe hacer el divisor
                ;desplazamiento total-desplazamiento anterior
      MOV BX,divisor
      SHR BX,CL ;corriemiento de n bits hacia la derecha (ajustandolo al nuevo tamano del mensaje)
      MOV divisor,BX ;Actualiza el valor del divisor
      JMP OperXOR ;Salta para repetir el proceso  
     

    comp: ;Seccion para comprobar   
        MOV AX, mensaje 
        ADD AX,CRC
        MOV mensaje,AX               ;Se actualiza el mensaje
        MOV CRC,AX                   ;Se actualiza CRC
        MOV desp,0                   ;Se reinicia desp (el que indica el desplazamiento)
        MOV divisor,1011000000000000b;Se reinicia divisor
        MOV DL,1 ;Solo para mostrar que ahora se hace la comprobacion
        JMP OperXOR ;Salta para realizar el mismo proceso con el mensaje con CRC
        
fin:
    CMP DL,0;Si DL==0 todavia no hace la comprobacion
    JE comp ; si DL==0 salta a comp de lo contrario finaliza el programa
    
    ;Hace la ultima operacin para demostrar que se obtiene cero
    MOV AX,CRC
    XOR AX, divisor ; Se realiza: (AX)XOR(divisor), o bien, (CRC)XOR(divisor)
      
    MOV CRC,AX ;Se actualiza el valor de CRC   
    
   MAIN ENDP
   
;-------Procedimientos-----
;--------------------------

END MAIN ;Fin del Programa