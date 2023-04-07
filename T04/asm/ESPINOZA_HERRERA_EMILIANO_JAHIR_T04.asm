section .data  
        ;EMILIANO JAHIR ESPINOZA HERRERA 
pi    equ 3.14159265359
x     dd 1.234  ; el número para calcular el seno
n     dd 10     ; 
fact  dd 1.0    ; variable para almacenar el factorial

section .text
global _start

_start:
  ; 
  finit
  
  ; 
  fld dword [x]
  fmul dword [pi]
  fdiv dword 180.0
  
  ; Calcular el seno usando 
  fld dword [x]    ; inicializar el término x
  fld dword [x]    ; duplicar el término x
  fmul dword [x]   ; 
  fchs             ; 
  mov dword [fact], 2
  fld1             
  faddp            
  fld dword [x]
  fmul dword [x]   
  fld dword [fact] 
  fadd dword 1.0   
  fmulp             
  fdiv dword 6.0    
  faddp             
  fld dword [x]
  fmul dword [x]    
  fld dword [fact]  
  fadd dword 1.0    
  fmul dword 5.0   
  fdiv dword 120.0 
  faddp            
  ; continuar añadiendo términos según el valor de n
  
  ; Mostrar el resultado en la consola
  fld st0
  fstp qword [esp]
  sub esp, 8
  push dword mensaje
  call dword printf
  add esp, 16
  
  ; Salir del programa
  mov eax, 1
  xor ebx, ebx
  int 0x80

section .data
mensaje db "El seno de %f es: %f", 10, 0
    loop potencia2

    ret

potenciaNeg:
    mov eax, [n]
    and eax, 1
    cmp eax, 0b
    jz pos
    jmp negativo

negativo:
    mov ebx, -1
    mov [numNeg], ebx
    jmp divMul

pos:
    mov ebx, 1
    mov [numNeg], ebx
    jmp divMul
        
divMul:
    finit
    fild dword [numNeg]
    fild dword [fac2n1]

    fdiv

    fstp dword [resDiv]

    ;Aquí se colocaría el código para imprimir el resultado

    ret
