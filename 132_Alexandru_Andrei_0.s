.data
	matrix: .space 1600
	columnIndex: .space 4
	lineIndex: .space 4
	n: .space 4
	cerinta: .space 4
	nrMuchii: .space 4
	index: .space 4
	left: .space 4
	right: .space 4
	formatScanf: .asciz "%ld"
	formatPrintf: .asciz "%ld "
	newLine: .asciz "\n"
	sir: .space 400
	apstr: .asciz "%s"
	elem: .space 4
	spatiu: .asciz " "
	nrr: .space 4
	leg: .space 4
	copie_mama: .space 4
.text
.global main
main:
	pushl $cerinta
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	pushl $n
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	
	lea sir, %edi
	mov $0, %ecx
	
citire_leg:
	
	cmp n, %ecx
	je preafisare
	
	pusha
	pushl $elem
	pushl $formatScanf
	call scanf
	popl %ebx
	popl %ebx
	popa

	
	mov elem, %eax
	mov %eax, (%edi, %ecx, 4)
	
	add $1, %ecx
	
	jmp citire_leg


preafisare:
	mov $0, %ecx
	
next:
	mov $0, %ecx
	
citire_nod:
	cmp n, %ecx
	je afisare_matrice
	mov (%edi, %ecx, 4), %eax
	mov %eax, elem
	mov %eax, copie_mama
	mov %ecx, nrr
		
	mov elem, %ecx  
	et_loop:
		cmp $0, %ecx
		je cont
		
		#CITIRE LEGATURI LA FIECARE NOD	
		pusha
		pushl $leg
		pushl $formatScanf
		call scanf
		popl %ebx
		popl %ebx
		popa
		
		
		movl nrr, %eax
		movl $0, %edx
		mull n
		add leg, %eax
		lea matrix, %esi
		movl $1, (%esi, %eax, 4)
		
		sub $1, %ecx 
		jmp et_loop
	
cont:
	mov nrr, %ecx
	mov copie_mama, %eax
	#pusha
	#pushl $apstr
	#call printf
	#popl %ebx
	#popa
	
	add $1, %ecx
	jmp citire_nod
	
	
afisare_matrice:

	movl $0, lineIndex
	for_lines:
		movl lineIndex, %ecx
		cmp %ecx, n
		je et_exit
		movl $0, columnIndex
	
	
for_columns:
	movl columnIndex, %ecx
	cmp %ecx, n
	je conti

	movl lineIndex, %eax
	movl $0, %edx
	mull n
	addl columnIndex, %eax

	lea matrix, %esi
	movl (%esi, %eax, 4), %ebx
	
	pushl %ebx
	pushl $formatPrintf
	call printf
	popl %ebx
	popl %ebx
	
	pushl $0
	call fflush
	popl %ebx
	
	incl columnIndex
	jmp for_columns


conti:
	movl $4, %eax
	movl $1, %ebx
	movl $newLine, %ecx
	movl $2, %edx
	
	#LINIE NOUA
	
	pushl %ecx
	call printf 
	popl %ebx
	
	
	
	#int $0x80
	incl lineIndex
	jmp for_lines
	
et_exit:
	pushl $0
	call fflush
	popl %ebx	
	
	movl $1, %eax
	movl $0, %ebx
	int $0x80

