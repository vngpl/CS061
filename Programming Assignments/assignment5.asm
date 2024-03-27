; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Assignment name: Assignment 5
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
; PUT ALL YOUR CODE AFTER THE main LABEL
;=================================================================================

;---------------------------------------------------------------------------------
;  Initialize program by setting stack pointer and calling main subroutine
;---------------------------------------------------------------------------------
.ORIG x3000

; initialize the stack
ld r6, stack_addr

; call main subroutine
lea r5, main
jsrr r5

;---------------------------------------------------------------------------------
; Main Subroutine
;---------------------------------------------------------------------------------
main
; get a string from the user
lea r1, user_string     ; load address of array into r1

ld r5, get_user_string_addr
jsrr r5

; find size of input string
ld r5, strlen_addr
jsrr r5

add r2, r1, r0          ; add length of string to starting address to get to end of array
add r2, r2, #-1         ; subtract 1 to get address of final character

; call palindrome method
ld r5, palindrome_addr
jsrr r5

; determine of stirng is a palindrome
add r3, r0, #0        ; r3 <- r0, copy r0 to r3  

; print the result to the screen
lea r0, result_string
puts

add r3, r3, #0
brp skip_not

; decide whether or not to print "not"
not_a_palindrome
    lea r0, not_string
    puts

skip_not
lea r0, final_string
puts

HALT

;---------------------------------------------------------------------------------
; Required labels/addresses
;---------------------------------------------------------------------------------

; Stack address ** DO NOT CHANGE **
stack_addr           .FILL    xFE00

; Addresses of subroutines, other than main
get_user_string_addr .FILL    x3200
strlen_addr          .FILL    x3300
palindrome_addr      .FILL	  x3400

; Reserve memory for strings in the progrtam
result_string        .STRINGZ "The string is "
not_string           .STRINGZ "not "
final_string         .STRINGZ "a palindrome\n"

; Reserve memory for user input string
user_string          .BLKW	  100

.END


;---------------------------------------------------------------------------------
; get_user_string - gets string from user, terminates input if newline character
;
; parameter: R1 - starting address of the array
;
; returns: nothing
;---------------------------------------------------------------------------------
.ORIG x3200

get_user_string
; Backup all used registers, R7 first, using proper stack discipline
add r6, r6, #-1
str r7, r6, #0
add r6, r6, #-1
str r1, r6, #0

ld r3, neg_sent

lea r0, user_prompt
puts

do_while_input
    getc
    out
    str r0, r1, #0              ; store character into array
    
    check_sentinel
        ldr r2, r1, #0          ; r2 <- r1
        add r2, r2, r3          ; r2 <- r2 + r3
        brz end_do_while_input  ; if newline detected (r2 = 0), end input
    
    add r1, r1, #1              ; shift array to next slot
    
    brnp do_while_input
end_do_while_input

; converts newline character to null
and r0, r0, #0
str r0, r1, #0

and r2, r2, #0
and r3, r3, #0

; Resture all used registers, R7 last, using proper stack discipline
ldr r1, r6, #0
add r6, r6, #1
ldr r7, r6, #0
add r6, r6, #1

ret
neg_sent    .fill #-10
user_prompt .STRINGZ "Enter a string: "

.END

;---------------------------------------------------------------------------------
; strlen - compute the length of a zero terminated string
;
; parameter: R1 - the address of a zero terminated string
;
; returns: R0 - the length of the string
;---------------------------------------------------------------------------------
.ORIG x3300
strlen

; Backup all used registers, R7 first, using proper stack discipline
add r6, r6, #-1
str r7, r6, #0
add r6, r6, #-1
str r1, r6, #0

and r0, r0, #0                  ; return value holding length of string

do_while_get_len
    ldr r2, r1, #0              ; load value into r2
    brz end_do_while_get_len    ; if value in r2 is 0, end counting
    add r1, r1, #1              ; shift array to next element
    add r0, r0, #1              ; increment length
    br do_while_get_len
end_do_while_get_len

; Resture all used registers, R7 last, using proper stack discipline
ldr r1, r6, #0
add r6, r6, #1
ldr r7, r6, #0
add r6, r6, #1

ret

.END

;---------------------------------------------------------------------------------
; palindrome - recursively checks string to see if it is a palindrome
;
; parameter: R1 - starting address of the array
; parameter: R2 - final adress of the array
;
; returns: 1 if the string is a palindrome, 0 if not a palindrome
;---------------------------------------------------------------------------------
.ORIG x3400
palindrome ; Hint, do not change this label and use for recursive alls
; Backup all used registers, R7 first, using proper stack discipline
add r6, r6, #-1
str r7, r6, #0
add r6, r6, #-1
str r2, r6, #0
add r6, r6, #-1
str r1, r6, #0

; base case: beginning greater than end
add r3, r2, #0      ; r3 <- r2, copy last memory address into r3
not r3, r3      
add r3, r3, #1      ; 2's complement of last memory address
add r3, r1, r3      ; r3 <- r1 - r3, check if addresses are the same
brzp return_true     ; if 0 middle reached, return true (r0 = 1)

; if not true, compare characters
ldr r3, r1, #0      ; r3 <- r1, get character from first memory address
ldr r4, r2, #0      ; r4 <- r2, get character from last memory address

not r4, r4      
add r4, r4, #1      ; 2's complement of last character

add r4, r3, r4      ; r4 <- r3 - r4, check if characters are the same
brnp return_false   ; if not 0, characters dont match, return false (r0 = 0)

add r1, r1, #1      ; increment r1 to next char mem adr
add r2, r2, #-1     ; decrement r2 to previous char mem adr
jsr palindrome
    add r0, r0, #0
    brz restore_registers

return_true         ; r0 = 1 if palindrome
    and r0, r0, #0
    add r0, r0, #1
    br restore_registers

return_false        ; r0 = 0 if not palindrome
    and r0, r0, #0

restore_registers
ldr r1, r6, #0
add r6, r6, #1
ldr r2, r6, #0
add r6, r6, #1
ldr r7, r6, #0
add r6, r6, #1

ret

.END
