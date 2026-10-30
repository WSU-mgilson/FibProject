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



;Step 5 JSR into MAIN
JSR MAIN

;Step 6 HALT

HALT


;Step 1 create stack pointer
Stack_Pointer .FILL x6000
USER_INPUT .FILL #0
MSG .STRINGZ "Enter a fibonacci number 0 - 9:\n"
;Step 2 create Global variables section
Globals
    .FILL #0 ;this is our n or our fib number we want to calculate

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
    LD R1 DEC_TO_ASCII
    ADD R0 R1 R0
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
