.ORIG x5000

; Clear registers
AND R1, R1, #0
AND R2, R2, #0
AND R3, R3, #0
AND R4, R4, #0

; - Hours Input -
LEA R0, PromptHour
PUTS

GetHourLoop
    GETC
    OUT
    
    ; Convert ASCII to decimal
    LD R5, ASCII_CONVERT    ; Load -48 for conversion
    ADD R1, R0, R5          ; Convert ASCII to decimal
    
    ; Check if valid digit (0-9)
    BRn InvalidHourInput    ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidHourInput    ; If > 9
    
    ; Multiply by 10
    AND R4, R4, #0          ; Clear R4
    ADD R3, R1, #0          ; Copy digit to R3
    
    ADD R4, R4, R3          ; Multiply by 10 (add 10 times)
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
    LD R5, ASCII_CONVERT    ; Load -48 for conversion
    ADD R1, R0, R5          ; Convert ASCII to decimal
    
    ; Check if valid digit (0-9)
    BRn InvalidHourInput    ; If negative, not a digit
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidHourInput    ; If > 9, not a digit
    
    ; Combine digits
    ADD R1, R4, R1          ; R1 = First digit (x10) + Second Digit
    
    ; Validate hour (0-23)
    BRn InvalidHourInput    ; If negative, invalid
    
    ; Check if hour > 23
    ADD R2, R1, #-16        ; Subtract 16
    ADD R2, R2, #-7         ; Subtract 7 (total 23)
    BRp InvalidHourInput    ; If > 23, invalid
    
    ; Store valid hour
    ST R1, HOUR_VAL         ; Store directly to memory
    BR MinuteInput          ; Branch to next section

InvalidHourInput
    ; Load error message and display
    LEA R0, ErrorMsg
    PUTS
    BR GetHourLoop

; - Mintues Input -
MinuteInput
    ; Clear registers
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    
    ; Load prompt and display
    LEA R0, PromptMinute
    PUTS                       

GetMinuteLoop
    ; Get first digit
    GETC
    OUT
    
    ; Convert ASCII to decimal
    LD R5, ASCII_CONVERT    ; Load -48 for conversion
    ADD R1, R0, R5          ; Convert ASCII to decimal
    
    ; Check if valid digit (0-9)
    BRn InvalidMinuteInput  ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidMinuteInput  ; If > 9
    
    ; Multiply by 10
    AND R4, R4, #0          ; Clear R4
    ADD R3, R1, #0          ; Copy digit to R3
    
    ADD R4, R4, R3          ; Multiply by 10 (add 10 times)
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
    LD R5, ASCII_CONVERT    ; Load -48 for conversion
    ADD R1, R0, R5          ; Convert ASCII to decimal
    
    ; Check if valid digit (0-9)
    BRn InvalidMinuteInput  ; If negative
    ADD R3, R1, #-9
    ADD R3, R3, #-1
    BRp InvalidMinuteInput  ; If > 9
    
    ; Combine digits
    ADD R1, R4, R1
    
    ; Validate minute (0-59)
    BRn InvalidMinuteInput  ; If negative
    
    ; Check if minute > 59
    ADD R2, R1, #-16        ; Subtract 16
    ADD R2, R2, #-16        ; Subtract 16
    ADD R2, R2, #-16        ; Subtract 16
    ADD R2, R2, #-11        ; Subtract 11 (total 59)

    BRp InvalidMinuteInput  ; If > 59
    
    ST R1, MINUTE_VAL       ; Store directly to memory
    BR DisplayTime          ; Branch to display section

InvalidMinuteInput
    ; Load error message and display
    LEA R0, ErrorMinute
    PUTS
    BR GetMinuteLoop

; - Display Time Section -
DisplayTime
    ; Load and display sunset message
    LEA R0, SUNSET_MSG
    PUTS
    
    ; Load Hour from memory using direct addressing
    LD R1, HOUR_VAL         ; Load validated hour directly from memory
    
    ; Division by 10 for hours
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy hour to R3
    
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
    LD R0, ASCII_DISPLAY    ; Load ASCII conversion constant
    ADD R0, R0, R2          ; Add tens digit to convert to ASCII
    OUT                     ; Print tens digit (Hour)
    
    ; Convert ones digit to ASCII
    LD R0, ASCII_DISPLAY    ; Load ASCII conversion constant
    ADD R0, R0, R3          ; Add ones digit to convert to ASCII
    OUT                     ; Print ones digit (Hour)
    
    ; Print colon
    LD R0, COLON_CHAR
    OUT
    
    ; Load Minutes
    LD R1, MINUTE_VAL
    
    ; Division by 10
    AND R2, R2, #0          ; Clear R2 for tens digit
    AND R3, R3, #0          ; Clear R3 for ones digit
    ADD R3, R1, #0          ; Copy minute to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 10, tens digit is 0
    ADD R2, R2, #1          
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn MinuteDigit         ; If < 20, tens digit is 1
    ADD R2, R2, #1          
    
    ; Check for tens digit - 2 (20-29)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 30, tens digit is 2
    ADD R2, R2, #1          
    
    ; Check for tens digit - 3 (30-39)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 40, tens digit is 3
    ADD R2, R2, #1          
    
    ; Check for tens digit - 4 (40-49)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 50, tens digit is 4
    ADD R2, R2, #1          
    
    ; Check for tens digit - 5 (50-59)
    ADD R3, R3, #-10
    BRn MinuteDigit         ; If < 60, tens digit is 5
    ADD R2, R2, #1          
    
MinuteDigit
    ADD R3, R3, #10         ; Add back the last 10
    
    ; Convert tens digit to ASCII
    LD R0, ASCII_DISPLAY    ; Load ASCII conversion constant
    ADD R0, R0, R2          ; Add tens digit to convert to ASCII
    OUT                     ; Print tens digit (Minute)
    
    ; Convert ones digit to ASCII
    LD R0, ASCII_DISPLAY    ; Load ASCII conversion constant
    ADD R0, R0, R3          ; Add ones digit to convert to ASCII
    OUT                     ; Print ones digit (Minute)
    
    ; Return to main program
    RET

; - Constants -
COLON_CHAR      .FILL x3A   ; ASCII code for colon (:)
ASCII_DISPLAY   .FILL x30   ; ASCII code for '0' (48)
ASCII_CONVERT   .FILL #-48  ; For converting ASCII to decimal

; - Storage Variables -
HOUR_VAL        .BLKW 1     ; Storage for validated hour
MINUTE_VAL      .BLKW 1     ; Storage for validated minute

; - String Messages -
PromptHour      .STRINGZ "Enter the hour (00-23): \n"
ErrorMsg        .STRINGZ "\nInvalid hour. Please enter a valid hour (00-23).\n"
PromptMinute    .STRINGZ "\nEnter the minute (00-59): \n"
ErrorMinute     .STRINGZ "\nInvalid minute. Please enter a valid minute (00-59).\n"
SUNSET_MSG      .STRINGZ "\nSunset time entered: \n"

.END
