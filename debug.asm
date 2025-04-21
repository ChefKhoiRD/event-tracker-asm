; TimeInput.asm - Improved diagnostic version

    .ORIG x3100

; Main entry point
GetSunsetTime
    ; Print entry message
    LEA R0, ENTRY_MSG
    PUTS
    
    ; Save return address - CRITICAL PART
    ADD R5, R7, #0      
    
    ; Just prompt for a simple sunset time input
    LEA R0, PROMPT
    PUTS
    GETC    ; Just get one character for simplicity
    OUT
    
    ; Print exit message
    LEA R0, EXIT_MSG
    PUTS
    
    ; Restore return address - CRITICAL PART
    ADD R7, R5, #0
    
    ; RETURN to EventDisplay.asm
    RET

; Data
ENTRY_MSG    .STRINGZ "\nEntered TimeInput at x3100"
PROMPT       .STRINGZ "\nEnter one character for sunset time: "
EXIT_MSG     .STRINGZ "\nReturning to EventDisplay now\n"

    .END