;На вход программе подается беззнаковое 32-битное целое число N. Требуется найти количество единичных битов в двоичном представлении данного числа.

%include 'io.inc'

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, eax
	mov ecx, 31
	xor edx, edx

.shift1:
	mov ebx, eax
	shr ebx, cl
	and ebx, 1
	add edx, ebx
	dec ecx
	cmp ecx, 0
	jge .shift1
	
	PRINT_DEC 4, edx

	NEWLINE
	xor eax, eax
	ret
