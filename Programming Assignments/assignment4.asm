;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Assignment name: Assignment 4
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=================================================================================
;THE BINARY REPRESENTATION OF THE USER-ENTERED DECIMAL NUMBER MUST BE STORED IN R4
;=================================================================================

.ORIG x3000		
;-------------
;Instructions
;-------------

; output intro prompt
start_check
ld r0, introPromptPtr
puts

; Set up flags, counters, accumulators as needed
and r1, r1, #0 ; negative flag
and r2, r2, #0 ; flagged char input checker
and r3, r3, #0 ; char check result / multiplication
and r4, r4, #0 ; target register

and r5, r5, #0
add r5, r5, #5 ; char counter

and r7, r7, #0 ; double sign flag
add r7, r7, #-1

; Get first character, test for '\n', '+', '-', digit/non-digit 
do_while_check_char
    add r7, r7, #0
    brp error_msg

    and r6, r6, #0
    add r6, r6, #10

    getc
    out
    
; is very first character = '\n'? if so, just quit (no message)!
    ld r2, newline
    not r2, r2
    add r2, r2, #1 ; take 2s complement of newline to get negative for check
    add r2, r0, r2
    brz end_input ; if 0, end input

; is it = '+'? if so, ignore it, go get digits
    ld r2, check_plus
    add r2, r0, r2
    brz set_first_sign_flag
    ; br check_double_sign_flag
    ; brz do_while_check_char ; if result of check is 0, skip flagging for negative

; is it = '-'? if so, set neg flag, go get digits
	ld r2, check_minus
	add r2, r0, r2
	brz set_neg_flag
	
; is it < '0'? if so, it is not a digit	- o/p error message, start over
    ld r2, check_0
    add r2, r0, r2
    brn error_msg

; is it > '9'? if so, it is not a digit	- o/p error message, start over
    ld r2, check_9
    add r2, r0, r2
    brp error_msg

; if none of the above, first character is first numeric digit - convert it to number & store in target register!
    add r3, r4, r3
    and r4, r4, #0
    
    multiply_by_10
    add r4, r4, r3
    add r6, r6, #-1
    brp multiply_by_10
    
    ld r2, check_0
    add r3, r0, r2

; Now get remaining digits from user in a loop (max 5), testing each to see if it is a digit, and build up number in accumulator
    add r5, r5, #-1
    brp do_while_check_char
    
    br end_input ; once 5 digits reached, end input

; remember to end with a newline!

convert_to_neg
    not r4, r4
    add r4, r4, #1
    br end_check_char

set_first_sign_flag
    ; brz error_msg
    add r7, r7, #1
    br do_while_check_char

set_neg_flag
	add r1, r1, #1 ; set negative flag to 1
	add r7, r7, #1 ; set first sign flag to 1
	br do_while_check_char

error_msg
    ld r0, newline
    out
    ld r0, errorMessagePtr
    puts
    br start_check

end_input
    add r5, r5, #-5 ; if first character was newline, output error msg
    brz error_msg
    
    add r4, r4, r3 ; add final digit if terminated by newline
    add r1, r1, #0
    brp convert_to_neg

end_check_char

ld r0, newline
out

HALT

;---------------	
; Program Data
;---------------

introPromptPtr  .FILL xB000
errorMessagePtr .FILL xB200
newline         .fill #10
check_plus      .fill #-43
check_minus     .fill #-45
check_0         .fill #-48
check_9         .fill #-57

.END

;------------
; Remote data
;------------
.ORIG xB000	 ; intro prompt
.STRINGZ	 "Input a positive or negative decimal number (max 5 digits), followed by ENTER\n"
.END					

.ORIG xB200	 ; error message
.STRINGZ	 "ERROR: invalid input\n"
.END

;-------------------
; PURPOSE of PROGRAM
;-------------------
; Convert a sequence of up to 5 user-entered ascii numeric digits into a 16-bit two's complement binary representation of the number.
; if the input sequence is less than 5 digits, it will be user-terminated with a newline (ENTER).
; Otherwise, the program will emit its own newline after 5 input digits.
; The program must end with a *single* newline, entered either by the user (< 5 digits), or by the program (5 digits)
; Input validation is performed on the individual characters as they are input, but not on the magnitude of the number.
