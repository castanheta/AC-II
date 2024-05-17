#include <detpic32.h>

void delay(unsigned int ms);

int main (void){
    TRISE = TRISE & 0xFFC1;
    TRISBbits.TRISB2 = 1;
    int counter = 0;
    int counter2;

    while(1){
        LATE = LATE & 0xFFC1;
        counter2 = counter << 2;
        LATE = LATE | counter2;


        if(PORTBbits.RB2 == 0){
            delay(500);
        }else{
            delay(3636);
        }

        printInt(counter, 0x0002000A);
        putChar('\n');


        if(counter == 0){
            counter = 12;
        }

        counter--;
    }

    return 0;

}

void delay(unsigned int ms){
    resetCoreTimer();
    while(readCoreTimer() < ms * 20000);
}