GLOBAL main
    section .text
        finit
        main:
            mov ecx,0
            mov ecx,[ciclo1] ;Asignamos el numero de ciclos

        c1:
            mov eax,[n] 
            inc eax         ;Incrementamos n
            mov [n],eax
            call calcSen    ;Llamamos al calculo de sen
            loop c1         ;Ciclamos c1 en base al registro c1
            jmp ext         ;Termina la ejecucion

        calcSen:    
            mov eax,0           
            mov [ciclo2],eax    ;Reiniciamos los ciclos
            mov [ciclo3],eax
            mov eax,[a]         
            mov [sum],eax
            mov eax,1
            mov [fact],eax
            mov eax,[b]
            mov [dividendo],eax

            
            call calcBase
            call c2
            call c3
            call calcDivision
            call calcSigno
            ret

        calcSigno:
            mov eax,[turno]
            cmp eax,0
            je positivo
            jne negativo
            ret
            
            positivo:
                mov eax,1
                mov [turno],eax
                call calcSumatoriaA
                ret
            
            negativo:
                mov eax,0
                mov [turno],eax
                call calcSumatoriaB 
                ret

        calcBase:
            mov eax,[n]
            add eax,eax
            inc eax
            mov [base],eax
            ret
        
        c2:
            call calcDividendo
            mov eax,[base]
            cmp [ciclo2],eax
            jnz c2
            finit
            ret


        calcDividendo:
            mov ebx,[ciclo2]
            inc ebx
            mov [ciclo2],ebx
            fld dword [x]
            fld dword [dividendo]
            fmul
            fst dword [dividendo]
            ret

        c3:
            call calcFact
            mov eax,[base]
            cmp [ciclo3],eax
            jnz c3
            ret

        calcFact:
            mov eax,0
            mov ebx,[ciclo3]
            inc ebx
            mov eax,[fact]
            mul ebx
            mov [fact],eax
            mov [ciclo3],ebx
            ret
        
        calcDivision:
            fld dword [dividendo]
            fild dword [fact]
            fdivp
            fstp dword [sum]
            ret
        
        calcSumatoriaA:
            fld dword [sum]
            fld dword [senx]
            faddp
            fstp dword [senx]
            ret

        calcSumatoriaB:
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
        ciclo1: dd 4
        ciclo2: dd 0
        ciclo3: dd 0
        turno: dd 0
        base: dd 0
        dividendo: dd 1.0
        fact: dd 1
        senx: dd 0.0
        sum: dd 0.0
        a: dd 0.0
        b: dd 1.0