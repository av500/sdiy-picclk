#include <p16f628a.inc>

__CONFIG _CP_OFF & _CPD_OFF & _LVP_OFF & _BOREN_ON & _MCLRE_OFF &  _WDTE_OFF & _PWRTE_ON & _FOSC_INTOSCIO

#define CLK	PORTB,RB0
#define RST	PORTB,RB1

#define Q0	PORTA,RA0
#define Q1	PORTA,RA1
#define Q2	PORTA,RA2
#define Q3	PORTA,RA3
#define Q4	PORTB,RB4
#define Q5	PORTB,RB5
#define Q6	PORTA,RA6
#define Q7	PORTA,RA7

#define CARRY	PORTB,RB3

RES_VECT  CODE    0x0000            ; processor reset vector
    GOTO    START                   ; go to beginning of program

MAIN_PROG CODE                      ; let linker place main program

START
    
    banksel PORTA
    CLRF	PORTA		; initialize PORTA by setting output data latches
    MOVLW	0X07 		; turn comparators off and
    MOVWF	CMCON 		; enable pins for I/O functions
    CLRF	PORTB 		; initialize PORTB by setting output data latches

    banksel PIE1		; change to bank 1
    CLRF	PIE1		; disable peripheral interrupts

    banksel TRISB
    MOVLW 	0xC7 		;RB3, RB4,RB5 set to output
    MOVWF 	TRISB
    MOVLW 	0x30 		;RA0-7 but not RA4,RA5 set to output
    MOVWF 	TRISA
    
    banksel PORTA
    
LOOP00:
    btfss CLK
    goto LOOP00
RST_WAIT:			; special case: RESET HIGH, STOP at Q0
    CLRF PORTA
    CLRF PORTB
    BSF	Q0
    BSF	CARRY
    btfsc RST
    goto RST_WAIT
LOOP01:
    btfsc CLK
    goto LOOP01
    BCF	Q0
    btfsc RST
    goto RST_WAIT
    
LOOP10:
    btfss CLK
    goto LOOP10
    BSF	Q1
    btfsc RST
    goto RST_WAIT
LOOP11:
    btfsc CLK
    goto LOOP11
    BCF	Q1
    btfsc RST
    goto RST_WAIT
        
LOOP20:
    btfss CLK
    goto LOOP20
    BSF	Q2
    btfsc RST
    goto RST_WAIT
LOOP21:
    btfsc CLK
    goto LOOP21
    BCF	Q2
    btfsc RST
    goto RST_WAIT
    
LOOP30:
    btfss CLK
    goto LOOP30
    BSF	Q3
    btfsc RST
    goto RST_WAIT
LOOP31:
    btfsc CLK
    goto LOOP31
    BCF	Q3  
    btfsc RST
    goto RST_WAIT
    
LOOP40:
    btfss CLK
    goto LOOP40
    BSF	Q4
    btfsc RST
    goto RST_WAIT
    BCF CARRY
LOOP41:
    btfsc CLK
    goto LOOP41
    BCF	Q4
    btfsc RST
    goto RST_WAIT 
    
LOOP50:
    btfss CLK
    goto LOOP50
    BSF	Q5
    btfsc RST
    goto RST_WAIT
LOOP51:
    btfsc CLK
    goto LOOP51
    BCF	Q5
    btfsc RST
    goto RST_WAIT
    
LOOP60:
    btfss CLK
    goto LOOP60
    BSF	Q6
    btfsc RST
    goto RST_WAIT
LOOP61:
    btfsc CLK
    goto LOOP61
    BCF	Q6
    btfsc RST
    goto RST_WAIT 
    
LOOP70:
    btfss CLK
    goto LOOP70
    BSF	Q7
    btfsc RST
    goto RST_WAIT
LOOP71:
    btfsc CLK
    goto LOOP71
    BCF	Q7
    btfsc RST
    goto RST_WAIT
    
    GOTO LOOP00		; back to the start

    END