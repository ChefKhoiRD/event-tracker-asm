.ORIG x3000
    
    ; Display event start time (hardcoded)
    LEA R0, EVT_START     
    PUTS                    
    LEA R0, START_PTR
    LDR R0, R0, #0
    PUTS
    
    ; Get sunset time using validation routines
    LEA R0, SUNSET_HDR
    PUTS
    
    ; Call the time input routine (from TimeInput.asm)
    JSR TimeInputRoutine
    
    ; Display event end time (hardcoded)
    LEA R0, EVT_END_PTR
    LDR R0, R0, #0
    PUTS
    
    LEA R0, END_PTR
    LDR R0, R0, #0  
    PUTS
    
    HALT             

TimeInputRoutine
    ST R7, SAVE_R7     ; Save return address
    
    JSR HoursRoutine
    JSR MinuteRoutine
    JSR DisplayTimeRoutine
    
    LD R7, SAVE_R7     ; Restore return address
    RET
    
SAVE_R7           .BLKW 1    ; Storage for R7

; Copy all routines from the other file below
HoursRoutine
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0

    LD R0, PROMPT_HOUR_PTR
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
    
    ; Store valid hour
    LD R2, HOUR_TIME_PTR
    STR R1, R2, #0
    RET

InvalidHourInput
    LD R0, ERROR_MSG_PTR
    PUTS
    BR GetHourLoop
 
 
; new code bode's event start hour calc
START_SUBTRACT3
    ;Gets the Event start time hour by -3 from inputted hour
    ADD R4, R4, #-3      ; Subtracts 3
    BRzp SKIP_ERROR      ; Skips error handling
    ADD R4, R4, #15      ; Makes sure that there is no negative numbers
    ADD R4, R4, #9
SKIP_ERROR
; new code bode's event start hour calc

MinuteRoutine
    ; Clear registers
    AND R1, R1, #0
    AND R2, R2, #0
    AND R3, R3, #0
    AND R4, R4, #0
    
    LD R0, PROMPT_MINUTE_PTR 
    PUTS                       

GetMinuteLoop
    ; Get first digit
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
    ADD R1, R4, R1          ; R1 = First digit (x10) + Second Digit
    
    ; Validate minute (0-59)
    BRn InvalidMinuteInput  ; If negative
    
    ; Check if minute > 59
    ADD R2, R1, #-16        ; Subtract 16
    ADD R2, R2, #-16        ; Subtract 16
    ADD R2, R2, #-16        ; Subtract 16
    ADD R2, R2, #-11        ; Subtract 11 (total 59)

    BRp InvalidMinuteInput  ; If > 59
    
    ; Store valid minute
    LD R2, MINUTE_TIME_PTR
    STR R1, R2, #0
    RET

InvalidMinuteInput
    LD R0, ERROR_MINUTE_PTR
    PUTS
    BR GetMinuteLoop

DisplayTimeRoutine
    LD R0, SUNSET_MSG_PTR
    PUTS
    
    ; Load Hour from memory
    LD R6, HOUR_TIME_PTR  ; Get address of HourTime
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
    LD R0, COLON
    OUT
    
    ; Load Minutes from memory
    LD R6, MINUTE_TIME_PTR ; Get address of MinuteTime
    LDR R1, R6, #0         ; Load validated minutes from memory
    
    ; Division by 10 for minutes using fixed checks
    AND R2, R2, #0      ; Clear R2
    AND R3, R3, #0      ; Clear R3
    ADD R3, R1, #0      ; Copy minute to R3
    
    ; Check for tens digit - 0 (0-9)
    ADD R3, R3, #-10
    BRn MinuteDigit        ; If < 10, tens digit is 0
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 1 (10-19)
    ADD R3, R3, #-10    
    BRn MinuteDigit        ; If < 20, tens digit is 1
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 2 (20-29)
    ADD R3, R3, #-10
    BRn MinuteDigit        ; If < 30, tens digit is 2
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 3 (30-39)
    ADD R3, R3, #-10
    BRn MinuteDigit        ; If < 40, tens digit is 3
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 4 (40-49)
    ADD R3, R3, #-10
    BRn MinuteDigit        ; If < 50, tens digit is 4
    ADD R2, R2, #1      ; Increment tens digit
    
    ; Check for tens digit - 5 (50-59)
    ADD R3, R3, #-10
    BRn MinuteDigit        ; If < 60, tens digit is 5
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

    RET

; Pointers to data
PROMPT_HOUR_PTR    .FILL PromptHour
ERROR_MSG_PTR      .FILL ErrorMsg
PROMPT_MINUTE_PTR  .FILL PromptMinute
ERROR_MINUTE_PTR   .FILL ErrorMinute
SUNSET_MSG_PTR     .FILL SUNSET_MSG
HOUR_TIME_PTR      .FILL HourTime
MINUTE_TIME_PTR    .FILL MinuteTime
COLON              .FILL x3A  ; ASCII code for colon (:)

; Headers and display text
EVT_START          .STRINGZ "\nEvent Start: "
SUNSET_HDR         .STRINGZ "\nSunset Time: "
EVT_END            .STRINGZ "\nEvent End: "
START_TIME         .STRINGZ "\n11:00"
END_TIME           .STRINGZ "\n19:00"

; Pointers to data
START_PTR        .FILL START_TIME
EVT_END_PTR      .FILL EVT_END
END_PTR          .FILL END_TIME

; Data
PromptHour      .STRINGZ "Enter the hour (00-23): \n"
ErrorMsg        .STRINGZ "\nInvalid hour. Please enter a valid hour (00-23).\n"
PromptMinute    .STRINGZ "\nEnter the minute (00-59): \n"
ErrorMinute     .STRINGZ "\nInvalid minute. Please enter a valid minute (00-59).\n"
SUNSET_MSG      .STRINGZ "\nThe time entered was: \n"
HourTime        .BLKW 1     ; Storage for validated hour
MinuteTime      .BLKW 1     ; Storage for validated minute

.END
