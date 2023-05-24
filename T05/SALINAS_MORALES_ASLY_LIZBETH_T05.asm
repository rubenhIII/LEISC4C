section .data
    filename db 'SALINAS_MORALES_ASLY_LIZBETH_COUNT.txt',0sect
    buffer_size equ 128
    alphabet db 'abcdefghijklmnopqrstuvwxyz',0
    counts times 26 db 0

section .bss
    buffer resb buffer_size

section .text
    global _start

_start:
    mov eax, 5
    mov ebx, filename
    mov ecx, 0
    int 0x80

    cmp eax, -1
    je file_error

    mov ebx, eax
    mov eax, 3
    mov ecx, buffer
    mov edx, buffer_size
    int 0x80

    mov ecx, buffer
    xor edi, edi

count_loop:
    movzx eax, byte [ecx]
    test al, al
    je end_count_loop

    cmp al, 'a'
    jl not_lowercase
    cmp al, 'z'
    jg not_lowercase

    sub al, 'a'
    inc byte [counts + eax]

not_lowercase:
    inc ecx
    jmp count_loop

end_count_loop:
    mov eax, 6
    int 0x80

    xor edi, edi
    mov esi, counts

print_loop:
    movzx eax, byte [alphabet + edi]
    movzx ebx, byte [esi]
    add ebx, '0'
    mov [ecx], al
    mov [ecx+1], byte ' '
    mov [ecx+2], bl
    mov [ecx+3], byte '\n'

    add ecx, 4
    inc edi
    inc esi

    cmp edi, 26
    jl print_loop

    mov eax, 4
    mov ebx, 1
    mov edx, ecx
    sub eax, 1