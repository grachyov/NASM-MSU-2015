;Год на планете Пандора по-прежнему состоит из 14 месяцев, в каждом из которых либо 41, либо 42 дня: в первом месяце 41 день, во втором — 42, далее число дней чередуется.
;
;На стандартном потоке ввода задаются два числа: номер месяца в году и номер дня в месяце. Оба номера отсчитываются от 1.
;
;На стандартный поток вывода напечатайте номер дня в года, отсчитываемый от 1.
;
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	m resd 1
	d resd 1

section .data
	m_len dd 41

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, m
	GET_UDEC 4, d
	
	mov ecx, dword[m]
	mov ebx, dword[d]
	sub ecx, 1
	mov eax, ecx
	mul dword[m_len]
	add ebx, eax
	mov eax, ecx
	mov ecx, 2
	div ecx
	add ebx, eax
	
	PRINT_UDEC 4, ebx

	NEWLINE
	xor eax, eax
	ret
