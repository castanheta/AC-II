#include <detpic32.h>

void delay(int ms);
void send2displays(unsigned char value);

int main(void){
    // configure RB8-RB14 as outputs
    TRISB = TRISB & 0x80FF;
    // configure RD5-RD6 as outputs
    TRISD = TRISD & 0xFF9F;
    int counter = 0;
    while(1){
        send2displays(counter);
        // wait 0.2s
        delay(20);
        counter++;
    }

}

void send2displays(unsigned char value){
    static const char display7Scodes[] = {
                        0x3F, //0
                        0x06, //1
                        0x5B, //2
                        0x4F, //3
                        0x66, //4
                        0x6D, //5
                        0x7D, //6
                        0x07, //7
                        0x7F, //8
                        0x6F, //9
                        0x77, //A
                        0x7C, //b
                        0x39, //C
                        0x5E, //d
                        0x79, //E
                        0x71  //F
                    };
    static char displayFlag = 0; // static variable: doesn't loose its
                                // value between calls to function 
    char dl, dh;

    dh = value >> 4;
    dl = value & 0x0F;

    if(displayFlag == 0){
         // select display low
        LATDbits.LATD5 = 1;
        LATDbits.LATD6 = 0;
        // send digit_low (dl) to display: dl = value & 0x0F
        LATB = (LATB & 0x00FF) | (display7Scodes[dl]) << 8;
    }else{
        // select display high
        LATDbits.LATD5 = 0;
        LATDbits.LATD6 = 1;
        // send digit_high (dh) to display: dh = value >> 4
        LATB = (LATB & 0x00FF) | (display7Scodes[dh]) << 8;
    }
    
    displayFlag = !displayFlag;
} 


void delay(int ms){
    resetCoreTimer();
    while(readCoreTimer() < 20000 * ms);
}   