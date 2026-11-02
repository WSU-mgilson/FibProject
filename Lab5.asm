.ORIG x3000

;Implementing Recursion 

;Step 3 Load Stack_Pointer into R6
LD R6 Stack_Pointer

;Step 4 Load the address of Globals into R4
LEA R4 Globals

LEA R0, MSG
PUTS
GETC ;Typed input will be in R0
OUT


LD R1 ASCII_TO_DEC
ADD R0 R0 R1
STR R0 R4 #0

;Needed to move this below my STR of R0, thats why I was only seeing my input, because my output got destroyed
LD R0, NEWLINE
OUT

;Im getting even more jank with this, I just read that I need to have it say Fib(n) = something
;prints Fib (
LEA R0 ANSWER
PUTS

;prints n
LDR R0 R4 #0
LD R1 DEC_TO_ASCII
ADD R0 R0 R1
OUT

;prints ) =
AND R0 R0 #0
LEA R0 ANSWER2
PUTS




;Step 5 JSR into MAIN
JSR MAIN

;Step 6 HALT

HALT


;Step 1 create stack pointer
Stack_Pointer .FILL x6000
;Deviated from the lab, I thought it would be easier to just get the user input and store it into the Global var we already created insted of making a display routine
USER_INPUT .FILL #0
MSG .STRINGZ "Enter a fibonacci number 0 - 9:\n"
NEWLINE .FILL x0A ; LC3 says a newline is x0A
ANSWER .STRINGZ "Fib ("
ANSWER2 .STRINGZ ") = "
;Step 2 create Global variables section
Globals
    .FILL #0 ;this is our n or our fib number we want to calculate, I just stored UserInput into global, bc it seemed easier than having to write a new subroutine

ASCII_TO_DEC .FILL #-48



;Remember, R6 = stack pointer, R5 = frame pointer, and R7 is my return address
;==============================MAIN=====================================
MAIN
;Step 7 save Return address
    ADD R6 R6 #-1 ;reserve space on stack(push)
    STR R7 R6 #0

;Step 8 Save previous frame pointer
    ADD R6 R6 #-1
    STR R5 R6 #0

;Step 9 set the current frame pointer
    ADD R5 R6 #0

;Step 10 load into R0 my n number I want to calculate which is in R4, and comes from Globals
    LDR R0 R4 #0

;Step 11 Push Frame onto stack
    ADD R6 R6 #-1
    STR R0 R6 #0

;Step 12 JSR into FIB
    JSR FIB

;DISPLAY
;Tens Loop Division
    ADD R2 R0 #0
    AND R1 R1 #0
DIVIDE_LOOP_START
    ADD R2 R2 #-10
BRn DIVIDE_LOOP_END
    ADD R1 R1 #1
    BRnzp DIVIDE_LOOP_START
DIVIDE_LOOP_END
ADD R2 R2 #10 ; get rid of the deficit from -10
;Outputs tens place
LD R3 DEC_TO_ASCII
ADD R1 R1 #0  ;if zero branch and print ones place
BRz ONES_PLACE
ADD R0 R1 R3
OUT
ONES_PLACE
;Outputs Ones place
ADD R0 R2 #0
ADD R0 R3 R0
OUT

;Step 13 Pop arguments
    ADD R6 R6 #1

;Step 14 Pop prev frame pointer
    LDR R5 R5 #0
    ADD R6 R6 #1

;Step 15 Pop return address
    LDR R7 R6 #0
    ADD R6 R6 #1

RET
DEC_TO_ASCII .FILL #48
;==============================MAIN=====================================




;==============================FIB=====================================
FIB
;Step 16 save Return address
    ADD R6 R6 #-1 ;reserve space on stack(push)
    STR R7 R6 #0

;Step 17 Save previous frame pointer
    ADD R6 R6 #-1
    STR R5 R6 #0

;Step 18 set the current frame pointer
    ADD R5 R6 #0

;Step 19 grab the arg from previous Frame
    LDR R1 R5 #2 ;Grabs n from previous frame

;Step 20 Check if we are at 1
    ADD R2 R1 #-1 ; n-1 is in R2
    BRnz BASE_CASE

;--------------General Case------------
;fib(n-1)
ADD R6 R6 #-1 
STR R2 R6 #0 ;pushes n-1 to the stack

JSR FIB
ADD R6 R6 #1 ;pop
ADD R6 R6 #-1
STR R0 R6 #0
;End of fib(n-1)


;fib(n-2)
LDR R1 R5 #2
ADD R2 R1 #-2
ADD R6 R6 #-1
STR R2 R6 #0
JSR FIB
ADD R6 R6 #1
;End of fib(n-2)


LDR R1 R5 #-1

ADD R0 R1 R0


;Step 13 Pop arguments
    ADD R6 R6 #1


BRnzp FIB_DONE
;--------------General Case END--------




;------------Base Case------------
BASE_CASE
    ADD R0 R1 #0
;-------------BASE_CASE END--------

FIB_DONE

;Step 14 Pop prev frame pointer
    LDR R5 R5 #0
    ADD R6 R6 #1

;Step 15 Pop return address
    LDR R7 R6 #0
    ADD R6 R6 #1



RET
;==============================FIB=====================================



.END
