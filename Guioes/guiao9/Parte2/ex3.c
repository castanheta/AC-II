#include <detpic32.h>

int main(void){
    setPWM(10);
}

void setPWM(unsigned int dutyCycle){
 // duty_cycle must be in the range [0, 100]
    OC1CONbits.OCM = 6;         // PWM mode on OCx; fault pin disabled
    OC1CONbits.OCTSEL = 1;       // Use timer T2 as the time base for PWM generation
    OC1CONbits.ON = 1;          // Enable OC1 module

    T_on = (dutyCycle x 0,01);
    T_out = 1 / 625000;

    OC1RS = T_on/T_out; // Determine OC1RS as a function of "dutyCycle"
} 