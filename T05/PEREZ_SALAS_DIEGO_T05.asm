section .data
     filename db 'archivo.txt', 0
     buffer_size equ 256
     buffer db buffer_size
     counter db 26 dup(0)

 section .text
     global _start

 _start:
     ; Abrir el archivo
     mov eax, 7       ; 
     mov ebx, filename
     mov ecx, 0       ;
     int 0x80         ; 

     ; Guardar el archivo
     mov ebx, eax

     ; Leer el archivo
     mov eax, 5       
     mov edx, buffer_size
     mov ecx, buffer
     int 0x80          

     ; Contar las letras
     mov esi, buffer  ; puntero
     mov ecx, edx    ; longitud del bufer

 count_loop:
     lodsb            
     cmp al, 0      
     je end_count

     cmp al, 'A'
     jb skip_count
     cmp al, 'Z'
     ja skip_count

     sub al, 'A'     ; 
     inc byte [counter + eax]

 skip_count:
     loop count_loop

 end_count:
     ; Cerrar
     mov eax, 6        
     int 0x80         

     ; Mostrar los resultados
     mov esi, counter 
     mov ecx, 26      ; alfabeto

 display_loop:
     mov dl, byte [esi]
     add dl, '0'      ; de numero a caracter
     mov ah, 2        ; imprime el caracter
     int 0x21         

     inc esi
     loop display_loop

     ; Salir del programa
     mov eax, 1       
     xor ebx, ebx     
     int 0x80         