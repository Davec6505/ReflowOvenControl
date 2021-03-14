 #ifndef CALCS_H
 #define CALCS_H
 
#include "Config.h"

struct Ticks{
unsigned int Ambient;
unsigned int RampTick;
unsigned int SoakTick;
unsigned int SpikeTick;
unsigned int CoolTick;
unsigned int tickActual;
};
 
extern struct Ticks TempTicks;
 
 ///////////////////////////////////////////
 //function prototypes
 void CalcTimerTicks(int iPv);
 #endif