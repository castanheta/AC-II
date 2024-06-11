#include <detpic32.h>

int main(void){
    TRISBbits.TRISB1 = 1;

    T3CONbits.TCKPS = 3;    // 1:4 prescaler (i.e Fout_presc = 625 KHz)
    PR3 = 38461;            // Fout = 20MHz / ( * (62499 + 1)) =  Hz
    TMR3 = 0;               // Reset timer T2 count register
    T3CONbits.TON = 1;      // Enable timer T2 (must be the last command of the
    
    // timer configuration sequence)
    OC4CONbits.OCM = 6;     // PWM mode on OCx; fault pin disabled
    OC4CONbits.OCTSEL =0;   // Use timer T2 as the time base for PWM generation
    OC4RS = 19231;          // Ton constant
    OC4CONbits.ON = 1;      // Enable OC1 module

    int state = 0;

    while(1){
        if(PORTBbits.RB1 == 0){
            resetCoreTimer();
            while(readCoreTimer() < 20000 * 1300);

            state = !state;

            if(state == 0){
                OC4RS = 28846;
            }else{
                OC4RS = 9615;
            }
        }
    }
    return 0;
}

