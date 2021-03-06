;Вам дана цистерна имеющая форму прямого параллелепипеда размером A×B×C дециметров и труба пропускной способностью V литров в минуту. На сколько минут необходимо пустить воду по трубе так, чтобы в цистерну набралось как можно больше воды, но она не переполнилась?
;
;В силу инженерных особенностей воду можно пускать по трубе только на максимум ее пропускной способности и только в течение целого числа минут.
;
;На стандартном потоке ввода заданы четыре числа через пробел: A, B, C и V. Все числа целые положительные не превосходящие 2·109.
;
;На стандартный поток вывода напечатайте количество минут, в течение которых вода должна поступать в цистерну по трубе. Гарантируется, что ответ не превосходит 2·109.
;
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	A resd 1
	B resd 1
	C resd 1
	V resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, A
	GET_UDEC 4, B
	GET_UDEC 4, C
	GET_UDEC 4, V

	mov eax, dword[A]
	mov ebx, dword[B]
	imul ebx
	mov ebx, dword[V]
	idiv ebx
	
	mov ebx, edx
	mov edx, 0	

	mov ecx, dword[C]
	imul ecx

	mov edx, eax
	mov eax, ebx
	mov ebx, edx
	mov edx, 0	

	imul ecx
	mov ecx, dword[V]
	idiv ecx
	add ebx, eax

	PRINT_UDEC 4, ebx

	NEWLINE
	xor eax, eax
	ret
