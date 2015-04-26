;На стандартном потоке ввода задвётся сначала неотрицательное целое число N ≤ 106, а затем N 32-разрядных чисел без знака. После этой последовательности задаётся дополнительно десятичное целое число K, 0 ≤ K < 32.
;
;Требуется на стандартный поток вывести последовательность из N беззнаковых 32-разрядных чисел, полученную из исходной циклическим сдвигом вправо на K битов. При этом биты, «выдвинутые» вправо из любого элемента, кроме последнего, «вдвигаются» слева в следующий. В случае последнего элемента биты оказываются «вдвинуты» в первый элемент.

%include 'io.inc'

section .bss
	N resd 1
	arr resd 1000050
	K resb 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	xor ebx, ebx
	mov ebp, dword[N]

.getting_array:
	cmp ebx, ebp
	je .start_proc
	GET_UDEC 4, eax
	mov dword[arr + 4 * ebx], eax
	inc ebx
	jmp .getting_array

.start_proc:
	GET_UDEC 1, K
	mov cl, byte[K]
	test cl, cl
	jz .prep_printing
	test ebp, ebp
	jz .return
	mov eax, dword[arr]
	mov cl, 32
	sub cl, byte[K]
	shl eax, cl
	xor ebx, ebx
	dec ebp

.proc_loop:	
	cmp ebx, ebp
	je .finish_proc
	inc ebx
	mov edx, dword[arr + 4 * ebx]
	mov esi, edx
	mov cl, 32
	sub cl, byte[K]
	shl esi, cl
	xchg eax, esi
	mov cl, byte[K]
	shr edx, cl
	or edx, esi
	mov dword[arr + 4 * ebx], edx
	jmp .proc_loop

.finish_proc:
	mov edx, dword[arr]
	mov cl, byte[K]
	shr edx, cl
	or edx, eax
	mov dword[arr], edx

.prep_printing:
	mov ebp, dword[N]
	xor ebx, ebx

.printing:
	cmp ebx, ebp
	je .return
	mov eax, dword[arr + 4 * ebx]
	PRINT_UDEC 4, arr + 4 * ebx
	PRINT_CHAR ' '
	inc ebx
	jmp .printing

.return:
	NEWLINE
	xor eax, eax
	ret
