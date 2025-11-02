section .data
    o_data        equ 0
    o_previous    equ 8
    size          equ 16

section .bss
    last_node

 section .text
    global _start

brk_current:
    mov rax, 12
    mov rdi, 0                    ;syscall arg, 0 = current break, else get new break
    syscall                       ;CURRENT brk returned to rax
    ret
brk_new:
    mov rax, 12
    syscall
    ret
push:
    call brk_current
    mov rbx, rax                  ; save for later
    mov rdi, rax                  ; block #1 start
    add rdi, size                 ; X + Offset = block #1 end
    call brk_new
    mov byte [rbx + o_data], r8b  ; store data
    mov rax, [last_node]          ; dereference last node's address
    mov [rbx + o_previous], rax   ; store data
    mov [last_node], rbx          ; update global
    ret

pop:
    mov rbx, [last_node]
    mov r9, rbx
    test r9, r9
    jz not_last_node             ; nullptr, dont pop
    mov rdi, rbx
    call brk_new
    mov rax, [rbx+ o_previous]   ; dereference previous node's address
    mov [last_node], rax         ; update global
    ret                          ; because we allocate the memory adjacent to [o_data], we could also overwrite the old data

not_last_node:
    mov rax, 1                    ; arbitrary flag for attempt at nullptr on pop
    ret

_start:
    mov r8, 1
    call push                     ; create node #1
    mov r8, 2
    call push                     ; create node #2
    call pop                      ; free and revert to state at node #1

 terminate:
    mov eax, 60
    mov rdi, 0
    syscall