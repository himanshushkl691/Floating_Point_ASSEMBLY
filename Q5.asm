global main
extern printf
extern scanf

;number in esi
read_int:
	push ebx
	push eax
	mov ebx,esp
	sub esp,4
	mov eax,esp
	push eax
	push format1
	call scanf
	mov eax,dword[ebx - 4]
	mov dword[esi],eax
	mov esp,ebx
	pop eax
	pop ebx
	ret

;number in esi
print_int:
	push eax
	push ebx
	mov ebx,esp
	sub esp,4
	mov eax,dword[esi]
	mov dword[esp],eax
	push format1
	call printf
	mov esp,ebx
	pop ebx
	pop eax
	ret

;number in esi
read_float:
	push ebx
	push eax
	mov ebx,esp
	sub esp,8
	mov eax,esp
	push eax
	push format0
	call scanf
	fld qword[ebx - 8]
	fstp qword[esi]
	mov esp,ebx
	pop eax
	pop ebx
	ret

;number in esi
print_float:
	push ebx
	mov ebx,esp
	sub esp,8
	fld qword[esi]
	fstp qword[esp]
	push format0
	call printf
	mov esp,ebx
	pop ebx
	ret
	
newline:
	push breakl
	call printf
	add esp,4
	ret

space:
	push spce
	call printf
	add esp,4
	ret

section .data
msg1:db	'Enter size: ',0h
msg2:db	'Enter array element',0h
breakl:	db	0ah,0h
spce:	db	32,0h
format0:db	'%lf',0h
format1:db	'%d',0h
arr:	TIMES 10000 dq 0.0000000

section .bss
anumb:	resb	100
n:	resb	100
i:	resb	100
j:	resb	100

section .text
main:
	push msg1
	call printf
	add esp,4
	
	mov esi,n
	call read_int
	mov esi,arr
	mov dword[i],0
	mov eax,dword[n]

	readArray:
		cmp dword[i],eax
		je exit_readArray
		push eax
		push ebx
		push esi
		mov esi,anumb
		call read_float
		pop esi
		fld qword[anumb]
		mov ebx,dword[i]
		fstp qword[esi + 8 * ebx]
		pop ebx
		pop eax
		inc dword[i]
		jmp readArray
	exit_readArray:

	mov esi,arr
	mov dword[i],0
	mov eax,dword[n]
	printArray:
		cmp dword[i],eax
		je exit_printArray
		push esi
		push ebx
		push eax
		mov ebx,dword[i]
		fld qword[esi + 8 * ebx]
		fstp qword[anumb]
		mov esi,anumb
		call print_float
		call space
		pop eax
		pop ebx
		pop esi
		inc dword[i]
		jmp printArray
	exit_printArray:
	call newline

	mov dword[i],0
	mov esi,arr
	mov eax,dword[n]
	SORT:
		cmp dword[i],eax
		je exitSORT
		mov dword[j],0
		mov ebx,dword[n]
		dec ebx
		INNER:
			cmp dword[j],ebx
			je exitINNER
			push ecx
			push edx
			mov ecx,dword[j]		;ecx = j
			mov edx,ecx		
			inc edx				;edx = j + 1
			fld qword[esi + 8 * edx]	;st1 = arr[j+1]
			fld qword[esi + 8 * ecx]	;st0 = arr[j]
			fcomi st1
			jna continue
			fstp qword[esi + 8 * edx]
			fstp qword[esi + 8 * ecx]
			pop edx
			pop ecx
			jmp increment
			continue:	
			pop edx
			pop ecx
			ffree st0
			ffree st1
			increment:
			inc dword[j]
			jmp INNER
		exitINNER:
		inc dword[i]
		jmp SORT
	exitSORT:
	mov esi,arr
	mov dword[i],0
	mov eax,dword[n]
	printArray0:
		cmp dword[i],eax
		je exit_printArray0
		push esi
		push ebx
		push eax
		mov ebx,dword[i]
		fld qword[esi + 8 * ebx]
		fstp qword[anumb]
		mov esi,anumb
		call print_float
		call space
		pop eax
		pop ebx
		pop esi
		inc dword[i]
		jmp printArray0
	exit_printArray0:
	call newline
