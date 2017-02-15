ASSUME cs:code, ds:data 

data SEGMENT

	A 		db 		'a', 'b', 'c', 'd'
	lenA 	equ 	$-A
	B 		db 		'e', 'f', 'g'
	lenB 	equ 	$-B
	D 		db 		lenA + lenB	DUP(?)

data ENDS

code SEGMENT
	start:
		
		mov ax, data	
		mov ds, ax
		mov es, ax
		
		cld					; make the direction flag 0, so the string indexing will be made from left to right
		
		mov cx, lenA 		; load in cx the number of bytes the array A has
		lea si, A			; loads in the register SI the offset of A
		lea di, D			; loads in the register DI the offset of D
		transA:
			movsb			; moves the byte from the address DS:SI to the address ES:DI and increments the value from  the registers SI and DI  
			loop transA		; decrements the value from CX and loops until its 0
			
		std 				; make the direction flag 1, so the string indexing will be made from right to left
		
		
		mov cx, lenB		; load in cx the number of bytes the array B has
		lea si, B+lenB-1	; loads in the register SI the near address of the string B
		lea di, D + lenA	; comute the address where we need to concatenate
		transB:
			lodsb			; load in al the byte from DS:SI
			mov [di], al	; puts the byte from al in the memory
			inc di			; increments the index
			loop transB		; loops until the value from CX is 0
		
		;Done
		
		mov ax, 4c00h
		int 21h
		
code ENDS
END start