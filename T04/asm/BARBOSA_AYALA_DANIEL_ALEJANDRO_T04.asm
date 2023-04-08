GLOBAL main
    
    section .text
    finit
        main:
            mov ecx,0
            mov ecx,[cmain] ;Determinamos la cantidad de ciclos del programa

        cicloprinc:
            mov eax,[n] ;Se le da el valor de n al registro eax
            inc eax  ;Aumenta n por cada ciclo
            mov [n],eax ;Se le regresa el valor a n
            call seno ;Se llama a la función principal
            loop cicloprinc ;Ciclo de la función principal
            jmp ext ;Llama a la excepción final

        seno:    
            mov eax,0 ;Se reinician todas las variables por cada iteración          
            mov [cint1],eax 
            mov [cint2],eax
            mov eax,[a]         
            mov [sum],eax
            mov eax,1
            mov [fact],eax
            mov eax,[b]
            mov [opdiv],eax
            call bs ;Calcula la base
            call cic1  ;Primer ciclo interno
            call cic2  ;Segundo ciclo interno
            call divisionproc ;Realiza la división final
            call signoneg ;Determina el signo de cada iteración
            ret

        signoneg: ;Determina el signo que le toca a la iteración actual
            mov eax,[pos]
            cmp eax,0
            je mas
            jne menos
            ret
            
            mas: 
                mov eax,1
                mov [pos],eax
                call suma1
                ret
            
            menos:
                mov eax,0
                mov [pos],eax
                call suma2 
                ret

        bs: ;Genera la base
            mov eax,[n]
            add eax,eax
            inc eax
            mov [base],eax
            ret
        
        cic1:
            call partearriba
            mov eax,[base]
            cmp [cint1],eax
            jnz cint1
            finit
            ret


        partearriba: ;Genera el dividendo de la operación
            mov ebx,[cint1]
            inc ebx
            mov [cint1],ebx
            fld dword [x]
            fld dword [opdiv]
            fmul
            fst dword [opdiv]
            ret

        cic2:
            call FACTORIAL
            mov eax,[base]
            cmp [cint2],eax
            jnz cint2
            ret

        FACTORIAL: ;Genera el factorial (Denominador)
            mov eax,0
            mov ebx,[cint2]
            inc ebx
            mov eax,[fact]
            mul ebx
            mov [fact],eax
            mov [cint2],ebx
            ret
        
        divisionproc: ;Hace la division
            fld dword [opdiv]
            fild dword [fact]
            fdivp
            fstp dword [sum]
            ret
        
        suma1:
            fld dword [sum]
            fld dword [senx]
            faddp
            fstp dword [senx]
            ret

        suma2:
            fld dword [senx]
            fld dword [sum]
            fsubp
            fstp dword [senx]
            ret

        ext:
            mov eax,1
            mov ebx,0
            int 0x80


    section .data
        n: dd -1
        x: dd 0.7853
        cmain: dd 4
        cint1: dd 0
        cint2: dd 0
        pos: dd 0
        base: dd 0
        opdiv: dd 1.0
        fact: dd 1
        senx: dd 0.0
        sum: dd 0.0
        a: dd 0.0
        b: dd 1.0