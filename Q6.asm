global main
extern scanf
extern printf

;number in esi
read_int:
	push ebx
	push eax
	mov ebx,esp
	sub esp,4
	mov eax,esp
	push eax
	push format0
	call scanf
	mov eax, dword[ebx - 4]
	mov dword[esi],eax
	mov esp,ebx
	pop eax
	pop ebx
	ret

;number in esi
print_int:
	push ebx
	mov ebx,esp
	sub esp,4
	fld dword[esi]
	fstp dword[esp]
	push format0
	call printf
	mov esp,ebx
	pop ebx
	ret

;number in esi
read_float:
	push ebx
	push eax
	mov ebx,esp
	sub esp,8
	mov eax,esp
	push eax
	push format1
	call scanf
	fld qword[ebx - 8]
	fstp qword[esi]
	mov esp, ebx
	pop eax
	pop ebx
	ret

;number in esi
print_float:
	push ebx
	push eax
	mov ebx,esp
	sub esp,8
	fld qword[esi]
	fstp qword[esp]
	push format1
	call printf
	mov esp,ebx
	pop eax
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
msg1:db	'Enter array size: ',0h
msg2:db	'Enter array element: ',0h
breakl:	db	0ah,0h
spce:	db	32,0h
format0:db '%d',0h
format1:db '%lf',0h
arr:	TIMES 1000 dq 0.0000000
epsilon:	dq 0.000001

section .bss
anumb:	resb 1000
n:	resb 1000
i:	resb 1000
j:	resb 1000
k:	resb 1000

section .text
main:
	push msg1
	call printf
	add esp,4

	mov esi,n
	call read_int

	mov dword[i],0
	mov eax,dword[n]
	mov esi,arr
	readArray:
		cmp dword[i],eax
		je exit_readArray
		push eax
		push esi
		mov esi,anumb
		call read_float
		fld qword[anumb]
		pop esi
		mov eax,dword[i]
		fstp qword[esi + 8 * eax]
		pop eax
		inc dword[i]
		jmp readArray
	exit_readArray:

	mov dword[i],0
	mov eax,dword[n]
	mov esi,arr
	printArray:
		cmp dword[i],eax
		je exit_printArray
		push eax
		push esi
		mov eax,dword[i]
		fld qword[esi + 8 * eax]
		fstp qword[anumb]
		mov esi,anumb
		call print_float
		call space
		pop esi
		pop eax
		inc dword[i]
		jmp printArray
	exit_printArray:
	call newline

	mov esi,k
	call read_float

	mov dword[i],0
	mov dword[j],0
	mov eax,dword[n]
	mov esi,arr
	CHECKER:
		cmp dword[i],eax
		je exit_CHECKER
		push ebx
		mov ebx,dword[i]
		mov dword[j],ebx
		pop ebx
		inc dword[j]
		INNER_CHECKER:
			cmp dword[j],eax
			jnl exit_INNER_CHECKER
			push eax
			push esi
			fld qword[epsilon]
			mov eax,dword[j]
			fld qword[esi + 8 * eax]
			mov eax,dword[i]
			fadd qword[esi + 8 * eax]
			fsub qword[k]
			fabs
			fcomi st1
			jnb continue	
			push esi
			mov eax,dword[i]
			fld qword[esi + 8 * eax]
			fstp qword[anumb]
			mov esi,anumb
			call print_float
			call space
			pop esi
			push esi
			mov eax,dword[j]
			fld qword[esi + 8 * eax]
			fstp qword[anumb]
			mov esi,anumb
			call print_float
			call newline
			pop esi
			pop esi
			pop eax
			jmp chalu
			
			continue:
			pop esi
			pop eax
			
			chalu:
			ffree st0
			ffree st1
			inc dword[j]
			jmp INNER_CHECKER
		exit_INNER_CHECKER:
		inc dword[i]
		jmp CHECKER
	exit_CHECKER:
	
