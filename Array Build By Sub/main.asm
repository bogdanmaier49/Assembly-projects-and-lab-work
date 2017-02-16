
; 4. A byte string A of length l is given. Obtain the string 
;B of length l-1 so that the elements of B represent the
;difference between every two consecutive elements of A.
; Exemple:
; A: 1, 2, 4, 6, 10, 20, 25
; B: 1, 2, 2, 4, 10, 5


ASSUME cs:code, ds:data

data segment
	
	A 		db		1, 2, 4, 6, 10, 20, 25
	lenA	equ		$-A
	B 		db		lenA-1 	dup(?)

data ends

code segment
	start:
		
		mov ax, data
		mov ds, ax
	
		mov cx, lenA
		dec cx
		mov si, 0
		
		build:
			
			mov al, A[si]
			mov bl, A[si+1]
			sub bl, al
			mov B[si], bl
			
			inc si
			dec cx
			cmp cx, 0
			jne build
	
		mov ax, 4c00h
		int 21h
	
code ends
end start