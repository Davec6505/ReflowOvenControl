//configure all chip SFR's

#include "Config.h"


void ConfPic(){
 //SLRB_bit = 1;
 C1ON_bit = 0;  //turn off comparators
 C2ON_bit = 0;
 
 ANSELA = 0x03; //make RA0 to RA3 as analogs
 ANSELB = 0X00; //turn off all analogs attached to Port B
 ANSELC = 0X00;
 
 TRISA = 0x3F;  //RA0 - RA5 as inputs
 TRISB = 0XC0;
 TRISC = 0x08;  //RC port as outputs;
 
 LATA  = 0;
 LATB  = 0;
 LATC  = 0;     //FORCE portc off


 //set timers for CCp module up front
 CCPTMRS0 = 0xD0;
 CCPTMRS1 = 0X0F;

  I2C1_Init(100000);//INIT I2C AT 100KHZ
  Delay_ms(100); 
  I2C1_SetTimeoutCallback(1000,I2C1_TimeoutCallback);    // enable error flag for I2C1 test
  I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle); // Sets the I2C1 module active
  ConfigSpi();
  SetUp_IOCxInterrupts();
  Delay_ms(100);
  UART1_Init(115200);
  Uart1_En();
  Delay_ms(100);
  Set_Priority();
  InitTimer0();
  InitTimer1();
  //  InitTimer2();
  InitTimer3();
  InitTimer5();
  ADC_Init();
}

//Timer0
//Counter mode | Clck Pin | Lo2Hi | No PreScaler assigned | Prescaler 1:1;
void InitTimer0(){
  T0CON       =  0xF8;
  TMR0L       =  0xFF; //To generate an immediate overflow
  TMR0IE_bit  = on;
  TMR0IP_bit  = on;    //assigne high priority
  TMR0IF_bit  = off;
}
//Timer1
//| Fosc/4 | Prescaler 1:8 | TxSOSCEN = 0 | No external clk | 16bit | T1ON = 1 |;
void InitTimer1(){
  T1CON       = 0x37;
  TMR1GE_bit  = off;
  TMR1IE_bit  = off;
  TMR1IF_bit  = off;
  //Configure Compare module for software interrupt and T1
  CCP1M3_bit = 1;     // |------
  CCP1M2_bit = 0;     // | _ Special Event interrupt
  CCP1M1_bit = 1;     // |
  CCP1M0_bit = 1;     // |------
  
  CCP1IE_bit = on;
  CCP1IF_bit = on;
  CCP1IP_bit = on;
  CCP1MD_bit = off;
  
  CCPR1H = 0X00;
  CCPR1L = 0XFF;
  
}
//Timer2
//| N/A | Postscaler 1:4 | T2ON = 1 | Prescaler 1:1 |;
void InitTimer2(){
  TRISC2_bit = on;
   CCP1MD_bit = off;
  //Configure Compare module for software interrupt and T1
  CCP1CON = 0x0C;
  PR2 = 0X7D;//SetPwm();
  CCPR1L = 0;
  DC1B1_bit = 0;
  DC1B0_bit = 0;
  T2CON              = 0x1C;
  TRISC2_bit  = off;
  TMR2IF_bit  = off;
}
//Timer3
//Prescaler 1:1; TMR1 Preload = 49536; Actual Interrupt Time : 1 ms
void InitTimer3(){
  T3CON              = 0x01;
  TMR3IF_bit  = 0;
  TMR3H              = 0xC1;
  TMR3L              = 0x80;
  TMR3IE_bit  = on;
  TMR3IP_bit  = on;
  TMR3IF_bit  = off;
}

//Timer5
//| Fosc/4 | Prescaler 1:8 | TxSOSCEN = 0 | No external clk | 16bit | T5ON = 1 |;
void InitTimer5(){
  T5CON       = 0x37;
  TMR5GE_bit  = off;
  TMR5IE_bit  = off;
  //Configure Compare module for software interrupt and T1
  CCP2M3_bit = 1;     // |------
  CCP2M2_bit = 0;     // | _ Special Event interrupt
  CCP2M1_bit = 1;     // |
  CCP2M0_bit = 0;     // |------

  CCP2IE_bit = on;
  CCP2IP_bit = on;
  CCP2IF_bit = off;
  CCP2MD_bit = off;

  CCPR2H = 0;
  CCPR2L = 0;

}

void Uart1_En(){
 RC1IE_bit = 1;  //turn on recieve interrupts
 RC1IP_bit = 0; //low priority interrupt
 RC1IF_bit = 0;
}
//INTERRUPTS enable
void Set_Priority(){
 IPEN_bit  = 1;  //PRIORITY INTERRUPTS ENABLE
}
void EI(){
 GIEH_bit  = 1;  //GLOBAL INTERRUPTS ENABLE
 GIEL_bit  = 1;  //PERIPHAL INTERRUPTS ENABLE
}
void DI(){
 GIEH_bit  = 0;  //GLOBAL INTERRUPTS ENABLE
 GIEL_bit  = 0;  //PERIPHAL INTERRUPTS ENABLE
}

void SetUp_IOCxInterrupts(){
   IOCB7_bit = 1;
   IOCB6_bit = 1;
   RBIE_bit  = on; //ENABLE IOCx
   RBIP_bit  = 0;
   RBIF_bit  = 0;
}
void ClearAll(){
  tmr.SecNew = -1;
  tmr.MinNew = -1;
  tmr.millis  = 0;
  tmr.ms  = 0;
  tmr.sec = 0;
  tmr.min = 0;
  tmr.I_Dlys  = 0;
  Phs.UartWriter = 0;
  Phs.pwmOut = 0;
  Phs.PhasePulsCntr = 0;
  Phs.PhaseCntr = 1;
  DegC.sampleTimer = 0;
  wait = off;
  DegC.Temp_iPv = 0;
  tmr.sec = 0;
  Menu_Bit = 0;
  Ok_Bit = 0;
  OFF_Bit = 0;
  pid_t.Mv = 10;
}

void WriteStart(){
      UART1_Write_Text("Start");
      UART1_Write(0x0D);
      UART1_Write(0x0A);
}

void WriteFin(){
      UART1_Write_Text("Finnished");
      UART1_Write(0x0D);
      UART1_Write(0x0A);
}

void WriteDataOut(){
      UART1_Write_Text(txt1);
      UART1_Write(',');
      UART1_Write_Text(txt5);
      UART1_Write(',');
      UART1_Write_Text(txt6);
      UART1_Write(',');
      UART1_Write(0x0D);
      UART1_Write(0x0A);
}