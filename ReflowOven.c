/*
Author:      D Coetzee
Date:        04/08/2018
Description: Code for a reflow oven
*/

#include "Config.h"

//constants
const unsigned int mulFact = 18;
unsigned char LCD_01_ADDRESS = 0x4E;//4E = !A || 7E = A
char *test = "Starting up";

// structs & enums
struct Time tmr;
struct Buttons But;
struct Phasing Phs;
_PID  pid_t;
Spts Sps;


//bits
unsigned char Bits;
sbit SetPtSet   at Bits.B0;
sbit SetCoolBit at Bits.B1;
sbit RstTmr     at Bits.B2;
sbit FinCycle   at Bits.B3;
sbit WriteData  at Bits.B4;

static bit TempBit,pidBit;

//variable declerations
static unsigned int TempTicPlaceholder_last;
static short pid_sample_last;
unsigned char PhaseCnt;
unsigned char txt1[6];
unsigned char txt2[5];
unsigned char txt3[5];
unsigned char txt4[5];
unsigned char txt5[9];
unsigned char txt6[4];
unsigned char txt7[3];
unsigned char *flttxt;




void main() {
  I2Cxx = I2C1;
  DI();
  ConfPic();
  I2C_LCD_init(LCD_01_ADDRESS,_2Line);
  Delay_ms(500);
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);          // Clear display
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);     // Cursor off
  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Starting UP");
  Delay_ms(2000);
  I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);//Lcd_Cmd(0,0x01);               // Clear display

  EERead();
//|| | Kp | Ki | Kd | Offset | Max | Min | Dir | P,I,D ||
  PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-900,'+',_PID);
  ResetBits();
  ClearAll();
  RstLocals();
  DegC.Temp_iPv = (int)ReadMax31855J();
  sprintf(txt5,"%3d",DegC.Temp_iPv); //DegC.Temp_
  I2C_LCD_Out(LCD_01_ADDRESS,3,13,"iC:=");
  //strcat(txt5, "'C");
  I2C_LCD_Out(LCD_01_ADDRESS,3,18,txt5);
  CalcTimerTicks(DegC.Temp_iPv);
  EI();
  while(1){
  static bit fp;
  long Test;
  static int DegSP_last;
  static unsigned int TempTicPlaceholder;
  static unsigned int TempDegPlaceholder;    
   
     LATC5_bit = RA3_bit && !FinCycle;
     ////////////////////////////////////////////
     //LCD Display control
     if(Menu_Bit)
         SampleButtons();
     
     //falling edge of Menu_Bit to reactivate display
     if(!Menu_Bit && fp){
        fp = off;
        DegC.Deg_Sp = DegSP_last;
        TempTicPlaceholder_last = -1;
        tmr.MinNew = -1;
        if(!Ok_Bit){
          SetPtSet = on;
          RstTmr = on;
        }
     }
     
     if (!Menu_Bit && Button(&PORTA, 2, 100, 0)){
           fp = on;
           DegSP_last = DegC.Deg_Sp;
           RstEntryBits();
           Menu_Bit = on;
           while(!RA2_bit);
      }
      
      
     ///////////////////////////////////////////
     //get the timer ticks if in run mode
     if((RA3_Bit)&&(!FinCycle)) 
         DoTime();

     /////////////////////////////////////////////
     //Block from displaying this data while in
     //settings page of LCD
     if(!Menu_Bit){
       ///////////////////////////////////////////
       //do every second
       if(tmr.SecNew != tmr.sec){
         sprintf(txt2,"%-2d",tmr.sec);
         I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
         tmr.SecNew = tmr.sec;
       }
       ///////////////////////////////////////////
       //do every min
       if(tmr.MinNew != tmr.min){
          tmr.MinNew = tmr.min;
          if(tmr.min>=1){
            sprintf(txt3,"%3d",tmr.min);
            I2C_LCD_Out(LCD_01_ADDRESS,1,10,txt3);
          }else
            I2C_LCD_Out(LCD_01_ADDRESS,1,10,"  0");

          I2C_LCD_Out(LCD_01_ADDRESS,1,13,":");
       }

       if(TempTicPlaceholder_last != TempTicPlaceholder){
          TempTicPlaceholder_last = TempTicPlaceholder;
          sprintf(txt4,"%4d",TempTicPlaceholder); //Phase counter
          I2C_LCD_Out(LCD_01_ADDRESS,4,12,"'C+:=");
          I2C_LCD_Out(LCD_01_ADDRESS,4,17,txt4);
          sprintf(txt4,"%4d",TempDegPlaceholder); //Phase counter
          I2C_LCD_Out(LCD_01_ADDRESS,2,12,"Spt:=");
          I2C_LCD_Out(LCD_01_ADDRESS,2,17,txt4);
       }
       //////////////////////////////////////////
       //timer tick deg incrament and Dec Cycle
       if(!SetPtSet){
             SetPtSet = on;
             DegC.Deg_Sp = DegC.Temp_iPv;
             CalcTimerTicks(DegC.Temp_iPv);
             if(!FinCycle){
               WriteStart();
             }
       }
       
       if(RA3_Bit){
       
          if(OFF_Bit){
             FinCycle = on;
             SetCoolBit = on;
             OFF_Bit = off;
          }

          if(!RstTmr){
             RstTmr = on;
             FinCycle = off;
             SetPtSet = off;
             SetCoolBit = off;
             Ok_Bit = off;
             tmr.MinNew = -1;
             TempTicPlaceholder_last = 0;
             tmr.sec = 0;
             tmr.min = 0;
          }
          if(Ok_Bit){
              RstTmr = off;
          }

          
          if((DegC.Deg_Sp < Sps.RmpDeg)&&(!SetCoolBit)){
               if (SetCoolBit)SetCoolBit = off;
               TempDegPlaceholder = Sps.RmpDeg;
               TempTicPlaceholder = TempTicks.RampTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ramp");
               sprintf(txt6,"%4d",Sps.RmpDeg);
          }
          else if((DegC.Deg_Sp >= Sps.RmpDeg)&&(DegC.Deg_Sp < Sps.SokDeg)&&(!SetCoolBit)){
               TempDegPlaceholder = Sps.SokDeg;
               TempTicPlaceholder = TempTicks.SoakTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Soak");
               sprintf(txt6,"%4d",Sps.SokDeg);
          }
          else if((DegC.Deg_Sp >= Sps.SokDeg)&&(DegC.Deg_Sp < Sps.SpkeDeg)&&(!SetCoolBit)){
               TempDegPlaceholder = Sps.SpkeDeg;
               TempTicPlaceholder = TempTicks.SpikeTick;
               I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Spke");
               sprintf(txt6,"%4d",Sps.SpkeDeg);
          }
          else{
              SetCoolBit = on;
              TempTicPlaceholder = TempTicks.CoolTick;
              TempDegPlaceholder = Sps.CoolOffDeg;
              if(!FinCycle)I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Cool");
              else I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Finn");
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
               sprintf(txt1,"%4d",DegC.Deg_Sp);
               I2C_LCD_Out(LCD_01_ADDRESS,2,1,"Deg:=");
               I2C_LCD_Out(LCD_01_ADDRESS,2,6,txt1);
               DegC.LastDeg = DegC.Deg_Sp;
            }

          }
       }else{
         I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Off ");
         SetCoolBit = off;
         tmr.tenMilli = 0;
         TempTicks.tickActual = 0;
         SetPtSet = off;
         RstTmr = off;
         Ok_Bit = off;
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
                 if(Phs.an0_ >= 1010)Phs.an0_ = 1010;
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
                   TempBit = on;
                  if(DegC.sampleTimer == DegC.SampleTmrSP){
                    DegC.Temp_fPv = ReadMax31855J();
                    if(!Menu_Bit){
                      DegC.Temp_iPv = (int)DegC.Temp_fPv;
                      sprintf(txt5,"%3.2f",DegC.Temp_fPv); //DegC.Temp_
                      I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
                      strcat(txt5, "'C");
                      I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
                      sprintf(txt5,"%3d",DegC.Temp_iPv); //DegC.Temp_
                      I2C_LCD_Out(LCD_01_ADDRESS,3,13,"iC:=");
                      //strcat(txt5, "'C");
                      I2C_LCD_Out(LCD_01_ADDRESS,3,18,txt5);
                    }
                  }
                }
                break;
      case 6://calculate Temp and display
                if(!pidBit){
                  pid_t.sample_tmr++;
                  pidBit = on;
                  if(pid_t.sample_tmr == pid_t.Kt){
                  
                    if(!FinCycle)
                        PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
                     else
                        pid_t.Mv = -900;
                        
                    if(!Menu_Bit){
                      I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Mv:=");
                      sprintf(txt4,"%4d",pid_t.Mv);
                      I2C_LCD_Out(LCD_01_ADDRESS,4,5,txt4);
                    }
                    
                  }
                }
                break;
      case 7:   //write data out to pc every 70*4 ms
                Phs.UartWriter++;
                if(Phs.UartWriter == Sps.SerialWriteDly){
                  if(!WriteData){
                     WriteData = on;
                     UART1_Write_Text(txt1);
                     UART1_Write(',');
                     UART1_Write_Text(txt5);
                     UART1_Write(',');
                     UART1_Write_Text(txt6);
                     UART1_Write(',');
                     UART1_Write_Text(txt4);
                     UART1_Write(0x0D);
                     UART1_Write(0x0A);
                     
                     if(FinCycle)
                          WriteFin();
                  }
                }
                break;
       default:
               if((Phs.UartWriter > Sps.SerialWriteDly)&&(!FinCycle)){
                  Phs.UartWriter = 0;
                  WriteData = off;
               }
               if(DegC.sampleTimer >= DegC.SampleTmrSP)DegC.sampleTimer = 0;
               if(pid_t.sample_tmr >= pid_t.Kt)pid_t.sample_tmr = 0;
               if(TempBit)TempBit = off;
               if(pidBit) pidBit = off;
               Phs.PhaseCntr = 1;
               break;
     }

  }

}

///////////////////////////////////////////////////
//interrupt vectors

void HighPriority() iv 0x0008 ics ICS_AUTO {
 High_Priority();
}

 void LowPriority() iv 0x0018 ics ICS_AUTO {
 Low_Priority();
}

void RstLocals(){
  TempTicPlaceholder_last = 0;
  Bits = 0;
  SetPtSet = 0;
  RstTmr = 0;
}

// define callback function
void I2C1_TimeoutCallback(char errorCode) {

   if (errorCode == _I2C_TIMEOUT_RD) {
     return;
   }

   if (errorCode == _I2C_TIMEOUT_WR) {
     // do something if timeout is caused during write
     LATC5_bit = !LATC5_bit;
     return;
   }

   if (errorCode == _I2C_TIMEOUT_START) {
     // do something if timeout is caused during start
     LATC5_bit = on;
       return;
     
   }

   if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
     // do something if timeout is caused during repeated start
   }
}