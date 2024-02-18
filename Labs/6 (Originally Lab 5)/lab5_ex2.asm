;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 5, ex 2
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================
.orig x3000
; Initialize the stack. Don't worry about what that means for now.
ld r6, top_stack_addr ; DO NOT MODIFY, AND DON'T USE R6, OTHER THAN FOR BACKUP/RESTORE

lea r1, array

ld r4, sub_get_string_3200
jsrr r4
ld r4, sub_is_palindrome_3400
jsrr r4

print 
    lea r0, output_str
    puts
        
    do_while_print
        ldr r0, r1, #0
        out
        add r1, r1, #1
        add r5, r5, #-1
        brp do_while_print
    end_do_while_print
        
    add r3, r4, #0
    add r3, r3, #-1
    brn not_palindrome_print
    
    is_palindrome_print
        lea r0, output_str_is_p
        puts
        br end_print
        
    not_palindrome_print        
        lea r0, output_str_is_not_p
        puts

end_print

; your code goes here
halt

; your local data goes here
top_stack_addr          .fill xFE00 ; DO NOT MODIFY THIS LINE OF CODE
array                   .blkw #100
sub_get_string_3200     .fill x3200
sub_is_palindrome_3400  .fill x3400
output_str              .stringz "The string "
output_str_is_p         .stringz " IS a palindrome\n"
output_str_is_not_p     .stringz " IS NOT a palindrome\n"
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
str r1, r6, #0
add r6, r6, #-1
str r7, r6, #0

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

and r2, r2, #0
and r3, r3, #0

; restores registers
ldr r7, r6, #0
add r6, r6, #1
ldr r1, r6, #0
add r6, r6, #1

ret
neg_sent    .fill #-10

.end

;-------------------------------------------------------------------------
; Subroutine: SUB_IS_PALINDROME_3400
; Parameter (R1): The starting address of a null-terminated string
; Parameter (R5): The number of characters in the array.
; Postcondition: The subroutine has determined whether the string at (R1)
;		 is a palindrome or not, and returned a flag to that effect.
; Return Value: R4 {1 if the string is a palindrome, 0 otherwise}
;-------------------------------------------------------------------------
.orig x3400

; backs up registers
add r6, r6, #-1
str r7, r6, #0
add r6, r6, #-1
str r1, r6, #0
add r6, r6, #-1
str r5, r6, #0

add r2, r1, r5
add r2, r2, #-1

; r1 has first memory adr
; r2 has last memory adr
; r3 has first char
; r4 has last char
; r1 <- r1 + not(r2), if 0 same
; r1 <- r1 + 1
; r2 <- r2 - 1

do_while_compare
    add r4, r2, #0
    not r4, r4
    add r4, r4, #1
    add r4, r1, r4
    brz is_a_palindrome

    ldr r3, r1, #0
    ldr r4, r2, #0
    
    not r4, r4
    add r4, r4, #1
    
    add r4, r3, r4
    brnp not_a_palindrome
    
    add r1, r1, #1
    add r2, r2, #-1
    br do_while_compare
    
    is_a_palindrome
        add r4, r4, #1
        br end_do_while_compare
    
    not_a_palindrome
        and r4, r4, #0
    
end_do_while_compare

; restores registers
; ldr r3, r6, #0
; add r6, r6, #1
ldr r5, r6, #0
add r6, r6, #1
ldr r1, r6, #0
add r6, r6, #1
ldr r7, r6, #0
add r6, r6, #1

ret
.end