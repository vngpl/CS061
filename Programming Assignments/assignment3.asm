;=========================================================================
; Name & Email must be EXACTLY as in Gradescope roster!
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Assignment name: Assignment 3
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
; I hereby certify that I have not received assistance on this assignment,
; or used code, from ANY outside source other than the instruction team
; (apart from what was provided in the starter file).
;
;=========================================================================

.ORIG x3000			        ; Program begins here
;-------------
; Instructions
;-------------
LD R6, Value_ptr		    ; R6 <-- pointer to value to be displayed as binary
LDR R1, R6, #0			    ; R1 <-- value to be displayed as binary 
;-------------------------------
; INSERT CODE STARTING FROM HERE
;--------------------------------
LD R3, COUNTER                      ; OUTER LOOP SET TO 4

NIBBLE_LOOP
    LD R4, COUNTER                  ; INNER LOOP COUNTER RESET TO 4
    
    BIT_LOOP
        LD R5, MSB_1                ; LOAD b1000000000000000 (d-32768)
        
        AND R5, R5, R1              ; IF R5 == b1000000000000000
        BRn PRINT_ONE               ; BRANCH DOWN TO PRINT ASCII '1'
        
        PRINT_ZERO                  ; ELSE PRINT ASCII '0'
            LD R0, ASCII_0
            OUT
        BR BIT_SHIFT                ; BRANCHES DOWN TO 'BIT_SHIFT' TO PREVENT PRINTING '1' AFTER '0'
        
        PRINT_ONE
            LD R0, ASCII_1
            OUT
        
        BIT_SHIFT
            ADD R1, R1, R1          ; SHIFTS BIT BY DOUBLING (MULTIPLYING BY 2)
            ADD R4, R4, #-1         ; DECREMENT BIT COUNTER
        BRp BIT_LOOP                ; IF BIT COUNTER > 0,  BRANCH UP TO CONTINUE PRINTING
    END_BIT_LOOP
    
    ADD R3, R3, #-1                 ; DECREMENT NIBBLE COUNTER
    BRz END_NIBBLE_LOOP             ; IF NIBBLE COUNTER == 0, EXIT LOOP
    
    LD R0, SPACE                    
    OUT
    
    BR NIBBLE_LOOP                  ; ELSE, BRANCH UP TO PRINT REST OF NIBBLES
END_NIBBLE_LOOP

LD R0, NEWLINE                      ; TERMINATE WITH NEWLINE
OUT

HALT
;---------------	
; Data
;---------------
Value_ptr       .FILL   xCA01	    ; The address where value to be displayed is stored
MSB_1           .FILL   #-32768
COUNTER         .FILL   #4
ASCII_0         .FILL   #48
ASCII_1         .FILL   #49
SPACE           .FILL   x20
NEWLINE         .FILL   x0A

.END

.ORIG xCA01				            ; Remote data
Value   .FILL   xABCD	            ; <----!!!NUMBER TO BE DISPLAYED AS BINARY!!! Note: label is redundant.
;---------------	
; END of PROGRAM
;---------------	
.END
