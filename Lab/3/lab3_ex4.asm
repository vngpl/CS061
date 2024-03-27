;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 3, ex 4
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000

LEA R5, ARRAY
LD R2, NEG_SENT

DO_WHILE_INPUT
    GETC
    STR R0, R5, #0
    
    CHECK_SENTINEL
        LDR R1, R5, #0
        ADD R1, R1, R2
        BRz END_DO_WHILE_INPUT
    
    ADD R5, R5, #1
    
    BRnp DO_WHILE_INPUT
END_DO_WHILE_INPUT

LEA R5, ARRAY

DO_WHILE_PRINT
    LDR R0, R5, #0
    
    CHECK_SENTINEL_2
        LDR R1, R5, #0
        ADD R1, R1, R2
        BRz END_DO_WHILE_PRINT
    
    OUT
    
    ADD R5, R5, #1
    BRp DO_WHILE_PRINT
END_DO_WHILE_PRINT

LD R0, NEWLINE
OUT

HALT

ARRAY       .BLKW   #100
NEG_SENT    .FILL   #-10
NEWLINE     .FILL   x0A

.END