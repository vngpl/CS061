;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Assignment name: Assignment 2
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			; Program begins here
;-------------
; Instructions
;-------------

;----------------------------------------------
; output prompt
;----------------------------------------------	
LEA R0, intro			; get starting address of prompt string
PUTS			    	; Invokes BIOS routine to output string

;-------------------------------
; INSERT YOUR CODE here
;--------------------------------
AND R1, R1, #0
AND R2, R2, #0

GETC
OUT
ADD R1, R0, #0

LD R0, newline
OUT

GETC
OUT
ADD R2, R0, #0

LD R0, newline
OUT

AND R0, R0, #0
ADD R0, R1, #0
OUT

LEA R0, minus_sign
PUTS

AND R0, R0, #0
ADD R0, R2, #0
OUT

LEA R0, equal_sign
PUTS

LD R4, num_to_ascii

ADD R1, R1, R4
ADD R2, R2, R4

NOT R2, R2
ADD R2, R2, #1

AND R3, R3, #0
ADD R3, R1, R2
BRzp IF_ZERO_OR_POSITIVE

LEA R0, neg_sign
PUTS
NOT R3, R3
ADD R3, R3, #1

IF_ZERO_OR_POSITIVE
LD R4, ascii_to_num

ADD R3, R3, R4
AND R0, R0, #0
ADD R0, R3, #0
OUT

LD R0, newline
OUT

HALT				; Stop execution of program
;------	
; Data
;------
; String to prompt user. Note: already includes terminating newline!
intro           .STRINGZ	"ENTER two numbers (i.e '0'....'9')\n" 		; prompt string - use with LEA, followed by PUTS.
newline         .FILL       x0A	                                        ; newline character - use with LD followed by OUT
neg_sign        .STRINGZ    "-"
minus_sign      .STRINGZ    " - "
equal_sign      .STRINGZ    " = "
num_to_ascii    .FILL       #-48
ascii_to_num    .FILL       #48
;---------------	
; END of PROGRAM
;---------------	
.END

