section .data
    file_name db 'data.txt', 0
    count_output db 'conteo.txt', 0
    alphabet db 'A-B-C-D-E-F-G-H-I-J-K-L-M-N-O-P-Q-R-S-T-U-V-W-X-Y-Z', 0

section .bss
    file_handle resb 8
    char_counts resb 26

section .text
    global _start

_start:
    mov eax, 10
    mov ebx, file_name
    mov ecx, 0
    int 0x80
    mov [file_handle], eax
    xor eax, eax
    mov ecx, char_counts
    mov edx, 1

.read_loop:
    mov ebx, [file_handle]
    mov eax, 3
    int 0x80
    cmp eax, 0
    jle .count_done
    sub al, 65
    cmp al, 0
    jl .read_loop
    cmp al, 25
    jg .read_loop
    inc byte [ecx+eax]
    jmp .read_loop

.count_done:
    mov ebx, [file_handle]
    mov eax, 6        ; sys_close
    int 0x80
    mov eax, 5
    mov ebx, count_output
    mov ecx, 0101
    mov edx, 0644
    int 0x80
    mov [file_handle], eax

    mov ebx, [file_handle]
    mov eax, 4
    mov edx, 26
    sub edx, 1
    xor ecx, ecx

.write_loop:
    mov al, [char_counts+ecx]
    add al, 48
    mov ah, '/'
    push eax
    mov al, [alphabet+ecx]
    push eax
    mov eax, esp
    mov edx, 2
    int 0x80
    add esp, 8
    inc ecx
    cmp ecx, edx
    jne .write_loop
    mov ebx, [file_handle]
    mov eax, 6
    int 0x80
    mov eax, 1
    xor ebx, ebx
    int 0x80