global main
extern scanf
extern printf
	
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

section .data
msg1:db	'Enter x: ',0h
format0:db	'%lf',0h
breakl:db 0ah,0h
spce:db 32,0h
factorial:	TIMES 1000 dq 1.000

section .bss
anumb:	resb 1000
x:	resb 1000
i:	resb 1000
sum:	resb 1000

section .text
main:
	push msg1
	call printf
	add esp,4
	
	mov esi,x
	call read_float

	fld qword[x]
	fstp qword[sum]
	mov eax,10
	mov dword[i],2
	mov esi,factorial
	fill_fac:
		cmp dword[i],eax
		je exit_fill
		push eax
		fild dword[i]
		mov eax,dword[i]
		dec eax
		fmul qword[esi + 8 * eax]
		inc eax
		fstp qword[esi + 8 * eax]
		pop eax
		inc dword[i]
		jmp fill_fac
	exit_fill:

	fld qword[x]
	fmul qword[x]
	fmul qword[x]
	fstp qword[anumb]
	fld qword[esi + 24]
	fldz
	fsub qword[anumb]
	fdiv st1
	fadd qword[sum]
	fstp qword[sum]
	ffree st0

	fld qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fdiv qword[esi + 40]
	fadd qword[sum]
	fstp qword[sum]

	fld qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fmul qword[x]
	fstp qword[anumb]
	fldz
	fsub qword[anumb]
	fdiv qword[esi + 56]
	fadd qword[sum]
	fstp qword[sum]
	mov esi,sum
	call print_float
	call newline
