;На вход программе подается беззнаковое 32-битное целое число N и натуральное число K (1 ≤ K ≤ 31). 
;Требуется взять K подряд идущих битов числа N так, чтобы полученное число было максимальным. Программа должна вывести полученное число.

%include 'io.inc'

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, eax ;N
	GET_UDEC 4, ecx ;K
	mov esi, 0
	sub ecx, 32
	neg ecx
	mov edx, ecx

.shift:
	cmp ecx, 0
	jl .end
	mov ebx, eax
	shr ebx, cl
	xchg edx, ecx
	shl ebx, cl
	shr ebx, cl
	xchg edx, ecx
	dec ecx
	cmp esi, ebx
	jg .shift
	mov esi, ebx
	jmp .shift

.end:
	PRINT_UDEC 4, esi

	NEWLINE
	xor eax, eax
	ret
