;Nombre: Gerardo Castañeda Martin
;SERIE DE TAYLOR

GLOBAL main

section .text ;Inicio de la sección de código
    FINIT

    main: ;Inicio de la función _start

        ;Inicialización de variables
        mov dword[resultado_factorial], 1 ;Inicialización de resultado_factorial a 1
        mov dword[potencia_actual], 1 ;Inicialización de potencia_actual a 1
        finit ;Inicialización de la unidad de coma flotante de punto flotante

        ;Llamadas a funciones para realizar cálculos
        call calcular_2n_mas_1 ;Llamada a función para calcular 2n+1
        call calcular_potencia ;Llamada a función para calcular la potencia
        call calcular_factorial ;Llamada a función para calcular el factorial

        ;Cálculo final
        finit ;Inicialización de la unidad de coma flotante de punto flotante
        fld dword[potencia_actual] ;Cargar la potencia actual en la pila
        fld dword[resultado_factorial] ;Cargar el resultado del factorial en la pila
        fdiv ;Dividir la potencia actual por el resultado del factorial
        fst dword[resultado_division] ;Guardar el resultado de la división en resultado_division

        ;Llamada a función para asignar el signo
        call asignar_signo

        ;Comparación de signo
        mov ecx, [auxiliar] ;Cargar auxiliar en el registro ecx
        cmp cx, 0 ;Comparar auxiliar con cero
        jz comparar_signo ;Saltar a comparar_signo si auxiliar es cero
        cmp cx, 1 ;Comparar auxiliar con uno
        je comparar_signo_positivo ;Saltar a comparar_signo_positivo si auxiliar es uno

        ;Cálculo final
        finit ;Inicialización de la unidad de coma flotante de punto flotante
        fld dword[resultado_division] ;Cargar el resultado de la división en la pila
        fld dword[senx] ;Cargar el valor actual de senx en la pila
        fadd ;Sumar el resultado de la división con el valor actual de senx
        fstp dword[senx] ;Guardar el resultado en senx

        ;Incremento del número de iteraciones y comparación con 5
        inc dword[num_iteraciones] ;Incrementar el número de iteraciones en 1
        cmp dword[num_iteraciones], 5 ;Comparar el número de iteraciones con 5
        jne main;Saltar a main si el número de iteraciones es menor a 5
        jmp salir ;Saltar a salir para finalizar el programa

    ;Función para calcular 2n+1
    ;Calcular 2n+1
calcular_2n_mas_1:
    finit                   ; Iniciar la unidad de coma flotante
    fld dword[num_iteraciones]  ; Cargar el valor de num_iteraciones en la pila de FPU
    fld dword[constante_2n_mas_1]  ; Cargar la constante 2n+1 en la pila de FPU
    fmulp                   ; Multiplicar los dos valores superiores en la pila y colocar el resultado en la parte superior
    fst dword[potencia_actual]    ; Almacenar el resultado en potencia_actual
    inc dword[potencia_actual]    ; Incrementar potencia_actual

    ret                     ; Retornar al llamador

;Calcular Potencia
calcular_potencia:
    mov ecx, 0              ; Inicializar el contador a cero
    mov cl, [potencia_actual]   ; Cargar el valor de potencia_actual en el contador
c1:
    call multiplicar        ; Llamar a la subrutina multiplicar
    loop c1                 ; Decrementar el contador y saltar a c1 si no es cero
    ret                     ; Retornar al llamador

multiplicar:
    finit                   ; Iniciar la unidad de coma flotante
    fld dword[valor_x]      ; Cargar el valor de valor_x en la pila de FPU
    fld dword[potencia_2]  ; Cargar el valor de potencia_actual en la pila de FPU
    fmulp                   ; Multiplicar los dos valores superiores en la pila y colocar el resultado en la parte superior
    fst dword[potencia_2]    ; Almacenar el resultado en potencia_actual

    ret                     ; Retornar al llamador

;Calcular Factorial
calcular_factorial:
    mov ecx, 0              ; Inicializar el contador a cero
    mov cx, [potencia_actual]   ; Cargar el valor de potencia_actual en el contador
c2f:
    mov eax, [resultado_factorial] ; Cargar el valor de resultado_factorial en el registro eax
    mul cx                  ; Multiplicar eax por cx y colocar el resultado en eax
    mov [resultado_factorial], eax  ; Almacenar el resultado en resultado_factorial
    loop c2f                ; Decrementar el contador y saltar a c2f si no es cero

    ret                     ; Retornar al llamador

;Colocar signo
asignar_signo:
    mov ecx, [auxiliar]     ; Cargar el valor de auxiliar en el registro ecx
    cmp cx, 0               ; Comparar cx con cero
    jz volver               ; Saltar a volver si cx es cero
    mov eax, [resultado_division]   ; Cargar el valor de resultado_division en el registro eax
    mov ebx, [signo]        ; Cargar el valor de signo en el registro ebx
    mul ebx                 ; Multiplicar eax por ebx y colocar el resultado en eax
    mov [resultado_division], eax  ; Almacenar el resultado en resultado_division
volver:
    ret                     ; Retornar al llamador

comparar_signo:
    mov dword[auxiliar], 1 ; Asignar 1 a auxiliar
    ret                     ; Retornar al llamador
    comparar_signo_positivo:
        mov dword[auxiliar], 0
        ret   

    salir:
        ; Salir del programa
        mov ecx, 1
        mov ebx, 0
        int 0x80
    
    
    
section .data
    ; Variables de la sección de datos
    num_iteraciones DD 0  ; Número de iteraciones
    auxiliar DD 0  ; Variable auxiliar para determinar el signo
    signo DD -1  ; Signo para el resultado de la división
    constante_2n_mas_1 DD 2  ; Constante utilizada para calcular la potencia
    potencia_actual DD 0 ; Potencia actual
    resultado_division DD 0  ; Resultado de la división de la potencia y el factorial
    resultado_factorial DD 1  ; Resultado del factorial
    potencia_2 DD 1.0;Resultado potencia
    valor_x DD 0.785398  ; Valor de x
    senx DD 0 ; Resultado de sen(x)