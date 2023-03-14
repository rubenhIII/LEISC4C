org 100h
.data

section .data
  input db "Hola, mundo!", 0
  len equ $-input
  crc dw 0xFFFF ; Valor inicial del CRC

section .text
  mov si, offset input ; Puntero a la cadena de entrada
  mov cx, len ; Longitud de la cadena de entrada
  
  ; Calcular el CRC
  crc_loop:
    mov al, [si] ; Cargar el siguiente byte de la cadena
    xor ah, ah ; Poner a cero el registro ah
    mov bl, 8 ; Configurar el contador de bits a 8
  bit_loop:
    shr ax, 1 ; Desplazar el byte hacia la derecha
    jnc no_xor ; Saltar si el bit más significativo es 0
    xor ax, 0xA001 ; Realizar la operación XOR con 0xA001
  no_xor:
    dec bl ; Decrementar el contador de bits
    jnz bit_loop ; Saltar si aún quedan bits por procesar
    inc si ; Avanzar al siguiente byte de la cadena
    loop crc_loop ; Saltar si aún quedan bytes por procesar
    
  ; Almacenar el resultado del CRC en la variable crc
  mov word [crc], ax
  
  ; Imprimir el resultado del CRC
  mov ah, 09h
  mov dx, offset crc
  int 21h
  
  ; Salir del programa
  mov ah, 4Ch
  int 21h