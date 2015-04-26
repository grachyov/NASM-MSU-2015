;В данной задаче вам необходимо подсчитать количество целых чисел из диапазона от 1 до N, в двоичном представлении которых содержится ровно K значащих нулей.
;
;На вход программе подаются натуральное число N и целое число K (0 ≤ K, N ≤ 1000000000). Программа должна вывести единственное целое число — ответ задачи.

%include 'io.inc'

section .bss
	prec_arr resd 1024
	N resd 1
	K resd 1
	L resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, N
	GET_UDEC 4, K
	cmp dword[N], 1
	jne .move_on
	cmp dword[K], 0
	jne .print_zero
	PRINT_UDEC 1, 1
	jmp .return

.print_zero:
	PRINT_UDEC 1, 0
	jmp .return

.move_on:
	xor esi, esi
	mov ecx, 1024
	mov ebx, 32

.make_zeros:
	test ecx, ecx
	jz .make_ones
	dec ecx
	mov dword[prec_arr + 4 * ecx], 0
	jmp .make_zeros

.make_ones:
	test ebx, ebx
	jz .row_loop
	dec ebx
	mov eax, 32
	mul ebx
	mov dword[prec_arr + 4 * eax], 1
	jmp .make_ones

.row_loop:
	inc esi
	cmp esi, 32
	je .prep_find_L
	xor ebx, ebx

.column_loop:
	inc ebx
	cmp ebx, 32
	je .row_loop
	mov eax, 32
	mul esi
	add eax, ebx
	sub eax, 32
	xor edx, edx
	mov edx, dword[prec_arr + 4 * eax]
	sub eax, 1
	add edx, dword[prec_arr + 4 * eax]
	add eax, 33
	mov dword[prec_arr + 4 * eax], edx
	jmp .column_loop

.prep_find_L:
	mov ecx, 32
	mov dword[L], 0

.find_L:
	test ecx, ecx
	jz .start_calc
	dec ecx
	mov ebx, dword[N]
	shr ebx, cl
	and ebx, 1
	test ebx, ebx
	jz .find_L
	inc ecx
	mov dword[L], ecx
	cmp ecx, dword[K]
	jg .start_calc
	PRINT_UDEC 1, 0
	jmp .return

.start_calc:
	sub ecx, 2
	xor esi, esi
	cmp dword[K], 0
	jnz .l_bits_loop
	inc esi

.l_bits_loop:
	test ecx, ecx
	jz .prep_h_bit_calc
	mov eax, 32
	mul ecx
	add eax, dword[K]
	add esi, dword[prec_arr + eax * 4]
	dec ecx
	jmp .l_bits_loop
	
.prep_h_bit_calc:
	cmp dword[K], 1
	jne .thats_ok
	dec esi

.thats_ok:
	mov edi, dword[L]
	dec edi

.h_bit_loop:
	test edi, edi
	jz .safe_finish

	cmp dword[K], 0
	jl .print_res

	mov ebx, 1
	mov ecx, edi
	dec ecx
	shl ebx, cl
	and ebx, dword[N]
	dec edi
	test ebx, ebx
	jz .zero_bit
	mov eax, edi
	mov ebx, 32
	mul ebx
	add eax, dword[K]
	dec eax
	add esi, dword[prec_arr + eax * 4]	
	jmp .h_bit_loop

.zero_bit:
	dec dword[K]
	jmp .h_bit_loop

.safe_finish:
	cmp dword[K], 0
	jne .print_res
	inc esi

.print_res:
	PRINT_UDEC 4, esi

.return:
	NEWLINE
	xor eax, eax
	ret
