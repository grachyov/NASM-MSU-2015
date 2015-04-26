;На стандартном потоке ввода задаётся клетка обычной шахматной доски 8x8, например, H2 (для обозначения вертикалей используются заглавные латинские буквы от A до H включительно).
;
;Требуется на стандартный поток вывода напечатать единственное число: количество белых клеток, находящихся правее и выше заданной (горизонталь и вертикаль самой клетки не учитываются).
;
;Запрещается использовать инструкции условной передачи данных и управления.

%include 'io.inc'

section .bss
	letter resb 1
	number resb 1

section .text
global CMAIN
CMAIN:
	GET_CHAR letter
	GET_UDEC 1, number
	
	mov al, 8
	sub al, byte[number]
	mov bl, 'H'
	sub bl, byte[letter]
	mul bl
	mov bl, 2
	div bl
	
	PRINT_DEC 1, al

	NEWLINE
	xor eax, eax
	ret
