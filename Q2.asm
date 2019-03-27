global main
extern printf
extern scanf

;number in esi
read_int:
	push eax
	push ebx
	mov ebx,esp
	sub esp,4
	mov eax,esp
	push eax
	push format1
	call scanf
	mov eax, dword[ebx - 4]
	mov dword[esi],eax
	mov esp,ebx
	pop ebx
	pop eax
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

;number is esi
read_float:
	push eax
	push ebx
	mov ebx,esp
	sub esp,8
	mov eax,esp
	push eax
	push format0
	call scanf
	fld qword[ebx - 8]
	fstp qword[esi]
	mov esp,ebx
	pop ebx
	pop eax
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
msg1:db	'Enter n: ',0h
msg2:db	'Average is : ',0h
breakl:db 0ah,0h
format0:db "%lf",0h
format1:db "%d",0h

section .bss
tmp:	resb	1000
l:	resb	1000
n: 	resb	1000
anumb: 	resb	1000
sum:	resb	1000
avg:	resb	1000

section .text
main:
	push msg1
	call printf
	add esp,4
	
	mov esi,n
	call read_int
	fldz
	fstp qword[sum]

	xor eax,eax
	reader:
		cmp eax,dword[n]
		je exit_reader
		push eax
		push esi
		mov esi,anumb
		call read_float
		fld qword[anumb]
		fadd qword[sum]
		fstp qword[sum]
		pop esi
		pop eax
		inc eax
		jmp reader
	exit_reader:
	push msg2
	call printf
	add esp,4
	fild qword[n]
	fstp qword[n]
	fld qword[sum]
	fdiv qword[n]
	fstp qword[avg]
	mov esi,avg
	call print_float
	call newline
