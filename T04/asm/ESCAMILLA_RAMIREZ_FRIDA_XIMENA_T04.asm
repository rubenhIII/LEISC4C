GLOBAL main
section .data 
    senx DD 0.0 ;resultado
    n DD 3 
    x DD 0.785398
    pow DD 1.0
    pow2 DD 1
    fact DD 1
    multi DD 1.0
    divi DD 1.0
    auxp DD 0.08 

section .text
    finit
main:
 mov ebx, 0
        mov ecx, 0
        mov eax, 0
        mov cx, [n]
        add cx, [n]
        add cx, 1
        call pot 

        ext:
            mov eax, 1
            mov ebx, 1
            int 0x80   

       pot:
            mov eax, dword [x]  
            mov ecx, dword [pow] 
            cmp ecx, 1           
            je pot2
            call pot1            
            loop pot            
            jmp pot2             
        
        pot1:
            fld dword [eax]      
            fld dword [ecx]      
            fmulp                
            fst dword [ecx]      
            ret                 
        
        pot2:
            mov eax, dword [n]    
            and eax, 1            
            cmp eax, 0            
            jz positivo           
        negativo:
            mov dword [pow2], -1  
            jmp Fact             
        positivo:
            mov dword [pow2], 1   
            jmp Fact             

        
        Fact:
            mov eax, 0
            mov ebx, 0
            mov ecx, 0
            mov cx, [n]
            add cx, [n]
            add cx, 1
            call calcFact
            call multiplica

        calcFact:
            mov eax, [fact]
            mul cx
            mov [fact], eax
            dec cx
            cmp cx, 0
            jz bk
            call calcFact
            bk:
                ret

        multiplica:
    
            mov eax, dword [pow2] 
            mov ebx, dword [fact]
            fild dword [eax]      
            fild dword [ebx]      
            fdiv                  
            fstp dword [divi]     
            mov eax, dword [pow] 
            fld dword [divi]      
            fld dword [eax]       
            fmul                  
            fstp dword [multi]   
            jmp suma

        
        suma:
            finit
            fld dword [senx]
            fld dword [multi]
            fadd
            fstp dword [senx]
            dec dword [n]
            cmp dword [n], 1
            jae main
            jmp final
        

        final:
            finit
            fld dword [x]
            fld dword [senx]
            fadd
            fld dword [auxp]
            fsub
            fstp dword [senx]
            jmp ext 