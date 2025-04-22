.ORIG x7000

CalculateEventTime
    ; Save return address
    ST R7, CALC_SAVE_R7
    
    ; Display event start message
    LEA R0, EVENT_START_MSG
    PUTS
    
    ; Load user's input hour from TimeInput.asm
    LD R0, HOUR_VAL_ADDR
    LDR R1, R0, #0          ; Load the hour value from memory
    
    ; Subtract 3 hours from the input
    ADD R1, R1, #-3         ; Subtract 3 hours
    
    ; Division by 10
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy hour value to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn HourDigit           ; Check if < 10
    ADD R2, R2, #1      
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn HourDigit           ; Check if < 20
    ADD R2, R2, #1      
    
    ; Check for tens digit - 2 (20-23)
    ADD R3, R3, #-10
    BRn HourDigit           ; Check if < 30
    ADD R2, R2, #1      
    
HourDigit
    ADD R3, R3, #10         ; Add back the last 10
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print tens digit (Hour)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print ones digit (Hour)
    
    ; Print colon
    LD R0, COLON_CHAR
    OUT
    
    ; Display minutes (user's input minutes)
    LD R0, MINUTE_VAL_ADDR  ; Load address of MINUTE_VAL
    LDR R1, R0, #0          ; Load the minute value
    
    ; Division by 10
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy minute value to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 10
    ADD R2, R2, #1          
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn MinuteDigit         ; If < 20
    ADD R2, R2, #1          
    
    ; Check for tens digit - 2 (20-29)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 30
    ADD R2, R2, #1          
    
    ; Check for tens digit - 3 (30-39)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 40
    ADD R2, R2, #1          
    
    ; Check for tens digit - 4 (40-49)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 50
    ADD R2, R2, #1          
    
    ; Check for tens digit - 5 (50-59)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 60
    ADD R2, R2, #1          
    
MinuteDigit
    ADD R3, R3, #10         ; Add back the last 10
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print tens digit (Minute)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print ones digit (Minute)
    
    ; Now display Event End time
    LEA R0, EVENT_END_MSG
    PUTS
    
    ; Load user's input hour from TimeInput.asm
    LD R0, HOUR_VAL_ADDR    ; Address of HOUR_VAL in TimeInput.asm
    LDR R1, R0, #0          ; Load the hour value from memory
    
    ; Add 3 hours to the input
    ADD R1, R1, #3          ; Add 3 hours
    
    ; Division by 10 for hours - using the same approach as before
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy hour value to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn EndHourDigit        ; Check if < 10
    ADD R2, R2, #1      
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn EndHourDigit        ; Check if < 20
    ADD R2, R2, #1      
    
    ; Check for tens digit - 2 (20-23)
    ADD R3, R3, #-10
    BRn EndHourDigit        ; Check if < 30
    ADD R2, R2, #1      
    
EndHourDigit
    ADD R3, R3, #10         ; Add back the last 10
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print tens digit (Hour)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print ones digit (Hour)
    
    ; Print colon
    LD R0, COLON_CHAR
    OUT
    
    ; Display minutes (user's input minutes) - same as before
    LD R0, MINUTE_VAL_ADDR  ; Load address of MINUTE_VAL
    LDR R1, R0, #0          ; Load the minute value
    
    ; Division by 10
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy minute value to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn EndMinuteDigit      ; If < 10, tens digit is 0
    ADD R2, R2, #1          
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn EndMinuteDigit      ; If < 20, tens digit is 1
    ADD R2, R2, #1          
    
    ; Check for tens digit - 2 (20-29)
    ADD R3, R3, #-10
    BRn EndMinuteDigit      ; If < 30, tens digit is 2
    ADD R2, R2, #1          
    
    ; Check for tens digit - 3 (30-39)
    ADD R3, R3, #-10
    BRn EndMinuteDigit      ; If < 40, tens digit is 3
    ADD R2, R2, #1          
    
    ; Check for tens digit - 4 (40-49)
    ADD R3, R3, #-10
    BRn EndMinuteDigit      ; If < 50, tens digit is 4
    ADD R2, R2, #1          
    
    ; Check for tens digit - 5 (50-59)
    ADD R3, R3, #-10
    BRn EndMinuteDigit      ; If < 60, tens digit is 5
    ADD R2, R2, #1          
    
EndMinuteDigit
    ADD R3, R3, #10         ; Add back the last 10
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print tens digit (Minute)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #15         ; Add 15
    ADD R0, R0, #3          ; Add 3 (+48)
    OUT                     ; Print ones digit (Minute)
    
    LD R7, CALC_SAVE_R7
    RET

; - Constants -
CALC_SAVE_R7    .BLKW 1     

HOUR_VAL_ADDR   .FILL x500D  
MINUTE_VAL_ADDR .FILL x500E  
COLON_CHAR      .FILL x3A    ; ASCII code for colon (:)
ZERO_CHAR       .FILL x30    ; ASCII code for '0'

EVENT_START_MSG .STRINGZ "\nEvent Start: "
EVENT_END_MSG   .STRINGZ "\nEvent End: "

.END