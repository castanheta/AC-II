#include <detpic32.h>

void delay(unsgined int ms);

int main (void){
    TRISE = TRISE & 0xFF03;
    TRISBbits.TRISB0 = 1;
    TRISBbits.TRISB2 = 1;

    int counter = 0x0030;
    int counter2;

    while(1){
        LATE = LATE & 0xFF03;
        counter2 = counter << 2;
        LATE = LATE | counter2;

        counter = counter >> 1;
        
        if(counter > 0x0003){
            counter = 0x0030;
        }

        if(PORTBbits.RB0 == 0 & PORTBbits.RB2 == 0){
            delay(285);
        }else{
            delay(95);
        }
    }

    return 0;
}

void delay(unsgined int ms){
    resetCoreTimer();
    while(readCoreTimer() < ms * 20000);
}