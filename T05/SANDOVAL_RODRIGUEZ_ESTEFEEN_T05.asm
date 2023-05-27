GLOBAL main

section .text
main:
    mov eax, 5
    mov ebx, filename
    mov ecx, 2
    mov edx, 777
    int 0x80

    mov [file_descriptor], eax
    mov eax, 3
    mov ebx, [file_descriptor]
    mov ecx, buffer
    mov edx, buffer_size
    int 0x80

    mov eax, 6
    mov ebx, [file_descriptor]
    int 0x80

    mov eax, 5
    mov ebx, filename2
    mov ecx, 2
    mov edx, 777
    int 0x80

    mov [file_descriptor2], eax
    mov ecx, 52
    mov eax, 0

    busca:
        mov edx, -1
        mov [current_index], edx

    cad:
        mov edx, [current_index]
        inc edx
        mov [current_index], edx

        mov edi, [current_index]
        mov esi, buffer
        add esi, edi

        mov al, [esi]

        cmp al, [letter]
        jne eval
        mov edx, [data_count]
        inc edx
        mov [data_count], edx

    eval:
        mov edx, 12
        cmp [current_index], edx
        jb cad
        call insersion

        mov edx, [letter]
        inc edx
        mov [letter], edx

        mov edx, 0
        mov [data_count], edx

        loop busca

    insersion:
        mov [temp_count], ecx
    
        mov edx, [data_count]
        add edx, 48
        mov [data_count], edx

        mov eax, 4
        mov ebx, [file_descriptor2]
        mov ecx, letter
        mov edx, 1
        int 0x80

        mov eax, 4
        mov ebx, [file_descriptor2]
        mov ecx, space
        mov edx, 1
        int 0x80

        mov eax, 4
        mov ebx, [file_descriptor2]
        mov ecx, data_count
        mov edx, 1
        int 0x80

        mov eax, 4
        mov ebx, [file_descriptor2]
        mov ecx, newline
        mov edx, 1
        int 0x80

        mov ecx, [temp_count]

        ret

    ext1:
        mov eax, 6
        mov ebx, [file_descriptor2]
        int 0x80
        mov eax, 1
        int 0x80

section .data
    filename db "data.txt", 0
    filename2 db "ESTEFEEN_SANDOVAL_RODRIGUEZ.txt", 0
    buffer_size equ 15
    letter db 65
    current_index dd -1
    space db 35
    newline db 10
    data_count db 0
    temp_count dd 0

section .bss
    file_descriptor resw 1
    file_descriptor2 resw 1
    separator resd 5
    buffer resb buffer_size

