
_CalcTimerTicks:

;Calcs.c,7 :: 		void CalcTimerTicks(int iPv){
;Calcs.c,8 :: 		TempTicks.Ambient = iPv;
	MOVF        FARG_CalcTimerTicks_iPv+0, 0 
	MOVWF       _TempTicks+0 
	MOVF        FARG_CalcTimerTicks_iPv+1, 0 
	MOVWF       _TempTicks+1 
;Calcs.c,11 :: 		TempTicks.RampTick = Sps.RmpTmr;
	MOVF        _Sps+2, 0 
	MOVWF       _TempTicks+2 
	MOVF        _Sps+3, 0 
	MOVWF       _TempTicks+3 
;Calcs.c,12 :: 		TempTicks.RampTick /= (Sps.RmpDeg + TempTicks.Ambient);
	MOVF        _TempTicks+0, 0 
	ADDWF       _Sps+0, 0 
	MOVWF       R4 
	MOVF        _TempTicks+1, 0 
	ADDWFC      _Sps+1, 0 
	MOVWF       R5 
	MOVF        _Sps+2, 0 
	MOVWF       R0 
	MOVF        _Sps+3, 0 
	MOVWF       R1 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
	MOVF        R1, 0 
	MOVWF       _TempTicks+3 
;Calcs.c,13 :: 		TempTicks.RampTick =  S_HWMul(TempTicks.RampTick,10);
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
;Calcs.c,16 :: 		TempTicks.SoakTick =  Sps.SokTmr  - Sps.RmpTmr;
	MOVF        _Sps+2, 0 
	SUBWF       _Sps+6, 0 
	MOVWF       R0 
	MOVF        _Sps+3, 0 
	SUBWFB      _Sps+7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
	MOVF        R1, 0 
	MOVWF       _TempTicks+5 
;Calcs.c,17 :: 		TempTicks.SoakTick /= ( Sps.SokDeg - Sps.RmpDeg );
	MOVF        _Sps+0, 0 
	SUBWF       _Sps+4, 0 
	MOVWF       R4 
	MOVF        _Sps+1, 0 
	SUBWFB      _Sps+5, 0 
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
	MOVF        R1, 0 
	MOVWF       _TempTicks+5 
;Calcs.c,18 :: 		TempTicks.SoakTick =  S_HWMul(TempTicks.SoakTick,10);
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
;Calcs.c,21 :: 		TempTicks.SpikeTick =  Sps.SpkeTmr - Sps.SokTmr;
	MOVF        _Sps+6, 0 
	SUBWF       _Sps+10, 0 
	MOVWF       R0 
	MOVF        _Sps+7, 0 
	SUBWFB      _Sps+11, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
	MOVF        R1, 0 
	MOVWF       _TempTicks+7 
;Calcs.c,22 :: 		TempTicks.SpikeTick /=  (Sps.SpkeDeg - Sps.SokDeg);
	MOVF        _Sps+4, 0 
	SUBWF       _Sps+8, 0 
	MOVWF       R4 
	MOVF        _Sps+5, 0 
	SUBWFB      _Sps+9, 0 
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
	MOVF        R1, 0 
	MOVWF       _TempTicks+7 
;Calcs.c,23 :: 		TempTicks.SpikeTick =  S_HWMul(TempTicks.SpikeTick,10);
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
;Calcs.c,26 :: 		TempTicks.CoolTick = Sps.CoolOffTmr - Sps.SpkeTmr;
	MOVF        _Sps+10, 0 
	SUBWF       _Sps+14, 0 
	MOVWF       R0 
	MOVF        _Sps+11, 0 
	SUBWFB      _Sps+15, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
	MOVF        R1, 0 
	MOVWF       _TempTicks+9 
;Calcs.c,27 :: 		TempTicks.CoolTick /= Sps.SpkeDeg - TempTicks.Ambient;
	MOVF        _TempTicks+0, 0 
	SUBWF       _Sps+8, 0 
	MOVWF       R4 
	MOVF        _TempTicks+1, 0 
	SUBWFB      _Sps+9, 0 
	MOVWF       R5 
	CALL        _Div_16X16_U+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
	MOVF        R1, 0 
	MOVWF       _TempTicks+9 
;Calcs.c,28 :: 		TempTicks.CoolTick =  S_HWMul(TempTicks.CoolTick,10);
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
;Calcs.c,30 :: 		}
L_end_CalcTimerTicks:
	RETURN      0
; end of _CalcTimerTicks
