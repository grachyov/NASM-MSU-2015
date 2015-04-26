;На вашем пути возникли числа! Они не отстанут, пока вы их хорошенько не отсортируете. Они не согласятся на сортировку хуже, чем за квадрат.
;
;На вход подается 32-битное знаковое число N (1 ≤ N ≤ 10000) и последовательность из N 32-битных знаковых чисел A. Требуется вывести эту последовательность в отсортированном по возрастанию виде, реализовав один из алгоритмов сортировки с квадратичной сложностью (например, пузырьком, вставками, выбором и т.д.)

%include 'io.inc'

section .bss
	N resd 1
	arr resd 1000050

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	xor ebx, ebx
	mov ebp, dword[N]

.getting_array:
	cmp ebx, ebp
	je .prep_to_sort
	GET_DEC 4, eax
	mov dword[arr + 4 * ebx], eax
	inc ebx
	jmp .getting_array

.prep_to_sort:
	mov ebx, -1
	
.outer_loop:
	inc ebx
	cmp ebx, ebp
	jge .prep_print
	mov ecx, ebx
	mov eax, dword[arr + 4 * ecx]
	mov edx, ecx

.inner_loop:
	inc ecx
	cmp ecx, ebp
	jge .finish_inner_loop
	cmp eax, dword[arr + 4 * ecx]
	jle .inner_loop
	mov eax, dword[arr + 4 * ecx]
	mov edx, ecx
	jmp .inner_loop

.finish_inner_loop:
	xchg eax, dword[arr + 4 * ebx]
	xchg eax, dword[arr + 4 * edx]
	jmp .outer_loop

.prep_print:
	mov ebp, dword[N]
	xor ebx, ebx

.printing:
	cmp ebx, ebp
	je .return
	mov eax, dword[arr + 4 * ebx]
	PRINT_DEC 4, arr + 4 * ebx
	PRINT_CHAR ' '
	inc ebx
	jmp .printing

.return:
	NEWLINE
	xor eax, eax
	ret
