/*
*Max31855j chipset for jtype thermocouple
*spi 1
*/
#include "Config.h"


const float dec[] = {0.00,0.25,0.5,0.75};
/////////////////////////////////////////
//SPI_ Pin
sbit Chip_Select at LATC1_bit;
sbit Chip_Select_Direction at TRISC1_bit;
/////////////////////////////////////////
//variables
struct Temp DegC;
char txt8[5];
////////////////////////////////////////
//functions

void ConfigSpi(){
 // TMR2ON_bit = on;
 // SSP1IE_bit = on;
 // SSP1IP_bit = on;
 // SSP1IF_bit = on;
  Chip_Select_Direction = 0;             // Set CS# pin as Output
  Chip_Select = 1;                       // Deselect DAC
  //SPI1_Init_Advanced(_SPI_MASTER_TMR2, _SPI_DATA_SAMPLE_END, _SPI_CLK_IDLE_HIGH, _SPI_HIGH_2_LOW);
  SPI2_Init_Advanced(_SPI_MASTER_OSC_DIV16 ,
                     _SPI_DATA_SAMPLE_END,
                     _SPI_CLK_IDLE_LOW,
                     _SPI_HIGH_2_LOW);
  SPI_Set_Active(&SPI2_Read, &SPI2_Write);
}
float ReadMax31855J(){
    Chip_Select = 0;
      DegC.TempBuff[0] = SPI2_Read(0);  //15-8
      DegC.TempBuff[1] = SPI2_Read(0);  //7-0
 //     DegC.TempBuff[2] = SPI2_Read(0);  //16-8
 //     DegC.TempBuff[3] = SPI2_Read(0);  //7-0
    Chip_Select = 1;
    return GetTemp();//DegC.Temp_SP;
}

float GetTemp(void){
float ftemp;
float fdec;
static int Tmp;
static int sign;
static int decimal;
int TConnect;

    TConnect = DegC.TempBuff[1] & 0x04;
    if(TConnect != 0)
        return -1.0;//TConnect;

    decimal = (DegC.TempBuff[1] & 0x30)>>4;
    fdec = dec[decimal];
    Tmp  =  DegC.TempBuff[0] & 0x7f;
    Tmp  =  Tmp<<8;
    Tmp  =  Tmp  | (DegC.TempBuff[1] & 0xe0);
    Tmp  =  (Tmp >> 6) & 0x03ff;
    ftemp =  (float)Tmp + fdec;

    return ftemp;
}