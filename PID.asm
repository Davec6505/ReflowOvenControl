
_PID_Init:

;PID.c,5 :: 		void PID_Init( _PID *PID_t,int kp,int ki,int kd,int offst,int Max,int Min,dirOfCntl Dirct,typeOfCntrl Cntl){
;PID.c,6 :: 		PID_t->Kp      = kp;
	MOVFF       FARG_PID_Init_PID_t+0, FSR1L+0
	MOVFF       FARG_PID_Init_PID_t+1, FSR1H+0
	MOVF        FARG_PID_Init_kp+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_kp+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,7 :: 		PID_t->Ki      = ki;
	MOVLW       2
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_ki+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_ki+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,8 :: 		PID_t->Kd      = kd;
	MOVLW       4
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_kd+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_kd+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,9 :: 		PID_t->offSet  = offst;
	MOVLW       6
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_offst+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_offst+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,10 :: 		PID_t->maxOut  = Max;
	MOVLW       16
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_Max+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_Max+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,11 :: 		PID_t->minOut  = Min;
	MOVLW       18
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_Min+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Init_Min+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,12 :: 		PID_t->Direction = Dirct;
	MOVLW       8
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Init_Dirct+0, 0 
	MOVWF       POSTINC1+0 
;PID.c,13 :: 		PID_t->LastDiff = 0;
	MOVLW       14
	ADDWF       FARG_PID_Init_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Init_PID_t+1, 0 
	MOVWF       FSR1L+1 
	CLRF        POSTINC1+0 
	CLRF        POSTINC1+0 
;PID.c,14 :: 		}
L_end_PID_Init:
	RETURN      0
; end of _PID_Init

_PID_Calc:

;PID.c,16 :: 		void PID_Calc(_PID *PID_t,int Sp,int Pv){
;PID.c,20 :: 		PID_t->error = Sp - Pv;
	MOVLW       22
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Calc_Pv+0, 0 
	SUBWF       FARG_PID_Calc_Sp+0, 0 
	MOVWF       R0 
	MOVF        FARG_PID_Calc_Pv+1, 0 
	SUBWFB      FARG_PID_Calc_Sp+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,21 :: 		PID_t->errorP = (int)S_HWMul(PID_t->error,PID_t->Kp);
	MOVLW       24
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FLOC__PID_Calc+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FLOC__PID_Calc+1 
	MOVLW       22
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVFF       FARG_PID_Calc_PID_t+0, FSR0L+0
	MOVFF       FARG_PID_Calc_PID_t+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVFF       FLOC__PID_Calc+0, FSR1L+0
	MOVFF       FLOC__PID_Calc+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,25 :: 		PID_t->InterimI += (int)S_HWMul(PID_t->error,PID_t->Ki);
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FLOC__PID_Calc+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FLOC__PID_Calc+1 
	MOVLW       22
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       2
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVFF       FLOC__PID_Calc+0, FSR0L+0
	MOVFF       FLOC__PID_Calc+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC0+0, 0 
	ADDWFC      R1, 1 
	MOVFF       FLOC__PID_Calc+0, FSR1L+0
	MOVFF       FLOC__PID_Calc+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,26 :: 		if(PID_t->InterimI > PID_t->maxOut)PID_t->InterimI = PID_t->maxOut;
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       16
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PID_Calc6
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__PID_Calc6:
	BTFSC       STATUS+0, 0 
	GOTO        L_PID_Calc0
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       16
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
L_PID_Calc0:
;PID.c,27 :: 		if(PID_t->InterimI <= PID_t->minOut)PID_t->InterimI = PID_t->minOut;
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       18
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PID_Calc7
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__PID_Calc7:
	BTFSS       STATUS+0, 0 
	GOTO        L_PID_Calc1
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       18
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
L_PID_Calc1:
;PID.c,30 :: 		PID_t->diffVal  = Pv - PID_t->LastDiff;
	MOVLW       26
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       14
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	SUBWF       FARG_PID_Calc_Pv+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	SUBWFB      FARG_PID_Calc_Pv+1, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,31 :: 		PID_t->diffVal  = (int)S_HWMul(PID_t->diffVal,PID_t->Kd);
	MOVLW       26
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FLOC__PID_Calc+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FLOC__PID_Calc+1 
	MOVFF       FLOC__PID_Calc+0, FSR0L+0
	MOVFF       FLOC__PID_Calc+1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       4
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVFF       FLOC__PID_Calc+0, FSR1L+0
	MOVFF       FLOC__PID_Calc+1, FSR1H+0
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,32 :: 		PID_t->LastDiff = Pv;
	MOVLW       14
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVF        FARG_PID_Calc_Pv+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        FARG_PID_Calc_Pv+1, 0 
	MOVWF       POSTINC1+0 
;PID.c,35 :: 		PID_t->Mv = PID_t->errorP + PID_t->InterimI + PID_t->diffVal + PID_t->offSet;
	MOVLW       20
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       24
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVLW       12
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       POSTINC0+0, 0 
	MOVWF       R0 
	MOVF        POSTINC2+0, 0 
	ADDWFC      POSTINC0+0, 0 
	MOVWF       R1 
	MOVLW       26
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R1, 1 
	MOVLW       6
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	ADDWF       R0, 1 
	MOVF        POSTINC2+0, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
	MOVF        R1, 0 
	MOVWF       POSTINC1+0 
;PID.c,38 :: 		if(PID_t->Mv > PID_t->maxOut)PID_t->Mv = PID_t->maxOut;
	MOVLW       20
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       16
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PID_Calc8
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__PID_Calc8:
	BTFSC       STATUS+0, 0 
	GOTO        L_PID_Calc2
	MOVLW       20
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       16
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
L_PID_Calc2:
;PID.c,39 :: 		if(PID_t->Mv <= PID_t->minOut)PID_t->Mv = PID_t->minOut;
	MOVLW       20
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       R3 
	MOVF        POSTINC0+0, 0 
	MOVWF       R4 
	MOVLW       18
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR2L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR2L+1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R1 
	MOVF        POSTINC2+0, 0 
	MOVWF       R2 
	MOVLW       128
	XORWF       R2, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       R4, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__PID_Calc9
	MOVF        R3, 0 
	SUBWF       R1, 0 
L__PID_Calc9:
	BTFSS       STATUS+0, 0 
	GOTO        L_PID_Calc3
	MOVLW       20
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR1L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR1L+1 
	MOVLW       18
	ADDWF       FARG_PID_Calc_PID_t+0, 0 
	MOVWF       FSR0L+0 
	MOVLW       0
	ADDWFC      FARG_PID_Calc_PID_t+1, 0 
	MOVWF       FSR0L+1 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
	MOVF        POSTINC0+0, 0 
	MOVWF       POSTINC1+0 
L_PID_Calc3:
;PID.c,44 :: 		}
L_end_PID_Calc:
	RETURN      0
; end of _PID_Calc

_S_HWMul:

;PID.c,46 :: 		long S_HWMul(int valA,int valB){
;PID.c,51 :: 		MOVF    FARG_S_HWMul_valA+0,0     ;
	MOVF        FARG_S_HWMul_valA+0, 0, 1
;PID.c,52 :: 		MULWF   FARG_S_HWMul_valB+0          ;
	MULWF       FARG_S_HWMul_valB+0, 1
;PID.c,53 :: 		MOVFF   PRODH,S_HWMul_res_L0+1       ;
	MOVFF       PRODH+0, S_HWMul_res_L0+1
;PID.c,54 :: 		MOVFF   PRODL,S_HWMul_res_L0+0       ;
	MOVFF       PRODL+0, S_HWMul_res_L0+0
;PID.c,56 :: 		MOVF    FARG_S_HWMul_valA+1,0     ;
	MOVF        FARG_S_HWMul_valA+1, 0, 1
;PID.c,57 :: 		MULWF   FARG_S_HWMul_valB+1          ;
	MULWF       FARG_S_HWMul_valB+1, 1
;PID.c,58 :: 		MOVFF   PRODH,S_HWMul_res_L0+3       ;
	MOVFF       PRODH+0, S_HWMul_res_L0+3
;PID.c,59 :: 		MOVFF   PRODL,S_HWMul_res_L0+2       ;
	MOVFF       PRODL+0, S_HWMul_res_L0+2
;PID.c,62 :: 		MOVF    FARG_S_HWMul_valA+0,0        ;
	MOVF        FARG_S_HWMul_valA+0, 0, 1
;PID.c,63 :: 		MULWF   FARG_S_HWMul_valB+1          ;
	MULWF       FARG_S_HWMul_valB+1, 1
;PID.c,65 :: 		MOVF   PRODL,0                      ;
	MOVF        PRODL+0, 0, 1
;PID.c,66 :: 		ADDWF   S_HWMul_res_L0+1             ;
	ADDWF       S_HWMul_res_L0+1, 1, 1
;PID.c,67 :: 		MOVF   PRODH,0                      ;
	MOVF        PRODH+0, 0, 1
;PID.c,68 :: 		ADDWFC  S_HWMul_res_L0+2             ;
	ADDWFC      S_HWMul_res_L0+2, 1, 1
;PID.c,69 :: 		CLRF    0                            ;
	CLRF        R0, 1
;PID.c,70 :: 		ADDWFC  S_HWMul_res_L0+3             ;
	ADDWFC      S_HWMul_res_L0+3, 1, 1
;PID.c,73 :: 		MOVF    FARG_S_HWMul_valA+1,0        ;
	MOVF        FARG_S_HWMul_valA+1, 0, 1
;PID.c,74 :: 		MULWF   FARG_S_HWMul_valB+0          ;
	MULWF       FARG_S_HWMul_valB+0, 1
;PID.c,76 :: 		MOVF    PRODL,0                      ;
	MOVF        PRODL+0, 0, 1
;PID.c,77 :: 		ADDWF   S_HWMul_res_L0+1             ;
	ADDWF       S_HWMul_res_L0+1, 1, 1
;PID.c,78 :: 		MOVF    PRODH,0                      ;
	MOVF        PRODH+0, 0, 1
;PID.c,79 :: 		ADDWFC  S_HWMul_res_L0+2             ;
	ADDWFC      S_HWMul_res_L0+2, 1, 1
;PID.c,80 :: 		CLRF    0                            ;
	CLRF        R0, 1
;PID.c,81 :: 		ADDWFC  S_HWMul_res_L0+3             ;
	ADDWFC      S_HWMul_res_L0+3, 1, 1
;PID.c,84 :: 		BTFSS   FARG_S_HWMul_valB+1,7        ;//test if bit 7 of valB hi is on eg negative
	BTFSS       FARG_S_HWMul_valB+1, 7, 1
;PID.c,85 :: 		BRA     SIGN_val                     ;//if it is on jump to label
	BRA         SIGN_val
;PID.c,86 :: 		MOVF    FARG_S_HWMul_valA+0,0        ;
	MOVF        FARG_S_HWMul_valA+0, 0, 1
;PID.c,87 :: 		SUBWF   S_HWMul_res_L0+2             ;
	SUBWF       S_HWMul_res_L0+2, 1, 1
;PID.c,88 :: 		MOVF    FARG_S_HWMul_valA+1,0        ;
	MOVF        FARG_S_HWMul_valA+1, 0, 1
;PID.c,89 :: 		SUBWFB  S_HWMul_res_L0+3             ;//sub wreg from file reg with the borrow flag
	SUBWFB      S_HWMul_res_L0+3, 1, 1
;PID.c,93 :: 		SIGN_val:   //LABEL to jump to if sign value was on to perform a different subtraction
SIGN_val:
;PID.c,94 :: 		BTFSS  FARG_S_HWMul_valA+1,7          ;//again test if bit 7 of valA hi is on sign bit
	BTFSS       FARG_S_HWMul_valA+1, 7, 1
;PID.c,95 :: 		BRA    CONT                           ;
	BRA         CONT
;PID.c,96 :: 		MOVF   FARG_S_HWMul_valB+0,0          ;
	MOVF        FARG_S_HWMul_valB+0, 0, 1
;PID.c,97 :: 		SUBWF  S_HWMul_res_L0+2               ;
	SUBWF       S_HWMul_res_L0+2, 1, 1
;PID.c,98 :: 		MOVF   FARG_S_HWMul_valB+1,0          ;
	MOVF        FARG_S_HWMul_valB+1, 0, 1
;PID.c,99 :: 		SUBWFB S_HWMul_res_L0+3               ;
	SUBWFB      S_HWMul_res_L0+3, 1, 1
;PID.c,101 :: 		CONT:
CONT:
;PID.c,105 :: 		return res;
	MOVF        S_HWMul_res_L0+0, 0 
	MOVWF       R0 
	MOVF        S_HWMul_res_L0+1, 0 
	MOVWF       R1 
	MOVF        S_HWMul_res_L0+2, 0 
	MOVWF       R2 
	MOVF        S_HWMul_res_L0+3, 0 
	MOVWF       R3 
;PID.c,108 :: 		}
L_end_S_HWMul:
	RETURN      0
; end of _S_HWMul
