.ORIG x3000

;================================================
; Assuming that R2 and R3 hold the minutes sunset
; time, CalculateLaunchTime increases the time
; to the next 30 minute increment. If the next 30
; minute increment in on the hour, the program 
; should increase the hour time by 1, but for now
; it just prints out a message that the hour was
; incremented.
;================================================


;================================================
; This Section is for testing,
; delete when merging
;================================================

FirstDigit
    ; Input first digit to R2
    LEA R0, PROMPT1
    PUTS
    GETC
    OUT
    ADD R2, R0, #0 ;move ASCII number to R2
    LD R5, A_TO_D
    ADD R2, R2, R5 ; convert ASCII to Decimal

SecondDigit
    ; Input second digit to R3
    LEA R0, PROMPT2
    PUTS
    GETC
    OUT
    ADD R3, R0, #0 ;move ASCII number to R3
    LD R5, A_TO_D
    ADD R3, R3, R5 ; convert ASCII to Decimal

;===============================================
; Keep the routines below when merging
; Assumes the two minute digits are in R2 and R3
;===============================================

CalculateLaunchTime
    ; Is the right digit 0?
    AND R6, R6, #0  ; Clear R6 to use condition codes
    ADD R6, R3, #0  ; Set off condition code
    BRp oLoop       ; Start the outer loop if its not zero
    
    ; Given that the right digit is 0, is the Left digit 0 too?
    ADD R6, R2, #0 ; Set condition codes based on R2 = 0
    BRz EXIT        ; If R2 == 0, go to EXIT
    ; Is the Left digit 3?
    ADD R6, R2, #-3 ; Set condition codes based on R2 - 3
    BRz EXIT        ; If R2 == 3, go to EXIT

    
oLoop
    ; Is the right digit 9?
    ADD R6, R3, #-9 ; 
    BRnp iLoop       ;
    
    ADD R6, R2, #-5 ; Is the left digit 5?
    BRz IncrementHour
    
    AND R3, R3, #0 ; Right digit = 0
    ADD R2, R2, #1 ; Increment left digit
    
    ; Is the left digit 3?
    ADD R6, R2, #-3 ; 
    BRz EXIT        ; stop if yes
    BR oLoop        ; run it again if not
        
iLoop
    ADD R3, R3, #1 ; increment right digit
    BR oLoop

IncrementHour
    AND R2, R2, #0 ; Left digit zero
    AND R3, R3, #0 ; Right digit zero
    ; INSERT CODE TO INCREMENT WHERE HOUR
    ; IS STORED HERE!!
    LEA R0, HRINCMSG    ; Message to show
    PUTS                ; that hour was
    BR EXIT             ; Incremented
    
; Delete this portion when merging
PROMPT1     .STRINGZ "\nEnter first minute digit: "
PROMPT2     .STRINGZ "\nEnter second minute digit: "
HRINCMSG    .STRINGZ "\nHour Incremented!"

; Keep these
A_TO_D      .FILL xFFD0 ;-48 in hex
D_TO_A      .FILL x30 ;48 in hex

EXIT

HALT
.END
