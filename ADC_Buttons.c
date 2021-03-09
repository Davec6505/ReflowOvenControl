#include "ADC_Buttons.h"

//////////////////////////////////////////////
//variables
static unsigned int enC,enC_temp;
unsigned char txt4_[6];
unsigned char B;
unsigned char B_;
static unsigned int valOf;
/////////////////////////////////////////////
//char B bits
sbit Menu_Bit at B.B0;
sbit OK_Bit  at B.B1;
sbit ENT_Bit at B.B2;
sbit OFF_Bit at B.B3;
sbit EEWrt   at B.B4;


//char B_ bits
sbit OK_A    at B_.B0;
sbit OK_B    at B_.B1;
sbit OK_C    at B_.B2;
sbit OK_D    at B_.B3;
sbit OK_E    at B_.B4;
sbit OK_F    at B_.B5;
sbit OK_G    at B_.B6;
sbit OK_H    at B_.B7;
sbit OK_I    at B.B5;
sbit OK_J    at B.B6;
sbit OK_K    at B.B7;
/////////////////////////////////////////////
//types
enum StatesOfControl Cntrl;

/////////////////////////////////////////////
//function pointer decleration
unsigned int (*Fptr)(unsigned int Arg1);

////////////////////////////////////////////
//functions
void SampleButtons(){
static unsigned int i;
     if (Button(&PORTA, 2, 10, 0))
               Menu_Bit = on;
     else
         return;
               
     if(Menu_Bit && !Ok_Bit){
        Ok_Bit = on;
        I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
     }
     
     if(Menu_Bit){
       enC = Get_EncoderValue();//ReadMax31855J();
       if(enC_temp != enC){
         sprintf(txt1,"%4d",enC);
         UART1_Write_Text(txt1);
         I2C_LCD_Out(LCD_01_ADDRESS,2,11,"Enc:=");
         I2C_LCD_Out(LCD_01_ADDRESS,2,17,txt1);
       }
     }

    if(Ok_Bit){
        if(EEWrt)EEWrt = off;
       switch(Sps.State){
           case Return:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ret     ");
                       // if(OK_Bit) LCD_Out(2,6,"On ");
                break;
           case RampDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampDeg ");
                        if(OK_A){
                         if(!OFF_Bit){
                          I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKA");
                          valOf = Sps.RmpDeg;
                          OFF_Bit = on;
                         }else Sps.RmpDeg = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case RampTm:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampTm  ");
                        if(OK_B){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKB");
                            valOf = Sps.RmpTmr;
                            OFF_Bit = on;
                          }else Sps.RmpTmr = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case SoakDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakDeg ");
                        if(OK_C){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKC");
                            valOf = Sps.SokDeg;
                            OFF_Bit = on;
                          }else Sps.SokDeg = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case SoakTm:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakTm  ");
                        if(OK_D){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKD");
                            valOf = Sps.SokTmr;
                            OFF_Bit = on;
                          }else Sps.SokTmr = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case SpikeDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeDeg");
                        if(OK_E){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKE");
                            valOf = Sps.SpkeDeg;
                            OFF_Bit = on;
                          }else Sps.SpkeDeg = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case SpikeTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeTm ");
                        if(OK_F){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKF");
                            valOf = Sps.SpkeTmr;
                            OFF_Bit = on;
                          }else Sps.SpkeTmr = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case CoolDownDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolDeg ");
                        if(OK_G){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKG");
                            valOf = Sps.CoolOffDeg;
                            OFF_Bit = on;
                          }else Sps.CoolOffDeg = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case CoolDownTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolTm ");
                        if(OK_H){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKH");
                            valOf = Sps.CoolOffTmr;
                            OFF_Bit = on;
                          }else Sps.CoolOffTmr = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case Kp_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kp    ");
                        if(OK_I){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKI");
                            valOf = pid_t.Kp;
                            OFF_Bit = on;
                          }else pid_t.Kp = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case Ki_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ki    ");
                        if(OK_J){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKJ");
                            valOf = pid_t.Ki;
                            OFF_Bit = on;
                          }else pid_t.Ki = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           case Kd_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kd    ");
                        if(OK_K){
                          if(!OFF_Bit){
                            I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKK");
                            valOf = pid_t.Kd;
                            OFF_Bit = on;
                          }else pid_t.Kd = valOf;
                        }else doOFFBitoff();
                        sprintf(txt4_,"%5u",valOf);
                        I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
                break;
           default: Sps.State = Return;
                    valOf = Sps.State;
                break;
       }
       


    }else{
       if(!EEWrt){
        CalcTimerTicks();
        EEWrite();
        EEWrt = on;
        I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
       }
       ResetBits();
     }
    if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
         Sps.State = valOf;
         if((valOf > 11)&&(valOf<50000))valOf = 11;
         else if (valOf >= 50001)valOf = 0;
    }

}

void ResetBits(){
  valOf = 0;
  Sps.State = 0;
  OK_Bit = 0;
  OK_A = 0;
  OK_B = 0;
  OK_C = 0;
  OK_D = 0;
  OK_E = 0;
  OK_F = 0;
  OK_G = 0;
  OK_H = 0;
  OK_I = 0;
  OK_J = 0;
  OK_K = 0;
}

void SavedVals(){
            if(Sps.State == RampDeg)          OK_A = !OK_A;
            else if(Sps.State == RampTm)      OK_B = !OK_B;
            else if(Sps.State == SoakDeg)     OK_C = !OK_C;
            else if(Sps.State == SoakTm)      OK_D = !OK_D;
            else if(Sps.State == SpikeDeg)    OK_E = !OK_E;
            else if(Sps.State == SpikeTM)     OK_F = !OK_F;
            else if(Sps.State == CoolDownDeg) OK_G = !OK_G;
            else if(Sps.State == CoolDowntM)  OK_H = !OK_H;
            else if(Sps.State == Kp_)         OK_I = !OK_I;
            else if(Sps.State == Ki_)         OK_J = !OK_J;
            else if(Sps.State == Kd_)         OK_K = !OK_K;
            else OK_Bit = !OK_Bit;
}

void doOFFBitoff(){
        if(OFF_Bit){
           I2C_LCD_Out(LCD_01_ADDRESS,2,6,"   ");
           valOf = Sps.State;
           OFF_Bit = off;
        }

}

void EERead(){
  //SETPOINTS
   Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
   Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
   Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
   Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
   Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
   Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
   Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
   Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
   Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
   Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
   Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
   Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
   Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
   Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
   Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
   Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
   /////////////////////////////////////////////////////
   //PID
   Lo(pid_t.Kp)     = EEPROM_Read(0x10);
   Hi(pid_t.Kp)     = EEPROM_Read(0x11);
   Lo(pid_t.Ki)     = EEPROM_Read(0x12);
   Hi(pid_t.Ki)     = EEPROM_Read(0x13);
   Lo(pid_t.Kd)     = EEPROM_Read(0x14);
   Hi(pid_t.Kd)     = EEPROM_Read(0x15);
   /////////////////////////////////////////////////////
   //tick values last calculated
   Lo(TempTicks.RampTick)  = EEPROM_Read(0x16);
   Hi(TempTicks.RampTick)  = EEPROM_Read(0x17);
   Lo(TempTicks.SoakTick)  = EEPROM_Read(0x18);
   Hi(TempTicks.SoakTick)  = EEPROM_Read(0x19);
   Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1A);
   Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1B);
   Lo(TempTicks.CoolTick)  = EEPROM_Read(0x1C);
   Hi(TempTicks.CoolTick)  = EEPROM_Read(0x1D);
   
}
void EEWrite(){
   I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");
  //SETPOINTS
   EEPROM_Write(0x00, Lo(Sps.RmpDeg));
   EEPROM_Write(0x01, Hi(Sps.RmpDeg));
   EEPROM_Write(0x02, Lo(Sps.RmpTmr));
   EEPROM_Write(0x03, Hi(Sps.RmpTmr));
   EEPROM_Write(0x04, Lo(Sps.SokDeg));
   EEPROM_Write(0x05, Hi(Sps.SokDeg));
   EEPROM_Write(0x06, Lo(Sps.SokTmr));
   EEPROM_Write(0x07, Hi(Sps.SokTmr));
   EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
   EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
   EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
   EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
   EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
   EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
   EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
   EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
   //////////////////////////////////////////////////////
   //PID
   EEPROM_Write(0x10, Lo(pid_t.Kp));
   EEPROM_Write(0x11, Hi(pid_t.Kp));
   EEPROM_Write(0x12, Lo(pid_t.Ki));
   EEPROM_Write(0x13, Hi(pid_t.Ki));
   EEPROM_Write(0x14, Lo(pid_t.Kd));
   EEPROM_Write(0x15, Hi(pid_t.Kd));
   //////////////////////////////////////////////////////
   //TempTicks
   EEPROM_Write(0x16, Lo(TempTicks.RampTick));
   EEPROM_Write(0x17, Hi(TempTicks.RampTick));
   EEPROM_Write(0x18, Lo(TempTicks.SoakTick));
   EEPROM_Write(0x19, Hi(TempTicks.SoakTick));
   EEPROM_Write(0x1A, Lo(TempTicks.SpikeTick));
   EEPROM_Write(0x1B, Hi(TempTicks.SpikeTick));
   EEPROM_Write(0x1C, Lo(TempTicks.CoolTick));
   EEPROM_Write(0x1D, Hi(TempTicks.CoolTick));
   Delay_ms(100);
}