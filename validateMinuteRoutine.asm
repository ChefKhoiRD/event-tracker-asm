; Error handling minutes
; If invalid PRINT "Incorrect input, please enter a number between 00 - 59"

    .ORIG x3100

VALIDATE_MINUTE
    BRn INVALID

    LD R1, MAX_MINUTE   ; Load MAX_MINUTE value (00-59)
    NOT R1, R1          ; Bitwise NOT to get -MAX_MINUTE (-60)
    ADD R1, R1, #1      ; Add 1 = -59
    ADD R2, R0, R1      ; MAX_MINUTE = R2 of 59
    BRp INVALID

    AND R0, R0, #0      ; Clear R0
    RET

INVALID
    ADD R0, R0, #1      ; Checks for INVALID input and other subroutine call upon it
    RET

MAX_MINUTE .FILL #59

    .END