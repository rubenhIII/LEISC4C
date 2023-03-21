; Este programa calcula el factorial de un número fijo (5 en este caso)
; y muestra el resultado en la pantalla.

org 100h

mov cx, 5      ; número fijo cuyo factorial se quiere calcular
mov bx, cx     ; se guarda el valor original en bx

mov ax, 1      ; se inicializa el acumulador con 1

loop1:
mul cx         ; se multiplica el acumulador por el contador
dec cx         ; se decrementa el contador
jnz loop1      ; si no ha llegado a cero, se vuelve al loop

mov cx, bx     ; se recupera el valor original
mov bx, 10     ; se divide el resultado por 10 para poder imprimirlo

loop2:
xor dx, dx     ; se limpia dx
div bx         ; se divide ax entre 10
push dx        ; se guarda el resto (dígito menos significativo) en la pila
cmp ax, 0      ; se compara el cociente con cero
jne loop2      ; si no ha llegado a cero, se vuelve al loop

mov ah, 2      ; se prepara para imprimir el resultado
pop dx         ; se saca el último dígito de la pila
add dl, 48     ; se convierte a ASCII
int 21h        ; se imprime el dígito

loop3:
mov ah, 2      ; se prepara para imprimir el resultado
pop dx         ; se saca el siguiente dígito de la pila
add dl, 48     ; se convierte a ASCII
int 21h        ; se imprime el dígito
loop loop3     ; se repite hasta que se hayan impreso todos los dígitos

mov ah, 4ch    ; se sale del programa
int 21h
