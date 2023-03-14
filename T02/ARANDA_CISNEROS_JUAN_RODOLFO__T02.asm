   TITLE "Verificacion de redundancia ciclica"

;JUAN RODOLFO ARANDA CISNEROS
;Fecha:13/03/2023





org 100h          ; punto de entrada del programa

start:
    mov ax, data   ; carga la dirección de la cadena de datos
    mov cx, len    ; carga la longitud de la cadena de datos
    call crc16     ; llama a la función CRC-16
    mov bx, crc    ; carga el valor CRC calculado
    int 3          ; detiene la ejecución y muestra el valor CRC en el depurador

crc16:
    push ax        ; guarda el registro AX en la pila
    push bx        ; guarda el registro BX en la pila
    push cx        ; guarda el registro CX en la pila

    mov bx, 0      ; carga el valor inicial del registro BX en cero
    mov dx, 0      ; carga el valor inicial del registro DX en cero

    crc_loop:
        mov al, [si]    ; carga el byte actual de la cadena de datos
        xor al, dh      ; XOR con los bits superiores del registro DX
        mov dh, al      ; mueve el resultado al registro DH
        mov al, dl      ; mueve los bits inferiores del registro DX al registro AL
        xor al, ah      ; XOR con los bits superiores del registro AX
        mov ah, al      ; mueve el resultado al registro AH
        mov al, dh      ; mueve los bits superiores del registro DX al registro AL
        xor al, dl      ; XOR con los bits inferiores del registro DX
        mov dl, al      ; mueve el resultado al registro DL
        mov si, si+1    ; incrementa el puntero de la cadena de datos
        loop crc_loop   ; repite hasta que se hayan procesado todos los bytes

    pop cx         ; restaura el registro CX de la pila
    pop bx         ; restaura el registro BX de la pila
    pop ax         ; restaura el registro AX de la pila
    ret            ; regresa del procedimiento CRC-16

data:
    db "Hello, world!", 0 ; cadena de datos
len equ $ - data         ; longitud de la cadena de datos
crc dw 0                 ; valor CRC inicial en cero




