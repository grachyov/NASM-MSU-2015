;На стандартном потоке ввода задаётся последовательность беззнаковых целых 32х-битных чисел в десятичной записи, 
;разделённых пробельными символами. Требуется вывести ту же самую последовательность, но каждое число 
;должно быть выведено через printf в формате "0x%08X\n"
;Запрещается использовать макросы ввода-вывода библиотеки io.inc. 
;При вызове всех библиотечных функций стек должен быть выровнен по 16 байт.

%include 'io.inc'

section .rodata
	u_in db `%u`, 0
	hex_out db `0x%08X\n`, 0

section .bss
	a resd 1

section .text
global CMAIN
CMAIN:
	mov ebp, esp
	and esp, 0xfffffff0
	sub esp, 16
	
	.rp_loop:
		mov dword[esp], u_in
		mov dword[esp + 4], a
		call scanf
		cmp eax, -1
		je .return
		mov dword[esp], hex_out
		mov eax, dword[a]
		mov dword[esp + 4], eax
		call printf
		jmp .rp_loop

	.return:
		mov esp, ebp
		xor eax, eax
		ret


