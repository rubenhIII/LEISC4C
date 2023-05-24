section .data
    nombreArchivo db "data.txt", 0
    Resultado.txt db "ResultadosDeLetras.txt", 0
    Abecedario db "abcdefghijklmnopqrstuvwxyz", 0
    counts db 26 dup(0)

section .bss
    identificador resb 4

section .text
    extern printf
    extern fopen
    extern fgetc
    extern fclose

global main
    main:
        ; Abrir el archivo de entrada
        push dword 0 ; Modo de apertura: lectura
        push dword nombreArchivo
        call fopen
        mov dword [identificador], eax
        
        cmp eax, 0
        jz error
        
        ; Leer caracteres del archivo
    lectura:
        push dword [identificador]
        call fgetc
        cmp eax, -1
        je fin_lectura
        
        ; Actualizar el contador de la letra correspondiente
        sub eax, 'a'
        cmp eax, 0
        jl lectura ; El caracter no es una letra minúscula
        cmp eax, 25
        jg lectura ; El caracter no es una letra minúscula
        
        inc byte [counts + eax]
        jmp lectura
        
    fin_lectura:
        ; Cerrar el archivo de entrada
        push dword [identificador]
        call fclose
        
        ; Abrir el archivo de resultados
        push dword 1 ; Modo de apertura: escritura
        push dword Resultado.txt
        call fopen
        mov dword [identificador], eax
        
        cmp eax, 0
        jz error
        
        ; Escribir los resultados en el archivo de resultados
        mov ecx, 26
        mov esi, 0
    escribir:
        mov eax, esi
        add eax, 'a'
        push eax
        push dword [counts + esi]
        push dword Abecedario
        push dword format_string
        call printf
        
        inc esi
        loop escribir
        
        ; Cerrar el archivo de resultados
        push dword [identificador]
        call fclose
        
        ; Salir del programa
        mov eax, 0
        ret
        
    error:
        ; Manejo de error
        mov eax, 1
        ret
        
section .data
    format_string db "%c: %d\n", 0
