;В данной задаче вам необходимо проверить, лежит ли точка P внутри прямоугольника ABCD.

;На вход программе подаются 5 пар чисел: сначала координаты вершин прямоугольника, а затем координаты точки P. Все координаты целые и по модулю не превосходят 1000. Вершины прямоугольника могут быть перечислены в произвольном порядке. Гарантируется, что стороны прямоугольника параллельны осям координат.

;Программа должна вывести YES, если точка P лежит строго внутри прямоугольника ABCD, и NO в противном случае.

%include 'io.inc'

section .bss
	a_x resd 1
	a_y resd 1
	b_x resd 1
	b_y resd 1
	c_x resd 1
	c_y resd 1
	d_x resd 1
	d_y resd 1
	p_x resd 1
	p_y resd 1

section .text
global CMAIN
CMAIN:
	GET_DEC 4, a_x
	GET_DEC 4, a_y
	GET_DEC 4, b_x
	GET_DEC 4, b_y
	GET_DEC 4, c_x
	GET_DEC 4, c_y
	GET_DEC 4, d_x
	GET_DEC 4, d_y
	GET_DEC 4, p_x
	GET_DEC 4, p_y

.prepare_x:
	mov eax, dword[a_x]
	cmp eax, dword[b_x]
	je .a_same_x_b
	mov ebx, dword[b_x]
	jmp .prepare_y

.a_same_x_b:
	mov ebx, dword[c_x]

.prepare_y:
	mov ecx, dword[a_y]
	cmp ecx, dword[b_y]
	je .a_same_y_b
	mov edx, dword[b_y]
	jmp .check_x

.a_same_y_b:
	mov edx, dword[c_y]

.check_x:
	cmp eax, ebx
	jg .swap_x
	jmp .check_y
	
.swap_x:
	xchg eax, ebx

.check_y:
	cmp ecx, edx
	jg .swap_y
	jmp .check_p
	
.swap_y:
	xchg ecx, edx

.check_p:
	cmp eax, dword[p_x]
	jge .res_no
	cmp ebx, dword[p_x]
	jle .res_no
	cmp ecx, dword[p_y]
	jge .res_no
	cmp edx, dword[p_y]
	jle .res_no
	PRINT_STRING 'YES'
	jmp .return

.res_no:
	PRINT_STRING 'NO'

.return:
	NEWLINE
	xor eax, eax
	ret
