GLOBAL main

section .text
  finit                     ;Inicializa la FPU
  main:                     ;Programa de pagina
    mov eax, 0              ;Mover el contenido del registro eax igual al valor de 0
    mov ecx, 0              ;Mover el contenido del registro ecx igual al valor de 0
    proceso:                ;Etiqueta de proceso
    call movimiento         ;LLama a la funcion movimiento
    add dword [n], 2        ;Agregar el valor al registro del valor de n y pasarlo a 2
    fld1                    ;Carga a valor a 1
    fstp dword [num]        ;Almacena los datos a la pila con el valor de numero
    dec dword [max]         ;Decrementa el valor de registro con el valor max
    jnz proceso             ;Saltara cuando el valor sea si no es 0 por lo cual salta a la etiqueta proceso
    ;-------                
    ;SALIDA                 
    ;-------                
    ext:                    ;Etiqueta salida
    mov eax, 1              ;Mover el contenido del registro eax igual al valor de 1
    mov ebx, 0              ;Mover el contenido del registro ebx igual al valor de 0
    int 0x80                ;Termina la ejecucion del proceso y del programa

    movimiento:             ;Etiqueta de movimiento
    mov cx, [n]             ;Mover el contenido del registro cx para asi cambiar el valor a n
    cambio:                 ;Etiqueta cambio
    fld dword [x]           ;Carga un valor flontante del valor que tiene en la variable x
    fld dword [num]         ;Carga un valor flontante del valor que tiene en la variable num
    fmulp                   ;Multiplica el parametro
    fstp dword [num]        ;Almacena los datos a la pila con el valor de la variable num
    loop cambio             ;Hace un ciclo de la etiqueta cambio
    ;------
    ;RESTA
    ;------
    mov cx, [n]             ;Mueve el contenido de cx a el valor que se tiene en n
    mov [dun], cx           ;Mueve el contenido que tiene dun al registro cx
    dec cx                  ;Decrementa el registro cx
    changes:                ;Etiqueta changes
    mov ax, [dun]           ;Mueve el valor de ax al valor de la variable dun
    mul cx                  ;multiplica el valor del registro cx
    mov [dun], ax           ;Mueve el valor que tiene
    loop changes            ;Hace un ciclo en changes
    ;--------
    ;DIVIISON
    ;--------
    fld dword [num]         ;Almacena los datos a la pila con el valor de la variable num
    fild dword [dun]        ;Almacena el valor en el dato de dun
    fdivp                   ;Divisor
    fild dword [sig]        ;Almacena el valor en el dato de sig
    fmulp                   ;Multiplicador
    fstp dword [divisor]    ;Hace comparacion con el top de la pila con el valor de divisor
    fild dword [sig]        ;Almacena el valor en el dato de sig
    fchs                    ;Operacion
    fistp dword [sig]       ;Rempalza el valor en el dato de sig
    ;-----                  
    ;SUMAN                  
    ;-----                  
    fld dword [senx]        ;Almacena los datos a la pila con el valor de la variable senx
    fld dword [divisor]     ;Almacena los datos a la pila con el valor de la variable divisor
    faddp                   ;Agregar elemento flotante de adyacencia
    fstp dword [senx]       ;Almacena los datos a la pila con el valor de la variable senx
    ret                     ;Retorna el programa

section .data
sig dd -1                   ;Valor puesto a -1 (Por la operacion)
num dd 1.0                  ;Valor puesto a 1.0
dun dd 0.0                  ;Valor puesto a 0.0
divisor dd 0.0              ;Valor puesto a 0.0
n dd 3                      ;Numero de interacciones
x dd 0.7853                 ;Lo que equivale pi/4
max dd 6                    ;Maxima interaccion
senx dd 0.07853             ;Resultado de este