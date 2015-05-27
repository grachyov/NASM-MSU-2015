;На входной поток подаётся сначала количество, а затем сами строки, 
;разделённые пробелами или переводами строк. 
;Подсчитайте количество различных строк и выведите на стандартный выходной поток. 
;Длина строк не превосходит 10, количество строк не превосходит 500 и не менее нуля.
;Запрещается использовать макросы ввода-вывода библиотеки io.inc. 
;При вызове всех библиотечных функций стек должен быть выровнен по 16 байт.

%include 'io.inc'

CEXTERN strcmp

section .rodata
	int_str db `%d`, 0
	char_io db `%c`, 0

section .bss
	n resd 1
	strings resb 5500
	pointers resd 500
	uniq resd 500

section .text
global CMAIN
CMAIN:
	mov ebp, esp
	and esp, 0xfffffff0
	sub esp, 16
	mov dword[esp], int_str
	mov dword[esp + 4], n
	call scanf
	mov dword[esp], char_io
	xor ebx, ebx
	xor edi, edi
	xor esi, esi

	.r_loop:
		cmp dword[n], ebx
		je .start_proc
		mov eax, strings
		add eax, edi
		mov dword[esp + 4], eax
		call scanf
		cmp byte[strings + edi], '\n'
		je .next_str
		cmp byte[strings + edi], ' '
		je .next_str
		inc edi
		inc esi
		jmp .r_loop

		.next_str:
			add edi, 11
			sub edi, esi
			dec edi
			mov byte[strings + edi], 0
			inc edi
			mov eax, edi
			sub eax, 11
			mov dword[pointers + 4 * ebx], eax
			xor esi, esi
			inc ebx
			jmp .r_loop

	.start_proc:
		mov ebx, -1
		
		.proc_loop:
			inc ebx
			cmp ebx, dword[n]
			je .count
			mov eax, pointers
			add eax, ebx
			mov dword[esp], eax
			mov esi, ebx

			.str_loop:
				inc esi
				cmp esi, dword[n]
				je .proc_loop

				mov eax, pointers
				add eax, esi
				mov dword[esp + 4], eax
				call strcmp
				mov dword[uniq + 4 * esi], 1
				test eax, eax
				jz .not_uniq
				jmp .str_loop
				
				.not_uniq:
					mov dword[uniq + 4 * esi], 0
					jmp .str_loop

	.count:
		xor eax, eax
		mov ebx, -1
			.print_loop:
				inc ebx
				cmp ebx, dword[n]
				je .print
				add eax, dword[uniq + 4 * ebx]
				jmp .print_loop

	.print:
		mov dword[esp], int_str
		mov dword[esp + 4], eax
		call printf

	.return:
		mov esp, ebp
		xor eax, eax
		ret