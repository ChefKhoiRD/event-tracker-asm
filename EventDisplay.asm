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
    ; Use indirect jumping to avoid encoding issues
    LD R1, INPUT_ADDR     ; Load the address for TimeInput.asm
    JSRR R1               ; Jump to subroutine at address in R1
    
    ; IMPORTANT: Ensure we continue execution here
    ; Display event end time (hardcoded)
    LEA R0, EVT_END_PTR
    LDR R0, R0, #0
    PUTS
    LEA R0, END_PTR
    LDR R0, R0, #0  
    PUTS
    
    HALT             

; Headers and display text with shortened names
EVT_START          .STRINGZ "\nEvent Start:"
SUNSET_HDR         .STRINGZ "\nSunset Time:"
EVT_END            .STRINGZ "\nEvent End:"
START_TIME         .STRINGZ "\n11:00"
END_TIME           .STRINGZ "\n19:00"

; Pointers to data
START_PTR        .FILL START_TIME
EVT_END_PTR      .FILL EVT_END
END_PTR          .FILL END_TIME
INPUT_ADDR       .FILL x3100    ; Address of GetSunsetTime routine

    .END