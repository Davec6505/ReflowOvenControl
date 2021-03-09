#ifndef ENCODER_H
#define ENCODER_H

#include "Config.h"



//encoder connections
sbit Aphase at RB6_bit;
sbit Bphase at RB7_bit;
sbit EncSW  at RA2_bit;
#define DATA (PORTB & 0xC0)

#define null 0
#define CW 1
#define CCW -1

typedef struct _enc{
    uint8_t codePrevNext;
    int8_t  storeSW;
    int16_t cntr;
    int8_t  val;
    uint8_t ROR;
    uint8_t layer_value[10];
    uint8_t layer_cnt;
}enc_Cnt;

//extern enc_Cnt enc;


void Init_Encoder(uint8_t rotate_value);
void Encode(void);
uint8_t _SW(void);
int8_t SW_Store(void);
int8_t read_rotary();
int16_t Get_EncoderValue(void);
uint8_t Get_Layer_Count(void);
uint8_t Get_Staged_Value(uint8_t layer,uint8_t depth);

#endif