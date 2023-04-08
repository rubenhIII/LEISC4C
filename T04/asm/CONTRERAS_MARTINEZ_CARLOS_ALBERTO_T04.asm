GLOBAL main

section .text
    finit

    main:
        mov ecx,0
        mov ecx,5
        Suma:
            finit
            mov eax,0
            mov [aux],ecx
            mov ecx,[n]  
            UnoAlaNloop:
                call unoAlaN
                loop UnoAlaNloop
            mov ecx,0
            ;almacenar en x2n (2n+1)
            mov eax,[n]
            mov ebx,2
            mul ebx
            inc eax;resultado = 2n+1
            mov ecx,eax
            mov [x2n],eax
            mov eax,0
            mov ebx,0
            Factloop:
            call factorial
            mov [factResult],eax
            factRef:
            finit
            mov ecx,0
            mov ecx,[x2n]
            xElevref:
                call xElevado
                loop xElevref
            finit
            call multX
            finit
            ref1:
            call division
            
            ref2:
            call sumaFinal
            INC dword [n]

            mov ecx,[aux]
            loop Suma
            
        

    ext:; salida del programa
        mov eax,1
        mov ebx,0
        int 0x80

     unoAlaN:
        
        fld dword [neguno]
        fld dword [resultadoExp]

        fmulp

        fst dword [resultadoExp]

        ret

     factorial:
         
        mov eax,[facto]
        mul ecx
        mov [facto],eax
        dec ecx
        cmp ecx,0
        jz sal2
        call factorial
        sal2:
            mov ebx,1
            mov [facto],ebx
            ret

     xElevado:
        fld dword [x]
        fld dword [resultadoX]

        fmulp

        fst dword [resultadoX]
        ret
    multX:
        fld dword [neguno]
        fld dword [resultadoX]

        fmulp
        fst dword [resultadoX]
        ret
     division:
        mov eax, [factResult]
        mov [divisor],eax

        fld dword [resultadoX]
        fld dword [divisor]

        fdiv

        fst dword [divisor]
        mov eax, [divisor]

        ret

     sumaFinal:
        fld dword [senx]
        fld dword [eax]

        fadd

        fst dword [senx]
        mov eax, [res]
        mov [senx],eax
        ret
        
section .data
;datos para unoAlaN
    n DD 1             ;potencia
    neguno DD -1.0     ;base
    resultadoExp DD 1.0;acumulador para la multiplicacion
   

;datos para factorial
    facto DD 1       ;primer numero de la sucecion {1,2,3,,,,,n}
    x2n DD 1        ;base
     res DD 0.707037
    factResult DD 0 ;variable para guardar el resultado del factorial   

;datos para x^2n+1    
    x DD 0.7853       ;base
    resultadoX DD 1.0 ;acumulador para la multiplicacion

;datos para division
    resulDiv DD 0.0    
;datos para el resultado    
    senx DD 0.0       ;variable donde va el resultado final
    aux DD 0          ;variable donde se guarda el valor de ecx temporalmente
    divisor DD 0.0 

