;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 5, ex 1
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

ld r5, SUB_GET_STRING_3200
jsrr r5

; your code goes here
halt

; your local data goes here

top_stack_addr      .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
sub_get_string_3200 .fill x3200
.end

; your subroutines go below here

;------------------------------------------------------------------------
; Subroutine: SUB_GET_STRING_3200
; Parameter (R1): The starting address of the character array
; Postcondition: The subroutine has prompted the user to input a string,
;	terminated by the [ENTER] key (the "sentinel"), and has stored 
;	the received characters in an array of characters starting at (R1).
;	the array is NULL-terminated; the sentinel character is NOT stored.
; Return Value (R5): The number of non-sentinel chars read from the user.
;	R1 contains the starting address of the array unchanged.
;-------------------------------------------------------------------------
.orig x3200

; backs up registers
add r6, r6, #-1
str r7, r6, #0
add r6, r6, #-1
str r3, r6, #0

lea r1, array
ld r3, neg_sent
and r5, r5, #0

do_while_input
    getc
    out
    str r0, r1, #0
    
    check_sentinel
        ldr r2, r1, #0
        add r2, r2, r3
        brz end_do_while_input
    
    add r5, r5, #1
    add r1, r1, #1
    
    brnp do_while_input
end_do_while_input

; converts newline character to null
and r0, r0, #0
str r0, r1, #0
lea r1, array

; restores registers
ldr r3, r6, #0
add r6, r6, #1
ldr r7, r6, #0
add r6, r6, #1

ret
array       .blkw   #100
neg_sent    .fill   #-10

.end