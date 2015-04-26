;На стандартном потоке ввода задаётся натуральное число 3 ≤ N < 106, после которого следует последовательность из N 32-битных целых чисел.
;
;На стандартный поток вывода напечатайте три наибольших числа из этой последовательности в следующем порядке: сначала наибольшее, затем второе по величине и, наконец, третье.
;
;Выводимые программой числа могут совпадать (например, если максимальное число встречается в последовательности дважды, его следует также выводить два раза: как наибольшее и второе по величине).

%include 'io.inc'

section .bss
	max1 resd 1
	max2 resd 1
	max3 resd 1

section .text
global CMAIN
CMAIN:
	mov eax, 1
	shl eax, 31
	mov dword[max1], eax
	mov dword[max2], eax
	mov dword[max3], eax
	GET_DEC 4, ecx

.process_next:
	GET_DEC 4, ebx
	cmp ebx, dword[max1]
	jge .shift1
	cmp ebx, dword[max2]
	jge .shift2
	cmp ebx, dword[max3] 
	jge .shift3	
	dec ecx
	cmp ecx, 0
	je .end
	jmp .process_next

.shift1:
	mov edx, dword[max1]
	mov dword[max1], ebx
	mov ebx, edx

.shift2:
	mov edx, dword[max2]
	mov dword[max2], ebx
	mov ebx, edx

.shift3:
	mov dword[max3], ebx
	dec ecx
	cmp ecx, 0
	jne .process_next

.end:	
	PRINT_DEC 4, max1
	PRINT_CHAR ' '
	PRINT_DEC 4, max2
	PRINT_CHAR ' ' 
	PRINT_DEC 4, max3
	PRINT_CHAR ' ' 
	NEWLINE
	xor eax, eax
	ret
