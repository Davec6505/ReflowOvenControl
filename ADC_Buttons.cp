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
 unsigned int Deg_OffSet;
 unsigned int LastDeg;
 float Temp_fPv;
 int Temp_iPv;
 unsigned int xVal;
 uint8_t Deg_decimal;
 short sampleTimer;
 short pidTimer;
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
 short sample_tmr;
 short Kt;
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



 void CalcTimerTicks(int iPv);
#line 1 "c:/users/git/reflowovencontrol/encoder.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 9 "c:/users/git/reflowovencontrol/encoder.h"
sbit Aphase at RB6_bit;
sbit Bphase at RB7_bit;
sbit EncSW at RA2_bit;






typedef struct _enc{
 uint8_t codePrevNext;
 int8_t storeSW;
 int16_t cntr;
 int8_t val;
 uint8_t ROR;
 uint8_t layer_value[10];
 uint8_t layer_cnt;
}enc_Cnt;




void Init_Encoder(uint8_t rotate_value);
void Encode(void);
uint8_t _SW(void);
int8_t SW_Store(void);
int8_t read_rotary();
int16_t Get_EncoderValue(void);
uint16_t Save_EncoderValue(int16_t new_val);
#line 1 "c:/users/git/reflowovencontrol/adc_buttons.h"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 23 "c:/users/git/reflowovencontrol/config.h"
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
void SetUp_IOCxInterrupts();
void Set_Priority();
void EI();
void DI();
void ClearAll();
unsigned long HWMul(unsigned int adcVal,unsigned int multiplicand);
void DoTime();
void WriteDataOut();
#line 13 "c:/users/git/reflowovencontrol/adc_buttons.h"
enum StatesOfControl{
 Return = 1,
 TempMenu,
 PIDMenu,
 RampSettings,
 SoakSettings,
 SpikeSettings,
 CoolSettings,
 KpSettings,
 KiSettings,
 KdSettings,
 KtimeSettings
};


extern unsigned char B;
extern sbit Menu_Bit;
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
extern sbit StartCycle;
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



void RstEntryBits();
void SampleButtons();
void ResetBits();
void EERead();
void EEWrite();
#line 5 "C:/Users/GIT/ReflowOvenControl/ADC_Buttons.c"
static unsigned int enC,enC_last,enC_line_inc,enC_line_last,enC_line_edit;
unsigned char txt4_[6];
static unsigned char B;
static unsigned char B_;
static unsigned int valOf;
static bit P0,P1,P2,P3;


sbit Menu_Bit at B.B0;
sbit OK_Bit at B.B1;
sbit ENT_Bit at B.B2;
sbit OFF_Bit at B.B3;
sbit EEWrt at B.B4;



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



void RstEntryBits(){
 P0 = 0;
 P2 = 0;
 enC = -1;
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
}
void SampleButtons(){
static unsigned int i;




 if(Menu_Bit){
 if(!P0 && (enC != 0)){
 P0 = 1;
 enC = 0;
 enC = Save_EncoderValue(enC);
 enC_line_inc = 0;
 enC_last = -1;
 }

 if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
 enC = Get_EncoderValue();

 if(enC < 0 || enC > 65000){
 enC = 0;
 enC = Save_EncoderValue(enC);
 }

 if(enC_last != enC){
 enC_last = enC;
 if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E){
 I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
 enC_line_inc = enC % 4 + 1;
 enC_line_last = enC_line_inc;
 I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
 enC_line_edit = enC_line_inc;
 }
 }

 }

 if(Menu_Bit){


 if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
 I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15," ");
 else{
 P1 = 1;
 I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15,"@");
 }
#line 99 "C:/Users/GIT/ReflowOvenControl/ADC_Buttons.c"
 state:
 switch(Sps.State){
 case Return: if(enC > 3){
 enC = Save_EncoderValue(3);
 }
 close:
 switch(enC){
 case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
 Ok_Bit = 1;
 enC = 13;
 goto close;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
 Sps.State = TempMenu;
 enC = Save_EncoderValue(0);
 goto state;
 }

 case 2: if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
 case 5:
 case 6:
 case 7: I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
 break;
 case 8:
 case 9:
 case 10:
 case 11: I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
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
 case 0: if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
 Sps.State = Return;
 enC = 13;
 goto ret1;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
 Sps.State = RampSettings;
 enC = Save_EncoderValue(0);
 goto state;
 }
 case 2: if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
 Sps.State = SoakSettings;
 enC = Save_EncoderValue(0);
 goto state;
 }
 case 3: if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
 Sps.State = SpikeSettings;
 enC = Save_EncoderValue(0);
 goto state;
 }
 I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
 break;
 case 4: if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
 Sps.State = CoolSettings;
 enC = Save_EncoderValue(0);
 goto state;
 }
 case 5:
 case 6:
 case 7: I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
 break;
 case 8:
 case 9:
 case 10:
 case 11: I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
 break;
 default:
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
 enC_line_inc = 0;
 Save_EncoderValue(DegC.Deg_OffSet);
 while(!RA2_bit);
 }
 if(OK_E){
 DegC.Deg_OffSet = Get_EncoderValue();
 if(Button(&PORTA, 2, 200, 0)){
 OK_E = 0;
 while(!RA2_bit);
 enC_line_inc = 0;
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
 sprintf(txt4,"%3d",pid_t.Kt);
 I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4);
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"*C Offset");
 sprintf(txt4,"%3d",DegC.Deg_OffSet);
 I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
 break;
 case 8:
 case 9:
 case 10:
 case 11: I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare    ");
 I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare    ");
 I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
 I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
 break;
 default:
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
 case 0: if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
 Sps.State = TempMenu;
 while(!RA2_bit);
 enC = 13;
 goto ret3;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
 case 2: if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
 default:
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
 case 0: if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
 Sps.State = TempMenu;
 while(!RA2_bit);
 enC = 13;
 goto ret4;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
 case 2: if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
 default:
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
 case 0: if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
 Sps.State = TempMenu;
 while(!RA2_bit);
 enC = 13;
 goto ret5;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
 case 2: if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
 default:
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
 case 0: if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
 Sps.State = TempMenu;
 while(!RA2_bit);
 enC = 13;
 goto ret6;
 }
 case 1: if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
 case 2: if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
 default:
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

 if(EEWrt){
 EEWrite();
 I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Writing To EEPROM...");
 Delay_ms(1000);
 EERead();
 CalcTimerTicks(DegC.Temp_iPv);
 ResetBits();
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
 }

}

void ResetBits(){
 valOf = 0;
 Sps.State = 0;
 Menu_Bit = 0;
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
 EEWrt = 0;
 P1 = 0;
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
  ((char *)&DegC.Deg_OffSet)[0]  = EEPROM_Read(0x16);
  ((char *)&DegC.Deg_OffSet)[1]  = EEPROM_Read(0x17);
 pid_t.Kt = EEPROM_Read(0x18);


  ((char *)&TempTicks.RampTick)[0]  = EEPROM_Read(0x1A);
  ((char *)&TempTicks.RampTick)[1]  = EEPROM_Read(0x1B);
  ((char *)&TempTicks.SoakTick)[0]  = EEPROM_Read(0x1C);
  ((char *)&TempTicks.SoakTick)[1]  = EEPROM_Read(0x1D);
  ((char *)&TempTicks.SpikeTick)[0]  = EEPROM_Read(0x1E);
  ((char *)&TempTicks.SpikeTick)[1]  = EEPROM_Read(0x1F);
  ((char *)&TempTicks.CoolTick)[0]  = EEPROM_Read(0x20);
  ((char *)&TempTicks.CoolTick)[1]  = EEPROM_Read(0x21);

}
void EEWrite(){

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
 EEPROM_Write(0x16,  ((char *)&DegC.Deg_OffSet)[0] );
 EEPROM_Write(0x17,  ((char *)&DegC.Deg_OffSet)[1] );
 EEPROM_Write(0x18, pid_t.Kt);


 EEPROM_Write(0x1A,  ((char *)&TempTicks.RampTick)[0] );
 EEPROM_Write(0x1B,  ((char *)&TempTicks.RampTick)[1] );
 EEPROM_Write(0x1C,  ((char *)&TempTicks.SoakTick)[0] );
 EEPROM_Write(0x1D,  ((char *)&TempTicks.SoakTick)[1] );
 EEPROM_Write(0x1E,  ((char *)&TempTicks.SpikeTick)[0] );
 EEPROM_Write(0x1F,  ((char *)&TempTicks.SpikeTick)[1] );
 EEPROM_Write(0x20,  ((char *)&TempTicks.CoolTick)[0] );
 EEPROM_Write(0x21,  ((char *)&TempTicks.CoolTick)[1] );
 Delay_ms(100);
}
