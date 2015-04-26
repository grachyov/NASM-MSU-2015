;Найдите такие беззнаковые 32-битные числа x и y, которые удовлетворяют системе уравнений
;
;(a11 & x) ^ (a12 & y) = b1
;(a21 & x) ^ (a22 & y) = b2
;На вход программе подаются числа a11, a12, a21, a22, b1, b2. Все числа - 32-битовые беззнаковые.
;
;Программа должна вывести два беззнаковых числа чила x и y, удовлетворяющих данной системе. Гарантируется, что такие числа всегда найдутся. Если у системы уравнений несколько решений - выводите любое.
;
;При решении задачи запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	a11 resd 1
	a12 resd 1
	a21 resd 1
	a22 resd 1
	b1 resd 1
	b2 resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, a11
	GET_UDEC 4, a12
	GET_UDEC 4, a21
	GET_UDEC 4, a22
	GET_UDEC 4, b1
	GET_UDEC 4, b2

	mov ecx, dword[a11]
	xor ecx, dword[a12]
	xor ecx, dword[b1]
	not ecx
	
	mov edx, dword[a21]
	xor edx, dword[a22]
	xor edx, dword[b2]
	not edx
	
	and ecx, edx
	mov eax, ecx
	mov ebx, ecx
	;x in eax, y in ebx

	mov ecx, dword[a11]
	xor ecx, dword[b1]
	not ecx
	
	mov edx, dword[a21]
	xor edx, dword[b2]
	not edx

	and ecx, edx
	or eax, ecx
;cool hack
	not ecx
	and ebx, ecx
;
	mov ecx, dword[a12]
	xor ecx, dword[b1]
	not ecx

	mov edx, dword[a22]
	xor edx, dword[b2]
	not edx

	and ecx, edx
	or ebx, ecx 	
;the same cool hack
	not ecx
	and eax, ecx
;
	PRINT_UDEC 4, eax
	PRINT_CHAR ' '
	PRINT_UDEC 4, ebx		

	NEWLINE
	xor eax, eax
	ret
