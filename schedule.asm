; Schedule.asm
; Calls from outputSchedule.asm for the promtps of the event
; Calls from Merge-v1.asm for the input of the time

    .ORIG X3000
    
    JSR PROMPT_SCHEDULE_ROUTINE     ; Calls from outputSchedule.asm
    
    JSR MAIN                        ; Calls from merge-v1.asm
    
    ; Prints saved name data
    LEA R0, NAME                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from name
    LEA R0, NAME_PROMPT             ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Prints saved date data
    LEA R0, DATE                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from MM
    LEA R6, SAVED_MONTH
    LDR R0, R6, #0                  ; 1st value of(M)M
    OUT
    LDR R0, R6, #1                  ; 2nd value of M(M)
    OUT
    
    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from DD
    LEA R6, SAVED_DAY
    LDR R0, R6, #0                  ; 1st value of (D)D
    OUT
    LDR R0, R6, #1                  ; 2nd value of D(D)
    OUT

    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from YYYY
    LEA R6, SAVED_YEAR
    LDR R0, R6, #0                  ; 1st value of (Y)YYY
    OUT
    LDR R0, R6, #1                  ; 2nd value of Y(Y)YY
    OUT
    LDR R0, R6, #2                  ; 3rd value of YY(Y)Y
    OUT
    LDR R0, R6, #3                  ; 4th value of YYY(Y)
    OUT
    
    ; Prints saved location data
    LEA R0, LOCATION                ; Loads prompt
    PUTS                            ; Displays prompt

    ; Loads input from location
    LEA R0, LOCATION_PROMPT         ; Loads prompt
    PUTS                            ; Displays prompt

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This will be where the inserted time of merge-v1.asm goes  ;
; Where it prompts for the input of the hour and minute      ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Print opening ceremony
    LEA R0, OPENING                 ; Loads prompt
    PUTS                            ; Displays prompt

    ; Load and print hour calling from merge-v1
    LEA R6, SAVED_HOUR
    LDR R0, R6, #0         ; Hour tens
    OUT
    LDR R0, R6, #1         ; Hour ones
    OUT

    LD R0, ASCII_COLON     ; Print ':'
    OUT

    ; Load and print minute
    LEA R6, SAVED_MINUTE
    LDR R0, R6, #0         ; Minute tens
    OUT
    LDR R0, R6, #1         ; Minute ones
    OUT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This will be where Alec's code goes for the time calculations ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Print saved sunset time
    LEA R0, SUNSET
    PUTS

    ; Loads saved data from Sunset Hour
    LEA R6, SUNSET_HOUR
    LDR R0, R6, #0         ; Hour tens
    OUT
    LDR R0, R6, #1         ; Hour ones
    OUT

    LD R0, ASCII_COLON
    OUT

    ; Load saved data from Sunset Minute
    LEA R6, SUNSET_MINUTE
    LDR R0, R6, #0         ; Minute tens
    OUT
    LDR R0, R6, #1         ; Minute ones
    OUT

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; This will be where Alec's code goes for the time calculations ;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

    ; Print Closing Ceremony
    LEA R0, CLOSING
    PUTS

    ; Loads saved data from Closing Hour
    LEA R6, CLOSING_HOUR
    LDR R0, R6, #0         ; Hour tens
    OUT
    LDR R0, R6, #1         ; Hour ones
    OUT

    LD R0, ASCII_COLON
    OUT

    ; Loads saved data from Closing Minute
    LEA R6, CLOSING_MINUTE
    LDR R0, R6, #0         ; Minute tens
    OUT
    LDR R0, R6, #1         ; Minute ones
    OUT

    HALT
    
NAME             .STRINGZ "\nName:\n"
DATE             .STRINGZ "\nDate:\n"
LOCATION         .STRINGZ "\nLocation:\n"
OPENING          .STRINGZ "\nOpening Ceremony:\n"
SUNSET           .STRINGZ "\nSunset Time:\n"
CLOSING          .STRINGZ "\nClosing Ceremony:\n"

ASCII_SLASH      .FILL x2F   ; /
ASCII_COLON     .FILL x3A     ; ASCII value for ':'

;SUNSET_HOUR     .BLKW 2     ; Alec will store 2-char hour here
;SUNSET_MINUTE   .BLKW 2     ; Alec will store 2-char minute here

;CLOSING_HOUR    .BLKW 2     ; Alec will store 2-char hour here
;CLOSING_MINUTE  .BLKW 2     ; Alec will store 2-char minute here
    
    .END