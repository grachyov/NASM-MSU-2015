;Давно ничего не умножали? Тогда у нас есть задача специально для вас!
;
;На вход программе подаются наутральные числа N, M и K, не превосходящие 100. За ними следуют NM + MK целых чисел — элементы соответственно матрицы A размером N×M и матрицы B размером M×K. Элементы матриц не превосходят 1000 по абсолютной величине.
;
;Программа должна вычислить матрицу C, являющуюся произведением A на B, и напечатать ее. Матрица C должна быть обязательно представлена в памяти, а не только напечатана.
;
;Все матрицы задаются по строкам, элементы в каждой строке отделяются пробелами.

%include 'io.inc'

section .bss
	n resd 1
	m resd 1
	k resd 1
	A resd 10000
	B resd 10000
	C resd 10000

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, n
	GET_UDEC 4, m
	GET_UDEC 4, k
	xor ebx, ebx
	xor ebp, ebp
	mov eax, dword[n]
	mov ecx, dword[m]
	mul ecx
	mov ecx, A

.get_matrix:
	cmp ebx, eax
	je .next_step
	GET_DEC 4, esi
	mov dword[ecx + 4 * ebx], esi
	inc ebx
	jmp .get_matrix

.next_step:
	test ebp, ebp
	jnz .multiply
	xor ebx, ebx
	mov eax, dword[m]
	mov ecx, dword[k]
	mul ecx
	mov ecx, B
	mov ebp, 1
	jmp .get_matrix

.multiply:
	mov ebx, -1

.row_loop:
	inc ebx
	cmp ebx, dword[n]
	je .prep_print
	mov ecx, -1

.column_loop:
	inc ecx
	cmp ecx, dword[k]
	je .row_loop
	mov ebp, -1
	xor esi, esi

.element_loop:
	inc ebp
	cmp ebp, dword[m]
	je .write_to_c
	mov eax, dword[m]
	mul ebx
	add eax, ebp
	mov edi, dword[A + 4 * eax]
	mov eax, dword[k]
	mul ebp
	add eax, ecx
	mov eax, dword[B + 4 * eax]
	mul edi
	add esi, eax
	jmp .element_loop

.write_to_c:
	mov eax, dword[k]
	mul ebx
	add eax, ecx
	mov dword[C + 4 * eax], esi
	jmp .column_loop

.prep_print:
	mov esi, -1

.row_print_loop:
	NEWLINE
	inc esi
	cmp esi, dword[n]
	je .return 
	mov ecx, -1

.column_print_loop:
	inc ecx
	cmp ecx, dword[k]
	je .row_print_loop
	mov eax, esi
	mov ebx, dword[k]
	mul ebx
	add eax, ecx
	PRINT_DEC 4, C + 4 * eax
	PRINT_CHAR ' ' 
	jmp .column_print_loop

.return:
	NEWLINE
	xor eax, eax
	ret
