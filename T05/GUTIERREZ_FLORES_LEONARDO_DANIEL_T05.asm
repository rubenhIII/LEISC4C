GLOBAL main

section .data
    ; Definición de variables de datos
    data    db "data.txt",0                ; Nombre del archivo de entrada
    output  db "GUTIERREZ_FLORES_LEONARDO_DANIEL_COUNT.txt",0   ; Nombre del archivo de salida
    Mayuscula db 65                        ; Valor ASCII inicial para las letras mayúsculas ('A')
    contador db 0                          ; Contador para el bucle principal
    numL dd 0                       ; Contador para el total de letras encontradas

    tamBuff equ 2000                       ; Tamaño del búfer de lectura
    Lcont dd 26 dup(0)                ; Arreglo de contadores para cada letra del alfabeto
    Auxbuff dd 0                         ; Variable auxiliar para convertir un dígito a cadena
    cadena dd "000"                        ; Cadena temporal para almacenar dígitos convertidos
    zero dd 0                           ; Variable auxiliar para cálculos

    nuevaLinea db 10                       ; Carácter de nueva línea (salto de línea)
    espacio    db ' '                      ; Carácter de espacio en blanco
    diagonal   db '/'                      ; Carácter de diagonal (/)
    
section .bss
    buffer resb tamBuff                    ; Búfer de lectura del archivo
    iden   resb 1                          ; Identificador temporal

section .text
    main:
        ; Abrir archivo de salida
        mov eax, 10
        mov ebx, output
        int 0x80
        
        ; Abrir archivo de entrada
        mov eax, 5
        mov ebx, data
        mov ecx, 0
        int 80h
        mov esi, eax
        
        ; Leer contenido del archivo
        mov eax, 3
        mov ebx, esi
        mov ecx, buffer
        mov edx, tamBuff
        int 0x80
        mov edi, buffer

Cont:
    ; Contar las letras en el búfer
    movzx eax, byte [edi]
    cmp al, 0
    je Endcont
    cmp al, 'A'
    jb movPTR
    cmp al, 'Z'
    ja cmpLetter
    sub eax, 'A'
    inc dword [Lcont + eax]
    inc dword [numL]
    jmp movPTR

cmpLetter:
    cmp al, 'a'
    jb movPTR
    cmp al, 'z'
    ja movPTR
    sub eax, 'a'
    inc dword [Lcont + eax]
    inc dword [numL]

movPTR:
    inc edi
    jmp Cont

Endcont:
    ; Cerrar archivo de entrada
    close_file:
    mov eax, 6
    mov ebx, esi
    int 0x80

    ; Reiniciar contadores y abrir archivo de salida en modo de escritura
    mov byte [contador], 0
    mov eax, 5
    mov ebx, output
    mov ecx, 0102o
    mov edx, 0666o
    int 0x80
    jmp ciclo0

ciclo:
    ; Escribir en el archivo de salida
    mov eax, 5
    mov ebx, output
    mov ecx, 2
    mov edx, 777
    int 0x80

ciclo0:
    mov [iden], eax
    ; Imprimir identificador
    mov eax, 0x13
    mov ebx, [iden]
    mov ecx, 0
    mov edx, 2
    int 0x80
    ; Imprimir letra mayúscula actual
    mov eax, 4
    mov edx, [iden]
    mov ecx, Mayuscula
    mov edx, 1
    int 0x80
    ; Imprimir espacio en blanco
    mov eax, 4
    mov edx, [iden]
    mov ecx, espacio
    mov edx, 1
    int 0x80
    ; Convertir y escribir el contador de letras actual
    movzx esi, byte [contador]
    mov eax, dword [Lcont + esi]
    mov dword [Auxbuff], eax
    mov al, byte [Auxbuff]
    call cambio
    mov eax, 4
    mov edx, [iden]
    mov ecx, cadena
    mov edx, 3
    int 0x80
    ; Imprimir diagonal (/)
    mov eax, 4
    mov edx, [iden]
    mov ecx, diagonal
    mov edx, 1
    int 0x80
    ; Convertir y escribir el total de letras encontradas
    mov eax, dword [numL]
    mov dword [Auxbuff], eax
    mov al, byte [Auxbuff]
    call cambio
    mov eax, 4
    mov edx, [iden]
    mov ecx, cadena
    mov edx, 3
    int 0x80
    ; Imprimir nueva línea
    mov eax, 4
    mov ebx, [iden]
    mov ecx, nuevaLinea
    mov edx, 1
    int 0x80
    ; Cerrar archivo de salida
    mov eax, 6
    mov ebx, [iden]
    int 0x80
    ; Incrementar contadores
    inc byte [Mayuscula]
    inc byte [contador]
    cmp byte [contador], 26
    je exit
    jmp ciclo
    jmp exit

cambio:
    pusha
    ; Convertir un dígito a cadena
    mov dword [cadena], "000"
    xor eax, eax
    xor ebx, ebx
    movzx ebx, byte [Auxbuff]
    cmp ebx, 0
    jne .check_hundreds

.check_hundreds:
    cmp ebx, 100      ; Compara el valor de ebx con 100
    jl .check_tens    ; Salta a .check_tens si ebx es menor que 100
    mov eax, ebx      ; Mueve el valor de ebx a eax
    xor edx, edx      ; Limpia edx (parte alta del valor dividido)
    mov ecx, 100      ; Mueve el valor 100 a ecx (divisor)
    div ecx           ; Divide eax entre ecx, el resultado se guarda en eax y el zero en edx
    add eax, '0'      ; Suma '0' al valor de eax para convertirlo en su correspondiente caracter ASCII
    mov byte [cadena], al  ; Guarda el caracter convertido en la primera posición de la cadena cadena
    mov ebx, edx      ; Mueve el zero de la división a ebx para continuar la conversión

.check_tens:
    cmp ebx, 10       ; Compara el valor de ebx con 10
    jl .ones_digit    ; Salta a .ones_digit si ebx es menor que 10
    xor edx, edx      ; Limpia edx (parte alta del valor dividido)
    mov eax, ebx      ; Mueve el valor de ebx a eax
    mov ecx, 10       ; Mueve el valor 10 a ecx (divisor)
    div ecx           ; Divide eax entre ecx, el resultado se guarda en eax y el zero en edx
    add eax, '0'      ; Suma '0' al valor de eax para convertirlo en su correspondiente caracter ASCII
    mov byte [cadena + 1], al  ; Guarda el caracter convertido en la segunda posición de la cadena cadena
    mov ebx, edx      ; Mueve el zero de la división a ebx para continuar la conversión

.ones_digit:
    add bl, '0'       ; Suma '0' al valor de bl para convertirlo en su correspondiente caracter ASCII
    mov byte [cadena + 2], bl  ; Guarda el caracter convertido en la tercera posición de la cadena cadena

finTocadena:
    mov byte [cadena + 3], '0'
    popa
    ret

exit:
    ; Salir del programa
    mov eax, 1
    int 0x80