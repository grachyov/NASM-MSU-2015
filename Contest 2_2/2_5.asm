;На стандартном потоке ввода задаётся натуральное число N (N > 0), после которого следует последовательность из N целых чисел.
;
;На стандартный поток вывода напечатайте длину максимальной (по длине) возрастающей непрерывной подпоследовательности входной последовательности.

%include 'io.inc'

section .text
global CMAIN
CMAIN:
	GET_UDEC 4, ecx
	dec ecx
	GET_DEC 4, ebx
	mov eax, 1
	mov esi, eax

.read_next:
	cmp ecx, 0
	je .seq_break
	dec ecx
	GET_DEC 4, edx
	cmp ebx, edx
	mov ebx, edx
	jge .seq_break
	inc eax
	jmp .read_next

.seq_break:
	cmp eax, esi
	jle .read_or_end
	mov esi, eax

.read_or_end:
	mov eax, 1
	cmp ecx, 0
	jne .read_next
	
	PRINT_DEC 4, esi

	NEWLINE
	xor eax, eax
	ret
