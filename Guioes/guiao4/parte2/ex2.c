#include <detpic32.h>

void delay(int ms);

int main(void){
    unsigned char segment;
    // enable display low (RD5) and disable display high (RD6)
    LATDbits.LATD5 = 1;
    LATDbits.LATD6 = 0;
    // configure RB8-RB14 as outputs
    TRISB = TRISB && 0x80FF
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;               //RD5 e RD6 como saídas

    while(1){
        segment = 1;
        for(int i=0; i < 7; i++){
            // send "segment" value to display
            
            // wait 0.5 second
            delay(500);
            segment = segment << 1;
        }
    // toggle display selection
    LATDbits.LATD5 = !LATDbits.LATD5;
    LATDbits.LATD6 = !LATDbits.LATD6;
    }
    return 0;
}





void delay(unsigned int ms)
{
 resetCoreTimer();
 while(readCoreTimer() < 20000 * ms);
} 
