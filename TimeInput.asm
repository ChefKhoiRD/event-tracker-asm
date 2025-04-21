.ORIG x3100 

GetSunsetTime
    ADD R5, R7, #0       ; Save return address in R5
    JSR HoursRoutine
    JSR MinuteRoutine
    JSR DisplayTimeRoutine
    JSR CalculateLaunchTime
    
    LEA R0, SUCC_PTR
    LDR R0, R0, #0
    PUTS
    
    ; Simple debug message
    LEA R0, DBG_PTR
    LDR R0, R0, #0
    PUTS
    
    ; IMPORTANT: Make sure R7 is correctly restored and we return
    ADD R7, R5, #0       ; Restore return address
    RET                  ; Return to EventDisplay.asm

HoursRoutine
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0

    LEA R0, PROMPT_H_PTR
    LDR R0, R0, #0
    PUTS
    
    LD R5, ASCII        ; Load ASCII constant (-48)
    ADD R1, R0, R5      ; Convert ASCII to decimal digit

GetHourLoop
    ; Get first digit
    GETC
    OUT
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16     ; Subtract 16
    ADD R1, R1, #-16     ; Subtract 16
    ADD R1, R1, #-16     ; Subtract 16
    
    ; Check if valid digit (0-9)
    BRn InvalidHourInput  ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidHourInput  ; If > 9
    
    ; Multiply by 10
    AND R4, R4, #0        ; Clear R4
    ADD R3, R1, #0        ; Copy digit to R3
    
    ADD R4, R4, R3        ; Multiply
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    
    ; Get second digit
    GETC
    OUT
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    
    ; Check if valid digit (0-9)
    BRn InvalidHourInput  ; If negative, not a digit
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidHourInput  ; If > 9, not a digit
    
    ; Combine digits
    ADD R1, R4, R1        ; R1 = First digit (x10) + Second Digit
    
    ; Validate hour (0-23)
    BRn InvalidHourInput  ; If negative, invalid
    
    ; Check if hour > 23
    ADD R2, R1, #-16      ; Subtract 16
    ADD R2, R2, #-7       ; Subtract 7 (total 23)
    BRp InvalidHourInput  ; If > 23, invalid
    
    ; Store valid hour
    LEA R2, HOUR_PTR
    LDR R2, R2, #0
    STR R1, R2, #0
    RET

InvalidHourInput
    LEA R0, ERR_H_PTR
    LDR R0, R0, #0
    PUTS
    BR GetHourLoop

MinuteRoutine
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    
    LEA R0, PROMPT_M_PTR
    LDR R0, R0, #0
    PUTS    
    
    LD R5, ASCII        ; Load ASCII constant (-48)
    ADD R1, R0, R5      ; Convert ASCII to decimal digit

GetMinuteLoop
    GETC
    OUT
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    
    ; Check if valid digit (0-9)
    BRn InvalidMinuteInput  ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidMinuteInput  ; If > 9
    
    ; Multiply by 10
    AND R4, R4, #0        ; Clear R4
    ADD R3, R1, #0        ; Copy digit to R3
    
    ADD R4, R4, R3        ; Multiply
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    ADD R4, R4, R3
    
    ; Get second digit
    GETC
    OUT
    
    ; Convert ASCII to decimal (FIXED)
    ADD R1, R0, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    
    ; Check if valid digit (0-9)
    BRn InvalidMinuteInput  ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidMinuteInput  ; If > 9
    
    ; Combine digits
    ADD R1, R4, R1        ; R1 = First digit (x10) + Second Digit
    
    ; Validate minute (0-59)
    BRn InvalidMinuteInput  ; If negative
    
    ; Check if minute > 59 (FIXED)
    AND R2, R2, #0        ; Clear R2
    ADD R2, R1, #0        ; Copy R1 to R2
    ADD R2, R2, #-16      ; Subtract 16
    ADD R2, R2, #-16      ; Subtract 16
    ADD R2, R2, #-16      ; Subtract 16
    ADD R2, R2, #-12      ; Subtract 12 (total 60)

    BRzp InvalidMinuteInput  ; If >= 60 (not valid)
    
    ; Store valid minute
    LEA R2, MIN_PTR
    LDR R2, R2, #0
    STR R1, R2, #0
    RET

InvalidMinuteInput
    LEA R0, ERR_M_PTR
    LDR R0, R0, #0
    PUTS
    BR GetMinuteLoop

DisplayTimeRoutine
    LEA R0, SUN_PTR
    LDR R0, R0, #0
    PUTS
    
    ; Load Hour from memory
    LEA R6, HOUR_PTR
    LDR R6, R6, #0        ; Get address of HourTime
    LDR R1, R6, #0        ; Load validated hour from memory
    
    ; Division by 10 for hours
    AND R2, R2, #0      ; Clear R2
    AND R3, R3, #0      ; Clear R3
    ADD R3, R1, #0      ; Copy hour to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn HourDigit       ; Check if < 10
    ADD R2, R2, #1      
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn HourDigit       ; Check if < 20
    ADD R2, R2, #1      
    
    ; Check for tens digit - 2 (20-23)
    ADD R3, R3, #-10
    BRn HourDigit       ; Check if < 30
    ADD R2, R2, #1      
    
HourDigit
    ADD R3, R3, #10     ; Fix remainder (add back the last 10)
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #3      ; Add 3 (+48)
    OUT                 ; Print tens digit (Hour)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15 
    ADD R0, R0, #15     ; Add 15 
    ADD R0, R0, #3      ; Add 3 (+48)
    OUT                 ; Print ones digit (Hour)
    
    ; Print colon
    LEA R0, COL_PTR
    LDR R0, R0, #0
    OUT
    
    ; Load Minutes from memory
    LEA R6, MIN_PTR
    LDR R6, R6, #0       ; Get address of MinuteTime
    LDR R1, R6, #0       ; Load validated minutes from memory
    
    ; Division by 10 for minutes using fixed checks
    AND R2, R2, #0      ; Clear R2
    AND R3, R3, #0      ; Clear R3
    ADD R3, R1, #0      ; Copy minute to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn MinuteDigit     ; If < 10, tens digit is 0
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn MinuteDigit     ; If < 20, tens digit is 1
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 2 (20-29)
    ADD R3, R3, #-10
    BRn MinuteDigit     ; If < 30, tens digit is 2
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 3 (30-39)
    ADD R3, R3, #-10
    BRn MinuteDigit     ; If < 40, tens digit is 3
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 4 (40-49)
    ADD R3, R3, #-10
    BRn MinuteDigit     ; If < 50, tens digit is 4
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 5 (50-59)
    ADD R3, R3, #-10
    BRn MinuteDigit     ; If < 60, tens digit is 5
    ADD R2, R2, #1      ; Increment tens digit
    
MinuteDigit
    ADD R3, R3, #10     ; Add back the last 10
    
    ; Convert tens digit to ASCII
    ADD R0, R2, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #3      ; Add 3 (+48)
    OUT                 ; Print tens digit (Minute)
    
    ; Convert ones digit to ASCII
    ADD R0, R3, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #15     ; Add 15
    ADD R0, R0, #3      ; Add 3 (+48)
    OUT                 ; Print ones digit (Minute)
    
    ; Print newline
    LEA R0, NL_PTR
    LDR R0, R0, #0
    OUT
    
    RET

CalculateLaunchTime
    LEA R6, MIN_PTR
    LDR R6, R6, #0
    LDR R1, R6, #0      ; Load validated minute from memory
    
    ; Division by 10 for minutes to get tens and ones digits
    AND R2, R2, #0      ; Clear R2 (tens digit)
    AND R3, R3, #0      ; Clear R3 (ones digit) 
    ADD R3, R1, #0      ; Copy minute to R3
    
MinuteDivision
    ADD R3, R3, #-10    ; Subtract 10
    BRn MinutesDivisionEnd
    ADD R2, R2, #1      ; Increment tens digit
    BR MinuteDivision   ; Loop
    
MinutesDivisionEnd
    ADD R3, R3, #10     ; Add back the last 10 for ones digit
    
    AND R6, R6, #0      ; Clear R6 to use condition codes
    ADD R6, R3, #0      ; Set off condition code
    BRp oLoop           ; Start the outer loop if its not zero
    
    ; Given that the right digit is 0, is the Left digit 0 too?
    ADD R6, R2, #0      ; Set condition codes based on R2 = 0
    BRz CalculateExit   ; If R2 == 0, go to EXIT
    
    ; Is the Left digit 3?
    ADD R6, R2, #-3     ; Set condition codes based on R2 - 3
    BRz CalculateExit   ; If R2 == 3, go to EXIT
    
oLoop
    ; Is the right digit 9?
    ADD R6, R3, #-9     
    BRnp iLoop          
    
    ADD R6, R2, #-5     ; Is the left digit 5?
    BRz IncrementHour   
    
    AND R3, R3, #0      ; Right digit = 0
    ADD R2, R2, #1      ; Increment left digit
    
    ; Is the left digit 3?
    ADD R6, R2, #-3     
    BRz CalculateExit   ; stop if yes
    BR oLoop            ; run it again if not
    
iLoop
    ADD R3, R3, #1      ; increment right digit
    BR oLoop

IncrementHour
    AND R2, R2, #0      ; Left digit zero
    AND R3, R3, #0      ; Right digit zero
    
    ; Increment Hour in memory
    LEA R6, HOUR_PTR
    LDR R6, R6, #0
    LDR R1, R6, #0      ; Load validated hour from memory
    ADD R1, R1, #1      ; Increment hour
    
    ; Check for hour overflow (23->0)
    ADD R4, R1, #-12    ; Check if hour = 24
    ADD R4, R1, #-12
    STR R1, R6, #0
    AND R1, R1, #0      ; Otherwise, reset to 0
    
CalculateExit
    ; Calculate the combined new minutes value and store back
    ; R2 = tens digit, R3 = ones digit
    AND R1, R1, #0      ; Clear R1
    ADD R1, R2, #0      ; R1 = tens digit
    
    ; Multiply tens digit by 10
    AND R4, R4, #0      ; Clear R4
    
    ADD R4, R4, R1      ; Multiply by 10
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    ADD R4, R4, R1
    
    ADD R1, R4, R3 
    
    ; Store back to minute memory
    LEA R6, MIN_PTR
    LDR R6, R6, #0
    STR R1, R6, #0
    
    ; Display the updated time
    LEA R0, LAUNCH_PTR
    LDR R0, R0, #0
    PUTS
    JSR DisplayTimeRoutine
    
    RET

; Pointers to data
PROMPT_H_PTR     .FILL PromptHour
ERR_H_PTR        .FILL ErrorMsg
PROMPT_M_PTR     .FILL PromptMin
ERR_M_PTR        .FILL ErrorMin
SUCC_PTR         .FILL Success
HOUR_PTR         .FILL HourTime
MIN_PTR          .FILL MinTime
SUN_PTR          .FILL SunsetMsg
LAUNCH_PTR       .FILL LaunchMsg
COL_PTR          .FILL COLON
NL_PTR           .FILL NEWLINE
DBG_PTR          .FILL DEBUG

; ASCII values
ASCII            .FILL #-48
COLON            .FILL x3A  ; ASCII code for colon (:)
NEWLINE          .FILL x0A  ; ASCII for newline

; Data 
PromptHour      .STRINGZ "Enter the hour of sunset (00-23): \n"
ErrorMsg        .STRINGZ "\nInvalid hour. Please enter a valid hour (00-23).\n"
PromptMin       .STRINGZ "\nEnter the minute of sunset (00-59): \n"
ErrorMin        .STRINGZ "\nInvalid minute. Please enter a valid minute (00-59).\n"
Success         .STRINGZ "\nTime successfully validated and stored!\n"
SunsetMsg       .STRINGZ "\nThe sunset time entered was: \n"
LaunchMsg       .STRINGZ "\nThe calculated time is: \n"
DEBUG           .STRINGZ "\nReturn check\n"
HourTime        .BLKW 1    ; Storage for validated hour
MinTime         .BLKW 1    ; Storage for validated minute

.END