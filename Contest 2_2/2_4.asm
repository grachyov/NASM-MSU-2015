;На стандартном потоке ввода задаётся целое 32х-битное беззнаковое число. Требуется вывести его в восьмиричной системе счисления без лидирующих нулей.
;
;Запрещается использовать какие-либо библиотечные функции, за исключением стандартного набора макросов ввода-вывода библиотеки io.inc.

%include 'io.inc'

section .bss
	oct resb 11

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, eax

	mov edx, 10
	mov edi, 2

	xor esi, esi
	mov ebx, eax
	mov ecx, 30
	shr ebx, cl
	test ebx, ebx
	jz .next_step
	mov byte[oct + esi], bl
	inc esi

.next_step:
	test edx, edx 
	jz .end
	dec edx
	mov ecx, edi
	add edi, 3
	mov ebx, eax
	shl ebx, cl
	mov ecx, 29
	shr ebx, cl
	test ebx, ebx
	jz .zeros
	mov byte[oct + esi], bl
	inc esi
	jmp .next_step

.zeros:
	test esi, esi
	jz .next_step
	mov byte[oct + esi], 0
	inc esi
	jmp .next_step

.end:
	xor ecx, ecx
	test esi, esi
	jnz .print_non_zero
	PRINT_UDEC 1, 0
	jmp .return
	
.print_non_zero:
	cmp ecx, esi
	jge .return
	PRINT_UDEC 1, oct + ecx
	inc ecx
	jmp .print_non_zero
	
.return:
	NEWLINE
	xor eax, eax
	ret
