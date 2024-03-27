;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 8, ex 1
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.orig x3000

LD R6, top_stack_addr

; Test harness
;-------------------------------------------------
ld r5, sub_load_fill_value_3200
jsrr r5

add r1, r1, #1

ld r5, sub_output_as_decimal_3400
jsrr r5

HALT

; Test harness local data
;-------------------------------------------------
top_stack_addr .fill xFE00
sub_load_fill_value_3200 .fill x3200
sub_output_as_decimal_3400 .fill x3400

.end

;=================================================
; Subroutine: LOAD_FILL_VALUE_3200
; Parameter: None
; Postcondition: Loads hardcoded '.fill' value into a register
; Return Value: R1 (value from '.fill')
;=================================================

.orig x3200

; Backup registers
add r6, r6, #-1
str r7, r6, #0

; Code
ld r1, value_to_load

; Restore registers
ldr r7, r6 #0
add r6, r6, #1

RET

value_to_load .fill #32767

.end

;=================================================
; Subroutine: OUTPUT_AS_DECIMAL_3400
; Parameter: R1 + 1
; Postcondition: Output value in R1 as decimal value
; Return Value: N/A
;=================================================

.orig x3400

; Backup registers
add r6, r6, #-1
str r7, r6, #0

and r2, r2, #0 ; digit checker
and r3, r3, #0 ; counter

ld r0, msb_1
add r2, r1, #0
and r2, r2, r0
brz skip_conversion

set_flag_and_convert_to_positive
    not r1, r1
    add r1, r1, #1 ; make positive
    
ld r0, minus
out

skip_conversion

; Code
ld r2, dec_10000
do_while_10000
    add r1, r1, r2
    brn end_do_while_10000
    add r3, r3, #1
    br do_while_10000
end_do_while_10000

not r2, r2
add r2, r2, #1 ; convert negative digit check to positive for addition
add r1, r1, r2

add r3, r3, #0
brz skip_to_1000

ld r0, num_to_char
add r0, r3, r0
out

skip_to_1000

and r3, r3, #0
ld r2, dec_1000
do_while_1000
    add r1, r1, r2
    brn end_do_while_1000
    add r3, r3, #1
    br do_while_1000
end_do_while_1000

not r2, r2
add r2, r2, #1
add r1, r1, r2

add r3, r3, #0
brz skip_to_100

ld r0, num_to_char
add r0, r3, r0
out

skip_to_100

and r3, r3, #0
ld r2, dec_100
do_while_100
    add r1, r1, r2
    brn end_do_while_100
    add r3, r3, #1
    br do_while_100
end_do_while_100

not r2, r2
add r2, r2, #1
add r1, r1, r2

add r3, r3, #0
brz skip_to_10

ld r0, num_to_char
add r0, r3, r0
out

skip_to_10

and r3, r3, #0
ld r2, dec_10
do_while_10
    add r1, r1, r2
    brn end_do_while_10
    add r3, r3, #1
    br do_while_10
end_do_while_10

not r2, r2
add r2, r2, #1
add r1, r1, r2

add r3, r3, #0
brz end_check

ld r0, num_to_char
add r0, r3, r0
out

end_check

ld r0, num_to_char
add r0, r1, r0
out

RET
msb_1           .fill #-32768
num_to_char     .fill #48
dec_10000       .fill #-10000
dec_1000        .fill #-1000
dec_100         .fill #-100
dec_10          .fill #-10
minus           .fill #45

.end