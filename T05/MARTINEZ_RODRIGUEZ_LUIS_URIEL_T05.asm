
GLOBAL main

section .data
    archivo db "data.txt", 0                     
    resultado db "MARTINEZ_RODRIGUEZ_LUIS_URIEL_COUNT.txt", 0              
    output_buffer db "A  n° ", 0                  
section .bss
    file_handle resb 4                           
    read_status resb 4                          
    count resb 26                                

section .text

main:
   
    mov eax, 5                                
    mov ebx, archivo                            
    xor ecx, ecx                                
    xor edx, edx                               
    int 0x80                                   

    mov [file_handle], eax                      

    
    mov eax, 3                                  
    mov ebx, [file_handle]                      
    mov ecx, buffer                            
    mov edx, 100                               
    int 0x80                                    

    
    xor esi, esi                               
    xor edi, edi                                

count_letters:
    cmp byte [buffer + edi], 0                   
    je end_counting

    mov al, byte [buffer + edi]                  

    
    cmp al, 'A'
    jb next_character
    cmp al, 'Z'
    ja next_character

    
    sub al, 'A'                                 
    add byte [count + esi], 1                   
next_character:
    inc edi                                   
    jmp count_letters

end_counting:
   
    mov eax, 6                                 
    mov ebx, [file_handle]                     
    int 0x80                                    

    
    mov eax, 5                                
    mov ebx, resultado                          
    mov ecx, 1                                 
    mov edx, 0o644                              
    int 0x80                                   

    mov [file_handle], eax                      

   
    mov esi, 0                                

write_results:
    cmp esi, 26                                
    jge end_program

   
    mov eax, 4                                 
    mov ebx, [file_handle]                     
    mov ecx, output_buffer                     
    add cl, byte [alphabet + esi]               
    int 0x80                                    

   
    mov eax, 4                                
    mov ebx, [file_handle]                     
    mov ecx, [count + esi]                       
    mov edx, 1                                  
    int 0x80                                   

    
    mov eax, 4                                 
    mov ebx, [file_handle]                     
    mov ecx, newline                            
    mov edx, 1                                  
    int 0x80                                    

    inc esi                                    
    jmp write_results

end_program:
   
    mov eax, 6                                 
    mov ebx, [file_handle]                     
    int 0x80                                   

   
    mov eax, 1                               
    xor ebx, ebx                               
    int 0x80                                   

section .data
    alphabet db "ABCDEFGHIJKLMNOPQRSTUVWXYZ" 
    buffer db 100                               
    newline db 0x0A                            
