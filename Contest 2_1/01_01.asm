;В начало координат координатной плоскости Oxy Кто-То положил хоккейную шайбу. После этого Кто-То сообщил ей по соответствующим осям начальные скорости vx и vy, а также ускорения ax и ay.;Требуется определить координаты точки, в которой в результате действий Кого-То окажется шайба через целое время t.;На стандартном потоке ввода через пробел задаются целые десятичные числа vx, vy, ax / 2, ay / 2, t. Скорости задаются в метрах в секунду; ускорения — в метрах, разделённых на секунду в квадрате; время — в секундах. Значение времени неотрицательно и не превышает 1000. Первые четыре числа по абсолютной величине не превышают 1000.;На стандартный поток вывода напечатайте через пробел два числа — координаты шайбы по прошествии t секунд: сначала координату x, а затем y.;Запрещается использовать инструкции условной передачи данных и управления.%include "io.inc"section .bss    v_x resd 1    v_y resd 1    a_x resd 1    a_y resd 1    t resd 1section .textglobal CMAINCMAIN:    GET_DEC 4, v_x    GET_DEC 4, v_y    GET_DEC 4, a_x    GET_DEC 4, a_y    GET_DEC 4, t    mov eax, dword[v_x]    mul dword[t]    mov ebx, eax    mov eax, dword[a_x]    times 2 mul dword[t]    add ebx, eax    mov eax, dword[v_y]    mul dword[t]    mov ecx, eax    mov eax, dword[a_y]    times 2 mul dword[t]    add ecx, eax    PRINT_DEC 4, ebx    PRINT_CHAR ' '    PRINT_DEC 4, ecx    xor eax, eax    NEWLINE    ret