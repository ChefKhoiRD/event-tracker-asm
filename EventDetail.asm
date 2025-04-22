; Gets the user input for the Event Details
; Gets Event name, date, and location

    .ORIG x4000
    
PROMPT_SCHEDULE_ROUTINE
    ; Prompts & gets the day
    
    ST R7, SAVE_R7      ; Save return address
    
    LEA R0, PROMPT_MONTH            ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Gets first digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R1, R0, R5                  ; Converts to decimal
    
    ; Gets second digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R2, R0, R5
    
    ; Saves day (to reuse R1-R2)
    LEA R6, SAVED_MONTH             ; Saved the MM
    STR R1, R6, #0                  ; Stores input and clears Register
    STR R2, R6, #1
    
    ; Prompts & gets the month
    LEA R0, PROMPT_DAY            ; Loads prompt
    PUTS                          ; Displays prompt
    
    ; Gets first digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R1, R0, R5
    
    ; Gets second digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R2, R0, R5
    
    ; Saves Month (to reuse R1-R2)
    LEA R6, SAVED_DAY               ; Saves the DD
    STR R1, R6, #0                  ; Stores input and clears Register
    STR R2, R6, #1
    
    ; Prompts & gets the year
    LEA R0, PROMPT_YEAR             ; Loads prompt
    PUTS                            ; Displays prompt
    
    ; Gets first digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R1, R0, R5
    
    ; Gets second digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R2, R0, R5
    
    ; Gets 3rd digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R3, R0, R5
    
    ; Gets 4th digit
    GETC
    OUT                             ; Echos
    LD R5, ASCII                    ; Converts to ASCII
    ADD R4, R0, R5
    
    ; Saves Year (to reuse R1-R4)
    LEA R6, SAVED_YEAR              ; Saves the YYYY
    STR R1, R6, #0                  ; Stores input and clears Register
    STR R2, R6, #1
    STR R3, R6, #2
    STR R4, R6, #3
    
    ; Prompts & gets Name
    LEA R0, PROMPT_NAME             ; Loads prompt
    PUTS                            ; Displays prompt
    
    LEA R2, NAME_PROMPT             ; R2 stores the string
    
NAME_STRING_LOOP
    GETC                            ; Gewts char
    OUT                             ; Echos
    
    ADD R3, R0, #-10                ; Checks for 'Enter' key
    BRz INPUTDONE_NAME              ; Calls to othere aubroutine
    
    STR R0, R2, #0                  ; stores char
    ADD R2, R2, #1
    BRnzp NAME_STRING_LOOP
    
INPUTDONE_NAME
    AND R1, R1, #0                  ; clear R1
    STR R0, R2, #0
    
    LEA R0, PROMPT_LOCATION         ; prompts user for location
    PUTS
    
    LEA R2, LOCATION_PROMPT

; Same thing as name loop
LOCATION_STRING_LOOP
    GETC
    OUT                             ; Echos
    
    ADD R3, R0, #-10                ; Checks for 'Enter' key
    BRz INPUTDONE_LOCATION
    
    STR R0, R2, #0
    ADD R2, R2, #1
    BRnzp LOCATION_STRING_LOOP
    
INPUTDONE_LOCATION
    AND R1, R1, #0
    STR R0, R2, #0
    
    LD R7, SAVE_R7      ; Restores address
    
    RET
    
PROMPT_MONTH     .STRINGZ "Enter a month (MM), for the date: "
PROMPT_DAY       .STRINGZ "\nEnter a day (DD), for the date: "
PROMPT_YEAR      .STRINGZ "\nEnter a year (YYYY), for the date: "
PROMPT_NAME      .STRINGZ "\nEnter the name of the event: "
PROMPT_LOCATION  .STRINGZ "Enter the location of the event: "

ASCII            .FILL #-48

SAVE_R7          .BLKW 1
SAVED_MONTH      .BLKW 2     ; 2 char input
SAVED_DAY        .BLKW 2
SAVED_YEAR       .BLKW 4     ; 4 char input
NAME_PROMPT      .BLKW 20    ; 20 char input
LOCATION_PROMPT  .BLKW 20

    .END