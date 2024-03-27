;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 3, ex 3
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000

LEA R5, ARRAY
LD R2, ITERATIONS

DO_WHILE_INPUT
    GETC
    ADD R1, R0, #0
    STR R1, R5, #0
    ADD R5, R5, #1
    ADD R2, R2, #-1
    BRp DO_WHILE_INPUT
END_DO_WHILE_INPUT

LEA R5, ARRAY
LD R2, ITERATIONS

DO_WHILE_PRINT
    LDR R0, R5, #0
    OUT
    LD R0, NEWLINE
    OUT
    ADD R5, R5, #1
    ADD R2, R2, #-1
    BRp DO_WHILE_PRINT
END_DO_WHILE_PRINT

HALT

ITERATIONS  .FILL   #10
ARRAY       .BLKW   #10
NEWLINE     .FILL   x0A

.END