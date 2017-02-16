ASSUME cs:code, ds:data

data segment

	A 		db 		2, 4, 7, 3, 8
	lenA	equ  	$-A
	B 		db 		-1, 6, 10, 11, 4
	D 		db 		lenA 	DUP(0)
	
data ends

code segment
	start:
		
		mov ax, data
		mov ds, ax
		
		mov si, 0							; si is the index of the curent position
		mov cx, lenA						; loads in CX the number of bytes of array A
		
		moveTroughString:
			dec cx							; decrements the value from cx.
			
			mov bl, A[si]					; move in bl the byte from A at the index si.
			mov bh, B[si]					; move in bh the byte from B at the index si.
			
			mov ax, si						; move in AL the index.
			shr ax,	1						; shift all the bits to the right 1 time. The value of the last bit will be in CF.
			jc _odd							; if the CF is 1 that means the number is odd, otherwise the number is even.
			clc								; clears the carry flag value.
			
			_even:							; if the number is even.
				add bl, bh					; add the values from bl and bh and memorize the result in bl.
				mov offset D[si], bl		; then the result is loaded in memory at the address of D + the curent index value.
				inc si						; increments the index.
				cmp cx, 0					; compares cx with 0.
				jne moveTroughString		; if CX is not 0 go back to moveTroughString.
			_odd:
				sub bl, bh					; subtract the values from bl and bh and memorize the result in bl.
				mov offset D[si], bl		; then the result is loaded in memory at the address of D + the curent index value.
				inc si						; increments the index.
				cmp cx, 0					; compares cx with 0.
				jne moveTroughString		; if CX is not 0 go back to moveTroughString.	
				
		mov ax, 4c00h
		int 21h
		
code ends
end start