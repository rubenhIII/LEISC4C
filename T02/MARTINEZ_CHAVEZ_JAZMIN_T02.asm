; Programa para calcular el CRC de una cadena de entrada

.data
.code

; Definición de variables
cadena db 100, 0
polinomio db 9 dup (0)
crc db 1

; Pide la entrada de la cadena
inicio:
  mov ah, 0ah
  mov dx, offset cadena
  int 21h

  ; Termina si la cadena es nula
  cmp byte ptr [cadena+1], 0
  je fin

  ; Calcula el CRC
  xor bx, bx
  xor ax, ax
  mov al, [cadena+1]
  mov bl, 8

  bucle1:
    shr ax, 1
    rcr bx, 1
    jc bucle2
    jmp siguiente

  bucle2:
    xor bx, byte ptr polinomio
    siguiente:
      dec bl
      jnz bucle1

  mov byte ptr crc, al

  ; Imprime el resultado
  mov ah, 09h
  mov dx, offset mensaje
  int 21h
  mov dl, byte ptr crc
  add dl, 30h
  mov ah, 02h
  int 21h
  mov ah, 09h
  mov dx, offset salto_de_linea
  int 21h

  jmp inicio

fin:
  ; Sale del programa
  mov ah, 4ch
  int 21h

; Datos
mensaje db "El CRC de la cadena es: "
salto_de_linea db 0dh, 0ah, "$"
polinomio db 110011011 ; Polinomio utilizado para el cálculo de CRC
