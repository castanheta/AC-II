#include <detpic32.h>



int main(void){
    TRISB = TRISB & 0x80FF;               //RB8 a RB14 como saídas
    TRISD = TRISD & 0xFF9F;               //RD5 e RD6 como saídas

    LATDbits.LATD5 = 1; //Display L on

    while(1){
        char c = getChar();

        if(c == 'a' || c == 'A') LATB = (LATB & 0x80FF) | 0x0100;
        if(c == 'b') LATB = (LATB & 0x80FF) | 0x0200;
        if(c == 'c') LATB = (LATB & 0x80FF) | 0x0400;
        if(c == 'd') LATB = (LATB & 0x80FF) | 0x0800;
        if(c == 'e') LATB = (LATB & 0x80FF) | 0x1000;
        if(c == 'f') LATB = (LATB & 0x80FF) | 0x2000;
        if(c == 'g') LATB = (LATB & 0x80FF) | 0x4000;
    }
    
}
