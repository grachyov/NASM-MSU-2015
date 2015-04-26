;На вход программе подаются 4 беззнаковых 8-битных целых числа: a, b, c, d. 
;Требуется построить такое беззнаковое 32-битное число X, что его младшие 8 бит равны a, 
;следующие за ними 8 бит - числу b, следующие 8 бит - числу c, и, наконец, старшие 8 бит - числу d. 
;Программа должна выводить искомое число X.
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	a resb 1
	b resb 1
	c resb 1
	d resb 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 1, a
	GET_UDEC 1, b
	GET_UDEC 1, c
	GET_UDEC 1, d

	mov cl, 8
	mov al, byte[d]
	times 3 shl eax, cl
	mov ebx, 0
	mov bl, byte[c]
	times 2 shl ebx, cl
	add eax, ebx
	mov ebx, 0
	mov bl, byte[b]
	shl ebx, cl
	add eax, ebx
	mov al, byte[a]

	PRINT_UDEC 4, eax

	NEWLINE
	xor eax, eax
	ret 
