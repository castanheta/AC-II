#include <detpic32.h>

int main(void){
    // Configure Timers T1 and T3 with interrupts enabled)
    T3CONbits.TCKPS = 4; // 1:16 prescaler (i.e. fout_presc = 125 KHz)
    PR3 = 50000; // Fout = 20MHz / (16 * (50000 + 1)) = 25 Hz
    TMR3 = 0; // Clear timer T3 count register
    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence)


    T1CONbits.TCKPS = 2; // 1:16 prescaler (i.e. fout_presc = 125 KHz)
    PR1 = 61539; // Fout = 20MHz / (64 * (61539 + 1)) = 5 Hz
    TMR1 = 0; // Clear timer T3 count register
    T1CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence)

    IPC3bits.T3IP = 2; // Interrupt priority (must be in range [1..6])
    IEC0bits.T3IE = 1; // Enable timer T2 interrupts
    IFS0bits.T3IF = 0; // Reset timer T2 interrupt fla

    IPC1bits.T1IP = 1; // Interrupt priority (must be in range [1..6])
    IEC0bits.T1IE = 1; // Enable timer T2 interrupts
    IFS0bits.T1IF = 0; // Reset timer T2 interrupt flag

    TRISEbits.TRISE0 = 0;
    TRISEbits.TRISE2 = 0;

    LATEbits.LATE0 = 0;
    LATEbits.LATE2 = 0;

    // Reset T1IF and T3IF flags
    EnableInterrupts(); // Global Interrupt Enable
    while(1);
    return 0;
}

void _int_(12) isr_T3(void) // Replace VECTOR by the timer T3
 // vector number
 {
LATEbits.LATE2 = !LATEbits.LATE2;
 IFS0bits.T3IF = 0;
 // Reset T3 interrupt flag
} 

void _int_(4) isr_T1(void) // Replace VECTOR by the timer T3
 // vector number
 {
    LATEbits.LATE0 = !LATEbits.LATE0;
    IFS0bits.T1IF = 0;
 // Reset T3 interrupt flag
} 