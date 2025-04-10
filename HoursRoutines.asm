.ORIG x3000      ; Start at memory 3000

; Prompt the user for the hour (0-23)
; Loop over the two ascii characters
; Convert ascii characters to decimal
; Call ValidateHours sub routine
; If ValidateHours returns false, print error
; If returns true, store the hours somewhere in memory

;----------------------------------------------------
; HOURS ROUTINE
;----------------------------------------------------
HoursRoutine
    LEA R0, PromptHour
    PUTS

GetHourLoop
    ; Get first digit
    GETC
    OUT
    LEA R2, InputBuffer
    STR R0, R2, #0  ; Store first ASCII char at inputbuffer[0]

    ; Get second digit
    GETC
    OUT
    STR R0, R2, #1  ; Store first ASCII char at inputbuffer[1]
    ; Call TranslateToDecimal (returns decimal in R0)
    JSR TranslateToDecimal

    ; Move result from R0 to R1 for validation
    ADD R1, R0, #0

    ; Call ValidateHours
    JSR ValidateHours

    ; R0 = 1 if valid, 0 if invalid
    BRz InvalidHourInput

    ; Store valid hour in HourTime
    LEA R2, HourTime
    STR R1, R2, #0

    RET                     ; Done

InvalidHourInput
    LEA R0, ErrorMsg
    PUTS
    BR GetHourLoop

;----------------------------------------------------
; VALIDATE HOURS SUBROUTINE
;----------------------------------------------------
; R1 = value to check
; R0 = 1 if valid (0–23), else 0
ValidateHours
    ; Check if R1 < 0 → Invalid
    ADD R2, R1, #0
    BRn Invalid

    ; Check if R1 > 23 → Invalid
    AND R3, R3, #0      ; Clear R3
    ADD R3, R3, #23
    NOT R3, R3
    ADD R3, R3, #1      ; R3 = -23
    ADD R2, R1, R3      ; R2 = R1 - 23
    BRp Invalid         ; If R1 > 23, invalid

    ; Return 1 if Valid
    AND R0, R0, #0
    ADD R0, R0, #1
    RET

Invalid
    AND R0, R0, #0
    RET ; Return 0 if invalid

;-------------------------
; Memory definitions
;-------------------------
HOURTIME        .BLKW 1          ; Stores final valid hour
INPUTBUFFER     .BLKW 2          ; Stores 2-character ASCII input
PROMPTHOUR      .STRINGZ "Enter hour (0 - 23): "
ERRORMSG        .STRINGZ "Invalid input. Please enter 0 - 23.\n"

.END