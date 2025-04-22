.ORIG x5000

TimeInputRoutine
    ST R7, SAVE_R7     ; Save return address
    
    LD R6, HOURS_ADDR
    JSRR R6
    
    LD R6, MINUTES_ADDR
    JSRR R6
    
    LD R6, DISPLAY_ADDR
    JSRR R6
    
    LD R7, SAVE_R7     ; Restore return address
    RET

; - Addresses for subroutines -
HOURS_ADDR      .FILL HoursRoutine
MINUTES_ADDR    .FILL MinuteRoutine
DISPLAY_ADDR    .FILL DisplayTimeRoutine

; - Storage Variables -
SAVE_R7         .BLKW 1     ; Storage for R7
HOUR_VAL        .BLKW 1     ; Storage for validated hour
MINUTE_VAL      .BLKW 1     ; Storage for validated minute

; - Constants -
COLON_CHAR      .FILL x3A   ; ASCII code for colon (:)

; - HOURS ROUTINE -
HoursRoutine
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0

    ; Load prompt address and display
    LD R0, PROMPT_HOUR_ADDR
    PUTS

GetHourLoop
    GETC
    OUT
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    
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
    
    ; Store valid hour using absolute addressing
    ST R1, HOUR_VAL       ; Store directly to memory
    RET

InvalidHourInput
    ; Load error message and display
    LD R0, ERROR_HOUR_ADDR
    PUTS
    BR GetHourLoop

; - MINUTES ROUTINE -
MinuteRoutine
    ; Clear registers
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    
    ; Load prompt and display
    LD R0, PROMPT_MIN_ADDR
    PUTS                       

GetMinuteLoop
    ; Get first digit
    GETC
    OUT
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16
    ADD R1, R1, #-16      ; Subtract 16 (-48)
    
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
    
    ; Convert ASCII to decimal
    ADD R1, R0, #-16        ; Subtract 16
    ADD R1, R1, #-16        ; Subtract 16
    ADD R1, R1, #-16        ; Subtract 16
    
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
    RET

InvalidMinuteInput
    ; Load error message and display
    LD R0, ERROR_MIN_ADDR
    PUTS
    BR GetMinuteLoop

DisplayTimeRoutine
    ; Load and display sunset message
    LD R0, SUNSET_MSG_ADDR
    PUTS
    
    ; Load Hour from memory using direct addressing
    LD R1, HOUR_VAL         ; Load validated hour directly from memory
    
    ; Division by 10 for hours
    AND R2, R2, #0          ; Clear R2
    AND R3, R3, #0          ; Clear R3
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
    ADD R3, R3, #10
    
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
    
    ; Load Minutes
    LD R1, MINUTE_VAL
    
    ; Division by 10
    AND R2, R2, #0          ; Clear R2
    AND R3, R3, #0          ; Clear R3
    ADD R3, R1, #0          ; Copy minute to R3
    
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
    
    RET

; - Constants -
PROMPT_HOUR_ADDR  .FILL PromptHour
ERROR_HOUR_ADDR   .FILL ErrorMsg
PROMPT_MIN_ADDR   .FILL PromptMinute
ERROR_MIN_ADDR    .FILL ErrorMinute
SUNSET_MSG_ADDR   .FILL SUNSET_MSG

PromptHour        .STRINGZ "Enter the hour (00-23): \n"
ErrorMsg          .STRINGZ "\nInvalid hour. Please enter a valid hour (00-23).\n"
PromptMinute      .STRINGZ "\nEnter the minute (00-59): \n"
ErrorMinute       .STRINGZ "\nInvalid minute. Please enter a valid minute (00-59).\n"
SUNSET_MSG        .STRINGZ "\nSunset time entered: \n"

.END