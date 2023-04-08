section .data
base: dd 0.7853     
n: db 10                
pi: dd 6.28318     
senx: dd 1

section .bss
fact: resd 1            
xpow: resd 1            



section .text
global main

 main:
   
    fld dword [base]          
    fld dword [base]           
    fmul st0, st1               
    fstp dword [xpow]         
    fld dword [xpow]            

    
    mov byte al, 1              
    mov byte bl, 1              
    mov byte cl, [n]           

fact_loop:
    cmp al, cl                 
    jge fact_done             
    inc al                     
    imul bl                    
    jmp fact_loop              
fact_done:
    mov dword [fact], ebx      

    
    fld1                       
    fld dword [base]           
    fdiv dword [pi]         
    fadd st0, st0               
    mov byte cl, 0              
 sloop:
	cmp cl, [n] 
	jge series
	mov ebx, dword [fact] 
	mov eax, 2 
	mov edx, 0 
	div ebx 
	mov ebx, eax 
	fdivr dword [fact] 
	fmulp st1, st0 
	fld dword [xpow] 
	fdivr st0, st1 
	faddp st1, st0 
	fld dword [xpow] 
	fmul st0, st1 
	fld1 
	faddp st1, st0 
	fstp dword [xpow]
	inc cl 
	jmp sloop 
series:

	mov eax, 1 
	mov ebx, [n] 
	shl eax, cl 
	fild dword [eax-4] 
	fld dword [base] 
	fprem 
	fmul dword [eax] 
	fadd dword [senx] 
	fstp dword [senx] 

ext: 
mov eax, 1                  
xor ebx, ebx               
int 0x80                    