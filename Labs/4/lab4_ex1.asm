;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 4, ex 1
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000

LEA R1, ARRAY
LD R3, ITERATIONS
LD R5, SUB_FILL_ARRAY_3200
JSRR R5

HALT

ARRAY                   .BLKW   #10
ITERATIONS              .FILL   #9
SUB_FILL_ARRAY_3200     .FILL   x3200

.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3200

AND R0, R0, #0
ADD R2, R1, #0
ADD R4, R3, #0
STR R0, R1, #0

DO_WHILE
    ADD R2, R2, #1
    ADD R0, R0, #1
    STR R0, R2, #0
    ADD R4, R4, #-1
    BRp DO_WHILE
END_DO_WHILE

RET

.END