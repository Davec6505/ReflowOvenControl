#ifndef ADC_BUTTONS_H
#define ADC_BUTTONS_H

#include "Config.h"
////////////////////////////////////////
//defines
#define OK    ((But.an2_ >= 600)&&(But.an2_ <= 603))
#define DEC   ((But.an2_ >= 803)&&(But.an2_ <= 807))
#define INC   ((But.an2_ >= 400)&&(But.an2_ <= 403))
#define ENTER ((But.an2_ >= 670)&&(But.an2_ <= 673))
///////////////////////////////////////
//structs, unions & enums
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
////////////////////////////////////////////////////
//the various Setpoints for ramp soak
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

////////////////////////////////////////
//function prototypes
void SampleButtons();
unsigned int IncValues(unsigned int Val);
unsigned int IncDec(unsigned int Val);
void ResetBits();
void SavedVals();
void doOFFBitoff();
void EERead();
void EEWrite();
#endif