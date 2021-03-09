#include "Calcs.h"


struct Ticks TempTicks;


void CalcTimerTicks(){
     TempTicks.Ambient = DegC.Temp_iPv;
    //////////////////////////////////////////////////////
    //calc the ramp timer Ticks in 10 milli seconds
     TempTicks.RampTick = Sps.RmpTmr;
     TempTicks.RampTick /= (Sps.RmpDeg - TempTicks.Ambient);
     TempTicks.RampTick =  S_HWMul(TempTicks.RampTick,10);
     ////////////////////////////////////////////////////
     //calculate the soak timer Ticks in 10 milli seconds
     TempTicks.SoakTick =  Sps.SokTmr  - Sps.RmpTmr;
     TempTicks.SoakTick /= ( Sps.SokDeg - Sps.RmpDeg );
     TempTicks.SoakTick =  S_HWMul(TempTicks.SoakTick,10);
     ////////////////////////////////////////////////////
     //calculate the spike Ticks in 10 milli seconds
     TempTicks.SpikeTick =  Sps.SpkeTmr - Sps.SokTmr;
     TempTicks.SpikeTick /=  (Sps.SpkeDeg - Sps.SokDeg);
     TempTicks.SpikeTick =  S_HWMul(TempTicks.SpikeTick,10);
     /////////////////////////////////////////////////////
     //calculate the cool Ticks in 10 milli seconds
     TempTicks.CoolTick = Sps.CoolOffTmr - Sps.SpkeTmr;
     TempTicks.CoolTick /= Sps.SpkeDeg - TempTicks.Ambient;
     TempTicks.CoolTick =  S_HWMul(TempTicks.CoolTick,10);
 
 }