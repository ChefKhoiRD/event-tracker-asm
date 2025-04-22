; Calls from other file to get users input and display it in a schedule format

    .ORIG x6000
    
DISPLAY_EVENT

    ST R7, SAVE_R7                  ; Saves information for easier a

    ; Prints saved name data
    LEA R0, NAME                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from name
    LD R0, NAME_PROMPT              ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Prints saved date data
    LEA R0, DATE                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from MM
    LD R6, PRT_SAVED_MONTH
    LDR R0, R6, #0                  ; 1st value of(M)M
    OUT
    LDR R0, R6, #1                  ; 2nd value of M(M)
    OUT
    
    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from DD
    LD R6, PRT_SAVED_DAY
    LDR R0, R6, #0                  ; 1st value of (D)D
    OUT
    LDR R0, R6, #1                  ; 2nd value of D(D)
    OUT

    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from YYYY
    LD R6, PRT_SAVED_YEAR
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

    RET
    
NAME             .STRINGZ "\nName:\n"
DATE             .STRINGZ "\nDate:\n"
LOCATION         .STRINGZ "\nLocation:\n"

ASCII_SLASH      .FILL x2F   ; /

SCHEDULE_ADDR    .FILL x4000
PRT_SAVED_MONTH  .FILL x4000
PRT_SAVED_DAY    .FILL x4000
PRT_SAVED_YEAR   .FILL x4000
NAME_PROMPT      .FILL x4000
LOCATION_PROMPT  .FILL x4000

SAVE_R7         .BLKW 1     ; Storage for R7

    .END