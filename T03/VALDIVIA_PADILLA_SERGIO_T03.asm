;Sacar Factorial de un número
.model small
.stack 100h

.data

;Valdivia Padilla Sergiop Armando    
.code
main proc
    mov ax, @data
    mov ds, ax
    
    mov ax, 5 ; Establecer el número a calcular el factorial en 5
    
    push ax ; guardar el número en la pila
    call factorial ; llamar al procedimiento factorial
    
    
    mov ah, 4ch
    int 21h
main endp

factorial proc
    push bp ; guardar el puntero de pila base
    mov bp, sp ; establecer bp al puntero de pila actual
    
    mov ax, [bp+4] ; obtener el número desde la pila
    cmp ax, 1 ; verificar si es 1 o no
    je .base_case ; saltar a caso base si es 1
    
    dec ax ; decrementar el número
    push ax ; guardar el nuevo número en la pila
    call factorial ; llamar al procedimiento factorial recursivamente
    
    mov bx, [bp+4] ; obtener el número desde la pila
    mul bx ; multiplicar el resultado de la llamada recursiva por el número actual
    
    jmp .done ; saltar al final del procedimiento
    
.base_case:
    mov ax, 1 ; caso base, el factorial de 1 es 1
    
.done:
    
factorial endp

end main

