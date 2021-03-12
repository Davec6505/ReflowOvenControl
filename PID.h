#ifndef PID_H
#define PID_H

#include "Config.h"
////////////////////////////////////////////////
//defines



////////////////////////////////////////////////
//structs , unions & enums
typedef enum pidDir{
  Direct_PID = '+',   //outvalue is rising
  Reverse_PID = '-'  //outvalue is falling
}dirOfCntl;

typedef enum pidControl{
  _P  = 1 ,           //only P
  _PI ,           //p and i calculated
  _PID           //pi&d calculated
}typeOfCntrl;

struct HWMul {
  unsigned int factor; //1,0
  unsigned int an0Lo;  //3,2
  unsigned int an0Hi;  //5,4
  unsigned long res;   //6,7,8,9
};
extern struct HWMul Mul;
typedef struct _PID_{
   //constants for pid calculation
   int Kp;
   int Ki;
   int Kd;
   int offSet;
   char Direction;
   char CntrlType[3];
   //variables for pid calculation
   int InterimI;
   int LastDiff;
   int maxOut;
   int minOut;
   int Mv;
   int error;
   int errorP;
   int diffVal;
   long LastCalcVal;
   short sample_tmr;
}_PID;
extern  dirOfCntl Dir_;
extern  typeOfCntrl Cntrl;
extern  _PID  pid_t;
///////////////////////////////////////////////
//global variables

///////////////////////////////////////////////
//function prototypes

void PID_Init( _PID *PID_t,
               int kp,
               int ki,
               int kd,
               int offst,
               int Max,
               int Min,
               dirOfCntl Dirct,
               typeOfCntrl Cntl);
               
void PID_Calc(_PID *PID_t,int Sp,int Pv);
long S_HWMul(int valA,int valB);





#endif