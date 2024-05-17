#include <detpic32.h>

void delay(int ms);
void putc(char byte2send);

volatile int baudrate= 115200;

int main(void)
{
    // Configure UART2
    U2BRG = (PBCLK + 2*baudrate) / (4*baudrate) - 1;                  // U2BRG = (20Mhz / (4*115200))-1 ~ 10          
    U2MODEbits.PDSEL = 0b00;    // 00 = 8-bit data, no parity
    U2MODEbits.STSEL = 0;       // only 1 stop bit
    U2MODEbits.BRGH = 1;        // divide by 4
    U2STAbits.URXEN = 1;        // Enable Receiver
    U2STAbits.UTXEN = 1;        // Enable Transmitter
    U2MODEbits.ON = 1;          // Enable UART2
    
    while (1)
    {
        putc('+');
        delay(1000);            // Wait 1s
    }
    
    return 0;
}

void putc(char byte2send)
{
    while (U2STAbits.UTXBF == 1);   // Wait until the Transmister Buffer is Full
    U2TXREG = byte2send;
}

void delay(int ms)
{   
    for (; ms > 0; ms--)
    {
        resetCoreTimer();
        while (readCoreTimer() < 20000);
    }
}