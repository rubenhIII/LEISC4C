GLOBAL main

section .data
    inputFileName db "data.txt", 0
    outputFileName db "ESCAMILLA_RAMIREZ_FRIDA_COUNT.txt", 0
    uppercaseLetter db 65
    lowercaseLetter db 97
    numCount db 0
    letterCount db 0
    asciiValue db 0
    space db " "
    newline db 10
    comparisonFlag db 1

section .bss
    inputFileDescriptor resw 1
    outputFileDescriptor resw 1
    buffer resb 1

section .text

main:
    mov eax, 5
    mov ebx, inputFileName
    mov ecx, 2
    mov edx, 777
    int 0x80

    mov [inputFileDescriptor], eax

read_loop:
    mov eax, 3
    mov ebx, dword [inputFileDescriptor]
    mov ecx, buffer
    mov edx, 1
    int 0x80
    cmp eax, 0
    jz end_loop

    mov al, [buffer]
    cmp al, [uppercaseLetter]
    je next
    cmp al, [lowercaseLetter]
    je next

    jmp read_loop

end_loop:
    mov eax, 6
    mov ebx, [inputFileDescriptor]
    int 0x80

    inc byte [letterCount]
    cmp byte [letterCount], 27
    je exit_program
    jl compare

next:
    inc byte [numCount]
    jmp read_loop

compare:
    cmp byte [comparisonFlag], 1
    je create_file
    jmp write_file

create_file:
    inc byte [comparisonFlag]
    mov eax, 8
    mov ebx, outputFileName
    mov ecx, 0777
    int 0x80
    mov [outputFileDescriptor], eax

    mov eax, 6
    mov ebx, [outputFileDescriptor]
    int 0x80
    jmp write_file

write_file:
    mov eax, 5
    mov ebx, outputFileName
    mov ecx, 2
    mov edx, 777
    int 0x80
    mov [outputFileDescriptor], eax

    mov eax, 0x13
    mov ebx, [outputFileDescriptor]
    mov ecx, 0
    mov edx, 2
    int 0x80

    mov eax, 4
    mov ebx, [outputFileDescriptor]
    mov ecx, uppercaseLetter
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, [outputFileDescriptor]
    mov ecx, space
    mov edx, 1
    int 0x80

    add byte [numCount], 48
    mov al, [numCount]
    mov [asciiValue], al

    mov eax, 4
    mov ebx, [outputFileDescriptor]
    mov ecx, asciiValue
    mov edx, 1
    int 0x80

    mov eax, 4
    mov ebx, [outputFileDescriptor]
    mov ecx, newline
    mov edx, 1
    int 0x80

    mov eax, 6
    mov ebx, [outputFileDescriptor]
    int 0x80
    inc byte [uppercaseLetter]
    inc byte [lowercaseLetter]
    mov byte [numCount], 0

    mov eax, 5
    mov ebx, inputFileName
    mov ecx, 2
    mov edx, 777
    int 0x80
    mov [inputFileDescriptor], eax

    jmp read_loop

exit_program:
    mov eax, 6
    mov ebx, [inputFileDescriptor]
    int 0x80

    mov eax, 1
    mov ebx, 0
    int 0x80
; nasm -f elf32 -g ESCAMILLA_RAMIREZ_FRIDA_XIMENA_T05.asm
; gcc -m32 -no-pie ESCAMILLA_RAMIREZ_FRIDA_XIMENA.o -o ESCAMILLA_RAMIREZ_FRIDA_XIMENA_T05Ex
; ./RESCAMILLA_RAMIREZ_FRIDA_XIMENA_T05Ex