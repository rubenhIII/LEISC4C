GLOBAL main

section .text
main:

mov edx, [valor] ;numero de aproximaciones de la series de taylor a realizar
mov eax, [valor] ;se añade el valor base al registro
mov [senx], eax ;ese valor pasa a la variable que contendra el seno
mov eax, 1
mov [nIt], eax

sumDen:
    mov eax, 2 ; proceso del factorial 2n+1
    mov ebx, [nIt]
    mul ebx
    add eax, 1
    mov ecx, eax ;mueve al contador el valor que se almaceno en el regsitro
    
    sub ecx, 1       
    mov [oper], ecx

    finit          ;punto flotante
    fld dword [valor]
    fld dword [valor]

    
    potencia: ;calcula la potencia

        fmul st0, st1
        loop potencia

        fist dword [oper]  
        mov ecx, eax
        dec ecx
        mov ebx, 1

    
    fact: ;se calcula el factorial
        cmp ecx, 0    ; si aun no se han hecho todas las iteracciones
        je division

        imul ebx, eax ;multiplicacion
        dec eax       
        dec ecx       ; decrementa el contador
        
        jmp fact  ;brinca hasta que se hagan el numero de iteracciones, el cual se hace la comparacion en el inicio del ciclo

    division:
        
        mov [oper], ebx    ; mueve el resultado temporal al regsitro
        fild dword [oper] ; el resultado del factorial se carga en la pila
        fdivp st1, st0    ; ejecuta la division del factorial y el exponente

        mov eax, [signo] ;se carga el signo negativo que ayudara para determinar los impares, que es sobre el cual se hace la serie de taylor
        mov ebx, [facIt]
        imul ebx
        mov [facIt], eax
        fild dword [facIt]
    
        
        fmul st0, st1 ;multiplica el valor contenido en la pila por el coeficiente tambien cargado en al formula del seno

    
    fld dword[senx] 
    fadd ;suma de las iteraciones hasta el numero de aproximaciones
    fstp dword [senx] ;copia el valor del seno en la pila, y/o se carga

    
    mov eax, [nIt] ;repite el numero de aproximaciones
    cmp eax, edx
    ja  salida      

    inc eax ;incrementa las iteracciones que se llevan, esto hasta que sean igual a 3 en esto caso (numero de aproximaciones)
    mov [nIt], eax ;se pasa el valor a la variable de control
    jmp sumDen  ; iteraciones del denominador


ext:  
    mov eax, 1
    xor ebx, ebx
    int 0x80



salida:
    FINIT             ; vacia la pila fpu
    fld dword [senx]  ; Carga el resultado en la pila en la variable que contendra el resultado del seno
    sub esp, 8         
    fstp qword [esp]  


    add esp, 12        ; Libera la pila
    jmp ext

section .data

valor: DD 0.7853 ;Valor a calcular del seno
nIt: DD 3 ; numero de aproximaciones
facIt: DD 1 ;factorial
signo: DD -1 ;signo
oper: DD 0.0 ;variable que hara las operaciones
senx: DD 0.0 ;variable del resultado