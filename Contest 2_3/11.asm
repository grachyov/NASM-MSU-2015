;На стандартном потоке ввода задается число N(1 ≤ N ≤ 100000), а следом за ним N целых беззнаковых 32-битных чисел.
;Для каждого из N чисел необходимо вывести YES, если число данное число делится на три, и NO в противном случае. Ответы должны быть разделены переводом строки.
;Указание: использовать массивы и инструкции деления запрещается, необходимо описать функцию div3, проверяющую делимость своего аргумента на 3.

%include 'io.inc'

section .bss
	N resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	xor esi, esi

	.process:
		cmp esi, dword[N]
		je .return
		inc esi
		GET_UDEC 4, eax
		push eax
		call div3
		add esp, 4
		test eax, eax
		jz .yes
		PRINT_STRING 'NO'
		NEWLINE
		jmp .process
	
		.yes:
			PRINT_STRING 'YES'
			NEWLINE
			jmp .process

	.return:
		NEWLINE
		xor eax, eax
		ret

div3:
	push ebp
	mov ebp, esp
	push 0
	push 0

	xor edx, edx
	mov cl, 32
	.find_sums:
		test cl, cl
		jz .find_diff
		dec cl
		mov eax, dword[ebp + 8]
		shr eax, cl
		and eax, 1
		test edx, edx
		jz .even
		xor edx, edx
		add dword[ebp - 8], eax
		jmp .find_sums
		.even:
			or edx, 1
			add dword[ebp - 4], eax
			jmp .find_sums

	.find_diff:
		pop eax
		pop ecx
		sub eax, ecx
		cmp eax, 0
		jge .check_div
		neg eax

	.check_div:
		cmp eax, 3
		jl .return
		sub eax, 3
		jmp .check_div

	.return:
		mov esp, ebp
		pop ebp
		ret