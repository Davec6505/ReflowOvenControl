#include "PID.h"

struct HWMul Mul;

void PID_Init( _PID *PID_t,int kp,int ki,int kd,int offst,int Max,int Min,dirOfCntl Dirct,typeOfCntrl Cntl){
  PID_t->Kp      = kp;
  PID_t->Ki      = ki;
  PID_t->Kd      = kd;
  PID_t->offSet  = offst;
  PID_t->maxOut  = Max;
  PID_t->minOut  = Min;
  PID_t->Direction = Dirct;
  PID_t->LastDiff = 0;
}

void PID_Calc(_PID *PID_t,int Sp,int Pv){
// long errorL,diffValL;
 ////////////////////////////////////////////
 //calculate proportional value
     PID_t->error = Sp - Pv;
     PID_t->errorP = (int)S_HWMul(PID_t->error,PID_t->Kp);

 ///////////////////////////////////////////
 //calc intergral value
     PID_t->InterimI += (int)S_HWMul(PID_t->error,PID_t->Ki);
     if(PID_t->InterimI > PID_t->maxOut)PID_t->InterimI = PID_t->maxOut;
     if(PID_t->InterimI <= PID_t->minOut)PID_t->InterimI = PID_t->minOut;
 ///////////////////////////////////////////
 //calc differential value
     PID_t->diffVal  = Pv - PID_t->LastDiff;
     PID_t->diffVal  = (int)S_HWMul(PID_t->diffVal,PID_t->Kd);
     PID_t->LastDiff = Pv;
 //////////////////////////////////////////
 //calculate Mv
     PID_t->Mv = PID_t->errorP + PID_t->InterimI + PID_t->diffVal + PID_t->offSet;
 //////////////////////////////////////////
 //clamp max and min Mv value
    if(PID_t->Mv > PID_t->maxOut)PID_t->Mv = PID_t->maxOut;
    if(PID_t->Mv <= PID_t->minOut)PID_t->Mv = PID_t->minOut;
 //////////////////////////////////////////
 //keep track of last Pv

   
}

long S_HWMul(int valA,int valB){
static long res;

    asm{
                  //calc low byte
                     MOVF    FARG_S_HWMul_valA+0,0     ;
                     MULWF   FARG_S_HWMul_valB+0       ;
                     MOVFF   PRODH,S_HWMul_res_L0+1    ;
                     MOVFF   PRODL,S_HWMul_res_L0+0    ;
                  //calc hi byte
                     MOVF    FARG_S_HWMul_valA+1,0     ;
                     MULWF   FARG_S_HWMul_valB+1       ;
                     MOVFF   PRODH,S_HWMul_res_L0+3    ;
                     MOVFF   PRODL,S_HWMul_res_L0+2    ;

                  //cross mul LO 2 HI byte
                     MOVF    FARG_S_HWMul_valA+0,0     ;
                     MULWF   FARG_S_HWMul_valB+1       ;
                  //add cross products  for lobyte arg1
                     MOVF   PRODL,0                     ;
                     ADDWF   S_HWMul_res_L0+1           ;
                     MOVF   PRODH,0                     ;
                     ADDWFC  S_HWMul_res_L0+2           ;
                     CLRF    0                          ;
                     ADDWFC  S_HWMul_res_L0+3           ;

                  //cross mul hi 2 lo
                     MOVF    FARG_S_HWMul_valA+1,0      ;
                     MULWF   FARG_S_HWMul_valB+0        ;
                  //add cross products for hi byte
                     MOVF    PRODL,0                    ;
                     ADDWF   S_HWMul_res_L0+1           ;
                     MOVF    PRODH,0                    ;
                     ADDWFC  S_HWMul_res_L0+2           ;
                     CLRF    0                          ;
                     ADDWFC  S_HWMul_res_L0+3           ;

                  //check the borrow or carry flag for negative value
                     BTFSS   FARG_S_HWMul_valB+1,7      ;//test if bit 7 of valB hi is on eg negative
                     BRA     SIGN_val                   ;//if it is on jump to label
                     MOVF    FARG_S_HWMul_valA+0,0      ;
                     SUBWF   S_HWMul_res_L0+2           ;
                     MOVF    FARG_S_HWMul_valA+1,0      ;
                     SUBWFB  S_HWMul_res_L0+3           ;//sub wreg from file reg with the borrow flag



    SIGN_val:   //LABEL to jump to if sign value was on to perform a different subtraction
                    BTFSS  FARG_S_HWMul_valA+1,7        ;//again test if bit 7 of valA hi is on sign bit
                    BRA    CONT                         ;
                    MOVF   FARG_S_HWMul_valB+0,0        ;
                    SUBWF  S_HWMul_res_L0+2             ;
                    MOVF   FARG_S_HWMul_valB+1,0        ;
                    SUBWFB S_HWMul_res_L0+3             ;

    CONT:

    }

      return res;


}