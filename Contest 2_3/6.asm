;На вход программе со стандартного потока ввода подается 32-битное беззнаковое число N (N ≤ 1000), 
;последовательность из N 32-битных беззнаковых чисел A и 32-битное беззнаковое число k (k ≤ 32). 
;Требуется вывести количество чисел в последовательности A, в двоичной записи которых количество значащих нулей равно k.

;Указание. При решении задачи необходимо реализовать функцию, вычисляющую количество значащих нулей в числе. 
;Функция должна удовлетворять соглашению cdecl.

%include 'io.inc'

section .bss
	N resd 1
	A resd 1000
	k resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	xor ebx, ebx
	xor ecx, ecx

	.get_nums:
		cmp ecx, dword[N]
		je .prep_proc
		GET_UDEC 4, [A + 4 * ecx]
		inc ecx
		jmp .get_nums

	.prep_proc:
		GET_UDEC 4, k
		xor esi, esi

	.proc:
		cmp esi, dword[N]
		je .return
		push dword[A + 4 * esi]
		call count_imp_zeros
		add esp, 4
		inc esi
		cmp eax, dword[k]
		jne .proc
		inc ebx
		jmp .proc

	.return:
		PRINT_UDEC 4, ebx

		NEWLINE
		xor eax, eax
		ret

count_imp_zeros:
	push ebp
	mov ebp, esp

	mov cl, 31
	xor eax, eax

	.find_one:
		test cl, cl
		jz .return
		mov edx, dword[ebp + 8]
		shr edx, cl
		test edx, edx
		jnz .process
		dec cl
		jmp .find_one

	.process:
		test cl, cl
		jz .check_lower
		mov edx, dword[ebp + 8]
		shr edx, cl
		and edx, 1
		xor edx, 1
		add eax, edx
		dec cl
		jmp .process

	.check_lower:
		mov edx, dword[ebp + 8]
		and edx, 1
		xor edx, 1
		add eax, edx

	.return:
		mov esp, ebp
		pop ebp
		ret