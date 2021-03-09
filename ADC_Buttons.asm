
_SampleButtons:

;ADC_Buttons.c,39 :: 		void SampleButtons(){
;ADC_Buttons.c,41 :: 		But.an2_ = ADC_Read(2);
	MOVLW       2
	MOVWF       FARG_ADC_Read_channel+0 
	CALL        _ADC_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _But+4 
	MOVF        R1, 0 
	MOVWF       _But+5 
;ADC_Buttons.c,42 :: 		if((!INC)&&(!DEC))But.ButMs = 500;
	MOVLW       1
	SUBWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons153
	MOVLW       144
	SUBWF       R0, 0 
L__SampleButtons153:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons1
	MOVF        _But+5, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons154
	MOVF        _But+4, 0 
	SUBLW       147
L__SampleButtons154:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons1
	MOVLW       1
	MOVWF       R0 
	GOTO        L_SampleButtons0
L_SampleButtons1:
	CLRF        R0 
L_SampleButtons0:
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons6
	MOVLW       3
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons155
	MOVLW       35
	SUBWF       _But+4, 0 
L__SampleButtons155:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons3
	MOVF        _But+5, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons156
	MOVF        _But+4, 0 
	SUBLW       39
L__SampleButtons156:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons3
	MOVLW       1
	MOVWF       R0 
	GOTO        L_SampleButtons2
L_SampleButtons3:
	CLRF        R0 
L_SampleButtons2:
	MOVF        R0, 1 
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons6
L__SampleButtons144:
	MOVLW       244
	MOVWF       _But+2 
	MOVLW       1
	MOVWF       _But+3 
L_SampleButtons6:
;ADC_Buttons.c,43 :: 		if(OK){
	MOVLW       2
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons157
	MOVLW       88
	SUBWF       _But+4, 0 
L__SampleButtons157:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons9
	MOVF        _But+5, 0 
	SUBLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons158
	MOVF        _But+4, 0 
	SUBLW       91
L__SampleButtons158:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons9
L__SampleButtons143:
;ADC_Buttons.c,44 :: 		if((!OK_Bit)&&(Sps.State!=0))Sps.State = 0;
	BTFSC       _B+0, 0 
	GOTO        L_SampleButtons12
	MOVF        _Sps+16, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons12
L__SampleButtons142:
	CLRF        _Sps+16 
L_SampleButtons12:
;ADC_Buttons.c,45 :: 		if((!OK_Bit)&&(Sps.State==0)) I2C_LCD_Out(LCD_01_ADDRESS,2,6,"  ");
	BTFSC       _B+0, 0 
	GOTO        L_SampleButtons15
	MOVF        _Sps+16, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons15
L__SampleButtons141:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr1_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr1_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
L_SampleButtons15:
;ADC_Buttons.c,47 :: 		if(i>=900){
	MOVLW       3
	SUBWF       SampleButtons_i_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons159
	MOVLW       132
	SUBWF       SampleButtons_i_L0+0, 0 
L__SampleButtons159:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons16
;ADC_Buttons.c,48 :: 		SavedVals();
	CALL        _SavedVals+0, 0
;ADC_Buttons.c,49 :: 		i = 0;
	CLRF        SampleButtons_i_L0+0 
	CLRF        SampleButtons_i_L0+1 
;ADC_Buttons.c,50 :: 		}else i++;
	GOTO        L_SampleButtons17
L_SampleButtons16:
	INFSNZ      SampleButtons_i_L0+0, 1 
	INCF        SampleButtons_i_L0+1, 1 
L_SampleButtons17:
;ADC_Buttons.c,53 :: 		}else i = 0;
	GOTO        L_SampleButtons18
L_SampleButtons9:
	CLRF        SampleButtons_i_L0+0 
	CLRF        SampleButtons_i_L0+1 
L_SampleButtons18:
;ADC_Buttons.c,55 :: 		if(OK_Bit){
	BTFSS       _B+0, 0 
	GOTO        L_SampleButtons19
;ADC_Buttons.c,56 :: 		valOf = IncValues(valOf); //needs to be here to reset from previous state
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_IncValues_Val+0 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_IncValues_Val+1 
	CALL        _IncValues+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,57 :: 		if(EEWrt)EEWrt = off;
	BTFSS       _B+0, 3 
	GOTO        L_SampleButtons20
	BCF         _B+0, 3 
L_SampleButtons20:
;ADC_Buttons.c,58 :: 		switch(Sps.State){
	GOTO        L_SampleButtons21
;ADC_Buttons.c,59 :: 		case Return:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ret     ");
L_SampleButtons23:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr2_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr2_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,61 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,62 :: 		case RampDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampDeg ");
L_SampleButtons24:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr3_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr3_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,63 :: 		if(OK_A){
	BTFSS       _B_+0, 0 
	GOTO        L_SampleButtons25
;ADC_Buttons.c,64 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons26
;ADC_Buttons.c,65 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKA");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,66 :: 		valOf = Sps.RmpDeg;
	MOVF        _Sps+0, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+1, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,67 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,68 :: 		}else Sps.RmpDeg = valOf;
	GOTO        L_SampleButtons27
L_SampleButtons26:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+0 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+1 
L_SampleButtons27:
;ADC_Buttons.c,69 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons28
L_SampleButtons25:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons28:
;ADC_Buttons.c,70 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_5_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_5_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_5_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,71 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,72 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,73 :: 		case RampTm:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampTm  ");
L_SampleButtons29:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr6_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr6_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,74 :: 		if(OK_B){
	BTFSS       _B_+0, 1 
	GOTO        L_SampleButtons30
;ADC_Buttons.c,75 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons31
;ADC_Buttons.c,76 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKB");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr7_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr7_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,77 :: 		valOf = Sps.RmpTmr;
	MOVF        _Sps+2, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+3, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,78 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,79 :: 		}else Sps.RmpTmr = valOf;
	GOTO        L_SampleButtons32
L_SampleButtons31:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+2 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+3 
L_SampleButtons32:
;ADC_Buttons.c,80 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons33
L_SampleButtons30:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons33:
;ADC_Buttons.c,81 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_8_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_8_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_8_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,82 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,83 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,84 :: 		case SoakDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakDeg ");
L_SampleButtons34:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr9_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr9_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,85 :: 		if(OK_C){
	BTFSS       _B_+0, 2 
	GOTO        L_SampleButtons35
;ADC_Buttons.c,86 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons36
;ADC_Buttons.c,87 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKC");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr10_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr10_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,88 :: 		valOf = Sps.SokDeg;
	MOVF        _Sps+4, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+5, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,89 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,90 :: 		}else Sps.SokDeg = valOf;
	GOTO        L_SampleButtons37
L_SampleButtons36:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+4 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+5 
L_SampleButtons37:
;ADC_Buttons.c,91 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons38
L_SampleButtons35:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons38:
;ADC_Buttons.c,92 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_11_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_11_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_11_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,93 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,94 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,95 :: 		case SoakTm:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakTm  ");
L_SampleButtons39:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr12_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr12_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,96 :: 		if(OK_D){
	BTFSS       _B_+0, 3 
	GOTO        L_SampleButtons40
;ADC_Buttons.c,97 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons41
;ADC_Buttons.c,98 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKD");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr13_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr13_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,99 :: 		valOf = Sps.SokTmr;
	MOVF        _Sps+6, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+7, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,100 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,101 :: 		}else Sps.SokTmr = valOf;
	GOTO        L_SampleButtons42
L_SampleButtons41:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+6 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+7 
L_SampleButtons42:
;ADC_Buttons.c,102 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons43
L_SampleButtons40:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons43:
;ADC_Buttons.c,103 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_14_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_14_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_14_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,104 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,105 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,106 :: 		case SpikeDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeDeg");
L_SampleButtons44:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr15_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr15_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,107 :: 		if(OK_E){
	BTFSS       _B_+0, 4 
	GOTO        L_SampleButtons45
;ADC_Buttons.c,108 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons46
;ADC_Buttons.c,109 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKE");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr16_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr16_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,110 :: 		valOf = Sps.SpkeDeg;
	MOVF        _Sps+8, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+9, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,111 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,112 :: 		}else Sps.SpkeDeg = valOf;
	GOTO        L_SampleButtons47
L_SampleButtons46:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+8 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+9 
L_SampleButtons47:
;ADC_Buttons.c,113 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons48
L_SampleButtons45:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons48:
;ADC_Buttons.c,114 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_17_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_17_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_17_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,115 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,116 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,117 :: 		case SpikeTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeTm ");
L_SampleButtons49:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr18_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr18_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,118 :: 		if(OK_F){
	BTFSS       _B_+0, 5 
	GOTO        L_SampleButtons50
;ADC_Buttons.c,119 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons51
;ADC_Buttons.c,120 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKF");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr19_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr19_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,121 :: 		valOf = Sps.SpkeTmr;
	MOVF        _Sps+10, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+11, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,122 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,123 :: 		}else Sps.SpkeTmr = valOf;
	GOTO        L_SampleButtons52
L_SampleButtons51:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+10 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+11 
L_SampleButtons52:
;ADC_Buttons.c,124 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons53
L_SampleButtons50:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons53:
;ADC_Buttons.c,125 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_20_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_20_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_20_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,126 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,127 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,128 :: 		case CoolDownDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolDeg ");
L_SampleButtons54:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr21_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr21_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,129 :: 		if(OK_G){
	BTFSS       _B_+0, 6 
	GOTO        L_SampleButtons55
;ADC_Buttons.c,130 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons56
;ADC_Buttons.c,131 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKG");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr22_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr22_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,132 :: 		valOf = Sps.CoolOffDeg;
	MOVF        _Sps+12, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+13, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,133 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,134 :: 		}else Sps.CoolOffDeg = valOf;
	GOTO        L_SampleButtons57
L_SampleButtons56:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+12 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+13 
L_SampleButtons57:
;ADC_Buttons.c,135 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons58
L_SampleButtons55:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons58:
;ADC_Buttons.c,136 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_23_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_23_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_23_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,137 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,138 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,139 :: 		case CoolDownTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolTm ");
L_SampleButtons59:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr24_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr24_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,140 :: 		if(OK_H){
	BTFSS       _B_+0, 7 
	GOTO        L_SampleButtons60
;ADC_Buttons.c,141 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons61
;ADC_Buttons.c,142 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKH");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr25_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr25_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,143 :: 		valOf = Sps.CoolOffTmr;
	MOVF        _Sps+14, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+15, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,144 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,145 :: 		}else Sps.CoolOffTmr = valOf;
	GOTO        L_SampleButtons62
L_SampleButtons61:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+14 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+15 
L_SampleButtons62:
;ADC_Buttons.c,146 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons63
L_SampleButtons60:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons63:
;ADC_Buttons.c,147 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_26_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_26_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_26_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,148 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,149 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,150 :: 		case Kp_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kp    ");
L_SampleButtons64:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr27_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr27_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,151 :: 		if(OK_I){
	BTFSS       _B+0, 5 
	GOTO        L_SampleButtons65
;ADC_Buttons.c,152 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons66
;ADC_Buttons.c,153 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKI");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr28_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr28_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,154 :: 		valOf = pid_t.Kp;
	MOVF        _pid_t+0, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+1, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,155 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,156 :: 		}else pid_t.Kp = valOf;
	GOTO        L_SampleButtons67
L_SampleButtons66:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+0 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+1 
L_SampleButtons67:
;ADC_Buttons.c,157 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons68
L_SampleButtons65:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons68:
;ADC_Buttons.c,158 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_29_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_29_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_29_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,159 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,160 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,161 :: 		case Ki_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ki    ");
L_SampleButtons69:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr30_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr30_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,162 :: 		if(OK_J){
	BTFSS       _B+0, 6 
	GOTO        L_SampleButtons70
;ADC_Buttons.c,163 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons71
;ADC_Buttons.c,164 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKJ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr31_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr31_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,165 :: 		valOf = pid_t.Ki;
	MOVF        _pid_t+2, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+3, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,166 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,167 :: 		}else pid_t.Ki = valOf;
	GOTO        L_SampleButtons72
L_SampleButtons71:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+2 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+3 
L_SampleButtons72:
;ADC_Buttons.c,168 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons73
L_SampleButtons70:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons73:
;ADC_Buttons.c,169 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_32_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_32_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_32_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,170 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,171 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,172 :: 		case Kd_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kd    ");
L_SampleButtons74:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr33_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr33_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,173 :: 		if(OK_K){
	BTFSS       _B+0, 7 
	GOTO        L_SampleButtons75
;ADC_Buttons.c,174 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 2 
	GOTO        L_SampleButtons76
;ADC_Buttons.c,175 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKK");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr34_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr34_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,176 :: 		valOf = pid_t.Kd;
	MOVF        _pid_t+4, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+5, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,177 :: 		OFF_Bit = on;
	BSF         _B+0, 2 
;ADC_Buttons.c,178 :: 		}else pid_t.Kd = valOf;
	GOTO        L_SampleButtons77
L_SampleButtons76:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+4 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+5 
L_SampleButtons77:
;ADC_Buttons.c,179 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons78
L_SampleButtons75:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons78:
;ADC_Buttons.c,180 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_35_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_35_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_35_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,181 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,182 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,183 :: 		default: Sps.State = Return;
L_SampleButtons79:
	CLRF        _Sps+16 
;ADC_Buttons.c,184 :: 		valOf = Sps.State;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,185 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,186 :: 		}
L_SampleButtons21:
	MOVF        _Sps+16, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons23
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons24
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons29
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons34
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons39
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons44
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons49
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons54
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons59
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons64
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons69
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons74
	GOTO        L_SampleButtons79
L_SampleButtons22:
;ADC_Buttons.c,190 :: 		}else{
	GOTO        L_SampleButtons80
L_SampleButtons19:
;ADC_Buttons.c,191 :: 		if(!EEWrt){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons81
;ADC_Buttons.c,192 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,193 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,194 :: 		EEWrt = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,195 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,196 :: 		}
L_SampleButtons81:
;ADC_Buttons.c,197 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,198 :: 		}
L_SampleButtons80:
;ADC_Buttons.c,199 :: 		if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
	BTFSC       _B_+0, 0 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 1 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 2 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 3 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 4 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 5 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 6 
	GOTO        L_SampleButtons84
	BTFSC       _B_+0, 7 
	GOTO        L_SampleButtons84
	BTFSC       _B+0, 5 
	GOTO        L_SampleButtons84
	BTFSC       _B+0, 6 
	GOTO        L_SampleButtons84
	BTFSC       _B+0, 7 
	GOTO        L_SampleButtons84
L__SampleButtons140:
;ADC_Buttons.c,200 :: 		Sps.State = valOf;
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+16 
;ADC_Buttons.c,201 :: 		if((valOf > 11)&&(valOf<50000))valOf = 11;
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_valOf+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons160
	MOVF        ADC_Buttons_valOf+0, 0 
	SUBLW       11
L__SampleButtons160:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons87
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons161
	MOVLW       80
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons161:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons87
L__SampleButtons139:
	MOVLW       11
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
	GOTO        L_SampleButtons88
L_SampleButtons87:
;ADC_Buttons.c,202 :: 		else if (valOf >= 50001)valOf = 0;
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons162
	MOVLW       81
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons162:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons89
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
L_SampleButtons89:
L_SampleButtons88:
;ADC_Buttons.c,203 :: 		}
L_SampleButtons84:
;ADC_Buttons.c,205 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_IncValues:

;ADC_Buttons.c,207 :: 		unsigned int IncValues(unsigned int Val){
;ADC_Buttons.c,209 :: 		if((INC)||(DEC)){
	MOVLW       1
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues164
	MOVLW       144
	SUBWF       _But+4, 0 
L__IncValues164:
	BTFSS       STATUS+0, 0 
	GOTO        L__IncValues149
	MOVF        _But+5, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues165
	MOVF        _But+4, 0 
	SUBLW       147
L__IncValues165:
	BTFSS       STATUS+0, 0 
	GOTO        L__IncValues149
	GOTO        L__IncValues147
L__IncValues149:
	MOVLW       3
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues166
	MOVLW       35
	SUBWF       _But+4, 0 
L__IncValues166:
	BTFSS       STATUS+0, 0 
	GOTO        L__IncValues148
	MOVF        _But+5, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues167
	MOVF        _But+4, 0 
	SUBLW       39
L__IncValues167:
	BTFSS       STATUS+0, 0 
	GOTO        L__IncValues148
	GOTO        L__IncValues147
L__IncValues148:
	GOTO        L_IncValues96
L__IncValues147:
;ADC_Buttons.c,210 :: 		if(tmr.millis > But.ButMs){
	MOVF        _tmr+3, 0 
	SUBWF       _But+3, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues168
	MOVF        _tmr+2, 0 
	SUBWF       _But+2, 0 
L__IncValues168:
	BTFSC       STATUS+0, 0 
	GOTO        L_IncValues97
;ADC_Buttons.c,211 :: 		tmr.millis = 0;
	CLRF        _tmr+2 
	CLRF        _tmr+3 
;ADC_Buttons.c,212 :: 		Val = IncDec(Val);
	MOVF        FARG_IncValues_Val+0, 0 
	MOVWF       FARG_IncDec_Val+0 
	MOVF        FARG_IncValues_Val+1, 0 
	MOVWF       FARG_IncDec_Val+1 
	CALL        _IncDec+0, 0
	MOVF        R0, 0 
	MOVWF       FARG_IncValues_Val+0 
	MOVF        R1, 0 
	MOVWF       FARG_IncValues_Val+1 
;ADC_Buttons.c,214 :: 		if(k<10)But.ButMs = 500;
	MOVLW       0
	SUBWF       IncValues_k_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues169
	MOVLW       10
	SUBWF       IncValues_k_L0+0, 0 
L__IncValues169:
	BTFSC       STATUS+0, 0 
	GOTO        L_IncValues98
	MOVLW       244
	MOVWF       _But+2 
	MOVLW       1
	MOVWF       _But+3 
	GOTO        L_IncValues99
L_IncValues98:
;ADC_Buttons.c,215 :: 		else if ((k>=10)&&(k<30)) But.ButMs = 200;
	MOVLW       0
	SUBWF       IncValues_k_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues170
	MOVLW       10
	SUBWF       IncValues_k_L0+0, 0 
L__IncValues170:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncValues102
	MOVLW       0
	SUBWF       IncValues_k_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues171
	MOVLW       30
	SUBWF       IncValues_k_L0+0, 0 
L__IncValues171:
	BTFSC       STATUS+0, 0 
	GOTO        L_IncValues102
L__IncValues146:
	MOVLW       200
	MOVWF       _But+2 
	MOVLW       0
	MOVWF       _But+3 
	GOTO        L_IncValues103
L_IncValues102:
;ADC_Buttons.c,216 :: 		else if ((k>=30)&&(k<100)) But.ButMs = 10;
	MOVLW       0
	SUBWF       IncValues_k_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues172
	MOVLW       30
	SUBWF       IncValues_k_L0+0, 0 
L__IncValues172:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncValues106
	MOVLW       0
	SUBWF       IncValues_k_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncValues173
	MOVLW       100
	SUBWF       IncValues_k_L0+0, 0 
L__IncValues173:
	BTFSC       STATUS+0, 0 
	GOTO        L_IncValues106
L__IncValues145:
	MOVLW       10
	MOVWF       _But+2 
	MOVLW       0
	MOVWF       _But+3 
	GOTO        L_IncValues107
L_IncValues106:
;ADC_Buttons.c,217 :: 		else But.ButMs = 1;
	MOVLW       1
	MOVWF       _But+2 
	MOVLW       0
	MOVWF       _But+3 
L_IncValues107:
L_IncValues103:
L_IncValues99:
;ADC_Buttons.c,218 :: 		k++;
	INFSNZ      IncValues_k_L0+0, 1 
	INCF        IncValues_k_L0+1, 1 
;ADC_Buttons.c,219 :: 		}
L_IncValues97:
;ADC_Buttons.c,220 :: 		}else k=0;
	GOTO        L_IncValues108
L_IncValues96:
	CLRF        IncValues_k_L0+0 
	CLRF        IncValues_k_L0+1 
L_IncValues108:
;ADC_Buttons.c,222 :: 		return Val;
	MOVF        FARG_IncValues_Val+0, 0 
	MOVWF       R0 
	MOVF        FARG_IncValues_Val+1, 0 
	MOVWF       R1 
;ADC_Buttons.c,223 :: 		}
L_end_IncValues:
	RETURN      0
; end of _IncValues

_IncDec:

;ADC_Buttons.c,224 :: 		unsigned int IncDec(unsigned int Val ){
;ADC_Buttons.c,226 :: 		if(INC)Val++;
	MOVLW       1
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncDec175
	MOVLW       144
	SUBWF       _But+4, 0 
L__IncDec175:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncDec111
	MOVF        _But+5, 0 
	SUBLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L__IncDec176
	MOVF        _But+4, 0 
	SUBLW       147
L__IncDec176:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncDec111
L__IncDec151:
	INFSNZ      FARG_IncDec_Val+0, 1 
	INCF        FARG_IncDec_Val+1, 1 
L_IncDec111:
;ADC_Buttons.c,227 :: 		if(DEC) Val--;
	MOVLW       3
	SUBWF       _But+5, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__IncDec177
	MOVLW       35
	SUBWF       _But+4, 0 
L__IncDec177:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncDec114
	MOVF        _But+5, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__IncDec178
	MOVF        _But+4, 0 
	SUBLW       39
L__IncDec178:
	BTFSS       STATUS+0, 0 
	GOTO        L_IncDec114
L__IncDec150:
	MOVLW       1
	SUBWF       FARG_IncDec_Val+0, 1 
	MOVLW       0
	SUBWFB      FARG_IncDec_Val+1, 1 
L_IncDec114:
;ADC_Buttons.c,229 :: 		return Val;
	MOVF        FARG_IncDec_Val+0, 0 
	MOVWF       R0 
	MOVF        FARG_IncDec_Val+1, 0 
	MOVWF       R1 
;ADC_Buttons.c,230 :: 		}
L_end_IncDec:
	RETURN      0
; end of _IncDec

_ResetBits:

;ADC_Buttons.c,231 :: 		void ResetBits(){
;ADC_Buttons.c,232 :: 		valOf = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,233 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,234 :: 		OK_Bit = 0;
	BCF         _B+0, 0 
;ADC_Buttons.c,235 :: 		OK_A = 0;
	BCF         _B_+0, 0 
;ADC_Buttons.c,236 :: 		OK_B = 0;
	BCF         _B_+0, 1 
;ADC_Buttons.c,237 :: 		OK_C = 0;
	BCF         _B_+0, 2 
;ADC_Buttons.c,238 :: 		OK_D = 0;
	BCF         _B_+0, 3 
;ADC_Buttons.c,239 :: 		OK_E = 0;
	BCF         _B_+0, 4 
;ADC_Buttons.c,240 :: 		OK_F = 0;
	BCF         _B_+0, 5 
;ADC_Buttons.c,241 :: 		OK_G = 0;
	BCF         _B_+0, 6 
;ADC_Buttons.c,242 :: 		OK_H = 0;
	BCF         _B_+0, 7 
;ADC_Buttons.c,243 :: 		OK_I = 0;
	BCF         _B+0, 5 
;ADC_Buttons.c,244 :: 		OK_J = 0;
	BCF         _B+0, 6 
;ADC_Buttons.c,245 :: 		OK_K = 0;
	BCF         _B+0, 7 
;ADC_Buttons.c,246 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_SavedVals:

;ADC_Buttons.c,248 :: 		void SavedVals(){
;ADC_Buttons.c,249 :: 		if(Sps.State == RampDeg)          OK_A = !OK_A;
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals115
	BTG         _B_+0, 0 
	GOTO        L_SavedVals116
L_SavedVals115:
;ADC_Buttons.c,250 :: 		else if(Sps.State == RampTm)      OK_B = !OK_B;
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals117
	BTG         _B_+0, 1 
	GOTO        L_SavedVals118
L_SavedVals117:
;ADC_Buttons.c,251 :: 		else if(Sps.State == SoakDeg)     OK_C = !OK_C;
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals119
	BTG         _B_+0, 2 
	GOTO        L_SavedVals120
L_SavedVals119:
;ADC_Buttons.c,252 :: 		else if(Sps.State == SoakTm)      OK_D = !OK_D;
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals121
	BTG         _B_+0, 3 
	GOTO        L_SavedVals122
L_SavedVals121:
;ADC_Buttons.c,253 :: 		else if(Sps.State == SpikeDeg)    OK_E = !OK_E;
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals123
	BTG         _B_+0, 4 
	GOTO        L_SavedVals124
L_SavedVals123:
;ADC_Buttons.c,254 :: 		else if(Sps.State == SpikeTM)     OK_F = !OK_F;
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals125
	BTG         _B_+0, 5 
	GOTO        L_SavedVals126
L_SavedVals125:
;ADC_Buttons.c,255 :: 		else if(Sps.State == CoolDownDeg) OK_G = !OK_G;
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals127
	BTG         _B_+0, 6 
	GOTO        L_SavedVals128
L_SavedVals127:
;ADC_Buttons.c,256 :: 		else if(Sps.State == CoolDowntM)  OK_H = !OK_H;
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals129
	BTG         _B_+0, 7 
	GOTO        L_SavedVals130
L_SavedVals129:
;ADC_Buttons.c,257 :: 		else if(Sps.State == Kp_)         OK_I = !OK_I;
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals131
	BTG         _B+0, 5 
	GOTO        L_SavedVals132
L_SavedVals131:
;ADC_Buttons.c,258 :: 		else if(Sps.State == Ki_)         OK_J = !OK_J;
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals133
	BTG         _B+0, 6 
	GOTO        L_SavedVals134
L_SavedVals133:
;ADC_Buttons.c,259 :: 		else if(Sps.State == Kd_)         OK_K = !OK_K;
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals135
	BTG         _B+0, 7 
	GOTO        L_SavedVals136
L_SavedVals135:
;ADC_Buttons.c,260 :: 		else OK_Bit = !OK_Bit;
	BTG         _B+0, 0 
L_SavedVals136:
L_SavedVals134:
L_SavedVals132:
L_SavedVals130:
L_SavedVals128:
L_SavedVals126:
L_SavedVals124:
L_SavedVals122:
L_SavedVals120:
L_SavedVals118:
L_SavedVals116:
;ADC_Buttons.c,261 :: 		}
L_end_SavedVals:
	RETURN      0
; end of _SavedVals

_doOFFBitoff:

;ADC_Buttons.c,263 :: 		void doOFFBitoff(){
;ADC_Buttons.c,264 :: 		if(OFF_Bit){
	BTFSS       _B+0, 2 
	GOTO        L_doOFFBitoff137
;ADC_Buttons.c,265 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr36_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr36_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,266 :: 		valOf = Sps.State;
	MOVF        _Sps+16, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,267 :: 		OFF_Bit = off;
	BCF         _B+0, 2 
;ADC_Buttons.c,268 :: 		}
L_doOFFBitoff137:
;ADC_Buttons.c,270 :: 		}
L_end_doOFFBitoff:
	RETURN      0
; end of _doOFFBitoff

_EERead:

;ADC_Buttons.c,272 :: 		void EERead(){
;ADC_Buttons.c,274 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,275 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,276 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,277 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,278 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,279 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,280 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,281 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,282 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,283 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,284 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,285 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,286 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,287 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,288 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,289 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,292 :: 		Lo(pid_t.Kp)     = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,293 :: 		Hi(pid_t.Kp)     = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,294 :: 		Lo(pid_t.Ki)     = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,295 :: 		Hi(pid_t.Ki)     = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,296 :: 		Lo(pid_t.Kd)     = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,297 :: 		Hi(pid_t.Kd)     = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,300 :: 		Lo(TempTicks.RampTick)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,301 :: 		Hi(TempTicks.RampTick)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,302 :: 		Lo(TempTicks.SoakTick)  = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,303 :: 		Hi(TempTicks.SoakTick)  = EEPROM_Read(0x19);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,304 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,305 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,306 :: 		Lo(TempTicks.CoolTick)  = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,307 :: 		Hi(TempTicks.CoolTick)  = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,309 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,310 :: 		void EEWrite(){
;ADC_Buttons.c,311 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr37_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr37_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,313 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,314 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,315 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,316 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,317 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,318 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,319 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,320 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,321 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,322 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,323 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,324 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,325 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,326 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,327 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,328 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,331 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,332 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,333 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,334 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,335 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,336 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,339 :: 		EEPROM_Write(0x16, Lo(TempTicks.RampTick));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,340 :: 		EEPROM_Write(0x17, Hi(TempTicks.RampTick));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,341 :: 		EEPROM_Write(0x18, Lo(TempTicks.SoakTick));
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,342 :: 		EEPROM_Write(0x19, Hi(TempTicks.SoakTick));
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,343 :: 		EEPROM_Write(0x1A, Lo(TempTicks.SpikeTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,344 :: 		EEPROM_Write(0x1B, Hi(TempTicks.SpikeTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,345 :: 		EEPROM_Write(0x1C, Lo(TempTicks.CoolTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,346 :: 		EEPROM_Write(0x1D, Hi(TempTicks.CoolTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,347 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite138:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite138
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite138
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite138
	NOP
;ADC_Buttons.c,348 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
