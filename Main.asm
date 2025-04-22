; This file assembles everything together

.ORIG x3000

    ; User Input Event Details (EventDetail.asm)
    LD R0, EVENT_DETAIL_ADDR ; Loads address of EventDetail
    JSRR R0                  ; Jump to subroutine at address in R0

    ; User Input Time Routine (TimeInput.asm)
    LD R0, TIME_INPUT_ADDR   ; Load address of TimeInputRoutine
    JSRR R0                  ; Jump to subroutine at address in R0
    
    ; Displays User Inputted Event Details (DisplayEvent.asm)
    LD R0, DISPLAY_ADDR      ; Loads address of DisplayEvent
    JSRR R0                  ; Jump to subroutine at address in R0
    
    ; Calculate User Inputted Time Routine (TimeCalculation.asm)
    LD R0, TIME_CALC_ADDR    ; Load address of CalculateEventTime
    JSRR R0                  ; Jump to subroutine at address in R0
    
    HALT             

; Address of external routines
EVENT_DETAIL_ADDR  .FILL x4000  ; EventDetail.asm
TIME_INPUT_ADDR    .FILL x5000  ; TimeInput.asm
DISPLAY_ADDR       .FILL x6000  ; DisplayEvent.asm
TIME_CALC_ADDR     .FILL x7000  ; TimeCalculation.asm

.END