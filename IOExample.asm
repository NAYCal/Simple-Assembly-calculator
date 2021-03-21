; Assembly language program -- This functions as a simple calculator that only does 1 operations of addition, subtraction, multiplication and subtraction
; Author Alexander Ng
; Date:		3/2021

.586
.MODEL FLAT

INCLUDE io.h		; header file for input/output
.STACK 4096

.DATA
num1		DWORD ?
num2		DWORD ?
prompt0		BYTE	"Enter math operator", 0
prompt1		BYTE	"Enter first number",0
prompt2		BYTE	"Enter second number", 0
string		BYTE 40 DUP (?)
resultbt	BYTE	"The result is",0
result		BYTE 11 DUP (?),0

.CODE
mul2	MACRO	num1, num2		; MACRO that multiplies two numbers
		mov		eax, num1
		mov		ebx, num2
		mul		ebx
		ENDM

div2	MACRO	num1, num2
		mov		eax, num1
		mov		ebx, num2
		mov		edx, 0

		div		ebx
		ENDM

_MainProc PROC
calc:	input	prompt1, string, 40		; read ASCII characters
		cmp		string, 101			; compares the input to 'e'
		je		endDisplay			; ends the program if it is
		atod	string		; convert to integer
		mov		num1, eax		; store in memory

		input	prompt2, string, 40			; read ASCII characters
		cmp		string, 101			; comapres the input to 'e'
		je		endDisplay			; ends the program if it is
		atod	string			; convert to integer
		mov		num2, eax			; store in memory

		input	prompt0, string, 40		; read ASCII characters
		cmp		string, 43		; compares to ASCII value of '+'
		je		addN		; if its equal jump to addN
	
		cmp		string, 45			; compares to ASCII value of '-'
		je		subN			; if its equal, jump to subN

		cmp		string, 42			; compares to ASCII value of '*'
		je		mulN			; if its equal, jump to mulN

		cmp		string, 47			; compares to ASCII value of '-'
		je		divN			; if its equal, jump to divN

		cmp		string, 101			; comapres the input to 'e'
		je		endDisplay			; ends the program if it is

endCalc:

addN:	push num2		; pushes num2 to stack
		push num1		; pushes num1 to stack
		call add2		; calls function add2
		add	esp, 8		; Remove parameters from stack
		call display
endAddN:

subN:	push num2		; pushes num2 to stack
		push num1		; pushes num1 to stack
		call sub2		; calls function sub2
		add esp, 8		; Remove parameters from stack
		call display
endSubN:

mulN:	mul2	num1, num2
		call display
endMulN:

divN:	div2	num1, num2
		call display
endDivN:

display:	dtoa	result, eax
		output	resultbt, result
		call calc
endDisplay:
		mov		eax, 0
		ret
_MainProc ENDP

add2	PROC		; procedure that takes in two numbers and adds them together
	push	ebp			; save base pointer
	mov		ebp, esp		; establish stack frame
	push	ebx		; save EBX

	mov		eax, [ebp+8]		; first number
	mov		ebx, [ebp+12]		; second number

	add		eax, ebx		; adds them both together

	pop		ebx		
	pop		ebp
	ret
add2	ENDP

sub2	PROC		; procedure that takes in two numbers and adds them together
	push	ebp			; save base pointer
	mov		ebp, esp		; establish stack frame
	push	ebx		; save EBX

	mov		eax, [ebp+8]		; first number
	mov		ebx, [ebp+12]		; second number

	sub		eax, ebx		; adds them both together

	pop		ebx		
	pop		ebp
	ret
sub2	ENDP

END