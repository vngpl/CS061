;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 4, ex 4
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000

LEA R1, ARRAY
LD R3, ITERATIONS
; JSR SUB_FILL_ARRAY_3200 ; JUMP TO SUBROUTINE FROM LABEL
; JSR SUB_CONVERT_ARRAY_3400
; JSR SUB_PRINT_ARRAY_3600
; JSR SUB_PRETTY_PRINT_ARRAY_3800
LD R5, SUB_FILL_ARRAY_3200 ; JUMP TO SUBROUTINE FROM REGISTER
JSRR R5
LD R5, SUB_CONVERT_ARRAY_3400
JSRR R5
LD R5, SUB_PRINT_ARRAY_3600
JSRR R5
LD R5, SUB_PRETTY_PRINT_ARRAY_3800
JSRR R5

HALT

ARRAY                       .BLKW   #10
ITERATIONS                  .FILL   #10
SUB_FILL_ARRAY_3200         .FILL   x3200
SUB_CONVERT_ARRAY_3400      .FILL   x3400
SUB_PRINT_ARRAY_3600        .FILL   x3600
SUB_PRETTY_PRINT_ARRAY_3800 .FILL   x3800

.END

;------------------------------------------------------------------------
; Subroutine: SUB_FILL_ARRAY_3200
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: The array has values from 0 through 9.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3200

AND R0, R0, #0 ; RESET TO 0
ADD R2, R1, #0 ; COPY STARTING ADDRESS OF ARRAY
ADD R4, R3, #0 ; COPY # OF ITERATIONS
STR R0, R1, #0 ; STORE FIRST VAL ('0') INTO FIRST ARRAY ADDRESS

DO_WHILE
    ADD R2, R2, #1
    ADD R0, R0, #1
    STR R0, R2, #0
    ADD R4, R4, #-1
    BRp DO_WHILE
END_DO_WHILE

RET

.END

;------------------------------------------------------------------------
; Subroutine: SUB_CONVERT_ARRAY_3400
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (number) in the array should be represented as a character. E.g. 0 -> ‘0’
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3400

AND R0, R0, #0      ; RESET TO 0
ADD R2, R1, #0      ; COPY STARTING ADDRESS OF ARRAY
ADD R4, R3, #0      ; COPY # OF ITERATIONS
LD R6, NUM_TO_ASCII ; FOR NUMBER TO ASCII CONVERSION

DO_WHILE_TO_ASCII
    LDR R0, R2, #0
    ADD R0, R0, R6
    STR R0, R2, #0
    ADD R2, R2, #1
    ADD R4, R4, #-1
    BRp DO_WHILE_TO_ASCII
END_DO_WHILE_TO_ASCII

RET

NUM_TO_ASCII    .FILL   #48

.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRINT_ARRAY_3600
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Each element (character) in the array is printed out to the console.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3600

AND R0, R0, #0      ; RESET TO 0
ADD R2, R1, #0      ; COPY STARTING ADDRESS OF ARRAY
ADD R4, R3, #0      ; COPY # OF ITERATIONS

DO_WHILE_PRINT
    LDR R0, R2, #0
    OUT
    LD R0, NEWLINE
    OUT
    ADD R2, R2, #1
    ADD R4, R4, #-1
    BRp DO_WHILE_PRINT
END_DO_WHILE_PRINT

RET

NEWLINE   .FILL   x0A

.END

;------------------------------------------------------------------------
; Subroutine: SUB_PRETTY_PRINT_ARRAY_3800
; Parameter (R1): The starting address of the array. This should be unchanged at the end of the subroutine!
; Postcondition: Prints out “=====” (5 equal signs), prints out the array, and after prints out “=====” again.
; Return Value (None)
;-------------------------------------------------------------------------

.ORIG x3800

LEA R0, EQUAL_SIGNS
PUTS

LD R5, SUB_3600_PTR
JSRR R5

LEA R0, EQUAL_SIGNS
PUTS

RET 
    ; CAUSES INFINITE LOOP BECAUSE RETURN STATEMENT IN 
    ; PREV SUBROUTINE CALL SETS R7 TO x3804 
    ; (RETURN TO SBR INSTEAD OF x3000)

EQUAL_SIGNS     .STRINGZ    "=====\n"
SUB_3600_PTR    .FILL       x3600

.END