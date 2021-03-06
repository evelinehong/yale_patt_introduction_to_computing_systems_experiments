		.ORIG x3000
		LEA R0,PROMPT
		Trap x22
		
		LEA R1,NUMBER
		LD R3,NEGENTER
AGAIN		Trap x20
		Trap x21
		ADD R2,R0,R3
		BRz LIST
		STR R0,R1,#0
		ADD R1,R1,#1
		BR AGAIN

LIST		LD R1,POINTER

LINKLIST	LDR R1,R1,#0
		BRz LINKERROR
		LDR R2,R1,#1
		LDR R3,R1,#2

		LEA R4,NUMBER
COMPARE		LDR R6,R4,#0		
		LDR R5,R2,#0
		BRnp MOVE
		NOT R6,R6
		ADD R6,R6,#1
		ADD R6,R5,R6
		BRz	CONT
		BRnp LINKLIST
		
MOVE		NOT R6,R6
		ADD R6,R6,#1
		ADD R6,R5,R6
		BRnp LINKLIST
		ADD R2,R2,#1
		ADD R4,R4,#1
		BRnzp COMPARE

LINKERROR	LEA R0,ERROR
		Trap x22
		BRnzp STOP

CONT		ADD R0,R3,#0
		Trap x22
STOP		HALT	

PROMPT		.STRINGZ "Type a room number and press Enter"
ERROR		.stringz "No Entry"
NEGENTER	.FILL xFFF6
POINTER		.FILL x3300
NUMBER		.BLKW 11
		.END