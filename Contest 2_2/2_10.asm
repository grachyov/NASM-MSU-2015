;В данной задаче вам необходимо найти наибольший делитель заданного числа, меньший самого числа.

;На вход программе подаётся одно целое число N (2 ≤ N ≤ 1000000000). Программа должна вывести единственное целое число — ответ задачи.

%include 'io.inc'

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, ebx
	mov ecx, 1 
	inc ecx
	mov esi, 1

	mov eax, ebx
	xor edx, edx
	div ecx
	test edx, edx
	jz .found
	dec ecx

.step:
	add ecx, 2
	mov eax, ecx
	mul ecx 
	cmp eax, ebx
	jg .end 
	mov eax, ebx
	xor edx, edx
	div ecx
	test edx, edx
	jnz .step

.found:
	xor esi, esi
	mov esi, eax

.end:
	PRINT_UDEC 4, esi 		
	NEWLINE
	xor eax, eax
	ret
