#ifndef IRQS_H
#define IRQS_H

#include "Config.h"



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

#endif
