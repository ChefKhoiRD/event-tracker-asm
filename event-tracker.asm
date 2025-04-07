.ORIG x3000

Main:
  AND R6, R6, #0     ; Initialize R6 to 0
  ADD R6, R6, x4000
  
  JSR HoursToDecimal
  JSR MinutesToDecimal
  
  HALT

; Translate ASCII values to decimal
TranslateToDecimal:
  AND R0, R0, #0    ; Clear R0
  ADD R0, R1, #-16  ; Subtract 16 from ASCII value
  ADD R0, R0, #-16  ; Subtract 16 more
  ADD R0, R0, #-16  ; Subtract 16 more (total -48 to convert from ASCII to decimal)
  RET

; Store Hours as decimal for ValidateHours Routine
HoursToDecimal:
  LD R1, HOURS_INPUT    ; Load ASCII hour value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #0        ; Store decimal value of Hour in memory
  RET                   ; Return 

; Store Minutes as decimal for ValidateMinutes Routine
MinutesToDecimal:
  LD R1, MINUTES_INPUT   ; Load ASCII minute value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #1         ; Store decimal value of Minute in memory
  RET                    ; Return 

; Add Sample Data
HOURS_INPUT: .FILL X0032    ; Hours ASCII value to 2
MINUTES_INPUT: .FILL X0038  ; Minutes ASCII value to 8

.END