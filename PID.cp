#line 1 "C:/Users/GIT/ReflowOvenControl/PID.c"
#line 1 "c:/users/git/reflowovencontrol/pid.h"
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
 unsigned short sampleTimer;
 unsigned short SampleTmrSP;
};

extern struct Temp DegC = {
 0,
 {0,0,0,0,0},
 0,
 0,
 0,
 0.0,
 0,
 0,
 0,
 0
};



void ConfigSpi();
float ReadMax31855J();
float GetTemp();
#line 1 "c:/users/git/reflowovencontrol/pid.h"
#line 1 "c:/users/git/reflowovencontrol/calcs.h"
#line 1 "c:/users/git/reflowovencontrol/config.h"
#line 10 "c:/users/git/reflowovencontrol/calcs.h"
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
 TimeSettings,
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
unsigned int RmpSec;
unsigned int SokDeg;
unsigned int SokTmr;
unsigned int SokSec;
unsigned int SpkeDeg;
unsigned int SpkeTmr;
unsigned int SpkeSec;
unsigned int CoolOffDeg;
unsigned int CoolOffTmr;
unsigned int CoolOffSec;
unsigned char State;
unsigned short SerialWriteDly;
}Spts;

extern enum StatesOfControl Cntrl;
extern struct Buttons But;
extern Spts Sps;



void RstEntryBits();
void SampleButtons();
void ResetBits();
void EERead();
void EEWrite();
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for pic/include/built_in.h"
#line 23 "c:/users/git/reflowovencontrol/config.h"
extern enum swt{off,on};



extern unsigned char txt1[6];
extern unsigned char txt2[5];
extern unsigned char txt3[5];
extern unsigned char txt4[5];
extern unsigned char txt5[4];
extern unsigned char txt6[4];

extern unsigned char Bits;


extern const unsigned int mulFact = 10;


void I2C1_TimeoutCallback(char errorCode);

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
void WriteStart();
void WriteFin();
void WriteDataOut();
void RstLocals();
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
#line 3 "C:/Users/GIT/ReflowOvenControl/PID.c"
struct HWMul Mul;

void PID_Init( _PID *PID_t,int kp,int ki,int kd,int offst,int Max,int Min,dirOfCntl Dirct,typeOfCntrl Cntl){
 PID_t->Kp = kp;
 PID_t->Ki = ki;
 PID_t->Kd = kd;
 PID_t->offSet = offst;
 PID_t->maxOut = Max;
 PID_t->minOut = Min;
 PID_t->Direction = Dirct;
 PID_t->LastDiff = 0;
}

void PID_Calc(_PID *PID_t,int Sp,int Pv){



 PID_t->error = Sp - Pv;
 PID_t->errorP = (int)S_HWMul(PID_t->error,PID_t->Kp);



 PID_t->InterimI += (int)S_HWMul(PID_t->error,PID_t->Ki);
 if(PID_t->InterimI > PID_t->maxOut)PID_t->InterimI = PID_t->maxOut;
 if(PID_t->InterimI <= PID_t->minOut)PID_t->InterimI = PID_t->minOut;


 PID_t->diffVal = Pv - PID_t->LastDiff;
 PID_t->diffVal = (int)S_HWMul(PID_t->diffVal,PID_t->Kd);
 PID_t->LastDiff = Pv;


 PID_t->Mv = PID_t->errorP + PID_t->InterimI + PID_t->diffVal + PID_t->offSet;


 if(PID_t->Mv > PID_t->maxOut)PID_t->Mv = PID_t->maxOut;
 if(PID_t->Mv <= PID_t->minOut)PID_t->Mv = PID_t->minOut;




}

long S_HWMul(int valA,int valB){
static long res;

 asm{

 MOVF FARG_S_HWMul_valA+0,0 ;
 MULWF FARG_S_HWMul_valB+0 ;
 MOVFF PRODH,S_HWMul_res_L0+1 ;
 MOVFF PRODL,S_HWMul_res_L0+0 ;

 MOVF FARG_S_HWMul_valA+1,0 ;
 MULWF FARG_S_HWMul_valB+1 ;
 MOVFF PRODH,S_HWMul_res_L0+3 ;
 MOVFF PRODL,S_HWMul_res_L0+2 ;


 MOVF FARG_S_HWMul_valA+0,0 ;
 MULWF FARG_S_HWMul_valB+1 ;

 MOVF PRODL,0 ;
 ADDWF S_HWMul_res_L0+1 ;
 MOVF PRODH,0 ;
 ADDWFC S_HWMul_res_L0+2 ;
 CLRF 0 ;
 ADDWFC S_HWMul_res_L0+3 ;


 MOVF FARG_S_HWMul_valA+1,0 ;
 MULWF FARG_S_HWMul_valB+0 ;

 MOVF PRODL,0 ;
 ADDWF S_HWMul_res_L0+1 ;
 MOVF PRODH,0 ;
 ADDWFC S_HWMul_res_L0+2 ;
 CLRF 0 ;
 ADDWFC S_HWMul_res_L0+3 ;


 BTFSS FARG_S_HWMul_valB+1,7 ;
 BRA SIGN_val ;
 MOVF FARG_S_HWMul_valA+0,0 ;
 SUBWF S_HWMul_res_L0+2 ;
 MOVF FARG_S_HWMul_valA+1,0 ;
 SUBWFB S_HWMul_res_L0+3 ;



 SIGN_val:
 BTFSS FARG_S_HWMul_valA+1,7 ;
 BRA CONT ;
 MOVF FARG_S_HWMul_valB+0,0 ;
 SUBWF S_HWMul_res_L0+2 ;
 MOVF FARG_S_HWMul_valB+1,0 ;
 SUBWFB S_HWMul_res_L0+3 ;

 CONT:

 }

 return res;


}
