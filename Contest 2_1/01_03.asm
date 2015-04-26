;Есть две корзины. В первой лежит A красных шаров, B синих и C зелёных. Во второй лежит D красных шаров, E синих и F зелёных. Все шары считаются различными. Сколько существует способов выбрать по одному шару из каждой корзины так, чтобы эти шары были разного цвета?
;
;На стандартном потоке ввода заданы шесть чисел через пробел: A, B, C, D, E и F. Все числа целые неотрицательные и не превосходят 10000.
;
;На стандартный поток вывода напечатайте единственное число — ответ поставленной задачи.
;
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	A resd 1
	B resd 1
	C resd 1
	D resd 1
	E resd 1
	F resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, A
	GET_DEC 4, B
	GET_DEC 4, C
	GET_DEC 4, D
	GET_DEC 4, E
	GET_DEC 4, F
	
	mov eax, dword[A]
	mov ebx, dword[E]
	add ebx, dword[F]
	mul ebx
	mov ecx, eax	

	mov eax, dword[B]
        mov ebx, dword[D]
        add ebx, dword[F]
        mul ebx
        add ecx, eax

	mov eax, dword[C]
        mov ebx, dword[D]
        add ebx, dword[E]
        mul ebx
        add ecx, eax

	PRINT_DEC 4, ecx

	xor eax, eax
	NEWLINE
	ret
