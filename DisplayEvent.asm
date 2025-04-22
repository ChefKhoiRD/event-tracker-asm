.ORIG x6000
    
DISPLAY_EVENT
    ST R7, SAVE_R7                  ; Saves return address

    ; Prints saved name data
    LEA R0, NAME                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from name
    LEA R0, NAME_PROMPT_ADDR        ; Get address of name storage
    LDR R0, R0, #0                  ; Load the address value
    PUTS                            ; Display the name string
    
    ; Prints saved date data
    LEA R0, DATE                    ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Loads input from MM
    LEA R6, SAVED_MONTH_ADDR        ; Get address of month storage
    LDR R6, R6, #0                  ; Load the address value
    
    LDR R0, R6, #0                  ; 1st value of(M)M
    LD R1, ASCII_DISPLAY            ; Convert to ASCII
    ADD R0, R0, R1
    OUT
    
    LDR R0, R6, #1                  ; 2nd value of M(M)
    ADD R0, R0, R1
    OUT
    
    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from DD
    LEA R6, SAVED_DAY_ADDR
    LDR R6, R6, #0                  ; Load the address value
    
    LDR R0, R6, #0                  ; 1st value of (D)D
    LD R1, ASCII_DISPLAY
    ADD R0, R0, R1
    OUT
    
    LDR R0, R6, #1                  ; 2nd value of D(D)
    ADD R0, R0, R1
    OUT

    LD R0, ASCII_SLASH              ; ASCII value for /
    OUT

    ; Loads input from YYYY
    LEA R6, SAVED_YEAR_ADDR
    LDR R6, R6, #0                  ; Load the address value
    
    LDR R0, R6, #0                  ; 1st value of (Y)YYY
    LD R1, ASCII_DISPLAY
    ADD R0, R0, R1
    OUT
    
    LDR R0, R6, #1                  ; 2nd value of Y(Y)YY
    ADD R0, R0, R1
    OUT
    
    LDR R0, R6, #2                  ; 3rd value of YY(Y)Y
    ADD R0, R0, R1
    OUT
    
    LDR R0, R6, #3                  ; 4th value of YYY(Y)
    ADD R0, R0, R1
    OUT
    
    ; Prints saved location data
    LEA R0, LOCATION                ; Loads prompt
    PUTS                            ; Displays prompt

    ; Loads input from location
    LEA R0, LOCATION_PROMPT_ADDR    ; Get address of location storage
    LDR R0, R0, #0                  
    PUTS                            

    LD R7, SAVE_R7                  ; Restore return address
    RET
    
NAME             .STRINGZ "\nName: "
DATE             .STRINGZ "\nDate: "
LOCATION         .STRINGZ "\nLocation: "

ASCII_SLASH      .FILL x2F          ; ASCII for /
ASCII_DISPLAY    .FILL x30          ; ASCII for conversion (48)

EVENT_DETAIL_ADDR    .FILL x4000     ; Base address of EventDetails.asm
SAVED_MONTH_ADDR     .FILL x40F9     ; Address of SAVED_MONTH in memory
SAVED_DAY_ADDR       .FILL x40FB     ; Address of SAVED_DAY in memory
SAVED_YEAR_ADDR      .FILL x40FD     ; Address of SAVED_YEAR in memory
NAME_PROMPT_ADDR     .FILL x4101     ; Address of NAME_PROMPT in memory
LOCATION_PROMPT_ADDR .FILL x4115    ; Address of LOCATION_PROMPT in memory

SAVE_R7             .BLKW 1

.END