;Задается три целых числа K, N и A (2 ≤ K ≤ 10, 1 ≤ N, A ≤ 4000000). Строится последовательность Xi.

;X0 = A mod 2011;
;X1 = (X0 # X0) mod 2011;
;X2 = (X1 # X0) mod 2011;
;X3 = (X2 # X1) mod 2011;
;...
;Xi + 1 = (Xi # Xi - 1) mod 2011.
;Здесь C mod D означает остаток от деления C на D. C # D — дает число, которое получится если приписать D к C 
;в системе счисления с основанием K (запись чисел без незначащих нулей). Например, в десятичной системе 20 # 10 = 2010. 
;В двоичной системе для этих же чисел 20 # 10 = 101002 # 10102 = 1010010102 = 330.

;Выведите XN в десятичной записи.

;Указание: реализуйте функцию, выполняющую описанную операцию #.

%include 'io.inc'

section .bss
	K resd 1
	N resd 1
	A resd 1
	prev resd 1
	cur resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, K
	GET_DEC 4, N
	GET_DEC 4, A

	mov eax, dword[A]
	mov ebx, 2011
	cdq
	div ebx
	mov dword[prev], edx
	mov dword[cur], edx

	.process:
		cmp dword[N], 0
		je .return
		dec dword[N]

		push dword[prev]
		push dword[cur]
		call pound_op
		add esp, 8
		cdq
		div ebx
		mov ecx, dword[cur]
		mov dword[prev], ecx
		mov dword[cur], edx
		jmp .process

	.return:
		PRINT_UDEC 4, cur
		NEWLINE
		xor eax, eax
		ret

pound_op:
	push ebp
	mov ebp, esp

	mov eax, dword[ebp + 12]
	mov ecx, 1
	.find_length:
		cmp eax, dword[K]
		jl .process
		inc ecx
		xor edx, edx
		div dword[K]
		jmp .find_length

	.process:
		xor edx, edx
		mov eax, 1
		;ecx is X2 length
		.power:
			test ecx, ecx
			jz .finish
			dec ecx
			mul dword[K]
			jmp .power

		.finish:
			mul dword[ebp + 8]
			add eax, dword[ebp + 12]

	mov esp, ebp
	pop ebp
	ret