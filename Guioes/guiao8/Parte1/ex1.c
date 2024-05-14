#include <detpic32.h>

int main(void){

    T3CONbits.TCKPS = 7; // 1:256 prescaler (i.e. fout_presc = 125 KHz)
    PR3 = 39063; // Fout = 20MHz / (256 * (39063 + 1)) = 2 Hz
    TMR3 = 0; // Clear timer T3 count register
    T3CONbits.TON = 1; // Enable timer T3 (must be the last command of the
    // timer configuration sequence)


    while(1){
        while(IFS0bits.T3IF = 0); // Reset timer T3 interrupt flag )
        IFS0bits.T2IF = 0; // Reset timer T3 interrupt flag 

        putChar('.');
    }
    return 0;
}