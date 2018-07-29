		.ORIG X3000
;initialize the stack pointer
		LD R6,POINTER	
;set up the keyboad interrupt vector table entry		
		LD R1,KEY
		LD R2,INTERADD	
		STR R2,R1,#0
;enable keyboard interrupts
		LD R2,IE
		STI R2,KBSR	
;start of actual user program to print the checkerboard
		AND R5,R5,#0
REPUT		LEA R0,CHECKER1
		TRAP x22
		JSR DELAY
		AND R4,R5,#1
		BRnp REPUT2
		LEA R0,CHECKER2
		TRAP x22
		JSR DELAY
		AND R4,R5,#1
		BRnp REPUT2
		BRnzp REPUT

REPUT2		LEA R0,CHECKER3
		TRAP x22
		JSR DELAY
		AND R4,R5,#1
		BRz REPUT
		LEA R0,CHECKER4
		TRAP x22
		JSR DELAY
		AND R4,R5,#1
		BRz REPUT
		BRnzp REPUT2

		TRAP x25

DELAY		ST R1,SaveR1
		LD R1,COUNT
REP		ADD R1,R1,#-1
		BRp REP
		LD R1,SaveR1
		RET

COUNT		.FILL #2500
SaveR1		.BLKW 1
				
POINTER		.FILL x3000
INTERADD	.FILL x2000
KEY		.FILL x0180
KBSR		.FILL xFE00
IE		.FILL x4000
CHECKER1	.STRINGZ "**    **    **    **    **    **    **    **\n"
CHECKER2	.STRINGZ "   **    **    **    **    **    **    **   \n"
CHECKER3	.STRINGZ "##    ##    ##    ##    ##    ##    ##    ##\n"
CHECKER4	.STRINGZ "   ##    ##    ##    ##    ##    ##    ##   \n"
		.END
