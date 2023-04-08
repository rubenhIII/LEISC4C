GLOBAL main

;SEBASTIAN RODRIGUEZ HERNANDEZ
;Sen de 0.7853

section .data
    dato:    DD 0.7853
    aproximado:    DD 6
    datoaux:    DD 1.0
    operan:  DD 0.0
    sendato: DD 0.0

section .text
    main:
        mov edx,[aproximado]
        mov eax,[dato]
        mov [sendato],eax 
        mov eax,1
        mov [aproximado],eax
    suma:
        mov eax,2
        mov ebx,[aproximado]
        mul ebx
        add eax,1
        mov ecx
        sub ecx,1
        mov [operan],ecx
        FINIT
        FLD DWORD [dato]
        FLD DWORD [dato]
        
    exponencial:
        FMUL st0,st1
        FIST DWORD [aux]  
        mov eax
        dec ecx
        loop exponencial
        mov ebx, 1
        
    factorial:
        cmp ecx, 0
        je nextStep
        imul ebx
        dec eax      
        dec ecx      
        jmp factorial

    next:
        mov [operan],ebx
        FILD DWORD [operan]
        FDIVP st1,st0
        mov eax,-1
        mov ebx,[datoaux]
        imul ebx
        mov [i],eax
        FILD DWORD [datoaux]
        FMUL st0,st1
        FLD DWORD [sendato]
        FADD
        FSTP DWORD [sendato]
        mov eax,[aproximado]
        cmp edx
        ja  mostrar;

        inc eax
        mov [aproximado],eax
        jmp suma
    mostrar:
        jmp exit

    exit:  
        add esp, 8
        mov eax, 1
        xor ebx
        int 0x80 