;В данной задаче вам необходимо найти наибольший общий делитель двух заданных натуральных чисел.
;
;На вход программе подаются два целых числа A и B (2 ≤ A, B ≤ 1000000000). Программа должна вывести единственное целое число — ответ задачи.

%include 'io.inc'

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, eax
	GET_UDEC 4, ebx

.step:
	test ebx, ebx
	jz .end
	xor edx, edx
	div ebx
	mov eax, ebx
	mov ebx, edx
	jmp .step

.end:
	PRINT_UDEC 4, eax 		
	NEWLINE
	xor eax, eax
	ret
