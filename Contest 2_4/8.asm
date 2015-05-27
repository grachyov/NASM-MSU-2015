;Это скучная задача.
;В текстовом файле input.txt задаётся последовательность знаковых целых 32х-битных чисел, 
;разделённых произвольными комбинациями пробельных символов и символов перевода строки. 
;Длина последовательности не превышает 1000 элементов. Требуется вывести отсортированную последовательность в файл output.txt. 
;Для сортировки воспользуйтесь библиотечной функцией qsort
;Запрещается использовать макросы ввода-вывода библиотеки io.inc. При вызове всех библиотечных функций стек должен быть выровнен по 16 байт.

%include 'io.inc'

CEXTERN qsort
CEXTERN fopen
CEXTERN fclose
CEXTERN fscanf
CEXTERN fprintf

section .bss
	array resd 1000
	cur_int resd 1
	input_file resd 1
	output_file resd 1

section .rodata
	input_name db "input.txt", 0
	output_name db "output.txt", 0
	input_mode db "r", 0
	output_mode db "w", 0
	int_in db "%d", 0
	int_out db "%d ", 0 

section .text
GLOBAL CMAIN
CMAIN:
	mov ebp, esp
	and esp, -16
	sub esp, 16
	mov dword[esp], input_name
	mov dword[esp + 4], input_mode
	call fopen
	xor ebx, ebx
	mov dword[input_file], eax
	mov dword[esp], eax
	mov dword[esp + 4], int_in
	mov dword[esp + 8], cur_int
	
	.read_loop:
		call fscanf
		cmp eax, -1
		je .processing
		mov edi, dword[cur_int]
		mov dword[array + ebx * 4], edi
		inc ebx
		jmp .read_loop

	.processing:
		mov eax, dword[input_file]
		mov dword[esp], eax
		call fclose
		mov dword[esp], array
		mov dword[esp + 4], ebx
		mov dword[esp + 8], 4
		mov dword[esp + 12], cmp_func
		call qsort

	xor esi, esi
	mov dword[esp], output_name
	mov dword[esp + 4], output_mode
	call fopen
	mov dword[output_file], eax
	mov dword[esp], eax
	mov dword[esp + 4], int_out

	.print_loop:
		cmp esi, ebx
		je .return
		mov ecx, dword[array + 4 * esi]
		mov dword[esp + 8], ecx
		call fprintf
		inc esi
		jmp .print_loop

	.return:
		mov eax, dword[output_file]
		mov dword[esp], eax
		call fclose
		mov esp, ebp
		xor eax, eax
		ret

cmp_func:
	push ebp
	mov ebp, esp
	xor eax, eax
	mov ecx, dword[ebp + 8]
	mov ecx, dword[ecx]
	mov edx, dword[ebp + 12]
	mov edx, dword[edx]
	cmp ecx, edx
	jl .less
	jg .greater
	jmp .return
	.less:
		mov eax, -1
		jmp .return

	.greater:
		mov eax, 1
		jmp .return

	.return:
		mov esp, ebp
		pop ebp
		ret