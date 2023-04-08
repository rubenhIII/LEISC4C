;Asly Lizbeth Salinas Morales
;ISC 4-C
GLOBAL main

section .text
  finit                     
  main:                     
    mov eax, 0              
    mov ecx, 0              
    proceso:                
    call movimiento         
    add dword [n], 2        
    fld1                    
    fstp dword [num]        
    dec dword [max]         
    jnz proceso             
                   
    ext:                    
    mov eax, 1              
    mov ebx, 0              
    int 0x80                

    movimiento:             
    mov cx, [n]             
    cambio:                 
    fld dword [x]           
    fld dword [num]         
    fmulp                   
    fstp dword [num]        
    loop cambio             
   
    mov cx, [n]             
    mov [dun], cx           
    dec cx                  
    changes:                
    mov ax, [dun]           
    mul cx                  
    mov [dun], ax           
    loop changes            

    fld dword [num]         
    fild dword [dun]        
    fdivp                   
    fild dword [sig]        
    fmulp                   
    fstp dword [divisor]    
    fild dword [sig]        
    fchs                    
    fistp dword [sig]       

    fld dword [senx]        
    fld dword [divisor]     
    faddp                   
    fstp dword [senx]       
    ret                     

section .data
sig dd -1                   
num dd 1.0                  
dun dd 0.0                  
divisor dd 0.0              
n dd 3                      
x dd 0.7853                 
max dd 6                    
senx dd 0.07853