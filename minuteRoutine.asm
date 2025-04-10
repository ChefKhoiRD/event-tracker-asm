; Prompts user for the minute
; Checks for user input
; Converts input to decimal
; Calls to the ValidateMinute Routine
; Stores in memory

    .ORIG x3000

MINUTE_ROUTINE
    LEA R0, PROMPT_MINUTE   ; Loads and displays prompt
    PUTS                    ; Prints the prompt

FIRST_DIGIT
    GETC                    ;;
    OUT                     ; Echo input
    LD R5, ASCII            ; Loads ASCII value
    ADD R1, R0, R5          ; Converts ASCII to integer

SECOND_DIGIT
    ; Repeat for second digit
    GETC
    OUT
    LD R5, ASCIIP
    ADD R2, R0, R5

    JSR COMBINE_DIGITS      ; Calls COMBINE_DIGITS subroutine
    ADD R0, R3, #0          ;;
    JSR VALIDATE_MINUTE     ; Calls VALIDATE_MINUTE subroutine

    BRz VALID_MINUTE
    
INVALID_MINUTE
    LEA R0, INVALID_MSG     ; Loads INVALID_MSG error message
    PUTS                    ; Prints INVALID_MSG
    BRnzp MINUTE_ROUTINE

VALID_MINUTE
    LEA R4, SAVED_MINUTE    ; Loads SAVED_MINUTE address
    STR R3, R4, #0          ; Stores the VALID_MINUTE in mem
    HALT

COMBINE_DIGITS
    ; Adds the _DIGIT together to form a double digit number
    AND R3, R3, #0          ; Clear R3
    LD R4, DOUBLE_DIGITS    ; Loads DOUBLE_DIGITS value

LOOP
    ; R3 = R3 * 10 + R1 (FIRST_DIGIT * 10 + SECOND_DIGIT) = (e.g. 2 * 10 + 3 = 23) != (2 + 3 = 5)
    ADD R3, R3, R1          ; Adds first digit to R3
    ADD R4, R4, #-1         ; Decrement R4
    BRp LOOP

    ADD R3, R3, R2          ; Adds second digit to R3
    RET

PROMPT_MINUTE   .STRINGZ "Enter the minute (00-59): "
INVALID_MSG     .STRINGZ "Invalid minute. Please enter a valid minute (00-59)."
ASCII           .FILL #-48
ASCIIP          .FILL #-48
DOUBLE_DIGITS   .FILL #10
SAVED_MINUTE    .BLKW 1

    .END