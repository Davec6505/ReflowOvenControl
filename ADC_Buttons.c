#include "ADC_Buttons.h"

//////////////////////////////////////////////
//variables
static unsigned int enC,enC_last,enC_line_inc,enC_line_last,enC_line_edit;
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
void RstEntryBits(){
       P0 = 0;
       P2 = 0;
       enC = -1;
       I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
}
void SampleButtons(){
  //test first entry and reset


         
     if(Menu_Bit){
       if(!P0 && (enC != 0)){
          P0 = 1;
          enC = 0;
          enC = Save_EncoderValue(enC);
          enC_line_inc = 0;
          enC_last = -1;
       }
       
       if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
           enC = Get_EncoderValue();//get encoder value
           
       if(enC < 0 || enC > 65000){
           enC = 0;
           enC = Save_EncoderValue(enC);
       }
       
       if(enC_last != enC){
           enC_last = enC;
           if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E){
             I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
             enC_line_inc =  enC % 4 + 1;
             enC_line_last = enC_line_inc;
             I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
             enC_line_edit = enC_line_inc;
           }
       }
       
     }
     
    if(Menu_Bit){
        ///////////////////////////////////////////
        //Show when editing
        if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
           I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15," ");
        else{
           P1 = 1;
           I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15,"@");
        }
        //////////////////////////////////////////
        /*jump condition to stop a re scan when needing
         *to change states;
         *various encoder entry states for settings and
         *other information
         */
        state:
       switch(Sps.State){
           case Return:   if(enC > 7){
                              enC = Save_EncoderValue(7);
                          }
                          close:
                          switch(enC){
                               case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
                                              enC = 13;
                                              goto close;
                                        }
                               case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
                                              Sps.State = TempMenu;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                                                 
                               case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
                                              Sps.State = PIDMenu;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                        }
                               case 3:
                                        if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
                                              Ok_Bit = 1;;
                                              enC = 13;
                                              goto close;
                                        }
                                        I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
                                        I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
                                        I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
                                        I2C_LCD_Out(LCD_01_ADDRESS,4,2,"ReStart");
                                     break;
                               case 4:
                                        if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
                                              OFF_Bit = 1;;
                                              enC = 13;
                                              goto close;
                                        }
                               case 5:
                               case 6:
                               case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Stop   ");
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
                                        if(P1) EEWrt = on;
                                        else Menu_Bit = off;
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
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                               case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
                                              Sps.State = SoakSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                               case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
                                              Sps.State = SpikeSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
                                     break;
                               case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
                                              Sps.State = CoolSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                               case 5:
                                         if (Button(&PORTA, 2, 200, 0) && (Sps.State != TimeSettings)){
                                              Sps.State = TimeSettings;
                                              enC = Save_EncoderValue(0);
                                              goto state;
                                         }
                               case 6:
                               case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Timers ");
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
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          Sps.State = 1;
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
                                     break;
                          }
                break;
           case PIDMenu:
                          if(enC > 7){
                               enC = Save_EncoderValue(7);
                          }
                          ret2:
                          switch(enC){
                               case 0:    
                                          if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
                                              Sps.State = Return;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret2;
                                          }
                               case 1:
                                          if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;OK_B = 0;OK_C = 0;OK_D=0;OK_E=0;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(pid_t.Kp);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_A){
                                              pid_t.Kp = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:
                                          if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;OK_A=0;OK_C=0;OK_D=0;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(pid_t.Ki);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              pid_t.Ki = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;OK_A=0;OK_C=0;OK_D=0;OK_E=0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 2;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          if(P2){
                                             P2 = 0;
                                             I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          }
                                          if (Button(&PORTA, 2, 200, 0) && !OK_C){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_C = 1;OK_A=0;OK_B=0;OK_D=0;OK_E=0;
                                                  enC_line_inc = 3;
                                                  Save_EncoderValue(pid_t.Kd);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_C){
                                              pid_t.Kd = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_C = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 3;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu     ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp:=     ");
                                          sprintf(txt4,"%3d",pid_t.Kp);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki:=     ");
                                          sprintf(txt4,"%3d",pid_t.Ki);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd:=     ");
                                          sprintf(txt4,"%3d",pid_t.Kd);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,16,txt4);
                                     break;
                               case 4:
                                          if (Button(&PORTA, 2, 200, 0) && !OK_D){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_D = 1;OK_A=0;OK_B=0;OK_C = 0;OK_E=0;
                                                  enC_line_inc = 0;
                                                  Save_EncoderValue(pid_t.Kt);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_D){
                                              pid_t.Kt = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_D = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 0;
                                                  enC = Save_EncoderValue(enC_line_inc+4);
                                              }
                                          }
                               case 5:
                                          if (Button(&PORTA, 2, 200, 0) && !OK_E){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_E = 1;OK_A=0;OK_B=0;OK_C = 0;OK_D=0;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(DegC.Deg_OffSet);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_E){
                                              DegC.Deg_OffSet = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_E = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
                                                  enC = Save_EncoderValue(enC_line_inc+4);
                                              }
                                          }
                               case 6:
                               case 7: 
                                          if(!P2){
                                              P2 = 1;
                                              I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          }
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"*Kt");
                                          sprintf(txt4,"%4d",pid_t.Kt);
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"*C Offset");
                                          sprintf(txt4,"%4d",DegC.Deg_OffSet);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
                                     break;
                               case 8:
                               case 9:
                               case 10:
                               case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare    ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare    ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
                                     break;
                              default:   //clear screen & update cursor position
                                         I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                         Sps.State = Return;
                                         enC_line_inc = 0;
                                         enC = Save_EncoderValue(enC_line_inc);
                                         enC_last = -1;
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
                                                  while(!RA2_bit);
                                          }
                                          if(OK_A){
                                              Sps.RmpDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
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
                                                  enC_line_inc = 2;
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
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
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
                                                  while(!RA2_bit);
                                          }
                                          if(OK_A){
                                              Sps.SokDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
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
                                                  enC_line_inc = 2;
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
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
                                     break;
                          }
                break;
           case SpikeSettings:
                          if(enC > 3){
                               enC = Save_EncoderValue(3);
                          }
                          ret5:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
                                              Sps.State = TempMenu;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret5;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(Sps.SpkeDeg);
                                          }
                                          if(OK_A){
                                              Sps.SpkeDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(Sps.SpkeTmr);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              Sps.SpkeTmr = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 2;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret       ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SpikeDeg:=");
                                          sprintf(txt4,"%3d",Sps.SokDeg);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SpikeTmr:=");
                                          sprintf(txt4,"%3d",Sps.SokTmr);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"          ");
                                     break;
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
                                     break;
                          }
                break;
           case CoolSettings:
                          if(enC > 3){
                               enC = Save_EncoderValue(3);
                          }
                          ret6:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
                                              Sps.State = TempMenu;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret6;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(Sps.CoolOffDeg);
                                          }
                                          if(OK_A){
                                              Sps.CoolOffDeg = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(Sps.CoolOffTmr);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              Sps.CoolOffTmr = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 2;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"CoolDeg:=");
                                          sprintf(txt4,"%3d",Sps.CoolOffDeg);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"CoolTmr:=");
                                          sprintf(txt4,"%3d",Sps.CoolOffTmr);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
                                     break;
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
                                     break;
                          }
                break;
           case TimeSettings:
                          if(enC > 3){
                               enC = Save_EncoderValue(3);
                          }
                          ret7:
                          switch(enC){
                               case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == TimeSettings)){
                                              Sps.State = TempMenu;
                                              while(!RA2_bit);
                                              enC = 13;
                                              goto ret7;
                                          }
                               case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_A = 1;OK_B=0;
                                                  enC_line_inc = 1;
                                                  Save_EncoderValue(Sps.SerialWriteDly);
                                          }
                                          if(OK_A){
                                              Sps.SerialWriteDly = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_A = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 1;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
                                                 enC = Save_EncoderValue(enC);
                                                 OK_B = 1;OK_A=0;
                                                  enC_line_inc = 2;
                                                  Save_EncoderValue(DegC.SampleTmrSP);
                                                  while(!RA2_bit);
                                          }
                                          if(OK_B){
                                              DegC.SampleTmrSP = Get_EncoderValue();
                                              if(Button(&PORTA, 2, 200, 0)){
                                                  OK_B = 0;
                                                  while(!RA2_bit);
                                                  enC_line_inc = 2;
                                                  enC = Save_EncoderValue(enC_line_inc);
                                              }
                                          }
                               case 3:
                                          I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ser Dly:=");
                                          sprintf(txt4,"%4d",Sps.SerialWriteDly);
                                          I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,2,"'C  Dly:=");
                                          sprintf(txt4,"%4d",DegC.SampleTmrSP);
                                          I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
                                          I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
                                     break;
                              default:    //clear screen & update cursor position
                                          I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
                                          enC_line_inc = 0;
                                          enC = Save_EncoderValue(enC_line_inc);
                                          enC_last = -1;
                                     break;
                          }
                break;
           default: Sps.State = Return;
                break;
       }
       
    }
    //write to EEPROM when finnished editing settings
    if(EEWrt){
        EEWrite();
        I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Writing To EEPROM...");
        Delay_ms(1000);
        EERead();
        CalcTimerTicks(DegC.Temp_iPv);
        ResetBits();
        I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
    }

}

void ResetBits(){
  valOf     = 0;
  Sps.State = 0;
  Menu_Bit  = 0;
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
  EEWrt = 0;
  P1 = 0;
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
   Lo(pid_t.Kp)         = EEPROM_Read(0x10);
   Hi(pid_t.Kp)         = EEPROM_Read(0x11);
   Lo(pid_t.Ki)         = EEPROM_Read(0x12);
   Hi(pid_t.Ki)         = EEPROM_Read(0x13);
   Lo(pid_t.Kd)         = EEPROM_Read(0x14);
   Hi(pid_t.Kd)         = EEPROM_Read(0x15);
   Lo(DegC.Deg_OffSet)  = EEPROM_Read(0x16);
   Hi(DegC.Deg_OffSet)  = EEPROM_Read(0x17);
   pid_t.Kt             = EEPROM_Read(0x18);
   /////////////////////////////////////////////////////
   //tick values last calculated
   Lo(TempTicks.RampTick)   = EEPROM_Read(0x1A);
   Hi(TempTicks.RampTick)   = EEPROM_Read(0x1B);
   Lo(TempTicks.SoakTick)   = EEPROM_Read(0x1C);
   Hi(TempTicks.SoakTick)   = EEPROM_Read(0x1D);
   Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1E);
   Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1F);
   Lo(TempTicks.CoolTick)   = EEPROM_Read(0x20);
   Hi(TempTicks.CoolTick)   = EEPROM_Read(0x21);
   /////////////////////////////////////////////////////
   //aditional values for control
   Sps.SerialWriteDly   =  EEPROM_Read(0x22);
   DegC.SampleTmrSP     =  EEPROM_Read(0x23);
}
void EEWrite(){
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
   EEPROM_Write(0x16, Lo(DegC.Deg_OffSet));
   EEPROM_Write(0x17, Hi(DegC.Deg_OffSet));
   EEPROM_Write(0x18, pid_t.Kt);
   //////////////////////////////////////////////////////
   //TempTicks
   EEPROM_Write(0x1A, Lo(TempTicks.RampTick));
   EEPROM_Write(0x1B, Hi(TempTicks.RampTick));
   EEPROM_Write(0x1C, Lo(TempTicks.SoakTick));
   EEPROM_Write(0x1D, Hi(TempTicks.SoakTick));
   EEPROM_Write(0x1E, Lo(TempTicks.SpikeTick));
   EEPROM_Write(0x1F, Hi(TempTicks.SpikeTick));
   EEPROM_Write(0x20, Lo(TempTicks.CoolTick));
   EEPROM_Write(0x21, Hi(TempTicks.CoolTick));
   //////////////////////////////////////////////////////
   //Aditional vlaues added to control
    EEPROM_Write(0x22, Sps.SerialWriteDly);
    EEPROM_Write(0x23, DegC.SampleTmrSP);
    /////////////////////////////////////////////////////
    //stall for 100ms to allow write to finnish
   Delay_ms(100);
}