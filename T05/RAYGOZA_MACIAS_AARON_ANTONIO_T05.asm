GLOBAL MAIN

section .data
    msgFalla1   db 'Fallo: No se pudo abrir el archivo', 10
    msgFalla2   equ $ - msgFalla1
    arch  db 'data.txt', 0
    archSalida db 'RAYGOZAMACIAS_AARONANTONIO_COUNT.txt', 0
    comparar    db 'abcdefghijklmnopqrstuvwxyz', 0
    contador   db '%c %d', 0
    auxLine     db 10, 0

section .bss
    cont      resb 26

section .text
    extern printf
    global inicio

inicio:
    mov eax, 5                
    mov ebx, arch    
    mov ecx, 0            
    int 0x80                 
    test eax, eax           
    js excepcionNASM              
    mov ebx, eax

leer:
    mov eax, 3                 
    mov ecx, ebx              
    mov edx, cont            
    mov esi, 26                 
    int 0x80
    test eax, eax            
    js excepcionNASM               
    cmp eax, 0                  
    je contarSalir 
    xor esi, esi              

contar:
    movzx edx, byte [cont + esi]
    add edx, 'A'                
    mov [contador + 1], dl     
    push esi                    
    push contador            
    call printf             
    add esp, 8   
    push dword auxLine         
    call printf                 
    add esp, 4                  
    inc esi                     
    cmp esi, 26              
    jne contar              
    jmp leer              

contarSalir:
    mov eax, 6                  
    mov ebx, ebx              
    int 0x80                 
    mov eax, 5                  
    mov ebx, archSalida   
    mov ecx, 641                
    mov edx, 384                
    int 0x80                    
    test eax, eax               
    js excepcionNASM               
    mov ebx, eax
    xor esi, esi                

escribirFun:
    movzx edx, byte [cont + esi]
    add edx, 'A'                
    mov [contador + 1], dl     
    push esi                   
    push contador              
    push ebx                    
    mov eax, 4                 
    mov ecx, esp               
    mov edx, 5                  
    int 0x80                    
    add esp, 12                 
    inc esi                    
    cmp esi, 26                 
    jne escribirFun              
    mov eax, 6                  
    mov ebx, ebx               
    int 0x80                
    mov eax, 1                  
    xor ebx, ebx               
    int 0x80                   

excepcionNASM:
    mov eax, 4                 
    mov ebx, 2                 
    mov ecx, msgFalla1          
    mov edx, msgFalla2         
    int 0x80                    
    mov eax, 1                  
    mov ebx, 1                  
    int 0x80                   

