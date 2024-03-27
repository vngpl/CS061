;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 8, ex 2
; Lab section: 022
; TA: Karan Bhogal
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

lea r0, intro_prompt
puts

getc
out

ld r5, sub_parity_check_3600
jsrr r5

add r4, r0, #0

ld r0, newline
out

lea r0, result_prompt
puts

add r0, r4, #0
out

lea r0, result_prompt_2
puts

ld r0, num_to_char
add r0, r0, r3
out

; Test harness
;-------------------------------------------------

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
intro_prompt .stringz "Enter a character: "
newline .fill #10
sub_parity_check_3600 .fill x3600
result_prompt .stringz "The number 1's in '"
result_prompt_2 .stringz "' is: "
num_to_char .fill #48

.end

;=================================================
; Subroutine: PARITY_CHECK_3600
; Parameter: R0 (character from user input)
; Postcondition: Check number of 1s in binary value of R0
; Return Value (R3): // Fixme
;=================================================

.orig x3600

; Backup registers
add r6, r6, #-1
str r0, r6, #0
add r6, r6, #-1
str r7, r6, #0

; Code
and r1, r1, #0
add r1, r1, #8
and r2, r2, #0
add r2, r2, #1
and r3, r3, #0

do_while_check
    and r4, r0, r2
    brp increment
    resume_check
    add r2, r2, r2
    add r1, r1, #-1
    brp do_while_check
    br end_check

increment
add r3, r3, #1
br resume_check

end_check

; Restore registers
ldr r7, r6, #0
add r6, r6, #1
ldr r0, r6, #0
add r6, r6, #1

RET


.end

; LD R2, CHECK_SPOTS_3200
; AND R1, R1, #0
; AND R3, R3, #0
; ADD R3, R3, #1
		
		
; CHECK_LOOP_3200
; 	LD R0, BACKUP_R0_3200
; 	AND R0, R0, R3
; 	BRnz BYPASS_ADD_3200
; 	ADD R1, R1, #1
; 	BYPASS_ADD_3200
; 	ADD R3, R3, R3
; 	ADD R2, R2, #-1
; 	BRp CHECK_LOOP_3200
; END_CHECK_LOOP_3200

; CHECK_SPOTS_3200 .FILL #8
; backup_r0_3200 .fill #120