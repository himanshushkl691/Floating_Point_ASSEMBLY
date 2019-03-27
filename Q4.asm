global main
extern scanf
extern printf

;number in esi
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
msg1:db	'Enter coefficients of x^2: ',0h
msg2:db	'Enter coefficients of x: ',0h
msg3:db	'Enter constant term: ',0h
msg4:db	'No real roots',0h
breakl:	db	0ah,0h
format0:db	'%lf',0h
two:	dq	2.0000

section .bss
a:	resb	100
b:	resb	100
c:	resb	100
x1:	resb	100
x2:	resb	100
t0:	resb	100
t1:	resb	100

section .text
main:
	push msg1
	call printf
	add esp,4
	
	mov esi,a
	call read_float
	
	push msg2
	call printf
	add esp,4
	
	mov esi,b
	call read_float
	
	push msg3
	call printf
	add esp,4
	
	mov esi,c
	call read_float

	fld qword[two]
	fmul qword[a]
	fstp qword[two]

	fld qword[b]
	fmul qword[b]
	fstp qword[t0]	;t0 = b * b
	fld1
	fstp qword[t1]
	fld1
	fadd qword[t1]
	fadd qword[t1]
	fadd qword[t1]
	fstp qword[t1]	;t1 = 4
	fld qword[a]
	fmul qword[t1]
	fstp qword[t1]	;t1 = 4 * a
	fld qword[c]
	fmul qword[t1]
	fstp qword[t1]	;t1 = 4 * a * c
	fld qword[t0]
	fsub qword[t1]	;t0 = b * b - 4 * a * c
	fldz
	fcomip st1
	jna here
	push msg4
	call printf
	add esp,4
	jmp return
	here:
	fsqrt
	fstp qword[t0]
	fldz
	fsub qword[b]
	fadd qword[t0]
	fdiv qword[two]
	fstp qword[x1]
	fldz
	fsub qword[b]
	fsub qword[t0]
	fdiv qword[two]
	fstp qword[x2]
	mov esi,x1
	call print_float
	call newline
	mov esi,x2
	call print_float
	return:
	call newline
