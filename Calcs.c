/***************************************************************************
 * Calculation to get mSec incriment of DegC *
 * RmpTmr = RmpSec * 1000   --- this is done in 2 stages 1st *100 || 2nd * 10
 * DegIncriment = RmpTmr / Deg_setpoint - present_deg
 **************************************************************************/

#include "Calcs.h"


struct Ticks TempTicks;
unsigned int temp;

void CalcTimerTicks(int iPv){
     TempTicks.Ambient = iPv;
    //////////////////////////////////////////////////////
    //calc the ramp timer Ticks in 10 milli seconds
     Sps.RmpTmr = S_HWMul(Sps.RmpSec, ten_msec_multiplier);
     temp = Sps.RmpDeg - TempTicks.Ambient;
     TempTicks.RampTick = Sps.RmpTmr / temp;
     TempTicks.RampTick =  S_HWMul(TempTicks.RampTick,msec_multiplier);
     ////////////////////////////////////////////////////
     //calculate the soak timer Ticks in 10 milli seconds
     Sps.SokTmr = S_HWMul(Sps.SokSec,ten_msec_multiplier);
     temp = Sps.SokDeg - Sps.RmpDeg;
     TempTicks.SoakTick =  Sps.SokTmr / temp;
     TempTicks.SoakTick =  S_HWMul(TempTicks.SoakTick,msec_multiplier);
     ////////////////////////////////////////////////////
     //calculate the spike Ticks in 10 milli seconds
     Sps.SpkeTmr = S_HWMul(Sps.SpkeSec,ten_msec_multiplier);
     temp = Sps.SpkeDeg - Sps.SokDeg;
     TempTicks.SpikeTick =  Sps.SpkeTmr / temp;
     TempTicks.SpikeTick =  S_HWMul(TempTicks.SpikeTick,msec_multiplier);
     /////////////////////////////////////////////////////
     //calculate the cool Ticks in 10 milli seconds
     Sps.CoolOffTmr = S_HWMul(Sps.CoolOffSec,ten_msec_multiplier);
     temp =  Sps.SpkeDeg -Sps.CoolOffDeg;
     TempTicks.CoolTick = Sps.CoolOffTmr / temp;
     TempTicks.CoolTick =  S_HWMul(TempTicks.CoolTick,msec_multiplier);
 
 }