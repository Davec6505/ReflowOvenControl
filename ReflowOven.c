/*
Author:      D Coetzee
Date:        04/08/2018
Description: Code for a reflow oven
*/

#include "Config.h"

unsigned char LCD_01_ADDRESS = 0x4E;
char *test = "Starting up";
// structs & enums

struct Time tmr;
struct Buttons But;
struct Phasing Phs;
_PID  pid_t;
Spts Sps;
//bits
static unsigned char Bits;
static unsigned int phase_cntr_last;

sbit SetPtSet   at Bits.B0;
sbit SetCoolBit at Bits.B1;
sbit RstTmr     at Bits.B2;
sbit FinCycle   at Bits.B3;
sbit WriteData  at Bits.B4;

static bit xDetect,pHase,Serv,buttDetect,TempBit,pidBit;
char PhaseCnt;
//variable declerations
unsigned char txt1[6];
unsigned char txt2[5];
unsigned char txt3[5];
unsigned char txt4[5];
unsigned char txt5[9];
unsigned char txt6[4];
unsigned char txt7[3];
//constants
const unsigned int mulFact = 18;


void main() {
 int a;
  I2Cxx = I2C1;
  ConfPic();
  ADC_Init();
  UART1_Init(115200);
  
  I2C1_Init(100000);//INIT I2C AT 100KHZ  Delay_ms(100); // I2C1_SetTimeoutCallback(1000,&test);    // enable error flag for I2C1 test
  I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle); // Sets the I2C1 module active
  Delay_ms(100);
  //|| | Kp | Ki | Kd | Offset | Max | Min | Dir | P,I,D ||
  PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-1000,'+',_PID);
  Uart1_En();
  Set_Priority();
  ConfigSpi();
  InitTimer0();
  InitTimer1();
//  InitTimer2();
  InitTimer3();
  InitTimer5();
  SetUp_IOCxInterrupts();
  ResetBits();
  ClearAll();
  
  I2C_LCD_init(LCD_01_ADDRESS,_2Line);
  Delay_ms(100);
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);          // Clear display
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);     // Cursor off
  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Starting UP");
  Delay_ms(2000);
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);//Lcd_Cmd(0,0x01);               // Clear display
  Delay_ms(200);
  EI();
  Delay_ms(100);
  wait = off;
  DegC.Temp_iPv = 0;
  EERead();
  EEWrt = on;
  tmr.sec = 0;
  Bits = 0;
  CalcTimerTicks();
  phase_cntr_last = Phs.PhaseCntr;
  while(1){
  long Test;
  static unsigned int TempTicPlaceholder;
     ////////////////////////////////////////////
     //display the pHase conter
     if (Button(&PORTA, 2, 10, 0))
               Menu_Bit = on;
     if(Menu_Bit)
         SampleButtons();
        
     if(!OK_Bit){

       if(phase_cntr_last != Phs.PhaseCntr){
          phase_cntr_last = Phs.PhaseCntr;
          sprintf(txt7,"%2u",Phs.PhaseCntr); //Phase counter
          I2C_LCD_Out(LCD_01_ADDRESS,4,14,"Phs:=");
          I2C_LCD_Out(LCD_01_ADDRESS,4,19,txt7);
       }
       ///////////////////////////////////////////
       //get the timer ticks if in run mode
       if((RA3_Bit)&&(!FinCycle)) DoTime();
       ///////////////////////////////////////////
       //do every second
       if(tmr.SecNew != tmr.sec){
        if(!OK_Bit){
         sprintf(txt2,"%-2d",tmr.sec);
         I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
        }
         tmr.SecNew = tmr.sec;
       }
       ///////////////////////////////////////////
       //do every min
       if(tmr.MinNew != tmr.min){
        if(!OK_Bit){
          if(tmr.min>=1){
            sprintf(txt3,"%3d",tmr.min);
            I2C_LCD_Out(LCD_01_ADDRESS,1,10,txt3);
          }else I2C_LCD_Out(LCD_01_ADDRESS,1,10,"  0");
          I2C_LCD_Out(LCD_01_ADDRESS,1,13,":");
        }
         tmr.MinNew = tmr.min;
       }
       //////////////////////////////////////////
       //timer tick deg incrament and Dec Cycle
       if(RA3_Bit){
          if(!RstTmr){
             tmr.sec = 0;
             tmr.min = 0;
             RstTmr = on;
             FinCycle = off;
          }
          if(!SetPtSet){
             DegC.Deg_Sp = DegC.Temp_iPv;
             CalcTimerTicks();
             if(!FinCycle){
               SetPtSet = on;
               UART1_Write_Text("Start");
               UART1_Write(0x0D);
               UART1_Write(0x0A);
             }
          }
          if((DegC.Deg_Sp < Sps.RmpDeg)&&(!SetCoolBit)){
               if (SetCoolBit)SetCoolBit = off;
               TempTicPlaceholder = TempTicks.RampTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,7,"Ramp");
               sprintf(txt6,"%3u",Sps.RmpDeg);
          }
          else if((DegC.Deg_Sp >= Sps.RmpDeg)&&(DegC.Deg_Sp < Sps.SokDeg)&&(!SetCoolBit)){
               TempTicPlaceholder = TempTicks.SoakTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,7,"Soak");
               sprintf(txt6,"%3u",Sps.SokDeg);
          }
          else if((DegC.Deg_Sp >= Sps.SokDeg)&&(DegC.Deg_Sp < Sps.SpkeDeg)&&(!SetCoolBit)){
               TempTicPlaceholder = TempTicks.SpikeTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,7,"Spke");
               sprintf(txt6,"%3u",Sps.SpkeDeg);
          }
          else{
              SetCoolBit = on;
              TempTicPlaceholder = TempTicks.CoolTick;
              if(!FinCycle)I2C_LCD_Out(LCD_01_ADDRESS,1,7,"Cool");
              else I2C_LCD_Out(LCD_01_ADDRESS,1,7,"Finn");
              sprintf(txt6,"%3u",Sps.CoolOffDeg);
              if(DegC.Deg_Sp < Sps.CoolOffDeg)FinCycle = on;
          }

          if(tmr.tenMilli > TempTicPlaceholder){
            tmr.tenMilli = 0;         //rest tick
            TempTicks.tickActual++;   //keep track of ticks ??
            if((SetPtSet)&&(!FinCycle)){
               if(!SetCoolBit)DegC.Deg_Sp++;
               else DegC.Deg_Sp--;
            }

            if(DegC.LastDeg != DegC.Deg_Sp){
               sprintf(txt1,"%3u",DegC.Deg_Sp);
               I2C_LCD_Out(LCD_01_ADDRESS,1,0,txt1);
               I2C_LCD_Out(LCD_01_ADDRESS,2,0,txt6);
               WriteDataOut();
               DegC.LastDeg = DegC.Deg_Sp;
            }

          }
       }else{
         SetCoolBit = off;
         tmr.tenMilli = 0;
         TempTicks.tickActual = 0;
         SetPtSet = off;
         RstTmr = off;
       }
     }
     //////////////////////////////////////////
     // Sample the Analog for buttons
     // SampleButtons();

     /////////////////////////////////////////
     //temp code to check phase detection
     switch(Phs.PhaseCntr){
        case 1:  //pid output to ccp module for pHase control
                 Phs.an0_ = (unsigned int)pid_t.Mv;// ADC_Read(0);
                 if(Phs.an0_ < 1)Phs.an0_ = 1;
                 Phs.an0_ = RevADC - Phs.an0_;
                 if(Phs.an0_ >= 980)Phs.an0_ = 980;
                 break;
       case 2:  //pid output ccp for servo control
                // Phs.an1_ = ADC_Read(1);
                Phs.an1_ = ServoSub + pid_t.Mv;//Phs.an1_;
                if(Phs.an1_ > 1500)Phs.an1_ = 1500;
                break;
       case 3:  //hardware multiplier
                if(Phs.olDan0_ != Phs.an0_){
                  Phs.an0_0 = (unsigned int)S_HWMul(Phs.an0_,mulFact);
              /*    sprintf(txt4,"%5u",Phs.an0_0);
                  LCD_Out(2,8,txt4); */
                  Phs.olDan0_ = Phs.an0_;
                }

                break;
       case 4:  //hardware multiplier
                if(Phs.olDan1_ != Phs.an1_){
                  Phs.an1_1 = (unsigned int)S_HWMul(Phs.an1_,ServoPls);
                /*  sprintf(txt4,"%5u",DegC.sampleTimer);
                  LCD_Out(1,1,txt4); */
                  Phs.olDan1_ = Phs.an1_;
                }
                break;
      case 5: // spi call to temp chip
                if(!TempBit){
                   DegC.sampleTimer++;
                   sprintf(txt7,"%2u",DegC.sampleTimer);
                   I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Clk:=");
                   I2C_LCD_Out(LCD_01_ADDRESS,4,6,txt7);
                   TempBit = on;
                  if(DegC.sampleTimer == 20){
                    DegC.Temp_fPv = ReadMax31855J();
                    if(!OK_Bit){
                      sprintf(txt5,"%3.2f",DegC.Temp_fPv); //DegC.Temp_
                      I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
                      I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
                      I2C_LCD_Out(LCD_01_ADDRESS,3,11,"'C");
                    }else I2C_LCD_Out(LCD_01_ADDRESS,3,11,"     ");
                  }
                }
                break;
      case 6://calculate Temp and display
                if(!pidBit){
                  pidBit = on;
                  if(DegC.sampleTimer >= 20){
                    PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
                    if(!OK_Bit){
                      sprintf(txt4,"%5d",pid_t.Mv);
                      I2C_LCD_Out(LCD_01_ADDRESS,2,5,txt4);
                    }
                  }
                }
                break;
     /* case 7:   //write data out to pc every 70*4 ms
                Phs.UartWriter++;
                if(Phs.UartWriter == 8){
                  if(!WriteData){
                     WriteData = on;
                     UART1_Write_Text(txt1);
                     UART1_Write(',');
                     UART1_Write_Text(txt5);
                     UART1_Write(',');
                     UART1_Write_Text(txt6);
                     UART1_Write(0x0D);
                     UART1_Write(0x0A);
                  }
                }
                break;  */
       default:
               if(Phs.UartWriter > 8){
                  Phs.UartWriter = 0;
                  WriteData = off;
               }
               if(DegC.sampleTimer >= 20)DegC.sampleTimer = 0;
               if(TempBit)TempBit = off;
               if(pidBit) pidBit = off;
               if(OK_Bit)I2C_LCD_Out(LCD_01_ADDRESS,2,0,"      ");
               Phs.PhaseCntr = 1;
               break;
     }

  }

}

///////////////////////////////////////////////////
//interrupt vectors

void HighPrioity() iv 0x0008 ics ICS_AUTO {
 High_Priority();
}

void Tmr1_Int() iv 0x0018 ics ICS_AUTO {
 Low_Priority();
}