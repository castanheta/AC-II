#include <detpic32.h>

void config();
void delay(unsigned int ms);
int voltageConversion(int VAL_AD);

int main(void){
    TRISEbits.TRISE1 = 0;
    LATEbits.LATE1 = 0;
    config();

    int voltage = 0, i, sum, j = 0;

    while (1)
    {   
        
        sum = 0;
        AD1CON1bits.ASAM = 1;               // Start conversion
        while ( IFS1bits.AD1IF == 0 );      // Wait while conversion not done
            
        int *p = (int *)(&ADC1BUF0);

        for (i = 0; i < 4; i++)             // Get the values for the 4 samples
        {
            sum += p[i*4];                  // Sum the values of the 4 buffers
        }

        voltage = voltageConversion(sum) / 2;   //Average the voltage value to decima

        printInt(voltage, 0x0003000A);
        putChar('\n');
        delay(166);

        LATEbits.LATE1 = !LATEbits.LATE1;
        
        IFS1bits.AD1IF = 0;                     // Reset AD1IF
    }
    
    return 0;
}

void config(){
    TRISBbits.TRISB4 = 1; // RBx digital output disconnected
    AD1PCFGbits.PCFG4= 0; // RBx configured as analog input
    AD1CON1bits.SSRC = 7; // Conversion trigger selection bits: in this
    // mode an internal counter ends sampling and
    // starts conversion
    AD1CON1bits.CLRASAM = 1; // Stop conversions when the 1st A/D converter
    // interrupt is generated. At the same time,
    // hardware clears the ASAM bit
    AD1CON3bits.SAMC = 16; // Sample time is 16 TAD (TAD = 100 ns)
    AD1CON2bits.SMPI = 2-1; // Interrupt is generated after N samples
    // (replace N by the desired number of
    // consecutive samples)
    AD1CHSbits.CH0SA = 4; // replace x by the desired input
    // analog channel (0 to 15)
    AD1CON1bits.ON = 1; // Enable A/D converter
    // This must the last command of the A/D
    // configuration sequence 
}

void delay(unsigned int ms){
    resetCoreTimer();
    while(readCoreTimer() < ms * 20000);
}

int voltageConversion(int VAL_AD)
{
    return (VAL_AD * 33 + 511) / 1023;
}