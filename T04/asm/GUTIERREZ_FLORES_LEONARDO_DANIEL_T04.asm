GLOBAL main

section .text
    finit
    main:
        mov eax, 0              ;limpiamos los registros
        mov ebx, 0
        mov ecx, 0
        mov bh, 4               ;en bh guardamos el numero de veces a repetir la formula
      seno:
        mov dword [fact],1      ;regresamos las variables al estado incial
        mov eax,[one]
        mov dword [potencia],eax
        mov eax,[zero]
        mov dword [divic],eax
        ;2n+1-----------------------------------
        mov al,2                ;movemos el 2 al registro al para posteriormente multilicarlo por bl, el cual seria en este caso n
        mul bl
        inc al                  ;incrementamos al en uno ya que este guardo el valor de la multiplicacion y le sumariamos el 1
        mov [repf],al           ;movemos el resultado a nuestra variable para posteriormente guardarlo en cl para los loop
        inc bl                  ;incrementamos bl ya que solo la n se ocupara para estos anteriores pasos
        mov cl,[repf]           ;guardamos en cl para los loop
        ;----------------------------------------
    potencial:;***********************************
        fld dword [operando]    ;Guardamos el operando en la pila
        fld dword [potencia]    ;Guardamos la potencia actual a multiplicar
        fmulp                   ;multiplicamos el operando por la potencia
        fstp dword [potencia]   ;guardamos el resultado en potencia y limiamos la pila
        loop potencial           ;regresa a la etiquieta potencia segun cuantas veces lo necesite segun el resultado almacenado en cl
        mov eax, 0              ;limpiamos ax y cx
        mov ecx, 0
        mov cl,[repf]           ;volvemos a guardar nuestro resultado anteriormente obtenido en cl ya que en este momento estaria en 0
        ;****************************************
        mov ax, [fact]          ;movemos lo que tenemos en el factorial hacia el registro ax
    factorial:;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!        
        mul cl                  ;lo multiplicamos por lo que tenemos en cl con ello multiplicaremos gracias al loop uno menos
        loop factorial
        ;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
        mov [fact],eax          ;guardamos el resultado en nuestra variable factorial
        fld dword [potencia]    ;guardamos en la pila lo que obtubimos en el potencial
        fild dword [fact]       ;agrupamos tambien el factorial
        fdivp                   ;dividimos  el factorial entre el potancial
        fst dword [divic]       ;guarda el valor de la divicion en nuestra variable divic
        call Fin                ;nos vamos a la subrutina final la cual servira para sumar
        dec bh                  ;decrementamos bh para poder hacer los saltos n veces sobrantes
        CMP bh,0                ;compara bh con 0
        JNE seno                ;si no es 0 brinca de regreso a seno
        call ext                ;si es 0 terminamos el programa
Fin:
        cmp byte [sing],0       ;comparamos el signo para saber si es positivo o negativo
        je sumar                ;llamamos a sumar si no es
        fchs                    ;si es 0 cambiamos el signo
    sumar:
        fld dword [senx]        ;guardamos lo que tenemos en senx en la pila
        faddp                   ;sumamos lo que tenemos en la posicion pprincipal y luego sacamos la pocicion inicila de la pila
        fstp dword [senx]       ;guardamos el resultado de la pila en senx
        cmp byte [sing],0       ;comparamos el signo si cambio
        je chsing               ;si no cambio nos vamos al cambio de signo
        mov byte [sing],0       ;si cambio lo volvemos a regresar a 0 para sumarlo despues
        ret 
        chsing:
            mov byte [sing],1       ;Cambiamos sing para que el siguiente sea resta cuando
            ret
ext:
        MOV ECX, 1
        MOV EBX, 0
        INT 0X80 
        
section .data
    senx:   dd 0.0              ;variable la cual guardara el resultado final
    operando: dd 0.7853         ;el operando que se va a utilizar en el programa en este caso pi/4
    repf:   db 0                ;variable para almacenar el resultado de la suma y multiplicacion de 2n+1
    potencia: dd 1.0               ;guarda el resultado de la potencia
    fact: dd 1                  ;guarda el resultado del factorial
    divic: dd 0.0               ;guarda el resultado de la division
    sing:   db 0                ;almacena la bandera la cual nos dira si se va a restar o sumar
    zero:   dd 0.0              ;guarda un 0 en punto flotante para luego utilizarlo en la limpieza de nuestras variables
    one:   dd 1.0               ;guarda un 1 en punto flotante para luego utilizarlo en la limpieza de nuestras variables