 #ifndef CALCS_H
 #define CALCS_H
 
#include "Config.h"

//10 * 100 = 1000 cannot calc all in 1 as 16bit int fo result = 65535
#define ten_msec_multiplier 100
#define msec_multiplier 10

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