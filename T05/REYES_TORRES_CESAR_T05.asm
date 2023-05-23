;Copyright (c) 2023, Cesar Reyes Torres <Cualquier copia de este programa será eliminada del repositorio sin previo aviso> All rights reserved.

; Programa en Lenguaje Ensamblador para la arquitectura i386
; que lea los caracteres de un archivo de texto y cuente cuántas
; veces se repite cada letra del alfabeto.

; En este programa se lee caracter por caracter y se identifica la letra independientemente
; si es mayúscula o minúscula y se aumenta el contador de cada letra.
; Una vez leido el archivo completo, se crea o se abre un nuevo archivo de texto
; y se esciben los resultados en forma de lista (hasta 999 de un mismo caracter).

; NOTA: Si el archivo reslutado no está creado y ejecuta el programa, se creará el archivo sin permisos
; necesarios para lectura, por lo que se deberan de actualizar para poder observar el contenido escrito.

GLOBAL main

section .data
    filename_1 db 'data.txt', 0
    filename_2 db "REYES_TORRES_CESAR_COUNT.txt", 0
    filehandle dd 0
    output db 4             ; Tamaño máximo de la cadena de salida
    buffer_c db 4 DUP('0')  ; Buffer para almacenar la cadena convertida
    buffer_z db 2 DUP('0')  ; Buffer para almacenar la cadena convertida ceros
    ;Mensajes para listado
    msg_A db "A ",0
    msg_B db 10,"B ",0
    msg_C db 10,"C ",0
    msg_D db 10,"D ",0
    msg_E db 10,"E ",0
    msg_F db 10,"F ",0
    msg_G db 10,"G ",0
    msg_H db 10,"H ",0
    msg_I db 10,"I ",0
    msg_J db 10,"J ",0
    msg_K db 10,"K ",0
    msg_L db 10,"L ",0
    msg_M db 10,"M ",0
    msg_N db 10,"N ",0
    msg_O db 10,"O ",0
    msg_P db 10,"P ",0
    msg_Q db 10,"Q ",0
    msg_R db 10,"R ",0
    msg_S db 10,"S ",0
    msg_U db 10,"U ",0
    msg_V db 10,"V ",0
    msg_W db 10,"W ",0
    msg_X db 10,"X ",0
    msg_Y db 10,"Y ",0
    msg_Z db 10,"Z ",0
    ;Contadores
    a dd 0
    b dd 0
    c dd 0
    d dd 0
    e dd 0
    f dd 0
    g dd 0
    h dd 0
    i dd 0
    j dd 0
    k dd 0
    l dd 0
    m dd 0
    n dd 0
    o dd 0
    p dd 0
    q dd 0
    r dd 0
    s dd 0
    u dd 0
    v dd 0
    w dd 0
    x dd 0
    y dd 0
    z dd 0

section .bss
    fd  resw 1
    buffer resb 1

section .text
main:
    ; Abrir el archivo
    mov eax, 5                  ; Código de la llamada al sistema para abrir el archivo
    mov ebx, filename_1           ; Nombre del archivo
    mov ecx, 0                  ; Modo de apertura: solo lectura
    int 0x80                    ; Llamar al sistema

    ; Comprobar errores al abrir el archivo
    cmp eax, -1
    je file_error

    ; Leer y mostrar cada letra del archivo
read_loop:

    mov eax, 3                  ; Código de la llamada al sistema para leer el archivo
    mov ebx, eax                ; Descriptor de archivo de entrada
    mov ecx, buffer             ; Búfer de lectura
    mov edx, 1                  ; Tamaño de lectura: 1 byte
    int 0x80                    ; Llamar al sistema

    ; Comprobar errores al leer el archivo
    cmp eax, -1
    je file_error

    ; Comprobar el final del archivo
    cmp eax, 0
    je end_read_loop

    ; Evaluar cada letra leida

    cmp byte [buffer], ' ' 
    je read_loop 

    cmp byte [buffer], '.' 
    je read_loop 

    cmp byte [buffer], 'A' 
    je letter_A 

    cmp byte [buffer], 'a' 
    je letter_A 

    cmp byte [buffer], 'B' 
    je letter_B 

    cmp byte [buffer], 'b' 
    je letter_B 

    cmp byte [buffer], 'C' 
    je letter_C 

    cmp byte [buffer], 'c' 
    je letter_C 

    cmp byte [buffer], 'D' 
    je letter_D 

    cmp byte [buffer], 'd' 
    je letter_D 

    cmp byte [buffer], 'E' 
    je letter_E 

    cmp byte [buffer], 'e' 
    je letter_E 

    cmp byte [buffer], 'F' 
    je letter_F 

    cmp byte [buffer], 'f' 
    je letter_F 

    cmp byte [buffer], 'G' 
    je letter_G 

    cmp byte [buffer], 'g' 
    je letter_G 

    cmp byte [buffer], 'H' 
    je letter_H 

    cmp byte [buffer], 'h' 
    je letter_H 

    cmp byte [buffer], 'I' 
    je letter_I 

    cmp byte [buffer], 'i' 
    je letter_I 

    cmp byte [buffer], 'J' 
    je letter_J 

    cmp byte [buffer], 'j' 
    je letter_J 

    cmp byte [buffer], 'K' 
    je letter_K 

    cmp byte [buffer], 'k' 
    je letter_K 

    cmp byte [buffer], 'L' 
    je letter_L 

    cmp byte [buffer], 'l' 
    je letter_L 

    cmp byte [buffer], 'M' 
    je letter_M 

    cmp byte [buffer], 'm' 
    je letter_M 

    cmp byte [buffer], 'N' 
    je letter_N 

    cmp byte [buffer], 'n' 
    je letter_N 

    cmp byte [buffer], 'O' 
    je letter_O 

    cmp byte [buffer], 'o' 
    je letter_O 

    cmp byte [buffer], 'P' 
    je letter_P 

    cmp byte [buffer], 'p' 
    je letter_P 

    cmp byte [buffer], 'Q' 
    je letter_Q 

    cmp byte [buffer], 'q' 
    je letter_Q 

    cmp byte [buffer], 'R' 
    je letter_R 

    cmp byte [buffer], 'r' 
    je letter_R 

    cmp byte [buffer], 'S' 
    je letter_S 

    cmp byte [buffer], 's' 
    je letter_S 

    cmp byte [buffer], 'U' 
    je letter_U 

    cmp byte [buffer], 'u' 
    je letter_U 

    cmp byte [buffer], 'V' 
    je letter_V 

    cmp byte [buffer], 'v' 
    je letter_V 

    cmp byte [buffer], 'W' 
    je letter_W 

    cmp byte [buffer], 'w' 
    je letter_W 

    cmp byte [buffer], 'X' 
    je letter_X 

    cmp byte [buffer], 'x' 
    je letter_X 

    cmp byte [buffer], 'Y' 
    je letter_Y 

    cmp byte [buffer], 'y' 
    je letter_Y 

    cmp byte [buffer], 'Z' 
    je letter_Z 

    cmp byte [buffer], 'z' 
    je letter_Z 


    ; Volver a leer la siguiente letra
    jmp read_loop



end_read_loop:
    ; Cerrar el archivo
    mov eax, 6                  ; Código de la llamada al sistema para cerrar el archivo
    mov ebx, eax                ; Descriptor de archivo
    int 0x80                    ; Llamar al sistema

    ; Crear archivo de resultados
    ; Abrir el archivo
    mov eax, 8            ; Código de llamada al sistema "open"
    mov ebx, filename_2   ; Nombre del archivo
    mov ecx, 2            ; Modo de apertura (2 = O_WRONLY | O_CREAT)
    mov edx, 644         ; Permisos del archivo
    int 0x80              ; Llamada al sistema

    mov [filehandle], eax ; Almacenar el descriptor de archivo devuelto

    
    call write_file       ;Escribir resultados en archivo

    ; Cerrar el archivo
    mov eax, 6            ; Código de llamada al sistema "close"
    mov ebx, [filehandle] ; Descriptor de archivo
    int 0x80   

ext:
    ; Salir del programa
    mov eax, 1                  ; Código de la llamada al sistema para salir del programa
    xor ebx, ebx                ; Código de salida: 0 (éxito)
    int 0x80                    ; Llamar al sistema

file_error:
    ; Salir del programa con un código de error
    mov eax, 1         ; Número de la llamada al sistema para salir (sys_exit)
    mov ebx, 1         ; Código de salida != 0 para indicar un error
    int 0x80           ; Llamar al sistema






; Convertir un numero entero en una cadena
convert_string:
    cmp eax, 0
    je zero_n
    ; Convierte el entero en una cadena
    mov ebx, 10             ; Base decimal
    mov ecx, buffer_c + 3   ; Puntero al último dígito del buffer de salida
    call itoa

    ; Encuentra el primer dígito distinto de cero en el buffer
    mov edi, buffer_c
    find_first_digit:
        cmp byte [edi], '0'
        jne print_string
        inc edi
        jmp find_first_digit

    print_string:
    ; Imprime la cadena en pantalla (verificación)
    ;mov eax, 4
    ;mov ebx, 1
    ;mov ecx, edi           ; Puntero al primer dígito no cero del buffer
    ;add edx, ecx           ; Calcula la longitud de la cadena
    ;sub edx, buffer_c
    ;int 0x80

    ret

itoa:
    xor edi, edi           ; Limpia edi (contador de dígitos)

check_zero:
    cmp eax, 0             ; Comprueba si el número es cero
    jne convert_loop       ; Salta si no es cero
    ; El número es cero, almacena un solo dígito cero en el buffer
    mov byte [ecx], '0'
    inc edi                ; Incrementa el contador de dígitos
    ; Agrega el carácter nulo al final de la cadena
    mov byte [ecx + edi], 0

    ret

convert_loop:
    xor edx, edx           ; Limpia edx
    div ebx                ; Divide eax por ebx (número entero y base)
    add dl, '0'            ; Convierte el dígito en un carácter ASCII

    ; Almacena el dígito en el buffer
    dec ecx                ; Decrementa ecx para almacenar el dígito en la posición correcta
    mov [ecx], dl
    inc edi                ; Incrementa el contador de dígitos
    cmp eax, 0             ; Comprueba si el cociente es cero
    jne convert_loop       ; Salta si no es cero
    ; Agrega el carácter nulo al final de la cadena
    mov byte [ecx + edi], 0
    jmp fin
    zero_n:                ; Cuando es un cero
        mov DWORD [buffer_c], "000"
    fin:
    ret



;******** Contadores ******* 

letter_A:
    inc DWORD [a]
    jmp read_loop

letter_B:
    inc DWORD [b]
    jmp read_loop

letter_C:
    inc DWORD [c]
    jmp read_loop

letter_D:
    inc DWORD [d]
    jmp read_loop

letter_E:
    inc DWORD [e]
    jmp read_loop

letter_F:
    inc DWORD [f]
    jmp read_loop

letter_G:
    inc DWORD [g]
    jmp read_loop

letter_H:
    inc DWORD [h]
    jmp read_loop

letter_I:
    inc DWORD [i]
    jmp read_loop

letter_J:
    inc DWORD [j]
    jmp read_loop

letter_K:
    inc DWORD [k]
    jmp read_loop

letter_L:
    inc DWORD [l]
    jmp read_loop

letter_M:
    inc DWORD [m]
    jmp read_loop

letter_N:
    inc DWORD [n]
    jmp read_loop

letter_O:
    inc DWORD [o]
    jmp read_loop

letter_P:
    inc DWORD [p]
    jmp read_loop

letter_Q:
    inc DWORD [q]
    jmp read_loop

letter_R:
    inc DWORD [r]
    jmp read_loop

letter_S:
    inc DWORD [s]
    jmp read_loop

letter_U:
    inc DWORD [u]
    jmp read_loop

letter_V:
    inc DWORD [v]
    jmp read_loop

letter_W:
    inc DWORD [w]
    jmp read_loop

letter_X:
    inc DWORD [x]
    jmp read_loop

letter_Y:
    inc DWORD [y]
    jmp read_loop

letter_Z:
    inc DWORD [z]
    jmp read_loop



write_file:      ; Escribir listado en el archivo
    mov eax, 4                      ; Código de llamada al sistema "write"
        mov ebx, [filehandle]
        mov ecx, msg_A              ; Dirección de variable
        mov edx, 2                  ; Longitud de variable
        int 0x80                    ; Llamada al sistema

        mov eax, [a]
          
        call convert_string
          
        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c       
        mov edx, 3    
        int 0x80        

    mov eax, 4            
        mov ebx, [filehandle]
        mov ecx, msg_B      
        mov edx, 3     
        int 0x80           

        mov eax, [b]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80        

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_C        
        mov edx, 3     
        int 0x80    

        mov eax, [c]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80         

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_D        
        mov edx, 3     
        int 0x80    

        mov eax, [d]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80      

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_E        
        mov edx, 3     
        int 0x80    

        mov eax, [e]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80  

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_G       
        mov edx, 3     
        int 0x80    

        mov eax, [g]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80  

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_H       
        mov edx, 3     
        int 0x80    

        mov eax, [h]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80  

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_I       
        mov edx, 3     
        int 0x80    

        mov eax, [i]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80  

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_J       
        mov edx, 3     
        int 0x80    

        mov eax, [j]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80  

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_K       
        mov edx, 3     
        int 0x80    

        mov eax, [k]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80          

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_L       
        mov edx, 3     
        int 0x80    

        mov eax, [l]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_M       
        mov edx, 3     
        int 0x80    

        mov eax, [m]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_N       
        mov edx, 3     
        int 0x80    

        mov eax, [n]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_O       
        mov edx, 3     
        int 0x80    

        mov eax, [o]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_P       
        mov edx, 3     
        int 0x80    

        mov eax, [p]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

   mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_Q       
        mov edx, 3     
        int 0x80    

        mov eax, [q]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_R       
        mov edx, 3     
        int 0x80    

        mov eax, [r]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_S       
        mov edx, 3     
        int 0x80    

        mov eax, [s]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_U       
        mov edx, 3     
        int 0x80    

        mov eax, [u]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_V       
        mov edx, 3     
        int 0x80    

        mov eax, [v]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_W       
        mov edx, 3     
        int 0x80    

        mov eax, [w]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_X       
        mov edx, 3     
        int 0x80    

        mov eax, [x]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_Y       
        mov edx, 3     
        int 0x80    

        mov eax, [y]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

    mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, msg_Z       
        mov edx, 3     
        int 0x80    

        mov eax, [z]
        call convert_string

        mov eax, 4         
        mov ebx, [filehandle]
        mov ecx, buffer_c        
        mov edx, 3    
        int 0x80   

        ret

;Lineas para compilar
; nasm -f elf32 -g REYES_TORRES_CESAR_T05.asm
; gcc -m32 -no-pie REYES_TORRES_CESAR_T05.o -o REYES_TORRES_CESAR_T05Ex
; ./REYES_TORRES_CESAR_T05Ex
