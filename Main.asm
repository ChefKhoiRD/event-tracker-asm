.ORIG x3000

    LEA R0, SUNSET_HDR
    PUTS
    
    ; User Input Time Routine (TimeInput.asm)
    LD R0, TIME_INPUT_ADDR  ; Load address of TimeInputRoutine
    JSRR R0                 ; Jump to subroutine at address in R0
    
    ; Calculate User Inputted Time Routine (TimeCalculation.asm)
    LD R0, TIME_CALC_ADDR   ; Load address of CalculateEventTime
    JSRR R0                 ; Jump to subroutine at address in R0
    
    HALT             

; Address of external routines
TIME_INPUT_ADDR    .FILL x4000  ; TimeInput.asm
TIME_CALC_ADDR     .FILL x5000  ; TimeCalculation.asm

; Headers and display text
SUNSET_HDR         .STRINGZ "\nSunset Time: "

.END