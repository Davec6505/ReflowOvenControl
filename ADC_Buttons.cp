#line 1 "C:/Users/GIT/ReflowOvenControl/ADC_Buttons.c"
#line 1 "c:/users/git/reflowovencontrol/adc_buttons.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/stdint.h"




typedef signed char int8_t;
typedef signed int int16_t;
typedef signed long int int32_t;


typedef unsigned char uint8_t;
typedef unsigned int uint16_t;
typedef unsigned long int uint32_t;


typedef signed char int_least8_t;
typedef signed int int_least16_t;
typedef signed long int int_least32_t;


typedef unsigned char uint_least8_t;
typedef unsigned int uint_least16_t;
typedef unsigned long int uint_least32_t;



typedef signed char int_fast8_t;
typedef signed int int_fast16_t;
typedef signed long int int_fast32_t;


typedef unsigned char uint_fast8_t;
typedef unsigned int uint_fast16_t;
typedef unsigned long int uint_fast32_t;


typedef signed int intptr_t;
typedef unsigned int uintptr_t;


typedef signed long int intmax_t;
typedef unsigned long int uintmax_t;
#line 1 "c:/users/git/reflowovencontrol/irqs.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 8 "c:/users/git/reflowovencontrol/irqs.h"
extern bit wait;


struct Time{
 unsigned int I_Dlys;
 unsigned int millis;
 unsigned int tenMilli;
 unsigned int ms;
 unsigned int ten_ms;
 unsigned int sec;
 unsigned int min;
 unsigned int TenMsNew;
 unsigned int SecNew;
 unsigned int MinNew;
};
struct Phasing{
 unsigned char UartWriter;
 unsigned char pwmOut;
 unsigned char PhaseCntr;
 unsigned char PhasePulsCntr;
 unsigned int PulseDly;
 unsigned int an0_;
 unsigned int olDan0_;
 unsigned int _olDan0_;
 unsigned int an0_0;
 unsigned int an1_;
 unsigned int olDan1_;
 unsigned int _olDan1_;
 unsigned int an1_1;
};

extern struct Time tmr;
extern struct Phasing Phs;

void High_Priority();
void Low_Priority();
void Serial();
void TMR3();
void DoTime();
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/i2c_lcdrm/uses/i2c_lcd.h"
#line 55 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/packages/i2c_lcdrm/uses/i2c_lcd.h"
typedef enum{
 _LCD_FIRST_ROW = 1,
 _LCD_SECOND_ROW,
 _LCD_THIRD_ROW,
 _LCD_FOURTH_ROW,
 _LCD_CLEAR,
 _LCD_RETURN_HOME,
 _LCD_CURSOR_OFF,
 _LCD_UNDERLINE_ON,
 _LCD_BLINK_CURSOR_ON,
 _LCD_MOVE_CURSOR_LEFT,
 _LCD_MOVE_CURSOR_RIGHT,
 _LCD_TURN_ON,
 _LCD_TURN_OFF,
 _LCD_SHIFT_LEFT,
 _LCD_SHIFT_RIGHT,
 _LCD_INCREMENT_NO_SHIFT
}Cmd_Type;
extern Cmd_Type Cmd;

typedef enum{
 I2C1 = 1,
 I2C2,
 I2C3,
 I2C4,
 I2C5
}I2C_No;
extern I2C_No I2Cx;

typedef enum{
 _1Line = 1,
 _2Line,
}LCD_Type;
extern LCD_Type DispLines;




extern unsigned int I2Cxx;
extern unsigned char LCD_01_ADDRESS;


  unsigned char  I2C_PCF8574_Write( unsigned char  addr, unsigned char  Data);
 void I2C_LCD_putcmd( unsigned char  addr,  unsigned char  dta, unsigned char  cmdtype);
 void I2C_LCD_goto( unsigned char  addr, unsigned char  row,  unsigned char  col);
 void I2C_Lcd_Cmd( unsigned char  addr,Cmd_Type cmd, unsigned char  col);
 void I2C_LCD_putch( unsigned char  addr,  unsigned char  dta);
 void I2C_LCD_Out( unsigned char  addr,  unsigned char  row,  unsigned char  col,  unsigned char  *s);
 void I2C_Lcd_Chr( unsigned char  addr,  unsigned char  row,  unsigned char  col,  unsigned char  out_char);
void I2C_LCD_init( unsigned char  addr,LCD_Type DispLines);
#line 1 "c:/users/git/reflowovencontrol/max31855j.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 12 "c:/users/git/reflowovencontrol/max31855j.h"
struct Temp{
 unsigned char SPIindx;
 unsigned short TempBuff[5];
 unsigned int Deg_Sp;
 unsigned int LastDeg;
 float Temp_fPv;
 int Temp_iPv;
 unsigned int xVal;
 uint8_t Deg_decimal;
 short sampleTimer;
 unsigned int Sample_SPI;
};

extern struct Temp DegC;



void ConfigSpi();
float ReadMax31855J();
float GetTemp();
#line 1 "c:/users/git/reflowovencontrol/pid.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 12 "c:/users/git/reflowovencontrol/pid.h"
typedef enum pidDir{
 Direct_PID = '+',
 Reverse_PID = '-'
}dirOfCntl;

typedef enum pidControl{
 _P = 1 ,
 _PI ,
 _PID
}typeOfCntrl;

struct HWMul {
 unsigned int factor;
 unsigned int an0Lo;
 unsigned int an0Hi;
 unsigned long res;
};
extern struct HWMul Mul;
typedef struct _PID_{

 int Kp;
 int Ki;
 int Kd;
 int offSet;
 char Direction;
 char CntrlType[3];

 int InterimI;
 int LastDiff;
 int maxOut;
 int minOut;
 int Mv;
 int error;
 int errorP;
 int diffVal;
 long LastCalcVal;

}_PID;
extern dirOfCntl Dir_;
extern typeOfCntrl Cntrl;
extern _PID pid_t;






void PID_Init( _PID *PID_t,
 int kp,
 int ki,
 int kd,
 int offst,
 int Max,
 int Min,
 dirOfCntl Dirct,
 typeOfCntrl Cntl);

void PID_Calc(_PID *PID_t,int Sp,int Pv);
long S_HWMul(int valA,int valB);
#line 1 "c:/users/git/reflowovencontrol/calcs.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 6 "c:/users/git/reflowovencontrol/calcs.h"
struct Ticks{
unsigned int Ambient;
unsigned int RampTick;
unsigned int SoakTick;
unsigned int SpikeTick;
unsigned int CoolTick;
unsigned int tickActual;
};

extern struct Ticks TempTicks;



 void CalcTimerTicks();
#line 1 "c:/users/git/reflowovencontrol/adc_buttons.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 21 "c:/users/git/reflowovencontrol/config.h"
extern enum swt{off,on};





extern unsigned char txt1[6];
extern unsigned char txt2[5];
extern unsigned char txt3[5];
extern unsigned char txt4[5];
extern unsigned char txt5[4];
extern unsigned char txt6[4];


extern const unsigned int mulFact = 10;



void ConfPic();
void InitTimer0();
void InitTimer1();
void InitTimer2();
void InitTimer3();
void InitTimer5();
void Uart1_En();
void Set_Priority();
void EI();
void DI();
void ClearAll();
unsigned long HWMul(unsigned int adcVal,unsigned int multiplicand);
void DoTime();
void WriteDataOut();
#line 13 "c:/users/git/reflowovencontrol/adc_buttons.h"
enum StatesOfControl{Return,RampDeg,RampTm,SoakDeg,SoakTm,SpikeDeg,SpikeTm,CoolDownDeg,CoolDownTm,KP_,Ki_,Kd_};


extern unsigned char B;
extern sbit OK_Bit;
extern sbit OK_A;
extern sbit OK_B;
extern sbit OK_C;
extern sbit OK_D;
extern sbit OK_E;
extern sbit OK_F;
extern sbit OK_G;
extern sbit OK_H;
extern sbit OK_I;
extern sbit OK_J;
extern sbit OK_K;
extern sbit ENT_Bit;
extern sbit OFF_Bit;
extern sbit EEWrt;
struct Buttons{
unsigned int ButMsVal;
unsigned int ButMs;
unsigned int an2_;
unsigned int olDan2_;
unsigned int olDan2__;
unsigned char ButtState;
};


typedef struct Setpoints {
unsigned int RmpDeg;
unsigned int RmpTmr;
unsigned int SokDeg;
unsigned int SokTmr;
unsigned int SpkeDeg;
unsigned int SpkeTmr;
unsigned int CoolOffDeg;
unsigned int CoolOffTmr;
unsigned char State;
}Spts;

extern enum StatesOfControl Cntrl;
extern struct Buttons But;
extern Spts Sps;



void SampleButtons();
unsigned int IncValues(unsigned int Val);
unsigned int IncDec(unsigned int Val);
void ResetBits();
void SavedVals();
void doOFFBitoff();
void EERead();
void EEWrite();
#line 5 "C:/Users/GIT/ReflowOvenControl/ADC_Buttons.c"
unsigned char txt4_[6];
unsigned char B;
unsigned char B_;
static unsigned int valOf;


sbit OK_Bit at B.B0;
sbit ENT_Bit at B.B1;
sbit OFF_Bit at B.B2;
sbit EEWrt at B.B3;



sbit OK_A at B_.B0;
sbit OK_B at B_.B1;
sbit OK_C at B_.B2;
sbit OK_D at B_.B3;
sbit OK_E at B_.B4;
sbit OK_F at B_.B5;
sbit OK_G at B_.B6;
sbit OK_H at B_.B7;
sbit OK_I at B.B5;
sbit OK_J at B.B6;
sbit OK_K at B.B7;


enum StatesOfControl Cntrl;



unsigned int (*Fptr)(unsigned int Arg1);



void SampleButtons(){
static unsigned int i;
 But.an2_ = ADC_Read(2);
 if((! ((But.an2_ >= 400)&&(But.an2_ <= 403)) )&&(! ((But.an2_ >= 803)&&(But.an2_ <= 807)) ))But.ButMs = 500;
 if( ((But.an2_ >= 600)&&(But.an2_ <= 603)) ){
 if((!OK_Bit)&&(Sps.State!=0))Sps.State = 0;
 if((!OK_Bit)&&(Sps.State==0)) I2C_LCD_Out(LCD_01_ADDRESS,2,6,"  ");

 if(i>=900){
 SavedVals();
 i = 0;
 }else i++;


 }else i = 0;

 if(OK_Bit){
 valOf = IncValues(valOf);
 if(EEWrt)EEWrt = off;
 switch(Sps.State){
 case Return: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ret     ");

 break;
 case RampDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampDeg ");
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
 case RampTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampTm  ");
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
 case SoakDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakDeg ");
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
 case SoakTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakTm  ");
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
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
 }
 ResetBits();
 }
 if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
 Sps.State = valOf;
 if((valOf > 11)&&(valOf<50000))valOf = 11;
 else if (valOf >= 50001)valOf = 0;
 }

}

unsigned int IncValues(unsigned int Val){
static unsigned int k;
 if(( ((But.an2_ >= 400)&&(But.an2_ <= 403)) )||( ((But.an2_ >= 803)&&(But.an2_ <= 807)) )){
 if(tmr.millis > But.ButMs){
 tmr.millis = 0;
 Val = IncDec(Val);

 if(k<10)But.ButMs = 500;
 else if ((k>=10)&&(k<30)) But.ButMs = 200;
 else if ((k>=30)&&(k<100)) But.ButMs = 10;
 else But.ButMs = 1;
 k++;
 }
 }else k=0;

 return Val;
}
unsigned int IncDec(unsigned int Val ){

 if( ((But.an2_ >= 400)&&(But.an2_ <= 403)) )Val++;
 if( ((But.an2_ >= 803)&&(But.an2_ <= 807)) ) Val--;

 return Val;
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
 if(Sps.State == RampDeg) OK_A = !OK_A;
 else if(Sps.State == RampTm) OK_B = !OK_B;
 else if(Sps.State == SoakDeg) OK_C = !OK_C;
 else if(Sps.State == SoakTm) OK_D = !OK_D;
 else if(Sps.State == SpikeDeg) OK_E = !OK_E;
 else if(Sps.State == SpikeTM) OK_F = !OK_F;
 else if(Sps.State == CoolDownDeg) OK_G = !OK_G;
 else if(Sps.State == CoolDowntM) OK_H = !OK_H;
 else if(Sps.State == Kp_) OK_I = !OK_I;
 else if(Sps.State == Ki_) OK_J = !OK_J;
 else if(Sps.State == Kd_) OK_K = !OK_K;
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

  ((char *)&Sps.RmpDeg)[0]  = EEPROM_Read(0x00);
  ((char *)&Sps.RmpDeg)[1]  = EEPROM_Read(0x01);
  ((char *)&Sps.RmpTmr)[0]  = EEPROM_Read(0x02);
  ((char *)&Sps.RmpTmr)[1]  = EEPROM_Read(0x03);
  ((char *)&Sps.SokDeg)[0]  = EEPROM_Read(0x04);
  ((char *)&Sps.SokDeg)[1]  = EEPROM_Read(0x05);
  ((char *)&Sps.SokTmr)[0]  = EEPROM_Read(0x06);
  ((char *)&Sps.SokTmr)[1]  = EEPROM_Read(0x07);
  ((char *)&Sps.SpkeDeg)[0]  = EEPROM_Read(0x08);
  ((char *)&Sps.SpkeDeg)[1]  = EEPROM_Read(0x09);
  ((char *)&Sps.SpkeTmr)[0]  = EEPROM_Read(0x0A);
  ((char *)&Sps.SpkeTmr)[1]  = EEPROM_Read(0x0B);
  ((char *)&Sps.CoolOffDeg)[0]  = EEPROM_Read(0x0C);
  ((char *)&Sps.CoolOffDeg)[1]  = EEPROM_Read(0x0D);
  ((char *)&Sps.CoolOffTmr)[0]  = EEPROM_Read(0x0E);
  ((char *)&Sps.CoolOffTmr)[1]  = EEPROM_Read(0x0F);


  ((char *)&pid_t.Kp)[0]  = EEPROM_Read(0x10);
  ((char *)&pid_t.Kp)[1]  = EEPROM_Read(0x11);
  ((char *)&pid_t.Ki)[0]  = EEPROM_Read(0x12);
  ((char *)&pid_t.Ki)[1]  = EEPROM_Read(0x13);
  ((char *)&pid_t.Kd)[0]  = EEPROM_Read(0x14);
  ((char *)&pid_t.Kd)[1]  = EEPROM_Read(0x15);


  ((char *)&TempTicks.RampTick)[0]  = EEPROM_Read(0x16);
  ((char *)&TempTicks.RampTick)[1]  = EEPROM_Read(0x17);
  ((char *)&TempTicks.SoakTick)[0]  = EEPROM_Read(0x18);
  ((char *)&TempTicks.SoakTick)[1]  = EEPROM_Read(0x19);
  ((char *)&TempTicks.SpikeTick)[0]  = EEPROM_Read(0x1A);
  ((char *)&TempTicks.SpikeTick)[1]  = EEPROM_Read(0x1B);
  ((char *)&TempTicks.CoolTick)[0]  = EEPROM_Read(0x1C);
  ((char *)&TempTicks.CoolTick)[1]  = EEPROM_Read(0x1D);

}
void EEWrite(){
 I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");

 EEPROM_Write(0x00,  ((char *)&Sps.RmpDeg)[0] );
 EEPROM_Write(0x01,  ((char *)&Sps.RmpDeg)[1] );
 EEPROM_Write(0x02,  ((char *)&Sps.RmpTmr)[0] );
 EEPROM_Write(0x03,  ((char *)&Sps.RmpTmr)[1] );
 EEPROM_Write(0x04,  ((char *)&Sps.SokDeg)[0] );
 EEPROM_Write(0x05,  ((char *)&Sps.SokDeg)[1] );
 EEPROM_Write(0x06,  ((char *)&Sps.SokTmr)[0] );
 EEPROM_Write(0x07,  ((char *)&Sps.SokTmr)[1] );
 EEPROM_Write(0x08,  ((char *)&Sps.SpkeDeg)[0] );
 EEPROM_Write(0x09,  ((char *)&Sps.SpkeDeg)[1] );
 EEPROM_Write(0x0A,  ((char *)&Sps.SpkeTmr)[0] );
 EEPROM_Write(0x0B,  ((char *)&Sps.SpkeTmr)[1] );
 EEPROM_Write(0x0C,  ((char *)&Sps.CoolOffDeg)[0] );
 EEPROM_Write(0x0D,  ((char *)&Sps.CoolOffDeg)[1] );
 EEPROM_Write(0x0E,  ((char *)&Sps.CoolOffTmr)[0] );
 EEPROM_Write(0x0F,  ((char *)&Sps.CoolOffTmr)[1] );


 EEPROM_Write(0x10,  ((char *)&pid_t.Kp)[0] );
 EEPROM_Write(0x11,  ((char *)&pid_t.Kp)[1] );
 EEPROM_Write(0x12,  ((char *)&pid_t.Ki)[0] );
 EEPROM_Write(0x13,  ((char *)&pid_t.Ki)[1] );
 EEPROM_Write(0x14,  ((char *)&pid_t.Kd)[0] );
 EEPROM_Write(0x15,  ((char *)&pid_t.Kd)[1] );


 EEPROM_Write(0x16,  ((char *)&TempTicks.RampTick)[0] );
 EEPROM_Write(0x17,  ((char *)&TempTicks.RampTick)[1] );
 EEPROM_Write(0x18,  ((char *)&TempTicks.SoakTick)[0] );
 EEPROM_Write(0x19,  ((char *)&TempTicks.SoakTick)[1] );
 EEPROM_Write(0x1A,  ((char *)&TempTicks.SpikeTick)[0] );
 EEPROM_Write(0x1B,  ((char *)&TempTicks.SpikeTick)[1] );
 EEPROM_Write(0x1C,  ((char *)&TempTicks.CoolTick)[0] );
 EEPROM_Write(0x1D,  ((char *)&TempTicks.CoolTick)[1] );
 Delay_ms(100);
}
