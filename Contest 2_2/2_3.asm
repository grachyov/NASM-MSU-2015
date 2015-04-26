;Назовём локальным минимумом целочисленной последовательности такой её элемент, который строго меньше обоих своих соседей. Назовём, аналогично, локальным максимумом целочисленной последовательности элемент, строго больший своих соседей.

;На стандартном потоке ввода задаётся сначала целое неотрицательное N ≤ 500000, а затем N целых 32-разрядных чисел, составляющих последовательность.

;Требуется на стандартный поток вывода вывести сначала число m — количество локальных минимумов последовательности, а затем номера соответствующих элементов. Далее необходимо вывести число M локальных максимумом последовательности, после чего — номера соответствующих элементов. 
;Элементы нумеруются с 0. Первый и последний элементы последовательности не могут являться её локальными экстремумами.

%include 'io.inc'

section .bss
	N resd 1
	mins_i resd 250000
	mins_amount resd 1
	maxs_i resd 250000
	maxs_amount resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, ecx
	mov dword[N], ecx
	mov dword[mins_amount], 0
	mov dword[maxs_amount], 0
	cmp ecx, 3
	jl .end
	sub ecx, 2
	xor esi, esi
	xor edi, edi
	GET_DEC 4, eax
	GET_DEC 4, ebx
	GET_DEC 4, edx

.process_step:
	cmp eax, ebx
	jl .mb_max
	je .prep_next_step
	cmp ebx, edx
	jge .prep_next_step
	mov eax, dword[N]
	sub eax, ecx
	dec eax
	mov dword[mins_i + 4 * esi], eax
	inc dword[mins_amount]
	inc esi
	jmp .prep_next_step

.mb_max:
	cmp ebx, edx
	jle .prep_next_step
	mov eax, dword[N]
	sub eax, ecx
	dec eax
	mov dword[maxs_i + 4 * edi], eax
	inc dword[maxs_amount]
	inc edi
	jmp .prep_next_step

.prep_next_step:
	dec ecx
	test ecx, ecx
	jz .end
	mov eax, ebx
	mov ebx, edx
	GET_DEC 4, edx
	jmp .process_step	

.end:
	PRINT_UDEC 4, mins_amount
	mov edx, dword[mins_amount]
	xor ecx, ecx
	NEWLINE

.print_mins:
	cmp ecx, edx
	je .prep_print_max
	PRINT_UDEC 4, mins_i + 4 * ecx
	PRINT_CHAR ' '
	inc ecx
	jmp .print_mins
		
.prep_print_max:
	NEWLINE
	PRINT_UDEC 4, maxs_amount
	mov edx, dword[maxs_amount]
	xor ecx, ecx
	NEWLINE

.print_maxs:
	cmp ecx, edx
	je .return
	PRINT_UDEC 4, maxs_i + 4 * ecx
	PRINT_CHAR ' '
	inc ecx
	jmp .print_maxs

.return:
	NEWLINE
	xor eax, eax
	ret
