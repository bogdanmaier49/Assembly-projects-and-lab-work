; 1. A string of bytes is given in 
; the data segment. Print on the 
; standard output (screen) the elements 
; of this string in base 2.





ASSUME cs:code, ds:data

data segment

	S		db	255,2,3,4,5,6,7,8,9
	lenS	equ $-S
	
data ends

code segment
	start:
	
	mov ax, data
	mov ds, ax
	
	mov si, 0
	mov cx, lenS
	
	load:
		mov bh, S[si]
		inc si
	
		mov bl, 8
		printEachBit:

			shl bh, 1
			jc print1
			jnc print0
			
			print0:
				mov dl, '0'
				jmp over
				
			print1:
				mov dl, '1'
				jmp over
				
			over:
				
				mov ah, 02h
				int 21h
				
				cmp bl, 0
				dec bl
				jne printEachBit
		
		mov ah, 02h
		mov dl, 0ah
		int 21h
		
		cmp cx, 0
		dec cx
		jne load


		
	
	mov ax, 4c00h
	int 21h
	
code ends
end start