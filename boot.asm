; boot.asm - simple boot sector (prints message via BIOS INT 0x10)
; Output is 512 bytes with boot signature 0xAA55
; Assemble with: nasm -f bin boot.asm -o boot.bin

org 0x7c00

start:
    xor ax, ax
    mov ds, ax
    mov si, msg

.print_char:
    lodsb
    cmp al, 0
    je .hang
    mov ah, 0x0e
    mov bx, 0x0007
    int 0x10
    jmp .print_char

.hang:
    cli
    hlt
    jmp .hang

msg db 'Hello from my bootloader!', 0

times 510-($-$$) db 0
dw 0xAA55
