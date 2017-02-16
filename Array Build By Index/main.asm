ASSUME cs:code, ds:data

data segment
	
	A 		db		'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h'
	lenA	equ		$-A
	B 		db		lenA 	dup(?)

data ends

code segment
	start:
		
		mov ax, data
		mov ds, ax
		
		mov cx, lenA

		mov si, 0
		mov di, 0
		
		
		; Adds the the values from bytes with even offset relative to A
			
		
		buildEven:
			mov dl, A[si]				
										
			mov B[di], dl		
			inc di					
				
			add si, 2
			sub cx, 2								
			cmp cx, 0				
			jne	buildEven		
			
			


		; Adds the the values from bytes with odd offset relative to A
		
		mov si, 1
		mov cx, lenA
		
		buildOdd:
			mov dl, A[si]				
										
			mov B[di], dl		
			inc di					
				
			add si, 2
			sub cx, 2								
			cmp cx, 0				
			jne	buildEven	
			
		mov ax, 4c00h
		int 21h
	
code ends
end start