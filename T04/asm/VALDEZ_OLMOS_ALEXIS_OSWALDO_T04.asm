 ;Alexis Oswaldo Valdez Olmos
 ;Fecha de entrega 07/04/2023
section .text
    GLOBAL _start
    
    _start:
        mov dword[resf],1
        mov dword[pwr],1
        finit
        call c2n
        call pot
        call c2f

        finit
        fld dword[pwr]
        fld dword[resf]
        fdiv
        fst dword[rstdiv]
        
        call signo
        mov ecx,[aux]
        cmp cx,0
        jz cmSig
        cmp cx,1
        je cmSigP

        finit
        fld dword[rstdiv]
        fld dword[senx]
        fadd
        fstp dword[senx]

        inc dword[num]
        cmp dword[num],5
        jne _start
        jmp ext
    
    ;Calcular 2n+1
    c2n:
        finit
        fld dword[num]
        fld dword[const]
        fmulp
        fst dword[potencia]
        inc dword[potencia]

        ret

    ;Caclular Potencia
    pot:
        mov ecx,0
        mov cl,[potencia]
    c1:
        call mult
        loop c1
        ret 

    
    mult:
        finit
        fld dword[x]
        fld dword[pwr]
        fmulp
        fst dword[pwr]

        ret
    
    ;Calcular Factorial
    fac:
        mov ecx,0
        mov cx,[potencia]
    c2f:
        mov eax,[resf]
        mul cx
        mov [resf],eax
        loop c2f

        ret
    
    ;Colocar signo
    signo:
        mov ecx,[aux]       
        cmp cx,0
        jz bk
        mov eax,[rstdiv]
        mov ebx,[sig]
        mul ebx
        mov [rstdiv],eax 
        bk:
        ret
        
    cmSig:
        mov dword[aux],1
        ret
    cmSigP:
        mov dword[aux],0
        ret   

    ext:
        mov ecx,1
        mov ebx,0
        int 0x80
    
    
    
section .data
    num DD 0 ;Numero de iteraciones
    aux DD 0
    sig DD -1
    const DD 2 ;2n+1
    potencia DD 0
    rstdiv DD 0
    resf DD 1  ;Resultado de factorial
    pwr DD 1  ;Resultado de la potencia
    x DD 0.78539 
    senx DD 0
