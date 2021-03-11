#include "ADC_Buttons.h"

//////////////////////////////////////////////
//variables
static unsigned int enC,enC_last,enC_line_inc,enC_line_last;
unsigned char txt4_[6];
static unsigned char B;
static unsigned char B_;
static unsigned int valOf;
static bit P0,P1,P2,P3;
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
  //test first entry and reset

     if(!Menu_Bit){
       P0 = 0;
       return;
     }
         
     if(Menu_Bit){
       if(!P0 && (enC != 0)){
          P0 = 1;
          enC = 0;
          enC = Save_EncoderValue(enC);
       }
       
       if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E && !OK_F && !OK_G)
           enC = Get_EncoderValue();//get encoder value
           
       if(enC < 0 || enC > 65000){
           enC = 0;
           enC = Save_EncoderValue(enC);
       }
       
       if(enC_last != enC){
           enC_last = enC;
           if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E && !OK_F && !OK_G){
             I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
             enC_line_inc =  enC % 4 + 1;
             enC_line_last = enC_line_inc;
             I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
             sprintf(txt4_,"%5u",enC_line_inc);
             I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4_);
             sprintf(txt4_,"%5u",enC);
             I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4_);
           }
       }
       
     }
     
    if(Menu_Bit){
        if(EEWrt)EEWrt = off;
        state:
       switch(Sps.State){
           case Return:   if(enC > 3){
                              enC = Save_EncoderValue(3);
                          }
                          close:
                          switch(enC){
                               case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
                                              Ok_Bit = 1;
                                              enC = 13;
                                              goto close;
                                        }
                               case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
                                              Sps.State = TempMenu;
                                              enC = Save_EncoderValue(1);
                                              goto state;
                                         }
                                                 
                               case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
                                              Sps.State = PIDMenu;
                                              enC = Save_EncoderValue(2);
                                              goto state;
                                        }
                               case 3:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                               case 4:
                               case 5:
                               case 6:
                               case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                               case 8:
                               case 9:
                               case 10:
                               case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                              default:
                                        I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                        Delay_ms(800);
                                        Menu_Bit = off;
                                        Ok_Bit   = off;
                                        P0 = 0;
                                        enC = Save_EncoderValue(0);
                                     break;
                          }
                break;
           case TempMenu:
                          if(enC > 7){
                               enC = Save_EncoderValue(7);
                          }
                          ret1:
                          switch(enC){
                               case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
                                              Sps.State = Return;
                                              enC = 13;
                                              goto ret1;
                                         }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
                                              Sps.State = RampSettings;
                                              enC = Save_EncoderValue(1);
                                              goto state;
                                         }
                               case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
                                              Sps.State = SoakSettings;
                                              enC = Save_EncoderValue(1);
                                              goto state;
                                         }
                               case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
                                              Sps.State = SpikeSettings;
                                              enC = Save_EncoderValue(1);
                                              goto state;
                                         }
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
                                     break;
                               case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
                                              Sps.State = CoolSettings;
                                              enC = Save_EncoderValue(1);
                                              goto state;
                                         }
                               case 5:
                               case 6:
                               case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                               case 8:
                               case 9:
                               case 10:
                               case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                              default:
                                          if(Ok_Bit || (enC > 12)){
                                            I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                            Sps.State = 1;
                                           
                                          }
                                     break;
                          }
                break;
           case PIDMenu:
                          if(enC > 7){
                               enC = Save_EncoderValue(7);
                          }
                          ret2:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
                                              Sps.State = Return;
                                              enC = 13;
                                              goto ret2;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KpSettings)){
                                              Sps.State = KpSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KiSettings)){
                                              Sps.State = KiSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                          }
                               case 3:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KdSettings)){
                                              Sps.State = KdSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                          }
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp     ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki     ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd     ");
                                     break;
                               case 4:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KtimeSettings)){
                                              Sps.State = KtimeSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                          }
                               case 5:
                               case 6:
                               case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Kt     ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                               case 8:
                               case 9:
                               case 10:
                               case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
                                     break;
                              default:
                                         if(Ok_Bit || (enC > 12)){
                                             I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                             Sps.State = Return;
                                          }
                                     break;
                          }
                break;
           case RampSettings:
                          if(enC > 3){
                               enC = Save_EncoderValue(3);
                          }
                          ret3:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
                                              Sps.State = TempMenu;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret3;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(Sps.RmpDeg);
                                          }
                                          if(OK_A){
                                              Sps.RmpDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 0;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(Sps.RmpTmr);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              Sps.RmpTmr = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 0;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
                                          sprintf(txt4,"%3d",Sps.RmpDeg);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpTmr:=");
                                          sprintf(txt4,"%3d",Sps.RmpTmr);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
                                     break;
                              default:
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                     break;
                          }
                break;
           case SoakSettings:                 
                          if(enC > 3){
                               enC = Save_EncoderValue(3);
                          }
                          ret4:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
                                              Sps.State = TempMenu;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret4;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(Sps.SokDeg);
                                          }
                                          if(OK_A){
                                              Sps.SokDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 0;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(Sps.SokTmr);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              Sps.SokTmr = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 0;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
                                          sprintf(txt4,"%3d",Sps.SokDeg);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakTmr:=");
                                          sprintf(txt4,"%3d",Sps.SokTmr);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
                                     break;
                              default:
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                     break;
                          }
                break;
           case SpikeSettings:
                break;
           case CoolSettings:
                break;
           case KpSettings:
                break;
           case KiSettings:
                break;
           case KdSettings:
                break;
           case KtimeSettings:
                break;
           default: Sps.State = Return;
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
        // Sps.State = valOf;
         if((valOf > 11)&&(valOf<50000))valOf = 11;
         else if (valOf >= 50001)valOf = 0;
    }

}

void ResetBits(){
  valOf     = 0;
  Sps.State = 0;
  Menu_Bit  = 0;
  OK_Bit    = 0;
  OK_A      = 0;
  OK_B      = 0;
  OK_C      = 0;
  OK_D      = 0;
  OK_E      = 0;
  OK_F      = 0;
  OK_G      = 0;
  OK_H      = 0;
  OK_I      = 0;
  OK_J      = 0;
  OK_K      = 0;
}

void SavedVals(){

}

void doOFFBitoff(){

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