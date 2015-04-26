;На стандартном потоке ввода задаются в шестнадцатеричном представлении три целых беззнаковых 32х-битных числа a, b и c. 
;Обозначим через x[i] i-тый бит числа x (биты нумеруются с нуля, начиная с младшего). 
;Требуется вывести на стандартный поток вывода в шестнадцатеричном представлении 32х-битное число d, 
;такое, что каждый его бит удовлетворяет равенству d[i] = c[i] ? a[i] : b[i].
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	a resd 1
	b resd 1
	c resd 1

section .text
global CMAIN
CMAIN:
	GET_HEX 4, a
	GET_HEX 4, b
	GET_HEX 4, c
	
	mov eax, dword[a]
	mov ebx, dword[b]
	mov ecx, dword[c]
	and eax, ecx
	not ecx
	and ecx, ebx
	or ecx, eax
	PRINT_HEX 4, ecx
	
	NEWLINE
	xor eax, eax
	ret
