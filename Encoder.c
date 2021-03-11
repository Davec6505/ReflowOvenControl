#include "Encoder.h"

const int8_t  rot_enc_table[] ={null,CW,CCW,null,CCW,null,null,CW,CW,null,null,CCW,null,CCW,CW,null};
enc_Cnt enc ={
    0,
    0,
    0,
    0,
    6,
    {0,0,0,0,0,0,0,0,0,0},
    0
};

void Init_Encoder(uint8_t rotate_value){
    enc.ROR = rotate_value;
}
/*
 *Encoder wheel Value
 */

uint8_t _SW(void){
    if(EncSW)
        return 0;
   return 1;
}

int8_t SW_Store(void){
    enc.storeSW = enc.val;
    return enc.storeSW;
}

void Encode(void){
      enc.val = read_rotary();
      enc.cntr += enc.val;
}

int8_t read_rotary(){
   enc.codePrevNext = (enc.codePrevNext << 2)& 0x0f;
   enc.codePrevNext |= (DATA >> enc.ROR);
   return rot_enc_table[enc.codePrevNext & 0x0f];
}

int16_t Get_EncoderValue(void){
    return enc.cntr;
}


uint16_t Save_EncoderValue(int16_t new_val){
    enc.cntr = new_val;
    return enc.cntr;
}

