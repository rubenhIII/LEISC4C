GLOBAL main

section .text
    finit
    main:
        mov ebx, 0
        mov ecx, 0
        mov eax, 0
        mov cx, [n]
        add cx, [n]
        add cx, 1
        call Cpot1 


        Cpot1:          
            call pot1
            loop Cpot1
            jmp pot2            
        pot1:
            fld dword [pow1]
            fld dword [x]
            fmulp
            fst dword [pow1]
            ret

        
        pot2:
            mov eax, 0
            mov eax, [n]
            and eax, 1
            cmp eax, 0b
            jz numpos
            ja numneg
        numpos:
            mov eax, 1
            mov [pow2], eax
            jmp Cfact
        numneg:
            mov eax, -1
            mov [pow2], eax
            jmp Cfact

        
        Cfact:
            mov eax, 0
            mov ebx, 0
            mov ecx, 0
            mov cx, [n]
            add cx, [n]
            add cx, 1
            call fact
            call mult
        fact:
            mov eax, [factorial]
            mul cx
            mov [factorial], eax
            dec cx
            cmp cx, 0
            jz bk
            call fact
            bk:
                ret


        mult:
            finit
            fild dword [pow2]
            fild dword [factorial]
            fdiv
            fstp dword [rdiv]

            finit
            fld dword [rdiv]
            fld dword [pow1]
            fmul
            fstp dword [rmul]
            jmp sumatoria

        
        sumatoria:
            finit
            fld dword [senx]
            fld dword [rmul]
            fadd
            fstp dword [senx]
            dec dword [n]
            cmp dword [n], 1
            jae main
            jmp ultimo
        

        ultimo:
            finit
            fld dword [x]
            fld dword [senx]
            fadd
            fld dword [powaux]
            fsub
            fstp dword [senx]
            jmp ext


        ext:
            mov eax, 1
            mov ebx, 1
            int 0x80    


        

section .data
    senx DD 0.0 
    n DD 3 
    x DD 0.785398
    powaux DD 0.08 
    pow1 DD 1.0
    pow2 DD 1
    factorial DD 1
    rmul DD 1.0
    rdiv DD 1.0

