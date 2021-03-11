
_SampleButtons:

;ADC_Buttons.c,42 :: 		void SampleButtons(){
;ADC_Buttons.c,46 :: 		if(!Menu_Bit){
	BTFSC       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,47 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,48 :: 		return;
	GOTO        L_end_SampleButtons
;ADC_Buttons.c,49 :: 		}
L_SampleButtons0:
;ADC_Buttons.c,51 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons1
;ADC_Buttons.c,52 :: 		if(!P0 && (enC != 0)){
	BTFSC       ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
	GOTO        L_SampleButtons4
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons222
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons222:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons4
L__SampleButtons220:
;ADC_Buttons.c,53 :: 		P0 = 1;
	BSF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,54 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,55 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,56 :: 		}
L_SampleButtons4:
;ADC_Buttons.c,58 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E && !OK_F && !OK_G)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 5 
	GOTO        L_SampleButtons7
	BTFSC       ADC_Buttons_B_+0, 6 
	GOTO        L_SampleButtons7
L__SampleButtons219:
;ADC_Buttons.c,59 :: 		enC = Get_EncoderValue();//get encoder value
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
L_SampleButtons7:
;ADC_Buttons.c,61 :: 		if(enC < 0 || enC > 65000){
	MOVLW       0
	SUBWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons223
	MOVLW       0
	SUBWF       ADC_Buttons_enC+0, 0 
L__SampleButtons223:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons218
	MOVF        ADC_Buttons_enC+1, 0 
	SUBLW       253
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons224
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       232
L__SampleButtons224:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons218
	GOTO        L_SampleButtons10
L__SampleButtons218:
;ADC_Buttons.c,62 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,63 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,64 :: 		}
L_SampleButtons10:
;ADC_Buttons.c,66 :: 		if(enC_last != enC){
	MOVF        ADC_Buttons_enC_last+1, 0 
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons225
	MOVF        ADC_Buttons_enC+0, 0 
	XORWF       ADC_Buttons_enC_last+0, 0 
L__SampleButtons225:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons11
;ADC_Buttons.c,67 :: 		enC_last = enC;
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_last+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,68 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E && !OK_F && !OK_G){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 5 
	GOTO        L_SampleButtons14
	BTFSC       ADC_Buttons_B_+0, 6 
	GOTO        L_SampleButtons14
L__SampleButtons217:
;ADC_Buttons.c,69 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVF        ADC_Buttons_enC_line_last+0, 0 
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr1_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr1_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,70 :: 		enC_line_inc =  enC % 4 + 1;
	MOVLW       3
	ANDWF       ADC_Buttons_enC+0, 0 
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       R1 
	MOVLW       0
	ANDWF       R1, 1 
	INFSNZ      R0, 1 
	INCF        R1, 1 
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,71 :: 		enC_line_last = enC_line_inc;
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC_line_last+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC_line_last+1 
;ADC_Buttons.c,72 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVF        R0, 0 
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr2_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr2_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,73 :: 		sprintf(txt4_,"%5u",enC_line_inc);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_3_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_3_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_3_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_enC_line_inc+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,74 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,75 :: 		sprintf(txt4_,"%5u",enC);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_4_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_4_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_4_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,76 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4_);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4_+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,77 :: 		}
L_SampleButtons14:
;ADC_Buttons.c,78 :: 		}
L_SampleButtons11:
;ADC_Buttons.c,80 :: 		}
L_SampleButtons1:
;ADC_Buttons.c,82 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons15
;ADC_Buttons.c,83 :: 		if(EEWrt)EEWrt = off;
	BTFSS       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons16
	BCF         ADC_Buttons_B+0, 4 
L_SampleButtons16:
;ADC_Buttons.c,84 :: 		state:
___SampleButtons_state:
;ADC_Buttons.c,85 :: 		switch(Sps.State){
	GOTO        L_SampleButtons17
;ADC_Buttons.c,86 :: 		case Return:   if(enC > 3){
L_SampleButtons19:
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons226
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons226:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons20
;ADC_Buttons.c,87 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,88 :: 		}
L_SampleButtons20:
;ADC_Buttons.c,89 :: 		close:
___SampleButtons_close:
;ADC_Buttons.c,90 :: 		switch(enC){
	GOTO        L_SampleButtons21
;ADC_Buttons.c,91 :: 		case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
L_SampleButtons23:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       100
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons26
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons26
	BTFSC       ADC_Buttons_B+0, 1 
	GOTO        L_SampleButtons26
L__SampleButtons216:
;ADC_Buttons.c,92 :: 		Ok_Bit = 1;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,93 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,94 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,95 :: 		}
L_SampleButtons26:
;ADC_Buttons.c,96 :: 		case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
L_SampleButtons27:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons30
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons30
L__SampleButtons215:
;ADC_Buttons.c,97 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,98 :: 		enC = Save_EncoderValue(1);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,99 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,100 :: 		}
L_SampleButtons30:
;ADC_Buttons.c,102 :: 		case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
L_SampleButtons31:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons34
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons34
L__SampleButtons214:
;ADC_Buttons.c,103 :: 		Sps.State = PIDMenu;
	MOVLW       3
	MOVWF       _Sps+16 
;ADC_Buttons.c,104 :: 		enC = Save_EncoderValue(2);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,105 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,106 :: 		}
L_SampleButtons34:
;ADC_Buttons.c,107 :: 		case 3:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
L_SampleButtons35:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr5_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr5_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,108 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr6_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr6_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,109 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr7_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr7_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,110 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr8_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr8_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,111 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,112 :: 		case 4:
L_SampleButtons36:
;ADC_Buttons.c,113 :: 		case 5:
L_SampleButtons37:
;ADC_Buttons.c,114 :: 		case 6:
L_SampleButtons38:
;ADC_Buttons.c,115 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons39:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr9_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr9_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,116 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr10_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr10_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,117 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr11_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr11_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,118 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr12_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr12_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,119 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,120 :: 		case 8:
L_SampleButtons40:
;ADC_Buttons.c,121 :: 		case 9:
L_SampleButtons41:
;ADC_Buttons.c,122 :: 		case 10:
L_SampleButtons42:
;ADC_Buttons.c,123 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons43:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr13_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr13_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,124 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr14_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr14_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,125 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr15_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr15_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,126 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr16_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr16_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,127 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,128 :: 		default:
L_SampleButtons44:
;ADC_Buttons.c,129 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,130 :: 		Delay_ms(800);
	MOVLW       65
	MOVWF       R11, 0
	MOVLW       240
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_SampleButtons45:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons45
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons45
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons45
;ADC_Buttons.c,131 :: 		Menu_Bit = off;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,132 :: 		Ok_Bit   = off;
	BCF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,133 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,134 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,135 :: 		break;
	GOTO        L_SampleButtons22
;ADC_Buttons.c,136 :: 		}
L_SampleButtons21:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons227
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons227:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons23
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons228
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons228:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons27
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons229
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons229:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons31
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons230
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons230:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons35
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons231
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons231:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons36
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons232
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons232:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons37
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons233
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons233:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons38
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons234
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons234:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons39
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons235
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons235:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons40
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons236
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons236:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons41
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons237
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons237:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons42
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons238
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons238:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons43
	GOTO        L_SampleButtons44
L_SampleButtons22:
;ADC_Buttons.c,137 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,138 :: 		case TempMenu:
L_SampleButtons46:
;ADC_Buttons.c,139 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons239
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons239:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons47
;ADC_Buttons.c,140 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,141 :: 		}
L_SampleButtons47:
;ADC_Buttons.c,142 :: 		ret1:
___SampleButtons_ret1:
;ADC_Buttons.c,143 :: 		switch(enC){
	GOTO        L_SampleButtons48
;ADC_Buttons.c,144 :: 		case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
L_SampleButtons50:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons53
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons53
L__SampleButtons213:
;ADC_Buttons.c,145 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,146 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,147 :: 		goto ret1;
	GOTO        ___SampleButtons_ret1
;ADC_Buttons.c,148 :: 		}
L_SampleButtons53:
;ADC_Buttons.c,149 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
L_SampleButtons54:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons57
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons57
L__SampleButtons212:
;ADC_Buttons.c,150 :: 		Sps.State = RampSettings;
	MOVLW       4
	MOVWF       _Sps+16 
;ADC_Buttons.c,151 :: 		enC = Save_EncoderValue(1);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,152 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,153 :: 		}
L_SampleButtons57:
;ADC_Buttons.c,154 :: 		case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
L_SampleButtons58:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons61
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons61
L__SampleButtons211:
;ADC_Buttons.c,155 :: 		Sps.State = SoakSettings;
	MOVLW       5
	MOVWF       _Sps+16 
;ADC_Buttons.c,156 :: 		enC = Save_EncoderValue(1);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,157 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,158 :: 		}
L_SampleButtons61:
;ADC_Buttons.c,159 :: 		case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
L_SampleButtons62:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons65
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons65
L__SampleButtons210:
;ADC_Buttons.c,160 :: 		Sps.State = SpikeSettings;
	MOVLW       6
	MOVWF       _Sps+16 
;ADC_Buttons.c,161 :: 		enC = Save_EncoderValue(1);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,162 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,163 :: 		}
L_SampleButtons65:
;ADC_Buttons.c,164 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr17_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr17_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,165 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr18_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr18_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,166 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr19_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr19_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,167 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr20_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr20_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,168 :: 		break;
	GOTO        L_SampleButtons49
;ADC_Buttons.c,169 :: 		case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
L_SampleButtons66:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons69
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons69
L__SampleButtons209:
;ADC_Buttons.c,170 :: 		Sps.State = CoolSettings;
	MOVLW       7
	MOVWF       _Sps+16 
;ADC_Buttons.c,171 :: 		enC = Save_EncoderValue(1);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,172 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,173 :: 		}
L_SampleButtons69:
;ADC_Buttons.c,174 :: 		case 5:
L_SampleButtons70:
;ADC_Buttons.c,175 :: 		case 6:
L_SampleButtons71:
;ADC_Buttons.c,176 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
L_SampleButtons72:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr21_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr21_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,177 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr22_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr22_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,178 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr23_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr23_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,179 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr24_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr24_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,180 :: 		break;
	GOTO        L_SampleButtons49
;ADC_Buttons.c,181 :: 		case 8:
L_SampleButtons73:
;ADC_Buttons.c,182 :: 		case 9:
L_SampleButtons74:
;ADC_Buttons.c,183 :: 		case 10:
L_SampleButtons75:
;ADC_Buttons.c,184 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons76:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr25_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr25_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,185 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr26_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr26_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,186 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr27_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr27_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,187 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr28_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr28_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,188 :: 		break;
	GOTO        L_SampleButtons49
;ADC_Buttons.c,189 :: 		default:
L_SampleButtons77:
;ADC_Buttons.c,190 :: 		if(Ok_Bit || (enC > 12)){
	BTFSC       ADC_Buttons_B+0, 1 
	GOTO        L__SampleButtons208
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons240
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       12
L__SampleButtons240:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons208
	GOTO        L_SampleButtons80
L__SampleButtons208:
;ADC_Buttons.c,191 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,192 :: 		Sps.State = 1;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,194 :: 		}
L_SampleButtons80:
;ADC_Buttons.c,195 :: 		break;
	GOTO        L_SampleButtons49
;ADC_Buttons.c,196 :: 		}
L_SampleButtons48:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons241
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons241:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons50
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons242
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons242:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons54
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons243
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons243:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons58
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons244
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons244:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons62
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons245
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons245:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons66
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons246
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons246:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons70
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons247
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons247:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons71
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons248
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons248:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons72
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons249
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons249:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons73
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons250
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons250:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons74
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons251
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons251:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons75
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons252
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons252:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons76
	GOTO        L_SampleButtons77
L_SampleButtons49:
;ADC_Buttons.c,197 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,198 :: 		case PIDMenu:
L_SampleButtons81:
;ADC_Buttons.c,199 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons253
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons253:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons82
;ADC_Buttons.c,200 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,201 :: 		}
L_SampleButtons82:
;ADC_Buttons.c,202 :: 		ret2:
___SampleButtons_ret2:
;ADC_Buttons.c,203 :: 		switch(enC){
	GOTO        L_SampleButtons83
;ADC_Buttons.c,204 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
L_SampleButtons85:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons88
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons88
L__SampleButtons207:
;ADC_Buttons.c,205 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,206 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,207 :: 		goto ret2;
	GOTO        ___SampleButtons_ret2
;ADC_Buttons.c,208 :: 		}
L_SampleButtons88:
;ADC_Buttons.c,209 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KpSettings)){
L_SampleButtons89:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons92
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons92
L__SampleButtons206:
;ADC_Buttons.c,210 :: 		Sps.State = KpSettings;
	MOVLW       8
	MOVWF       _Sps+16 
;ADC_Buttons.c,211 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,212 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,213 :: 		}
L_SampleButtons92:
;ADC_Buttons.c,214 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KiSettings)){
L_SampleButtons93:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons96
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons96
L__SampleButtons205:
;ADC_Buttons.c,215 :: 		Sps.State = KiSettings;
	MOVLW       9
	MOVWF       _Sps+16 
;ADC_Buttons.c,216 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,217 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,218 :: 		}
L_SampleButtons96:
;ADC_Buttons.c,219 :: 		case 3:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KdSettings)){
L_SampleButtons97:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons100
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons100
L__SampleButtons204:
;ADC_Buttons.c,220 :: 		Sps.State = KdSettings;
	MOVLW       10
	MOVWF       _Sps+16 
;ADC_Buttons.c,221 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,222 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,223 :: 		}
L_SampleButtons100:
;ADC_Buttons.c,224 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr29_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr29_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,225 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr30_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr30_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,226 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr31_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr31_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,227 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr32_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr32_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,228 :: 		break;
	GOTO        L_SampleButtons84
;ADC_Buttons.c,229 :: 		case 4:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != KtimeSettings)){
L_SampleButtons101:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons104
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons104
L__SampleButtons203:
;ADC_Buttons.c,230 :: 		Sps.State = KtimeSettings;
	MOVLW       11
	MOVWF       _Sps+16 
;ADC_Buttons.c,231 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,232 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,233 :: 		}
L_SampleButtons104:
;ADC_Buttons.c,234 :: 		case 5:
L_SampleButtons105:
;ADC_Buttons.c,235 :: 		case 6:
L_SampleButtons106:
;ADC_Buttons.c,236 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Kt     ");
L_SampleButtons107:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr33_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr33_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,237 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr34_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr34_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,238 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr35_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr35_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,239 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr36_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr36_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,240 :: 		break;
	GOTO        L_SampleButtons84
;ADC_Buttons.c,241 :: 		case 8:
L_SampleButtons108:
;ADC_Buttons.c,242 :: 		case 9:
L_SampleButtons109:
;ADC_Buttons.c,243 :: 		case 10:
L_SampleButtons110:
;ADC_Buttons.c,244 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons111:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr37_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr37_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,245 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr38_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr38_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,246 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr39_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr39_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,247 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr40_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr40_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,248 :: 		break;
	GOTO        L_SampleButtons84
;ADC_Buttons.c,249 :: 		default:
L_SampleButtons112:
;ADC_Buttons.c,250 :: 		if(Ok_Bit || (enC > 12)){
	BTFSC       ADC_Buttons_B+0, 1 
	GOTO        L__SampleButtons202
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons254
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       12
L__SampleButtons254:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons202
	GOTO        L_SampleButtons115
L__SampleButtons202:
;ADC_Buttons.c,251 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,252 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,253 :: 		}
L_SampleButtons115:
;ADC_Buttons.c,254 :: 		break;
	GOTO        L_SampleButtons84
;ADC_Buttons.c,255 :: 		}
L_SampleButtons83:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons255
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons255:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons85
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons256
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons256:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons89
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons257
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons257:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons93
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons258
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons258:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons97
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons259
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons259:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons101
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons260
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons260:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons105
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons261
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons261:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons106
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons262
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons262:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons107
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons263
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons263:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons108
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons264
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons264:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons109
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons265
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons265:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons110
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons266
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons266:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons111
	GOTO        L_SampleButtons112
L_SampleButtons84:
;ADC_Buttons.c,256 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,257 :: 		case RampSettings:
L_SampleButtons116:
;ADC_Buttons.c,258 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons267
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons267:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons117
;ADC_Buttons.c,259 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,260 :: 		}
L_SampleButtons117:
;ADC_Buttons.c,261 :: 		ret3:
___SampleButtons_ret3:
;ADC_Buttons.c,262 :: 		switch(enC){
	GOTO        L_SampleButtons118
;ADC_Buttons.c,263 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
L_SampleButtons120:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons123
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons123
L__SampleButtons201:
;ADC_Buttons.c,264 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,265 :: 		while(!RA2_bit);
L_SampleButtons124:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons125
	GOTO        L_SampleButtons124
L_SampleButtons125:
;ADC_Buttons.c,266 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,267 :: 		goto ret3;
	GOTO        ___SampleButtons_ret3
;ADC_Buttons.c,268 :: 		}
L_SampleButtons123:
;ADC_Buttons.c,269 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons126:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons129
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons129
L__SampleButtons200:
;ADC_Buttons.c,270 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,271 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,272 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,273 :: 		Save_EncoderValue(Sps.RmpDeg);
	MOVF        _Sps+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,274 :: 		}
L_SampleButtons129:
;ADC_Buttons.c,275 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons130
;ADC_Buttons.c,276 :: 		Sps.RmpDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
	MOVF        R1, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,277 :: 		if(Button(&PORTA, 2, 200, 0)){
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons131
;ADC_Buttons.c,278 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,279 :: 		while(!RA2_bit);
L_SampleButtons132:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons133
	GOTO        L_SampleButtons132
L_SampleButtons133:
;ADC_Buttons.c,280 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,281 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,282 :: 		}
L_SampleButtons131:
;ADC_Buttons.c,283 :: 		}
L_SampleButtons130:
;ADC_Buttons.c,284 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons134:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons137
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons137
L__SampleButtons199:
;ADC_Buttons.c,285 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,286 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,287 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,288 :: 		Save_EncoderValue(Sps.RmpTmr);
	MOVF        _Sps+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,289 :: 		while(!RA2_bit);
L_SampleButtons138:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons139
	GOTO        L_SampleButtons138
L_SampleButtons139:
;ADC_Buttons.c,290 :: 		}
L_SampleButtons137:
;ADC_Buttons.c,291 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons140
;ADC_Buttons.c,292 :: 		Sps.RmpTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
	MOVF        R1, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,293 :: 		if(Button(&PORTA, 2, 200, 0)){
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons141
;ADC_Buttons.c,294 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,295 :: 		while(!RA2_bit);
L_SampleButtons142:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons143
	GOTO        L_SampleButtons142
L_SampleButtons143:
;ADC_Buttons.c,296 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,297 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,298 :: 		}
L_SampleButtons141:
;ADC_Buttons.c,299 :: 		}
L_SampleButtons140:
;ADC_Buttons.c,300 :: 		case 3:
L_SampleButtons144:
;ADC_Buttons.c,301 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr41_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr41_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,302 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr42_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr42_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,303 :: 		sprintf(txt4,"%3d",Sps.RmpDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_43_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_43_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_43_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,304 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,305 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr44_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr44_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,306 :: 		sprintf(txt4,"%3d",Sps.RmpTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_45_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_45_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_45_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,307 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,308 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr46_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr46_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,309 :: 		break;
	GOTO        L_SampleButtons119
;ADC_Buttons.c,310 :: 		default:
L_SampleButtons145:
;ADC_Buttons.c,311 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,312 :: 		break;
	GOTO        L_SampleButtons119
;ADC_Buttons.c,313 :: 		}
L_SampleButtons118:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons268
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons268:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons120
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons269
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons269:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons126
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons270
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons270:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons134
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons271
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons271:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons144
	GOTO        L_SampleButtons145
L_SampleButtons119:
;ADC_Buttons.c,314 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,315 :: 		case SoakSettings:
L_SampleButtons146:
;ADC_Buttons.c,316 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons272
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons272:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons147
;ADC_Buttons.c,317 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,318 :: 		}
L_SampleButtons147:
;ADC_Buttons.c,319 :: 		ret4:
___SampleButtons_ret4:
;ADC_Buttons.c,320 :: 		switch(enC){
	GOTO        L_SampleButtons148
;ADC_Buttons.c,321 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
L_SampleButtons150:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons153
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons153
L__SampleButtons198:
;ADC_Buttons.c,322 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,323 :: 		while(!RA2_bit);
L_SampleButtons154:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons155
	GOTO        L_SampleButtons154
L_SampleButtons155:
;ADC_Buttons.c,324 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,325 :: 		goto ret4;
	GOTO        ___SampleButtons_ret4
;ADC_Buttons.c,326 :: 		}
L_SampleButtons153:
;ADC_Buttons.c,327 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons156:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons159
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons159
L__SampleButtons197:
;ADC_Buttons.c,328 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,329 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,330 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,331 :: 		Save_EncoderValue(Sps.SokDeg);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,332 :: 		}
L_SampleButtons159:
;ADC_Buttons.c,333 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons160
;ADC_Buttons.c,334 :: 		Sps.SokDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
	MOVF        R1, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,335 :: 		if(Button(&PORTA, 2, 200, 0)){
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons161
;ADC_Buttons.c,336 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,337 :: 		while(!RA2_bit);
L_SampleButtons162:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons163
	GOTO        L_SampleButtons162
L_SampleButtons163:
;ADC_Buttons.c,338 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,339 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,340 :: 		}
L_SampleButtons161:
;ADC_Buttons.c,341 :: 		}
L_SampleButtons160:
;ADC_Buttons.c,342 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons164:
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons167
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons167
L__SampleButtons196:
;ADC_Buttons.c,343 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,344 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,345 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,346 :: 		Save_EncoderValue(Sps.SokTmr);
	MOVF        _Sps+6, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,347 :: 		while(!RA2_bit);
L_SampleButtons168:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons169
	GOTO        L_SampleButtons168
L_SampleButtons169:
;ADC_Buttons.c,348 :: 		}
L_SampleButtons167:
;ADC_Buttons.c,349 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons170
;ADC_Buttons.c,350 :: 		Sps.SokTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
	MOVF        R1, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,351 :: 		if(Button(&PORTA, 2, 200, 0)){
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       200
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons171
;ADC_Buttons.c,352 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,353 :: 		while(!RA2_bit);
L_SampleButtons172:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons173
	GOTO        L_SampleButtons172
L_SampleButtons173:
;ADC_Buttons.c,354 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,355 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,356 :: 		}
L_SampleButtons171:
;ADC_Buttons.c,357 :: 		}
L_SampleButtons170:
;ADC_Buttons.c,358 :: 		case 3:
L_SampleButtons174:
;ADC_Buttons.c,359 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr47_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr47_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,360 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr48_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr48_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,361 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_49_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_49_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_49_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,362 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,363 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr50_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr50_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,364 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_51_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_51_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_51_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,365 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,366 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr52_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr52_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,367 :: 		break;
	GOTO        L_SampleButtons149
;ADC_Buttons.c,368 :: 		default:
L_SampleButtons175:
;ADC_Buttons.c,369 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,370 :: 		break;
	GOTO        L_SampleButtons149
;ADC_Buttons.c,371 :: 		}
L_SampleButtons148:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons273
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons273:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons150
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons274
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons274:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons156
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons275
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons275:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons164
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons276
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons276:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons174
	GOTO        L_SampleButtons175
L_SampleButtons149:
;ADC_Buttons.c,372 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,373 :: 		case SpikeSettings:
L_SampleButtons176:
;ADC_Buttons.c,374 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,375 :: 		case CoolSettings:
L_SampleButtons177:
;ADC_Buttons.c,376 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,377 :: 		case KpSettings:
L_SampleButtons178:
;ADC_Buttons.c,378 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,379 :: 		case KiSettings:
L_SampleButtons179:
;ADC_Buttons.c,380 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,381 :: 		case KdSettings:
L_SampleButtons180:
;ADC_Buttons.c,382 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,383 :: 		case KtimeSettings:
L_SampleButtons181:
;ADC_Buttons.c,384 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,385 :: 		default: Sps.State = Return;
L_SampleButtons182:
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,386 :: 		break;
	GOTO        L_SampleButtons18
;ADC_Buttons.c,387 :: 		}
L_SampleButtons17:
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons19
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons46
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons81
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons116
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons146
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons176
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons177
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons178
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons179
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons180
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons181
	GOTO        L_SampleButtons182
L_SampleButtons18:
;ADC_Buttons.c,391 :: 		}else{
	GOTO        L_SampleButtons183
L_SampleButtons15:
;ADC_Buttons.c,392 :: 		if(!EEWrt){
	BTFSC       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons184
;ADC_Buttons.c,393 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,394 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,395 :: 		EEWrt = on;
	BSF         ADC_Buttons_B+0, 4 
;ADC_Buttons.c,396 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,397 :: 		}
L_SampleButtons184:
;ADC_Buttons.c,398 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,399 :: 		}
L_SampleButtons183:
;ADC_Buttons.c,400 :: 		if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 5 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 6 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B_+0, 7 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B+0, 5 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B+0, 6 
	GOTO        L_SampleButtons187
	BTFSC       ADC_Buttons_B+0, 7 
	GOTO        L_SampleButtons187
L__SampleButtons195:
;ADC_Buttons.c,402 :: 		if((valOf > 11)&&(valOf<50000))valOf = 11;
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_valOf+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons277
	MOVF        ADC_Buttons_valOf+0, 0 
	SUBLW       11
L__SampleButtons277:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons190
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons278
	MOVLW       80
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons278:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons190
L__SampleButtons194:
	MOVLW       11
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
	GOTO        L_SampleButtons191
L_SampleButtons190:
;ADC_Buttons.c,403 :: 		else if (valOf >= 50001)valOf = 0;
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons279
	MOVLW       81
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons279:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons192
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
L_SampleButtons192:
L_SampleButtons191:
;ADC_Buttons.c,404 :: 		}
L_SampleButtons187:
;ADC_Buttons.c,406 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,408 :: 		void ResetBits(){
;ADC_Buttons.c,409 :: 		valOf     = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,410 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,411 :: 		Menu_Bit  = 0;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,412 :: 		OK_Bit    = 0;
	BCF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,413 :: 		OK_A      = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,414 :: 		OK_B      = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,415 :: 		OK_C      = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,416 :: 		OK_D      = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,417 :: 		OK_E      = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,418 :: 		OK_F      = 0;
	BCF         ADC_Buttons_B_+0, 5 
;ADC_Buttons.c,419 :: 		OK_G      = 0;
	BCF         ADC_Buttons_B_+0, 6 
;ADC_Buttons.c,420 :: 		OK_H      = 0;
	BCF         ADC_Buttons_B_+0, 7 
;ADC_Buttons.c,421 :: 		OK_I      = 0;
	BCF         ADC_Buttons_B+0, 5 
;ADC_Buttons.c,422 :: 		OK_J      = 0;
	BCF         ADC_Buttons_B+0, 6 
;ADC_Buttons.c,423 :: 		OK_K      = 0;
	BCF         ADC_Buttons_B+0, 7 
;ADC_Buttons.c,424 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_SavedVals:

;ADC_Buttons.c,426 :: 		void SavedVals(){
;ADC_Buttons.c,428 :: 		}
L_end_SavedVals:
	RETURN      0
; end of _SavedVals

_doOFFBitoff:

;ADC_Buttons.c,430 :: 		void doOFFBitoff(){
;ADC_Buttons.c,432 :: 		}
L_end_doOFFBitoff:
	RETURN      0
; end of _doOFFBitoff

_EERead:

;ADC_Buttons.c,434 :: 		void EERead(){
;ADC_Buttons.c,436 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,437 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,438 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,439 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,440 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,441 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,442 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,443 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,444 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,445 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,446 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,447 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,448 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,449 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,450 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,451 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,454 :: 		Lo(pid_t.Kp)     = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,455 :: 		Hi(pid_t.Kp)     = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,456 :: 		Lo(pid_t.Ki)     = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,457 :: 		Hi(pid_t.Ki)     = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,458 :: 		Lo(pid_t.Kd)     = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,459 :: 		Hi(pid_t.Kd)     = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,462 :: 		Lo(TempTicks.RampTick)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,463 :: 		Hi(TempTicks.RampTick)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,464 :: 		Lo(TempTicks.SoakTick)  = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,465 :: 		Hi(TempTicks.SoakTick)  = EEPROM_Read(0x19);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,466 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,467 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,468 :: 		Lo(TempTicks.CoolTick)  = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,469 :: 		Hi(TempTicks.CoolTick)  = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,471 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,472 :: 		void EEWrite(){
;ADC_Buttons.c,473 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr53_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr53_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,475 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,476 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,477 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,478 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,479 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,480 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,481 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,482 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,483 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,484 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,485 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,486 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,487 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,488 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,489 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,490 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,493 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,494 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,495 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,496 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,497 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,498 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,501 :: 		EEPROM_Write(0x16, Lo(TempTicks.RampTick));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,502 :: 		EEPROM_Write(0x17, Hi(TempTicks.RampTick));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,503 :: 		EEPROM_Write(0x18, Lo(TempTicks.SoakTick));
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,504 :: 		EEPROM_Write(0x19, Hi(TempTicks.SoakTick));
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,505 :: 		EEPROM_Write(0x1A, Lo(TempTicks.SpikeTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,506 :: 		EEPROM_Write(0x1B, Hi(TempTicks.SpikeTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,507 :: 		EEPROM_Write(0x1C, Lo(TempTicks.CoolTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,508 :: 		EEPROM_Write(0x1D, Hi(TempTicks.CoolTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,509 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite193:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite193
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite193
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite193
	NOP
;ADC_Buttons.c,510 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
