#ifndef CONFIG_H
#define CONFIG_H

#include <stdint.h>
#include "IRQs.h"
#include "I2C_Lcd.h"
#include "Max31855J.h"
#include "PID.h"
#include "Calcs.h"
#include "Encoder.h"
#include "ADC_Buttons.h"
#include "built_in.h"
///////////////////////////////////////////
//defines
#define pulseLATC2 500
#define RevADC 1023
#define ServoSub 1500
#define ServoPls 4
#define PhaseOff 17640
///////////////////////////////////////////
//enums  & structs
extern enum swt{off,on};



////////////////////////////////////////////
//variable declerations
extern unsigned char txt1[6];
extern unsigned char txt2[5];
extern unsigned char txt3[5];
extern unsigned char txt4[5];
extern unsigned char txt5[4];
extern unsigned char txt6[4];
///////////////////////////////////////////
//constants
extern const unsigned int mulFact = 10;
///////////////////////////////////////////
//function prototypes

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
void WriteDataOut();
#endif

/////////////////////////////////////////////////
//Debug code
        /*if(phase_cntr_last != Phs.PhaseCntr){
          phase_cntr_last = Phs.PhaseCntr;
          sprintf(txt7,"%2u",Phs.PhaseCntr); //Phase counter
          I2C_LCD_Out(LCD_01_ADDRESS,4,14,"Phs:=");
          I2C_LCD_Out(LCD_01_ADDRESS,4,19,txt7);
       }*/
       
       /*if(!Menu_Bit){
         sprintf(txt7,"%2u",DegC.sampleTimer);
         I2C_LCD_Out(LCD_01_ADDRESS,4,14,"Cyc:=");
         I2C_LCD_Out(LCD_01_ADDRESS,4,19,txt7);
       }*/