.ORIG x3000

Main:
  AND R6, R6, #0     ; Initialize R6 to 0
  LD R1, MEM_ADDR    ; Load memory address from constant
  ADD R6, R6, R1     ; Set R6 to memory location for data storage
  
  JSR HoursToDecimal
  JSR MinutesToDecimal

  HALT

; Translate ASCII (0-9) values to decimal (-48)
TranslateToDecimal:
  AND R0, R0, #0    ; Clear R0
  ADD R0, R1, #-16  ; Subtract 16 from ASCII value
  ADD R0, R0, #-16  ; Subtract 16 more
  ADD R0, R0, #-16  ; Subtract 16 more (total -48 to convert from ASCII to decimal)
  RET

; Convert ASCII input to decimal and stores in memory (R6, #0)
HoursToDecimal:
  LD R1, HOURS_INPUT     ; Load ASCII hour value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #0         ; Store decimal value of Hour in memory
  RET                    ; Return 

; Convert ASCII input to decimal and stores in memory (R6, #1)
MinutesToDecimal:
  LD R1, MINUTES_INPUT   ; Load ASCII minute value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #1         ; Store decimal value of Minute in memory
  RET                    ; Return 

; Displays sunset time in HH:MM format
SunsetTime:
  
  ; Display prompt message
  LEA R0, SUNSET_MSG
  PUTS
  
  ; Grab Hour from memory
  LDR R1, R6, #0          ; Load validated hour from memory (Grab from Alec)
  
  ; Calculate tens and ones digits for hour
  AND R2, R2, #0          ; Clear R2 for tens digit
  AND R3, R3, #0          ; Clear R3 for ones digit
  ADD R3, R1, #0          ; Copy hour value to R3
  
  ; Convert digits to ASCII and output
  ADD R0, R2, #16         ; Add 16
  ADD R0, R0, #16         ; Add another 16
  ADD R0, R0, #16         ; Add another 16 (total +48)
  OUT                     ; Print tens digit

  ADD R0, R3, #16         ; Add 16
  ADD R0, R0, #16         ; Add another 16
  ADD R0, R0, #16         ; Add another 16 (total +48)
  OUT                     ; Print ones digit
  
  ; Print separator
  LD R0, COLON
  OUT
  
  ; Grab Minutes from memory
  LDR R1, R6, #1          ; Load validated minutes from memory (Grab from Bode)
  
  ; Calculate tens and ones digits for minutes
  AND R2, R2, #0          ; Clear R2 for tens digit
  AND R3, R3, #0          ; Clear R3 for ones digit
  ADD R3, R1, #0          ; Copy minute value to R3
  
  ; Convert digits to ASCII and output
  ADD R0, R2, #16         ; Add 16
  ADD R0, R0, #16         ; Add another 16
  ADD R0, R0, #16         ; Add another 16 (total +48)
  OUT                     ; Print tens digit

  ADD R0, R3, #16         ; Add 16
  ADD R0, R0, #16         ; Add another 16
  ADD R0, R0, #16         ; Add another 16 (total +48)
  OUT                     ; Print ones digit
  
  RET

SUNSET_MSG: .STRINGZ "Sunset time: "
MEM_ADDR:  .FILL x4000  ; Memory address

.END