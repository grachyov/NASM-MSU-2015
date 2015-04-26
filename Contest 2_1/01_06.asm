;На вход программе подается беззнаковое 32-битное целое число N и натуральное число K (1 ≤ K ≤ 31). Требуется взять K младших битов числа N и вывести полученное таким образом число.;

;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	N resd 1
	K resb 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	GET_UDEC 1, K

	mov cl, byte[K]
	add cl, -32
	neg cl
	mov eax, dword[N]
	shl eax, cl
	shr eax, cl

	PRINT_UDEC 4, eax

	NEWLINE
	xor eax, eax
	ret 
