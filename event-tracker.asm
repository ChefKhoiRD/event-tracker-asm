.ORIG x3000

Main:
  JSR HoursToDecimal
  JSR MinutesToDecimal

TranslateToDecimal:


HoursToDecimal:
  LD R1, HOURS_INPUT ; Load ASCII hour value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #0 ; Store decimal value of Hour in memory
  RET ; Return 

MinutesToDecimal:
  LD R1, MINUTES_INPUT ; Load ASCII minute value to R1
  JSR TranslateToDecimal ; Call TranslateToDecimal
  STR R0, R6, #1 ; Store decimal value of Minute in memory
  RET ; Return 


; Add Sample Data
HOURS_INPUT: .FILL X0032 ; Hours ASCII value to 2
MINUTES_INPUT: .FILL X0038 ; Minutes ASCII value to 8
ASCII_ZERO: .FILL X0030 ; ASCII value to 0

.END