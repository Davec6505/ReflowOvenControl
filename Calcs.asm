
_CalcTimerTicks:

;Calcs.c,13 :: 		void CalcTimerTicks(int iPv){
;Calcs.c,14 :: 		TempTicks.Ambient = iPv;
	MOVF        FARG_CalcTimerTicks_iPv+0, 0 
	MOVWF       _TempTicks+0 
	MOVF        FARG_CalcTimerTicks_iPv+1, 0 
	MOVWF       _TempTicks+1 
;Calcs.c,17 :: 		Sps.RmpTmr = S_HWMul(Sps.RmpSec, ten_msec_multiplier);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       100
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
	MOVF        R1, 0 
	MOVWF       _Sps+3 
;Calcs.c,18 :: 		temp = Sps.RmpDeg - TempTicks.Ambient;
	MOVF        _TempTicks+0, 0 
	SUBWF       _Sps+0, 0 
	MOVWF       R4 
	MOVF        _TempTicks+1, 0 
	SUBWFB      _Sps+1, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;Calcs.c,19 :: 		TempTicks.RampTick = Sps.RmpTmr / temp;
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
	MOVF        R1, 0 
	MOVWF       _TempTicks+3 
;Calcs.c,20 :: 		TempTicks.RampTick =  S_HWMul(TempTicks.RampTick,msec_multiplier);
	MOVF        R0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        R1, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       10
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
	MOVF        R1, 0 
	MOVWF       _TempTicks+3 
;Calcs.c,23 :: 		Sps.SokTmr = S_HWMul(Sps.SokSec,ten_msec_multiplier);
	MOVF        _Sps+10, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       100
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
	MOVF        R1, 0 
	MOVWF       _Sps+9 
;Calcs.c,24 :: 		temp = Sps.SokDeg - Sps.RmpDeg;
	MOVF        _Sps+0, 0 
	SUBWF       _Sps+6, 0 
	MOVWF       R4 
	MOVF        _Sps+1, 0 
	SUBWFB      _Sps+7, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;Calcs.c,25 :: 		TempTicks.SoakTick =  Sps.SokTmr / temp;
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
	MOVF        R1, 0 
	MOVWF       _TempTicks+5 
;Calcs.c,26 :: 		TempTicks.SoakTick =  S_HWMul(TempTicks.SoakTick,msec_multiplier);
	MOVF        R0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        R1, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       10
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
	MOVF        R1, 0 
	MOVWF       _TempTicks+5 
;Calcs.c,29 :: 		Sps.SpkeTmr = S_HWMul(Sps.SpkeSec,ten_msec_multiplier);
	MOVF        _Sps+16, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Sps+17, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       100
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
	MOVF        R1, 0 
	MOVWF       _Sps+15 
;Calcs.c,30 :: 		temp = Sps.SpkeDeg - Sps.SokDeg;
	MOVF        _Sps+6, 0 
	SUBWF       _Sps+12, 0 
	MOVWF       R4 
	MOVF        _Sps+7, 0 
	SUBWFB      _Sps+13, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;Calcs.c,31 :: 		TempTicks.SpikeTick =  Sps.SpkeTmr / temp;
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
	MOVF        R1, 0 
	MOVWF       _TempTicks+7 
;Calcs.c,32 :: 		TempTicks.SpikeTick =  S_HWMul(TempTicks.SpikeTick,msec_multiplier);
	MOVF        R0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        R1, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       10
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
	MOVF        R1, 0 
	MOVWF       _TempTicks+7 
;Calcs.c,35 :: 		Sps.CoolOffTmr = S_HWMul(Sps.CoolOffSec,ten_msec_multiplier);
	MOVF        _Sps+22, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Sps+23, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       100
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+20 
	MOVF        R1, 0 
	MOVWF       _Sps+21 
;Calcs.c,36 :: 		temp =  Sps.SpkeDeg -Sps.CoolOffDeg;
	MOVF        _Sps+18, 0 
	SUBWF       _Sps+12, 0 
	MOVWF       R4 
	MOVF        _Sps+19, 0 
	SUBWFB      _Sps+13, 0 
	MOVWF       R5 
	MOVF        R4, 0 
	MOVWF       _temp+0 
	MOVF        R5, 0 
	MOVWF       _temp+1 
;Calcs.c,37 :: 		TempTicks.CoolTick = Sps.CoolOffTmr / temp;
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
	MOVF        R1, 0 
	MOVWF       _TempTicks+9 
;Calcs.c,38 :: 		TempTicks.CoolTick =  S_HWMul(TempTicks.CoolTick,msec_multiplier);
	MOVF        R0, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        R1, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       10
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
	MOVF        R1, 0 
	MOVWF       _TempTicks+9 
;Calcs.c,40 :: 		}
L_end_CalcTimerTicks:
	RETURN      0
; end of _CalcTimerTicks
