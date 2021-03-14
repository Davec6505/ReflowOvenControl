#include "IRQs.h"

bit wait;


void High_Priority(){
     if(TMR0IF_bit){
      //Zero crossing has occured
       TMR0IF_bit  = off;
       TMR0L       = 0xFF;
      //Start compare mode tmr1
       if(Phs.PhasePulsCntr == 4)Phs.PhasePulsCntr = 0;
       Phs.pwmOut = 0;
       Phs.PhaseCntr++;
       TMR1H       = 0;
       TMR1L       = 0;
       CCPR1L      = Phs.an0_0 & 0XFF;
       CCPR1H      = Phs.an0_0 >> 8 ;

       //start the servo pulse tmr5
       LATC0_bit   = on;

       TMR5H       = 0;
       TMR5L       = 0;
       CCPR2L      = Phs.an1_1 & 0XFF;
       CCPR2H      = Phs.an1_1 >> 8 ;

       //start the interrupts again
       CCP1IF_bit  = off;
       if(RA3_Bit)CCP1IE_bit  = on;
       CCP2IE_bit = on;
       CCP2IF_bit = off;
     }

     if(CCP1IF_bit){
       CCP1IF_bit = off;
       if((Phs.pwmOut == 0)&&(Phs.PhasePulsCntr < 4)){
         CCP1IE_bit  = off;
         if(RA3_Bit)LATC2_bit = on;
         Phs.pwmOut = 1;
         TMR1H  = 0;
         TMR1L  = 0;
         CCPR1L = 250;//Phs.an1_ & 0XFF;
         CCPR1H = 0;//Phs.an1_ >> 8 ;
        // TMR1ON_bit  = on;
         wait = on;
        // CCP1IE_bit  = on;
       }

       if((Phs.pwmOut == 1)&&(!wait)){
        Phs.PhasePulsCntr++;
        TMR1H  = 0;
        TMR1L  = 0;
        CCPR1L = 50;
        CCPR1H = 0;
        LATC2_bit = off;
        Phs.pwmOut = 0;
        if(Phs.PhasePulsCntr >= 3){
          CCP1IE_bit  = off;
          Phs.PhasePulsCntr = 4;
        }

       }
       if(wait){
         wait = off;
         CCP1IE_bit  = on;
       }

     }
     if((CCP2IF_bit)&&(LATC1_bit)){
         CCP2IE_bit = off;
         CCP2IF_bit = off;
         LATC0_bit   = off;
     }
}

void Low_Priority(){
    if (TMR3IF_bit)
           TMR3();
     
     if(RBIF_bit){
        RBIF_bit  = 0;
        if((IOCB6_bit)||(IOCB7_bit))
            Encode();
     }
     
     if(RC1IF_bit)
        Serial();
}

void DoTime(){
  if(tmr.ms > 999){
    tmr.ms = 0;
    tmr.sec++;

     if(tmr.sec > 59){
          // tmr.SecNew = -1;
       tmr.sec = 0;
       tmr.min++;

       if(tmr.min > 59){
            // tmr.MinNew = -1;
         tmr.min = 0;
       }
     }
  }
}

void TMR3(){
    TMR3IF_bit = 0;
    TMR3H      = 0xC1;
    TMR3L      = 0x80;

    ///////////////////////////////////////////
    //I_Dlys for continous wait states
    tmr.millis++;
    
    ////////////////////////////////////////////
    //ten milliseconds
    tmr.tenMilli++;
    
    ////////////////////////////////////////////
    //Clock timers for Reflow
    tmr.ms++;
    tmr.ten_ms++;
    if(tmr.ten_ms > 9){
         tmr.ten_ms = 0;
    }
}

void Serial(){
     RCIF_bit = off;
     TXREG1 = RCREG1;
}

