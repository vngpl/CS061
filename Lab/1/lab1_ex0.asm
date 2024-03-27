;=================================================
; Name: Vansh Nagpal
; Email: vnagp002@ucr.edu
; 
; Lab: lab 1, ex 0
; Lab section: 022
; TA: Karan Bhogal, Cody Kurpanek
; 
;=================================================

.ORIG x3000
; -------------
; INSTRUCTIONS
; -------------
LEA R0, MSG_TO_PRINT                        ; R0 <- Location of label: MSG_TO_PRINT
PUTS                                        ; Prints string defined at MSG_TO_PRINT
                                                ; (CAN USE 'TRAP x22' INSTEAD)
HALT                                        ; Terminates program

; -----------
; LOCAL DATA
; -----------
MSG_TO_PRINT .STRINGZ "Hello World!!!\n"    ; Stores 'H' in address labeled
                                            ; 'MSG_TO_PRINT' and each character
                                            ; following in its own memory address,
                                            ; with '#0' at the end of the string
                                            ; to mark the end.

.END
