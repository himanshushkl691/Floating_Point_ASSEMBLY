global main
extern scanf
extern printf

;number in esi
read_numb:
    push eax
	push ebp
	mov ebp,esp
	sub esp,8
	mov eax,esp
	push eax
	push format0
	call scanf
	fld qword[ebp - 8]
	fstp qword[esi]
	mov esp,ebp
	pop ebp
    pop eax
	ret

;number in esi
print_numb:
	push ebp
	mov ebp,esp
	sub esp,8
	fld qword[esi]
	fstp qword[esp]
	push format0
	call printf
	mov esp,ebp
	pop ebp
	ret

newline:
	push breakl
	call printf
	add esp,4
	ret

section .data
msg1:db 'Enter first number: ',0h
msg2:db	'Enter second number: ',0h
msg3:db	'Product is : ',0h
msg4:db	'Sum is : ',0h
msg5:db	'Difference is : ',0h
format0:db "%lf",0h
breakl:db	0ah,0h

section .bss
anumb:	resb	100
bnumb:	resb	100
prod:	resb	1000
sum:	resb	1000
diff:	resb	1000

section .text
main:
	push msg1
	call printf
	add esp, 4

	mov esi,anumb
	call read_numb
	
	push msg2
	call printf
	add esp,4

	mov esi,bnumb
	call read_numb

	;MULTIPLICATION
	push msg3
	call printf
	add esp,4
	fld qword[anumb]
	fmul qword[bnumb]
	fstp qword[prod]
	mov esi,prod
	call print_numb
	call newline

	;SUM
	push msg4
	call printf
	add esp,4
	fld qword[anumb]
	fadd qword[bnumb]
	fstp qword[sum]
	mov esi,sum
	call print_numb
	call newline

	;DIFFERENCE
	push msg5
	call printf
	add esp,4
	fld qword[anumb]
	fsub qword[bnumb]
	fabs
	fstp qword[diff]
	mov esi,diff
	call print_numb
	call newline
	ret
