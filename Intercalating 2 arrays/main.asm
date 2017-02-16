
; 5. Two byte string S1 and S2 are given, having 
; the same length. Obtain the string D by intercalating 
; the elements of the two strings. 
;
; Exemple: 
; S1: 1, 3, 5, 7
; S2: 2, 6, 9, 4
; D: 1, 2, 3, 6, 5, 9, 7, 4

ASSUME cs:code, ds:data

data segment
	
	A 		db		'a', 'b', 'c', 'd', 'e', 'f'
	B 		db		'1', '2', '3', '4', '5', '6'
	len		equ		$-B
	D		db		len*2 	dup(?)
	
data ends

code segment
	start:
		
		mov ax, data
		mov ds, ax
		
		mov si, 0
		mov di, 0
		mov cx, len
		
		build:
			
			mov al, A[si]
			mov ah, B[si]
			
			mov D[di], al
			inc di
			mov D[di], ah
			inc di
			
			inc si
			dec cx
			cmp cx, 0
			jne build
	
		mov ax, 4c00h
		int 21h
	
code ends
end start