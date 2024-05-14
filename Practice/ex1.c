#include <detpic32.h>

void delay(unsigned int ms);

int main(void){
    TRISE = TRISE & 0xFFC0;
    TRISBbits.TRISB2 = 1;

    int count = 1;

    while(1){
        LATE = LATE & 0xFFC0;
        LATE = LATE | count;

        if(PORTBbits.RB2 == 0){
            delay(1000);
        }else{
            delay(500);
        }

        count = count << 1;
        if(count == 0x0040){
            count = 1;
        }
        
    }

    return 0;
}

void delay(unsigned int ms){
    resetCoreTimer();
    while (readCoreTimer() < ms * 20000);
    
}
