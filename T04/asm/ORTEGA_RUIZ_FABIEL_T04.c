GLOBALES  principal

sección .datos
    x: DD 0 . 7853 ;
    n: DD 6       ;
    i: DD 1       ;
    auxiliar: DD 0 . 0     ;
    senx: DD 0 . 0     ;
    ;mensaje DD "Valor senx: %f", 10, 0

sección .texto
    principal:
        ;principal del ciclo n=0 an
        mov edx ,[ n ]     ;limite 
        mov eax ,[ x ] 
        mov [ senx ], eax  
        mov eax , 1 
        mov [ norte ], eax 
    suma:
        ;2n+1
        mov eax , 2 
        mov ebx ,[ norte ] 
        mul ebx 
        añadir eax , 1 
        mov ecx , eax 
        sub ecx , 1        ; bucle 
        mov [ aux ], ecx 
        FINIT            ;Inicia FPU
        FLD DWORD [ x ]
        FLD DWORD [ x ]

        ;x'(2n+1)
        exposición:
            FMUL st0 , st1
            exposición de bucle
        FIST DWORD [ aux ]
        mov ecx , eax  
        diciembre ecx 
        mov ebx , 1  

        ;(2n+1)!
        hecho:
            cmp ecx , 0     ;
            imul ebx , eax ; 
            dec eax        ; 
            diciembre ecx        ; 
            hecho jmp

        próximo:

            ;x'(2n+1) / (2n+1)!
            mov [ aux ], ebx     ;
            FILD DWORD [ aux ] ;

            FDIVP st1 , st0     ;

            ;-1'(n)
            mov eax ,- 1 
            mov ebx ,[ yo ] 
            imul ebx 
            mov [ yo ], eax 
            FILD DWORD [ i ]
        
        ;(-1)'n * x'(2n+1) / (2n+2)!
        FMUL st0 , st1

        ;suma
        FLD DWORD [ senx ]
        FADD
        FSTP DWORD [ senx ]

        ;ciclo (n;n>=0;n--)
        mov eax ,[ norte ] 
        cmp eax , edx 
        ja   imprimir        ;

        inc . 
        mov [ norte ], eax 
        jmp suma   ;Ciclo

    imprimir:
        ;finito             
        ; fstp qword [esp]
        ; mov eax, 0        
        ; mov ebx, mensaje      
        ; empujar mensaje
        ; llama a printf;
        salida jmp

    salida:  
        add esp , 8       ;
        mov eax , 1  
        x o ebx , ebx  
        int 0x80 