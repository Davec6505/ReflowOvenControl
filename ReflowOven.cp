#line 1 "C:/Users/GIT/ReflowOvenControl/ReflowOven.c"
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
#line 1 "c:/users/git/reflowovencontrol/config.h"
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
void ResetBits();
void SavedVals();
void doOFFBitoff();
void EERead();
void EEWrite();
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 22 "c:/users/git/reflowovencontrol/config.h"
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
#line 9 "C:/Users/GIT/ReflowOvenControl/ReflowOven.c"
unsigned char LCD_01_ADDRESS = 0x4E;
char *test = "Starting up";


struct Time tmr;
struct Buttons But;
struct Phasing Phs;
_PID pid_t;
Spts Sps;

static unsigned char Bits;
static unsigned int phase_cntr_last;

sbit SetPtSet at Bits.B0;
sbit SetCoolBit at Bits.B1;
sbit RstTmr at Bits.B2;
sbit FinCycle at Bits.B3;
sbit WriteData at Bits.B4;

static bit xDetect,pHase,Serv,buttDetect,TempBit,pidBit;
char PhaseCnt;

unsigned char txt1[6];
unsigned char txt2[5];
unsigned char txt3[5];
unsigned char txt4[5];
unsigned char txt5[9];
unsigned char txt6[4];
unsigned char txt7[3];

const unsigned int mulFact = 18;


void main() {
 int a;
 I2Cxx = I2C1;
 ConfPic();
 ADC_Init();
 UART1_Init(115200);

 I2C1_Init(100000);
 I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle);
 Delay_ms(100);



 PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-1000,'+',_PID);
 Uart1_En();
 Set_Priority();
 ConfigSpi();
 InitTimer0();
 InitTimer1();

 InitTimer3();
 InitTimer5();
 SetUp_IOCxInterrupts();
 ResetBits();
 ClearAll();

 I2C_LCD_init(LCD_01_ADDRESS,_2Line);
 Delay_ms(100);
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);
 I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Starting UP");
 Delay_ms(2000);
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
 Delay_ms(200);
 EI();
 Delay_ms(100);
 wait = off;
 DegC.Temp_iPv = 0;
 EERead();
 EEWrt = on;
 tmr.sec = 0;
 Bits = 0;
 Menu_Bit = 0;
 Ok_Bit = 0;
 CalcTimerTicks();
 phase_cntr_last = Phs.PhaseCntr;
 while(1){
 long Test;
 static unsigned int TempTicPlaceholder;


 LATB5_bit = Menu_Bit;
 if(Menu_Bit)
 SampleButtons();

 if (!Menu_Bit && !Ok_Bit && Button(&PORTA, 2, 200, 0)){
 Menu_Bit = on;
 I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
 }


 if(!Menu_Bit){

 if(phase_cntr_last != Phs.PhaseCntr){
 phase_cntr_last = Phs.PhaseCntr;
 sprintf(txt7,"%2u",Phs.PhaseCntr);
 I2C_LCD_Out(LCD_01_ADDRESS,4,14,"Phs:=");
 I2C_LCD_Out(LCD_01_ADDRESS,4,19,txt7);
 }


 if((RA3_Bit)&&(!FinCycle)) DoTime();


 if(tmr.SecNew != tmr.sec){
 if(!OK_Bit){
 sprintf(txt2,"%-2d",tmr.sec);
 I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
 }
 tmr.SecNew = tmr.sec;
 }


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
 tmr.tenMilli = 0;
 TempTicks.tickActual++;
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






 switch(Phs.PhaseCntr){
 case 1:
 Phs.an0_ = (unsigned int)pid_t.Mv;
 if(Phs.an0_ < 1)Phs.an0_ = 1;
 Phs.an0_ =  1023  - Phs.an0_;
 if(Phs.an0_ >= 980)Phs.an0_ = 980;
 break;
 case 2:

 Phs.an1_ =  1500  + pid_t.Mv;
 if(Phs.an1_ > 1500)Phs.an1_ = 1500;
 break;
 case 3:
 if(Phs.olDan0_ != Phs.an0_){
 Phs.an0_0 = (unsigned int)S_HWMul(Phs.an0_,mulFact);
#line 227 "C:/Users/GIT/ReflowOvenControl/ReflowOven.c"
 Phs.olDan0_ = Phs.an0_;
 }

 break;
 case 4:
 if(Phs.olDan1_ != Phs.an1_){
 Phs.an1_1 = (unsigned int)S_HWMul(Phs.an1_, 4 );
#line 236 "C:/Users/GIT/ReflowOvenControl/ReflowOven.c"
 Phs.olDan1_ = Phs.an1_;
 }
 break;
 case 5:
 if(!TempBit){
 DegC.sampleTimer++;
 if(!Menu_Bit){
 sprintf(txt7,"%2u",DegC.sampleTimer);
 I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Clk:=");
 I2C_LCD_Out(LCD_01_ADDRESS,4,6,txt7);
 }
 TempBit = on;
 if(DegC.sampleTimer == 20){
 DegC.Temp_fPv = ReadMax31855J();
 if(!Menu_Bit){
 sprintf(txt5,"%3.2f",DegC.Temp_fPv);
 I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
 I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
 I2C_LCD_Out(LCD_01_ADDRESS,3,11,"'C");
 }
 }
 }
 break;
 case 6:
 if(!pidBit){
 pidBit = on;
 if(DegC.sampleTimer >= 20){
 PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
 if(!Menu_Bit){
 sprintf(txt4,"%5d",pid_t.Mv);
 I2C_LCD_Out(LCD_01_ADDRESS,2,5,txt4);
 }
 }
 }
 break;
#line 286 "C:/Users/GIT/ReflowOvenControl/ReflowOven.c"
 default:
 if(Phs.UartWriter > 8){
 Phs.UartWriter = 0;
 WriteData = off;
 }
 if(DegC.sampleTimer >= 20)DegC.sampleTimer = 0;
 if(TempBit)TempBit = off;
 if(pidBit) pidBit = off;
 Phs.PhaseCntr = 1;
 break;
 }

 }

}




void HighPrioity() iv 0x0008 ics ICS_AUTO {
 High_Priority();
}

void Tmr1_Int() iv 0x0018 ics ICS_AUTO {
 Low_Priority();
}
