GLOBAL main

section .data
    data    db "data.txt",0 ;archivo de lectura de los datos
    output  db "AVILA_RIVERA_MARIANA_COUNT.txt",0 ;archivo de resultados
    letrasMay db 65
    contLoop db 0
    totalLetras db 0    ;lleva la cuenta del total de letras

    tamBuff equ 2000
    contLetras db 26 dup(0)  ; SE reservan 26 espacios de memoria de tamaño db
                             ; EN el arreglo se  almacenará el conteo de cada letra
    buffDigit dd 0   ;almacena la cadena convertida (numero a cadena)
    string dd "000"  ;guarda la cadena resultante

    ;Para dar formato al archivo:
    nuevaLinea db 10                ; Carácter de nueva línea
    espacio    db ' '   ;
    diagonal   db '/'
section .bss
    buffer resb tamBuff
    iden   resb 1   ;guarda el identificador del archivo abierto

section .text
    main:
        ;Abriendo el archivo de texto
        mov eax, 5    ;Identificador de interrupción (apertura de archivo)
        mov ebx, data ;nombre del archivo
        mov ecx, 0    ; Modo de apertura de lectura 
        ;mov edx, 777  ; Privilegios de lectura, escritura y ejecución para todos
        int 80h ;Ejecución de interrupción

        mov esi, eax ;Se guarda el identificador del archivo en "esi"

        ;Leyendo el contenido del archivo
        mov eax, 3      ;Identificador de interrupción
        mov ebx, esi ;Le pasa el identificador del archivo abierto
        mov ecx, buffer ;Buffer donde se guarda el contenido del archivo
        mov edx, tamBuff;Tamaño del buffer
        int 0x80        ;Lee el contenido del archivo

;//////////////////////////////////////////////////////////
    ;Conteo de letras encontradas
    mov edi, buffer ;Se utiliza "edi" como indice para el desplazamiento del buffer para recorrer cada byte
conteoLetras:
    movzx eax, byte [edi] ;Obtiene la letra actual del archivo 
                                 ;(se usan ceros extendidos pues byte[] es menor al tamaño de eax)
    cmp al, 0 ; COmprueba si se alcanzó el final del búfer
    je finConteo ;Si es el final del buffer salta a "finConteo"

    cmp al, 'A'
    jb incIndice           ; Si es menor que 'A', no es una letra

    cmp al, 'Z'
    ja checkMin           ; Si es mayor que 'Z', comprobar si es una letra minúscula

    ; Contar letra mayúscula
    sub eax, 'A'
    inc byte [contLetras + eax]
    inc byte[totalLetras]

    jmp incIndice

checkMin:
    cmp al, 'a'
    jb incIndice           ; Si es menor que 'a', no es una letra 

    cmp al, 'z'
    ja incIndice           ; Si es mayor que 'z', no es una letra

    ; Contar letra minúscula
    sub eax, 'a'
    inc byte [contLetras + eax]
    inc byte[totalLetras]

incIndice:
    inc edi                     ; Incrementar el índice del búfer
    jmp conteoLetras           ; Volver a contar las letras


finConteo:
     close_file:
    ; Cerrar el archivo de entrada
    mov eax, 6                  ; Llamada al sistema 'close'
    mov ebx, esi                ; Descriptor de archivo
    int 0x80

;///////////////////////////////////////////////////
    
    mov esi, 0          
    
    mov eax,5
    mov ebx, output
      mov ecx, 0102o   ; Modo de apertura (2 = O_WRONLY | O_CREAT)
    mov edx, 0666o         ; Permisos del archivo
    int 0x80              ; Llamada al sistema 
    jmp ptintLoop0

printLoop:

    ;Se abre el archivo en modo escritura
    mov eax, 5
    mov ebx, output
    mov ecx, 2
    mov edx, 777
    int 0x80

ptintLoop0:
    mov [iden]  , eax ;Se guarda el identificador del archivo en "esi"
;Recorrer el offset en archivo
        mov eax, 0x13
        mov ebx, [iden]
        mov ecx, 0
        mov edx, 2
        int 0x80
   
    ; Escribir la letra en el archivo
    mov eax, 4              ; sys_write
    mov edx, [iden]         ; Longitud del dato a escribir
    mov ecx, letrasMay
    mov edx, 1              ; Longitud del dato a escribir
    int 0x80                ; Llamar al sistema operativo

;Escribir un espacio en el archivo
    mov eax, 4              ; sys_write
    mov edx, [iden]              ; Longitud del dato a escribir
    mov ecx, espacio
    mov edx, 1              ; Longitud del dato a escribir
    int 0x80                ; Llamar al sistema operativo

    mov eax,dword[contLetras+esi]  ; Cargar el valor de totalLetras en EAX
    mov dword[buffDigit], eax
    mov al, byte [buffDigit]
    call numToStr                     ; Llamar a la función itoa
     ; Escribir la cantidad leida
    mov eax, 4              ; sys_write
    mov edx, [iden]              ; Longitud del dato a escribir
    mov ecx, string     ;la cadena de números a imprimir
    mov edx, 3        ; Longitud de la cadena a escribir
    int 0x80                ; Llamar al sistema operativo

     ;Escribir un signo de / en el archivo
    mov eax, 4              ; sys_write
    mov edx, [iden]              ; Longitud del dato a escribir
    mov ecx, diagonal
    mov edx, 1              ; Longitud del dato a escribir
    int 0x80                ; Llamar al sistema operativo

    mov eax,dword[totalLetras]  ; Cargar el valor de totalLetras en EAX
    mov dword[buffDigit], eax
    mov al, byte [buffDigit]
    call numToStr                     ; Llamar a la función itoa
 ; Escribir el total de letras
    mov eax, 4              ; sys_write
    mov edx, [iden]              ; Longitud del dato a escribir
    mov ecx, string     ;la cadena de números a imprimir
    mov edx, 3         ; Longitud de la cadena a escribir
    int 0x80                ; Llamar al sistema operativo

    ; Escribir el carácter de nueva línea
    mov eax, 4              ; sys_write
    mov ebx, [iden]              ; Descriptor de archivo estándar de salida (STDOUT)
    mov ecx, nuevaLinea        ; Dirección del carácter de nueva línea
    mov edx, 1              ; Longitud del dato a escribir
    int 0x80                ; Llamar al sistema operativo

;Cerrar el archivo
        mov eax, 6
        mov ebx, [iden]
        int 0x80

    ; Incrementar el índice y repetir el bucle
    inc byte[letrasMay]
    inc esi
    mov [contLoop],esi ; Se actualiza el contador
    cmp esi, 26            ; Comprobar si hemos alcanzado el final del abecedario
    je exit                 ; Salir del bucle si es así

   jmp printLoop ; Continua en el LOOP
   jmp exit    ;Salta a la etiqueta de salida

;-------------- Obtiene digitos de contador --------------------------------
numToStr:
 pusha                 ; Guardar los registros generales en la pila
    mov dword[string],"000"
    xor eax, eax          ; Limpiar el registro eax
    xor ebx, ebx          ; Limpiar el registro ebx

    movzx ebx, byte[buffDigit]   ; Cargar el número en el registro ebx

    cmp ebx, 0             ; Verificar si el número es cero
    jne .check_hundreds   ; Saltar si no es cero

    inc ebx               ; Incrementar ebx para avanzar a la siguiente posición

    jmp finToString             ; Saltar al final de la función

.check_hundreds:
    cmp ebx, 100           ; Verificar si el número es mayor o igual a 100
    jl .check_tens        ; Saltar si es menor a 100

    mov eax, ebx
    xor edx, edx          ; Limpiar el registro edx para la división

    mov ecx, 100          ; Divisor
    div ecx               ; Dividir ebx por 100, el cociente queda en eax

    add eax, '0'           ; Convertir el cociente a caracter

    mov byte[string], al      ; Colocar el caracter en la cadena de salida
    ;inc ebx               ; Incrementar ebx para avanzar a la siguiente posición
    mov bl,ah    ;guarda el residuo
.check_tens:
    cmp ebx, 10            ; Verificar si el número es mayor o igual a 10
    jl .ones_digit        ; Saltar si es menor a 10

    xor edx, edx          ; Limpiar el registro edx para la división

    mov eax, ebx
    mov ecx, 10           ; Divisor
    div ecx               ; Dividir ebx por 10, el cociente queda en eax

    add eax, '0'           ; Convertir el cociente a caracter

    mov byte[string+1], al    ; Colocar el caracter en la cadena de salida
    ;inc ebx               ; Incrementar ebx para avanzar a la siguiente posición
    mov bl,ah    ;guarda el residuo

.ones_digit:
    add ebx, '0'           ; Convertir el número en las unidades a caracter
    mov byte[string+2], bl    ; Colocar el caracter en la cadena de salida

finToString:
    mov byte [string+3], '0'
    popa                  ; Restaurar los registros generales desde la pila
    ret                   ; Retornar de la función
    
exit:
    mov eax, 1  ;Fin del programa
    int 0x80
        


