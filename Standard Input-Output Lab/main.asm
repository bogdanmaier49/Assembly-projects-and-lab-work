
; 2. Read a character from the keyboard without echo. 
; If the character is a digit, print it on the screen. 
; If the character is '$', end the current program. 
; In any other situation, the character is added to 
; a buffer (i.e. a string) which will be printed on
; the screen when the program exits.

ASSUME cs:code, ds:data

data segment
	
	buffer	 		db 		255 	dup(?)
	
data ends

code segment 
	start:
		mov ax, data
		mov ds, ax
		
		mov si, 0
		run:
			; reads a character from keyboard
			mov ah, 01h
			int 21h
			
			jmp checkIfEnd
			
			; check if the read character is a digit
			jmp checkIfDigit
			
		checkIfEnd:
			cmp al, '$'
			mov buffer[si], al
			je	programEnd
		
		checkIfLetter:
			cmp al, '0'
			jge is0
			jmp checkIfDigit
			is0:
				cmp al, '9'
				jbe isLetter
				jmp checkIfDigit
			isLetter:
				mov buffer[si], al
				inc si
			jmp run
		
		checkIfDigit:
			cmp al, 'a'
			jge isa
			jmp run
			isa:
				cmp al, 'z'
				jbe isDigit
				jmp checkIfDigit
			isDigit:
				mov ah, 02h
				mov dl, al
				int 21h
			jmp run			
		
		programEnd:
			mov ah, 09h
			lea dx, buffer
			int 21h
		
		mov ax, 4c00h
		int 21h
	
code ends
end start
