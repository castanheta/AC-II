#include <detpic32.h>

void delay(int ms);

int main(void){
    TRISE = TRISE & 0xFF87;
    int counter = 0;

    while(1){

        LATE = (LATE & 0xFF87) | counter << 3;
        resetCoreTimer(); while( readCoreTimer() < 4347826 );
        counter = (counter + 1) % 10; 
    }
}


