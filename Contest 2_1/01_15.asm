;Найдите площадь треугольника, заданного координатами его вершин.

;На вход программе подаются числа x1, y1, x2, y2, x3, y3 - координаты вершин. Все числа целые, не превосходящие по модулю 10000.

;Программа должна вывести площадь треугольника с точностью до одного знака после запятой.

;При решении задачи запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	x1 resd 1
	x2 resd 1
	x3 resd 1
	y1 resd 1
	y2 resd 1
	y3 resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, x1
	GET_DEC 4, y1
	GET_DEC 4, x2
	GET_DEC 4, y2
	GET_DEC 4, x3
	GET_DEC 4, y3

	mov eax, dword[x2]
	sub eax, dword[x1]
	mov ebx, dword[y3]
	sub ebx, dword[y1]
	cdq
	imul ebx
	mov ecx, eax
	mov eax, dword[x1]
	sub eax, dword[x3]
	mov ebx, dword[y2]
	sub ebx, dword[y1]
	cdq
	imul ebx
	add eax, ecx
	mov cl, 31
	mov ebx, eax
	sar ebx, cl
	mov ecx, eax
	neg ecx
	and ecx, ebx
	times 2 add eax, ecx
	mov ebx, 2
	cdq
	idiv ebx
	mov ebx, eax
	mov eax, edx
	cdq
	mov ecx, 5
	imul ecx
	
	PRINT_DEC 4, ebx
	PRINT_CHAR '.'
	PRINT_DEC 4, eax

	NEWLINE
	xor eax, eax
	ret
