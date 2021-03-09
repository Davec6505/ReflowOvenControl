#ifndef MAX31855J_H
#define MAX31855J_H

#include "Config.h"

//////////////////////////////////////////
//defines


/////////////////////////////////////////
//structs & enums & constants
struct Temp{
 unsigned char SPIindx;
 unsigned short TempBuff[5];
 unsigned int Deg_Sp;
 unsigned int LastDeg;
 float Temp_fPv;
 int   Temp_iPv;
 unsigned int xVal;
 uint8_t Deg_decimal;
 short sampleTimer;
 unsigned int Sample_SPI;
};

extern struct Temp DegC;

////////////////////////////////////////
//function prototypes
void ConfigSpi();
float ReadMax31855J();
float GetTemp();



#endif