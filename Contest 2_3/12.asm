;К сожалению для Льва Николаевича, компрессия детей -- занятие крайне неблагодарное, 
;потому ему пришлось всерьёз озадачиться вопросом их размещения. 
;Комната имеет треугольную форму (ненулевой площади), а пол выложен квадратной плиткой (иными словами, представляет собой решётку). 
;Углы комнаты и дети расположены в узлах этой решётки, при этом дети находятся только в узлах внутри комнаты. 
;В узле не могут одновременно быть стена и ребёнок. Графа очень интересует, сколько же детей поместится, 
;но ручной подсчёт слишком утомителен, потому он вооружился ноутбуком, документацией по nasm и книгой "Формула Пика" 
;и приготовился написать самое великое своё произведение, но в силу очевидных причин без вас ему не обойтись.

;Комната задаётся по вершинам треугольника. Для каждой вершины сначала даётся её абсцисса, затем ордината. 
;Гарантируется, что площадь треугольника не переполняет целочисленный беззнаковый 32-х битный тип.

%include 'io.inc'

section .bss
	x1 resd 1
	x2 resd 1
	x3 resd 1
	y1 resd 1
	y2 resd 1
	y3 resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, x1
	GET_DEC 4, y1
	GET_DEC 4, x2
	GET_DEC 4, y2
	GET_DEC 4, x3
	GET_DEC 4, y3

	mov eax, dword[x2]
	sub eax, dword[x1]
	mov ebx, dword[y3]
	sub ebx, dword[y1]
	cdq
	imul ebx
	mov ecx, eax
	mov eax, dword[x1]
	sub eax, dword[x3]
	mov ebx, dword[y2]
	sub ebx, dword[y1]
	cdq
	imul ebx
	add eax, ecx
	mov cl, 31
	mov ebx, eax
	sar ebx, cl
	mov ecx, eax
	neg ecx
	and ecx, ebx
	times 2 add eax, ecx
	mov ebx, 2
	cdq
	idiv ebx
	mov ebx, edx
	cdq
	mov ecx, 2
	mul ecx
	add eax, ebx
	add eax, 2 
	mov ebx, eax ;ebx = 2 * S + 2

	xor esi, esi
	push dword[x1]
	push dword[y1]
	push dword[x2]
	push dword[y2]
	call count_bound_dots
	add esi, eax

	add esp, 8
	push dword[x3]
	push dword[y3]
	call count_bound_dots
	add esi, eax

	add esp, 16
	push dword[x3]
	push dword[y3]
	push dword[x2]
	push dword[y2]
	call count_bound_dots
	add esi, eax
	add esp, 16

	mov eax, ebx
	sub eax, esi
	mov ebx, 2
	xor edx, edx
	div ebx

	PRINT_DEC 4, eax

	NEWLINE
	xor eax, eax
	ret

count_bound_dots:
	push ebp
	mov ebp, esp

	mov eax, dword[ebp + 8]
	sub eax, dword[ebp + 16]
	mov ecx, dword[ebp + 12]
	sub ecx, dword[ebp + 20]
	cmp eax, 0
	jge .abs_ecx
	neg eax

	.abs_ecx:
		cmp ecx, 0
		jge .gcd
		neg ecx

	.gcd:
		test ecx, ecx
		jz .return
		xor edx, edx
		div ecx
		mov eax, ecx
		mov ecx, edx
		jmp .gcd

	.return:
		mov esp, ebp
		pop ebp
		ret
