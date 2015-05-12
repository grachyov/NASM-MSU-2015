;В этой задаче Вам необходимо описать рекурсивную функцию F(x), которая вычисляет количество единиц в троичной записи числа. 
;Функция должна удовлетворять соглашениям о вызовах cdecl.
;На вход программе подается 32-битное беззнаковое число x.
;Программа должна вывести единственное число — значение F(x).

%include 'io.inc'

section .bss 
	a resd 1

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, a
	push dword[a]
	call f
	add esp, 4
	PRINT_DEC 4, eax
	NEWLINE
	xor eax, eax
	ret

f:
	push ebp
	mov ebp, esp

	cmp dword[ebp + 8], 2
	ja .continue
	cmp dword[ebp + 8], 1
	jne .ret0
	mov eax, 1
	jmp .return

	.continue:
		mov eax, dword[ebp + 8]
		mov ecx, 3
		xor edx, edx
		div ecx
		push edx
		push eax
		call f
		add esp, 4
		pop edx
		cmp edx, 1
		jne .return
		add eax, 1
		jmp .return

	.ret0:
		xor eax, eax

	.return:
		mov esp, ebp
		pop ebp
		ret