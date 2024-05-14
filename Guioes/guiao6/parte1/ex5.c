#include <detpic32.h>

int voltageConversion(int value_ad);

int main(void){
    TRISBbits.TRISB4 = 1; // RBx digital output disconnected
    AD1PCFGbits.PCFG4 = 0; // RBx configured as analog input
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
    // mode an internal counter ends sampling and
    // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 4-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence
    volatile int i;
    volatile int avg;
    volatile int amp;
    
    while(1){
        // Start conversion
        AD1CON1bits.ASAM = 1;
        // Wait while conversion not done (AD1IF == 0)
        while( IFS1bits.AD1IF == 0 ); 
        // Read conversion result (ADC1BUF0 value) and print it
        int *p = (int *)(&ADC1BUF0);
        avg = 0;
        for( i = 0; i < 4; i++ ) {
           
            avg += p[i*4];
        }
        amp = voltageConversion(avg/4);
        printInt(amp,10 | 4 << 16);
        
        putChar('\r');
        // Reset AD1IF
        IFS1bits.AD1IF = 0;
    }
    return 0;
}

int voltageConversion(int value_ad){
    return (value_ad *33 + 511) / 1023;
}