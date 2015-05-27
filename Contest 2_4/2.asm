;Необходимо написать программу, которая считывает две строки 
;(каждая содержит не более 1000 символов) и проверяет, не является ли одна из строк подстрокой другой. 
;В случае, если первая строка является подстрокой второй, необходимо вывести на печать 
;"1 2" (без кавычек), если вторая - подстрока первой, то "2 1", если ни одна строка не является подстрокой другой, необходимо вывести "0".
;Гарантируется, что подаваемые строки различны.

%include 'io.inc'

CEXTERN gets
CEXTERN strstr

section .rodata
	one_in_two db "1 2", 0
	two_in_one db "2 1", 0
	none db "0", 0

section .bss
	a resb 1001
	b resb 1001

section .text
global CMAIN
CMAIN:
	mov ebp, esp
	and esp, 0xfffffff0
	sub esp, 16
	
	mov dword[esp], a
	call gets

	mov dword[esp], b
	call gets

	mov dword[esp + 4], a
	call strstr
	test eax, eax
	jnz .one_two

	mov dword[esp], a
	mov dword[esp + 4], b
	call strstr
	test eax, eax
	jnz .two_one

	mov dword[esp], none
	call printf

	.return:
		mov esp, ebp
		xor eax, eax
		ret

	.one_two:
		mov dword[esp], one_in_two
		call printf
		jmp .return

	.two_one:
		mov dword[esp], two_in_one
		call printf
		jmp .return