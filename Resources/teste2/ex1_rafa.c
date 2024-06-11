#include<detpic32.h>


int main(void) {

	T3CONbits.TCKPS = 3; // 1:4
	PR3 = 38461; // Fout = 20MHz / (32 * (62499 + 1)) = 10 Hz
	TMR3 = 0; // Clear timer T2 count register
	T3CONbits.TON = 1;
	
	 
	OC4CONbits.OCM = 6; 
	OC4CONbits.OCTSEL =0;
	OC4RS = 19231; 
	OC4CONbits.ON = 1;
	
	TRISBbits.TRISB1 = 0;
	static char state = 0;
	
	while(1) {
		if (PORTBbits.RB1 == 0){ 
			resetCoreTimer();while(readCoreTimer()<26000000);
			state = !state;

			if(state == 1){
				OC4RS = 9615;
			}else{
				OC4RS = 28485;
			}
		}
		
	}
	
}