section .text
    global _start
    
_start:
    mov dword [resultado], 1
    mov dword [potencia], 1
    finit
    call calcular_n
    call calcular_potencia
    call calcular_factorial

    finit
    fld dword [potencia]
    fld dword [resultado]
    fdiv
    fst dword [resultado_dividido]
    
    call calcular_signo
    mov ecx, [auxiliar]
    cmp cx, 0
    jz comparar_signo
    cmp cx, 1
    je comparar_signo_positivo

    finit
    fld dword [resultado_dividido]
    fld dword [senx]
    fadd
    fstp dword [senx]

    inc dword [numero]
    cmp dword [numero], 5
    jne _start
    jmp salir

calcular_n:
    finit
    fld dword [numero]
    fld dword [constante]
    fmulp
    fst dword [potencia]
    inc dword [potencia]

    ret

calcular_potencia:
    mov ecx, 0
    mov cl, [potencia]
calcular_potencia_loop:
    call multiplicar
    loop calcular_potencia_loop
    ret 

multiplicar:
    finit
    fld dword [x]
    fld dword [potencia]
    fmulp
    fst dword [potencia]

    ret

calcular_factorial:
    mov ecx, 0
    mov cx, [potencia]
calcular_factorial_loop:
    mov eax, [resultado]
    mul cx
    mov [resultado], eax
    loop calcular_factorial_loop

    ret

calcular_signo:
    mov ecx, [auxiliar]
    cmp cx, 0
    jz hacer_backup
    mov eax, [resultado_dividido]
    mov ebx, [signo]
    imul eax, ebx
    mov [resultado_dividido], eax 
hacer_backup:
    ret

comparar_signo:
    mov dword [auxiliar], 1
    ret

comparar_signo_positivo:
    mov dword [auxiliar], 0
    ret

salir:
    mov ecx, 1
    mov ebx, 0
    int 0x80
      
section .data
    numero dd 0 
    auxiliar dd 0
    signo dd -1
    constante dd 2 
    potencia dd 0
    resultado_dividido dd 0
    resultado dd 1  
    x dd 0.78539 ; Valor en radianes
    senx dd 0 ; Resultado de sen(x)
