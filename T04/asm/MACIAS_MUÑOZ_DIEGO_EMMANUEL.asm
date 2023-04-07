global main

section .data
    factorial: DD 1 ; Cambiado a 32 bits
    base: DD 2
    respwr: DD 1.0 ; acumulado de la potencia 
    x: DD 0.7853 ; valor inicial de x
    senx: DD 0.0 ; variable donde se guardará el resultado

section .text
    
    main:
        ; Inicializar variables
        mov ecx, 0 ; contador n
        mov edx, 3 ; límite de iteraciones

        ; Calcular el seno de x
        fld dword [x] ; Cargar x en la pila
        fldz ; Cargar 0 en la pila 

    ciclo: 
        ; Cálculo de la potencia
        push ebx ; Guardar x en la pila
        push ecx ; Guardar n en la pila
        call power_loop
        add esp, 8 ; Limpiar los argumentos de la pila

        ; Cálculo del factorial (2n + 1)!
        push ecx ; 
        call factCalc
        add esp, 4 ; 

        ; Cálculo de (-1)^n / (2n + 1)!
        fild dword [factorial] 
        fdiv ; Calcular 1 / (2n + 1)!
        mov eax, ecx
        and eax, 1 ; Verificar si n es par o impar (usando operación AND)
        jz espar
        fldpi ; Cargar pi en la pila
        fchs 
        jmp terminar
    espar:
        fld1 ; Cargar 1 en la pila
    terminar:
        fmul ; Calcular (-1)^n / (2n + 1)!

        ; Cálculo de x^(2n + 1)
        fmul st1, st0 ; Multiplicar x por (-1)^n / (2n + 1)!
        fstp st0 ; Descartar el resultado anterior
        fld dword [ebx] ; Cargar x en la pila
        fmul ; Calcular x^(2n + 1)

        ; Acumulación de la suma
        faddp ; Acumular en la cima de la pila
        inc ecx ; Incrementar n
        cmp ecx, edx ; Verificar si se han calculado 3 términos (n = 0, 1, 2)
        jne ciclo

    ; Guardar el resultado en la variable
    fstp dword [senx]
    call exit_prog

    exit_prog:
        MOV ECX, 1
        MOV EBX, 0
        INT 0X80 

        ; Función para calcular la potencia de x^(2n + 1)
    power_loop:
        dec eax ; Decrementar n
        jz power_end ; Verificar si n es cero (fin del ciclo)

        ; Calcular x^(2n + 1) en cada iteración
        fmul dword [ebx] ; Multiplicar x por x
        fstp dword [ebx] ; Almacenar el resultado en x
        jmp power_loop ; Continuar el ciclo

    power_end:
        ; Limpiar la pila
        add esp, 8 ; Limpiar los argumentos de la pila

        ; Retornar el control al llamador
        ret

; Función para calcular el factorial (2n + 1)!
    factCalc:
        push ebp
        mov ebp, esp
        sub esp, 4

        ; Obtener el argumento de la pila
        mov eax, [ebp+8] ; n

        ; Inicializar el acumulador del factorial
        mov dword [factorial], 1

    fact_loop:
        cmp eax, 1 ; Verificar si n es 1 (fin del ciclo)
        jle fact_end

        ; Calcular el factorial en cada iteración
        mov ebx, [factorial] ; Cargar el valor de 'factorial' en 'ebx'
        imul ebx, eax ; Multiplicar 'factorial' por 'eax'
        mov [factorial], ebx ; Guardar el resultado de vuelta en 'factorial'
        dec eax ; Decrementar n
        jmp fact_loop ; Continuar el ciclo

    fact_end:
        ; Limpiar la pila y retornar el valor del factorial
        mov eax, dword [factorial]
        mov esp, ebp
        pop ebp
        ret

