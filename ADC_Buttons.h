#ifndef ADC_BUTTONS_H
#define ADC_BUTTONS_H

#include "Config.h"
////////////////////////////////////////
//defines
#define OK    1
#define DEC   2
#define INC   3
#define ENTER 4
///////////////////////////////////////
//structs, unions & enums
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
////////////////////////////////////////////////////
//the various Setpoints for ramp soak
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

////////////////////////////////////////
//function prototypes
void RstEntryBits();
void SampleButtons();
void ResetBits();
void EERead();
void EEWrite();
#endif


///////////////////////////////////////////////////////////////////////////
//All Debug code below
           /*sprintf(txt4_,"%5u",enC_line_inc);
             I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4_);
             sprintf(txt4_,"%5u",enC);
             I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4_);*/