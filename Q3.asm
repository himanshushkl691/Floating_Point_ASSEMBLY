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
msg1:db	'Enter radius of circle: ',0h
msg2:db	'Circumference: ',0h
breakl:	db	0ah,0h
format0:	db	'%lf',0h

section .bss
radius:	resb	1000
circum:	resb	1000

section .text
main:
	push msg1
	call printf
	add esp,4
	
	mov esi,radius
	call read_float
	
	fld1
	fstp qword[circum]
	fld1
	fadd qword[circum]
	fstp qword[circum]
	fldpi
	fmul qword[circum]
	fmul qword[radius]
	fstp qword[circum]
	push msg2
	call printf
	add esp,4
	mov esi,circum
	call print_float
	call newline
