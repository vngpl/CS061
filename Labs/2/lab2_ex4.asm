;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 2, ex 4
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000

LD R0, HEX_61
LD R1, HEX_1A

LOOP
    OUT
    ADD R0, R0, #1
    ADD R1, R1, #-1
    BRp LOOP

HALT

HEX_61  .FILL x61
HEX_1A  .FILL x1A

.END