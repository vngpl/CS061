;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 5, ex 3
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================
.orig x3000

ld r6, backup_stack_adr
ld r3, base
ld r4, max
ld r5, tos

; lea r2, array
; add r1, r1, #10

; do_while_fill_array
;     str r1, r2, #0
;     add r2, r2, #1
;     add r1, r1, #-1
;     brp do_while_fill_array
; end_do_while_fill_array

; lea r2, array

ld r2, to_num

lea r0, num_1
puts
getc
out
add r0, r0, r2
add r1, r0, #0

ld r0, sub_stack_push_3200
jsrr r0

ld r0, newline
out

lea r0, num_2
puts
getc
out
add r0, r0, r2
add r1, r0, #0

ld r0, sub_stack_push_3200
jsrr r0

ld r0, newline
out

lea r0, operation
puts
getc
out

ld r0, newline
out

ld r0, sub_rpn_addition_3600
jsrr r0

ld r0, sub_stack_pop_3400
jsrr r0

ld r2, to_ascii
add r0, r0, r2
out

halt

backup_stack_adr        .fill xFE00
base                    .fill xa000
max                     .fill xa005
tos                     .fill xa000
sub_stack_push_3200     .fill x3200
sub_stack_pop_3400      .fill x3400
sub_rpn_addition_3600   .fill x3600
; array                   .blkw #10
num_1                   .stringz "Enter a single digit number (0-9): "
newline                 .fill x0a
num_2                   .stringz "Enter another single digit number (0-9): "
operation               .stringz "Enter a operation (+): "
output_msg              .stringz "The sum is \n"
to_num                  .fill #-48
to_ascii                .fill #48

.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_PUSH_3200
; Parameter (R1): The value to push onto the stack
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has pushed (R1) onto the stack (i.e to address TOS+1). 
;		    If the stack was already full (TOS = MAX), the subroutine has printed an
;		    overflow error message and terminated.
; Return Value: R5 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3200

add r6, r6, #-1
str r1, r6, #0
add r6, r6, #-1
str r3, r6, #0
add r6, r6, #-1
str r4, r6, #0
add r6, r6, #-1
str r7, r6, #0

push
    add r0, r5, #0  ; copy TOS mem adr (r5) to r0
    not r0, r0      ; take twos complement of TOS
    add r0, r0, #1
    add r0, r4, r0  ; r0 <- r4 - r5 (MAX - TOS)
    brnz overflow_condition
    
    add r5, r5, #1  ; increment TOS
    ; ldr r5, r2, #0  ; copy element of array into r1
    str r1, r5, #0  ; store element into stack
    ; add r2, r2, #1  ; shift array up
    br end_push

    overflow_condition
        lea r0, overflow_msg
        puts
end_push

ldr r7, r6, #0
add r6, r6, #1
ldr r4, r6, #0
add r6, r6, #1
ldr r3, r6, #0
add r6, r6, #1
ldr r1, r6, #0
add r6, r6, #1

ret

overflow_msg    .stringz "Error: called push on a full stack\n"

.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_STACK_POP_3400
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped MEM[TOS] off of the stack and copied it to R0.
;		    If the stack was already empty (TOS = BASE), the subroutine has printed
;                an underflow error message and terminated.
; Return Values: R0 ← value popped off the stack
;		   R5 ← updated TOS
;------------------------------------------------------------------------------------------
.orig x3400

add r6, r6, #-1
str r3, r6, #0
add r6, r6, #-1
str r4, r6, #0
add r6, r6, #-1
str r7, r6, #0

pop
    add r0, r3, #0  ; copy base mem adr (r3) to r0
    not r0, r0      ; take twos complement of base
    add r0, r0, #1
    add r0, r5, r0  ; r0 <- r4 - r5 (MAX - TOS)
    brnz underflow_condition
    
    ldr r0, r5, #0  ; r5 <- r0
    add r5, r5, #-1 ; shift TOS down
    br end_pop
    
    underflow_condition
        lea r0, underflow_msg
        puts
end_pop

ldr r7, r6, #0
add r6, r6, #1
ldr r4, r6, #0
add r6, r6, #1
ldr r3, r6, #0
add r6, r6, #1

ret

underflow_msg   .stringz "Error: called pop on an empty stack\n"

.end

;------------------------------------------------------------------------------------------
; Subroutine: SUB_RPN_ADDITION_3600
; Parameter (R3): BASE: A pointer to the base (one less than the lowest available                      ;                       address) of the stack
; Parameter (R4): MAX: The "highest" available address in the stack
; Parameter (R5): TOS (Top of Stack): A pointer to the current top of the stack
; Postcondition: The subroutine has popped off the top two values of the stack,
;		    added them together, and pushed the resulting value back
;		    onto the stack.
; Return Value: R5 ← updated TOS address
;------------------------------------------------------------------------------------------
.orig x3600

add r6, r6, #-1
str r3, r6, #0
add r6, r6, #-1
str r4, r6, #0
add r6, r6, #-1
str r7, r6, #0

ld r0, sub_stack_pop_3400_2
jsrr r0
add r2, r0, #0

ld r0, sub_stack_pop_3400_2
jsrr r0

add r1, r2, r0

ld r0, sub_stack_push_3200_2
jsrr r0

ldr r7, r6, #0
add r6, r6, #1
ldr r4, r6, #0
add r6, r6, #1
ldr r3, r6, #0
add r6, r6, #1

ret

sub_stack_pop_3400_2    .fill x3400
sub_stack_push_3200_2   .fill x3200

.end