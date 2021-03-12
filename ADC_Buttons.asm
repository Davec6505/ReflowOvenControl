
_RstEntryBits:

;ADC_Buttons.c,42 :: 		void RstEntryBits(){
;ADC_Buttons.c,43 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,44 :: 		enC = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,45 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,46 :: 		}
L_end_RstEntryBits:
	RETURN      0
; end of _RstEntryBits

_SampleButtons:

;ADC_Buttons.c,47 :: 		void SampleButtons(){
;ADC_Buttons.c,53 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,54 :: 		if(!P0 && (enC != 0)){
	BTFSC       ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
	GOTO        L_SampleButtons3
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons304
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons304:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons3
L__SampleButtons301:
;ADC_Buttons.c,55 :: 		P0 = 1;
	BSF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,56 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,57 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,58 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,59 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,60 :: 		}
L_SampleButtons3:
;ADC_Buttons.c,62 :: 		if(!OK_A && !OK_B && !OK_C)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons6
L__SampleButtons300:
;ADC_Buttons.c,63 :: 		enC = Get_EncoderValue();//get encoder value
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
L_SampleButtons6:
;ADC_Buttons.c,65 :: 		if(enC < 0 || enC > 65000){
	MOVLW       0
	SUBWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons305
	MOVLW       0
	SUBWF       ADC_Buttons_enC+0, 0 
L__SampleButtons305:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons299
	MOVF        ADC_Buttons_enC+1, 0 
	SUBLW       253
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons306
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       232
L__SampleButtons306:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons299
	GOTO        L_SampleButtons9
L__SampleButtons299:
;ADC_Buttons.c,66 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,67 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,68 :: 		}
L_SampleButtons9:
;ADC_Buttons.c,70 :: 		if(enC_last != enC){
	MOVF        ADC_Buttons_enC_last+1, 0 
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons307
	MOVF        ADC_Buttons_enC+0, 0 
	XORWF       ADC_Buttons_enC_last+0, 0 
L__SampleButtons307:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons10
;ADC_Buttons.c,71 :: 		enC_last = enC;
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_last+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,72 :: 		if(!OK_A && !OK_B && !OK_C){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons13
L__SampleButtons298:
;ADC_Buttons.c,73 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
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
;ADC_Buttons.c,74 :: 		enC_line_inc =  enC % 4 + 1;
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
;ADC_Buttons.c,75 :: 		enC_line_last = enC_line_inc;
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC_line_last+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC_line_last+1 
;ADC_Buttons.c,76 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
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
;ADC_Buttons.c,77 :: 		enC_line_edit = enC_line_inc;
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       ADC_Buttons_enC_line_edit+0 
	MOVF        ADC_Buttons_enC_line_inc+1, 0 
	MOVWF       ADC_Buttons_enC_line_edit+1 
;ADC_Buttons.c,78 :: 		}
L_SampleButtons13:
;ADC_Buttons.c,79 :: 		}
L_SampleButtons10:
;ADC_Buttons.c,81 :: 		}
L_SampleButtons0:
;ADC_Buttons.c,83 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons14
;ADC_Buttons.c,86 :: 		if(!OK_A && !OK_B && !OK_C)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons17
L__SampleButtons297:
;ADC_Buttons.c,87 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15," ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVF        ADC_Buttons_enC_line_edit+0, 0 
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       15
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr3_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr3_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
	GOTO        L_SampleButtons18
L_SampleButtons17:
;ADC_Buttons.c,89 :: 		P1 = 1;
	BSF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,90 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15,"@");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVF        ADC_Buttons_enC_line_edit+0, 0 
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       15
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,91 :: 		}
L_SampleButtons18:
;ADC_Buttons.c,98 :: 		state:
___SampleButtons_state:
;ADC_Buttons.c,99 :: 		switch(Sps.State){
	GOTO        L_SampleButtons19
;ADC_Buttons.c,100 :: 		case Return:   if(enC > 3){
L_SampleButtons21:
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons308
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons308:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons22
;ADC_Buttons.c,101 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,102 :: 		}
L_SampleButtons22:
;ADC_Buttons.c,103 :: 		close:
___SampleButtons_close:
;ADC_Buttons.c,104 :: 		switch(enC){
	GOTO        L_SampleButtons23
;ADC_Buttons.c,105 :: 		case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
L_SampleButtons25:
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
	GOTO        L_SampleButtons28
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons28
	BTFSC       ADC_Buttons_B+0, 1 
	GOTO        L_SampleButtons28
L__SampleButtons296:
;ADC_Buttons.c,106 :: 		Ok_Bit = 1;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,107 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,108 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,109 :: 		}
L_SampleButtons28:
;ADC_Buttons.c,110 :: 		case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
L_SampleButtons29:
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
	GOTO        L_SampleButtons32
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons32
L__SampleButtons295:
;ADC_Buttons.c,111 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,112 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,113 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,114 :: 		}
L_SampleButtons32:
;ADC_Buttons.c,116 :: 		case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
L_SampleButtons33:
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
	GOTO        L_SampleButtons36
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons36
L__SampleButtons294:
;ADC_Buttons.c,117 :: 		Sps.State = PIDMenu;
	MOVLW       3
	MOVWF       _Sps+16 
;ADC_Buttons.c,118 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,119 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,120 :: 		}
L_SampleButtons36:
;ADC_Buttons.c,121 :: 		case 3:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
L_SampleButtons37:
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
;ADC_Buttons.c,122 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
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
;ADC_Buttons.c,123 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
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
;ADC_Buttons.c,124 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"ReStart");
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
;ADC_Buttons.c,125 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,126 :: 		case 4:
L_SampleButtons38:
;ADC_Buttons.c,127 :: 		case 5:
L_SampleButtons39:
;ADC_Buttons.c,128 :: 		case 6:
L_SampleButtons40:
;ADC_Buttons.c,129 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons41:
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
;ADC_Buttons.c,130 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,131 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,132 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,133 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,134 :: 		case 8:
L_SampleButtons42:
;ADC_Buttons.c,135 :: 		case 9:
L_SampleButtons43:
;ADC_Buttons.c,136 :: 		case 10:
L_SampleButtons44:
;ADC_Buttons.c,137 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons45:
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
;ADC_Buttons.c,138 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,139 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,140 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,141 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,142 :: 		default:
L_SampleButtons46:
;ADC_Buttons.c,143 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,144 :: 		Delay_ms(800);
	MOVLW       65
	MOVWF       R11, 0
	MOVLW       240
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_SampleButtons47:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons47
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons47
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons47
;ADC_Buttons.c,145 :: 		if(P1) EEWrt = on;
	BTFSS       ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
	GOTO        L_SampleButtons48
	BSF         ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons49
L_SampleButtons48:
;ADC_Buttons.c,146 :: 		else Menu_Bit = off;
	BCF         ADC_Buttons_B+0, 0 
L_SampleButtons49:
;ADC_Buttons.c,147 :: 		Ok_Bit   = off;
	BCF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,148 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,149 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,150 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,151 :: 		}
L_SampleButtons23:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons309
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons309:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons25
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons310
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons310:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons29
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons311
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons311:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons33
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons312
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons312:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons37
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons313
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons313:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons38
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons314
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons314:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons39
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons315
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons315:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons40
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons316
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons316:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons41
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons317
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons317:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons42
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons318
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons318:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons43
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons319
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons319:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons44
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons320
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons320:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons45
	GOTO        L_SampleButtons46
L_SampleButtons24:
;ADC_Buttons.c,152 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,153 :: 		case TempMenu:
L_SampleButtons50:
;ADC_Buttons.c,154 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons321
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons321:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons51
;ADC_Buttons.c,155 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,156 :: 		}
L_SampleButtons51:
;ADC_Buttons.c,157 :: 		ret1:
___SampleButtons_ret1:
;ADC_Buttons.c,158 :: 		switch(enC){
	GOTO        L_SampleButtons52
;ADC_Buttons.c,159 :: 		case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
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
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons57
L__SampleButtons293:
;ADC_Buttons.c,160 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,161 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,162 :: 		goto ret1;
	GOTO        ___SampleButtons_ret1
;ADC_Buttons.c,163 :: 		}
L_SampleButtons57:
;ADC_Buttons.c,164 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
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
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons61
L__SampleButtons292:
;ADC_Buttons.c,165 :: 		Sps.State = RampSettings;
	MOVLW       4
	MOVWF       _Sps+16 
;ADC_Buttons.c,166 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,167 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,168 :: 		}
L_SampleButtons61:
;ADC_Buttons.c,169 :: 		case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
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
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons65
L__SampleButtons291:
;ADC_Buttons.c,170 :: 		Sps.State = SoakSettings;
	MOVLW       5
	MOVWF       _Sps+16 
;ADC_Buttons.c,171 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,172 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,173 :: 		}
L_SampleButtons65:
;ADC_Buttons.c,174 :: 		case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
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
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons69
L__SampleButtons290:
;ADC_Buttons.c,175 :: 		Sps.State = SpikeSettings;
	MOVLW       6
	MOVWF       _Sps+16 
;ADC_Buttons.c,176 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,177 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,178 :: 		}
L_SampleButtons69:
;ADC_Buttons.c,179 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
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
;ADC_Buttons.c,180 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
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
;ADC_Buttons.c,181 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
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
;ADC_Buttons.c,182 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
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
;ADC_Buttons.c,183 :: 		break;
	GOTO        L_SampleButtons53
;ADC_Buttons.c,184 :: 		case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
L_SampleButtons70:
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
	GOTO        L_SampleButtons73
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons73
L__SampleButtons289:
;ADC_Buttons.c,185 :: 		Sps.State = CoolSettings;
	MOVLW       7
	MOVWF       _Sps+16 
;ADC_Buttons.c,186 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,187 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,188 :: 		}
L_SampleButtons73:
;ADC_Buttons.c,189 :: 		case 5:
L_SampleButtons74:
;ADC_Buttons.c,190 :: 		case 6:
L_SampleButtons75:
;ADC_Buttons.c,191 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
L_SampleButtons76:
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
;ADC_Buttons.c,192 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,193 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,194 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,195 :: 		break;
	GOTO        L_SampleButtons53
;ADC_Buttons.c,196 :: 		case 8:
L_SampleButtons77:
;ADC_Buttons.c,197 :: 		case 9:
L_SampleButtons78:
;ADC_Buttons.c,198 :: 		case 10:
L_SampleButtons79:
;ADC_Buttons.c,199 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons80:
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
;ADC_Buttons.c,200 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,201 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,202 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,203 :: 		break;
	GOTO        L_SampleButtons53
;ADC_Buttons.c,204 :: 		default:    //clear screen & update cursor position
L_SampleButtons81:
;ADC_Buttons.c,205 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,206 :: 		Sps.State = 1;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,207 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,208 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,209 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,210 :: 		break;
	GOTO        L_SampleButtons53
;ADC_Buttons.c,211 :: 		}
L_SampleButtons52:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons322
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons322:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons54
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons323
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons323:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons58
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons324
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons324:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons62
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons325
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons325:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons66
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons326
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons326:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons70
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons327
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons327:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons74
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons328
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons328:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons75
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons329
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons329:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons76
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons330
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons330:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons77
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons331
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons331:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons78
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons332
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons332:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons79
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons333
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons333:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons80
	GOTO        L_SampleButtons81
L_SampleButtons53:
;ADC_Buttons.c,212 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,213 :: 		case PIDMenu:
L_SampleButtons82:
;ADC_Buttons.c,214 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons334
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons334:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons83
;ADC_Buttons.c,215 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,216 :: 		}
L_SampleButtons83:
;ADC_Buttons.c,217 :: 		ret2:
___SampleButtons_ret2:
;ADC_Buttons.c,218 :: 		switch(enC){
	GOTO        L_SampleButtons84
;ADC_Buttons.c,219 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
L_SampleButtons86:
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
	GOTO        L_SampleButtons89
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons89
L__SampleButtons288:
;ADC_Buttons.c,220 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,221 :: 		while(!RA2_bit);
L_SampleButtons90:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons91
	GOTO        L_SampleButtons90
L_SampleButtons91:
;ADC_Buttons.c,222 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,223 :: 		goto ret2;
	GOTO        ___SampleButtons_ret2
;ADC_Buttons.c,224 :: 		}
L_SampleButtons89:
;ADC_Buttons.c,225 :: 		case 1:
L_SampleButtons92:
;ADC_Buttons.c,226 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	GOTO        L_SampleButtons95
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons95
L__SampleButtons287:
;ADC_Buttons.c,227 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,228 :: 		OK_A = 1;OK_B = 0;OK_C = 0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,229 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,230 :: 		Save_EncoderValue(pid_t.Kp);
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,231 :: 		while(!RA2_bit);
L_SampleButtons96:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons97
	GOTO        L_SampleButtons96
L_SampleButtons97:
;ADC_Buttons.c,232 :: 		}
L_SampleButtons95:
;ADC_Buttons.c,233 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons98
;ADC_Buttons.c,234 :: 		pid_t.Kp = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
	MOVF        R1, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,235 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons99
;ADC_Buttons.c,236 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,237 :: 		while(!RA2_bit);
L_SampleButtons100:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons101
	GOTO        L_SampleButtons100
L_SampleButtons101:
;ADC_Buttons.c,238 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,239 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,240 :: 		}
L_SampleButtons99:
;ADC_Buttons.c,241 :: 		}
L_SampleButtons98:
;ADC_Buttons.c,242 :: 		case 2:
L_SampleButtons102:
;ADC_Buttons.c,243 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
	GOTO        L_SampleButtons105
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons105
L__SampleButtons286:
;ADC_Buttons.c,244 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,245 :: 		OK_B = 1;OK_A=0;OK_C=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,246 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,247 :: 		Save_EncoderValue(pid_t.Ki);
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,248 :: 		while(!RA2_bit);
L_SampleButtons106:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons107
	GOTO        L_SampleButtons106
L_SampleButtons107:
;ADC_Buttons.c,249 :: 		}
L_SampleButtons105:
;ADC_Buttons.c,250 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons108
;ADC_Buttons.c,251 :: 		pid_t.Ki = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
	MOVF        R1, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,252 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons109
;ADC_Buttons.c,253 :: 		OK_B = 0;OK_A=0;OK_C=0;
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,254 :: 		while(!RA2_bit);
L_SampleButtons110:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons111
	GOTO        L_SampleButtons110
L_SampleButtons111:
;ADC_Buttons.c,255 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,256 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,257 :: 		}
L_SampleButtons109:
;ADC_Buttons.c,258 :: 		}
L_SampleButtons108:
;ADC_Buttons.c,259 :: 		case 3:
L_SampleButtons112:
;ADC_Buttons.c,260 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_C){
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
	GOTO        L_SampleButtons115
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons115
L__SampleButtons285:
;ADC_Buttons.c,261 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,262 :: 		OK_C = 1;OK_A=0;OK_B=0;
	BSF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,263 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,264 :: 		Save_EncoderValue(pid_t.Kd);
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,265 :: 		while(!RA2_bit);
L_SampleButtons116:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons117
	GOTO        L_SampleButtons116
L_SampleButtons117:
;ADC_Buttons.c,266 :: 		}
L_SampleButtons115:
;ADC_Buttons.c,267 :: 		if(OK_C){
	BTFSS       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons118
;ADC_Buttons.c,268 :: 		pid_t.Kd = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
	MOVF        R1, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,269 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons119
;ADC_Buttons.c,270 :: 		OK_C = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,271 :: 		while(!RA2_bit);
L_SampleButtons120:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons121
	GOTO        L_SampleButtons120
L_SampleButtons121:
;ADC_Buttons.c,272 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,273 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,274 :: 		}
L_SampleButtons119:
;ADC_Buttons.c,275 :: 		}
L_SampleButtons118:
;ADC_Buttons.c,276 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
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
;ADC_Buttons.c,277 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp:=   ");
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
;ADC_Buttons.c,278 :: 		sprintf(txt4,"%3d",pid_t.Kp);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_31_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_31_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_31_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,279 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,280 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki:=   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr32_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr32_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,281 :: 		sprintf(txt4,"%3d",pid_t.Ki);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_33_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_33_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_33_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,282 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,283 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd:=   ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr34_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr34_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,284 :: 		sprintf(txt4,"%3d",pid_t.Kd);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_35_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_35_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_35_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,285 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,286 :: 		break;
	GOTO        L_SampleButtons85
;ADC_Buttons.c,287 :: 		case 4:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
L_SampleButtons122:
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
	GOTO        L_SampleButtons125
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons125
L__SampleButtons284:
;ADC_Buttons.c,288 :: 		Sps.State = KtimeSettings;
	MOVLW       11
	MOVWF       _Sps+16 
;ADC_Buttons.c,289 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,290 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,291 :: 		}
L_SampleButtons125:
;ADC_Buttons.c,292 :: 		case 5:
L_SampleButtons126:
;ADC_Buttons.c,293 :: 		case 6:
L_SampleButtons127:
;ADC_Buttons.c,294 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Kt     ");
L_SampleButtons128:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr36_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr36_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,295 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr37_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr37_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,296 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr38_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr38_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,297 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr39_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr39_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,298 :: 		break;
	GOTO        L_SampleButtons85
;ADC_Buttons.c,299 :: 		case 8:
L_SampleButtons129:
;ADC_Buttons.c,300 :: 		case 9:
L_SampleButtons130:
;ADC_Buttons.c,301 :: 		case 10:
L_SampleButtons131:
;ADC_Buttons.c,302 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons132:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr40_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr40_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,303 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr41_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr41_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,304 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr42_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr42_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,305 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr43_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr43_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,306 :: 		break;
	GOTO        L_SampleButtons85
;ADC_Buttons.c,307 :: 		default:   //clear screen & update cursor position
L_SampleButtons133:
;ADC_Buttons.c,308 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,309 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,310 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,311 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,312 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,313 :: 		break;
	GOTO        L_SampleButtons85
;ADC_Buttons.c,314 :: 		}
L_SampleButtons84:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons335
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons335:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons86
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons336
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons336:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons92
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons337
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons337:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons102
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons338
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons338:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons112
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons339
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons339:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons122
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons340
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons340:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons126
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons341
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons341:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons127
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons342
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons342:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons128
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons343
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons343:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons129
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons344
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons344:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons130
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons345
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons345:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons131
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons346
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons346:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons132
	GOTO        L_SampleButtons133
L_SampleButtons85:
;ADC_Buttons.c,315 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,316 :: 		case RampSettings:
L_SampleButtons134:
;ADC_Buttons.c,317 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons347
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons347:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons135
;ADC_Buttons.c,318 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,319 :: 		}
L_SampleButtons135:
;ADC_Buttons.c,320 :: 		ret3:
___SampleButtons_ret3:
;ADC_Buttons.c,321 :: 		switch(enC){
	GOTO        L_SampleButtons136
;ADC_Buttons.c,322 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
L_SampleButtons138:
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
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons141
L__SampleButtons283:
;ADC_Buttons.c,323 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,324 :: 		while(!RA2_bit);
L_SampleButtons142:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons143
	GOTO        L_SampleButtons142
L_SampleButtons143:
;ADC_Buttons.c,325 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,326 :: 		goto ret3;
	GOTO        ___SampleButtons_ret3
;ADC_Buttons.c,327 :: 		}
L_SampleButtons141:
;ADC_Buttons.c,328 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons144:
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
	GOTO        L_SampleButtons147
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons147
L__SampleButtons282:
;ADC_Buttons.c,329 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,330 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,331 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,332 :: 		Save_EncoderValue(Sps.RmpDeg);
	MOVF        _Sps+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,333 :: 		while(!RA2_bit);
L_SampleButtons148:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons149
	GOTO        L_SampleButtons148
L_SampleButtons149:
;ADC_Buttons.c,334 :: 		}
L_SampleButtons147:
;ADC_Buttons.c,335 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons150
;ADC_Buttons.c,336 :: 		Sps.RmpDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
	MOVF        R1, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,337 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons151
;ADC_Buttons.c,338 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,339 :: 		while(!RA2_bit);
L_SampleButtons152:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons153
	GOTO        L_SampleButtons152
L_SampleButtons153:
;ADC_Buttons.c,340 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,341 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,342 :: 		}
L_SampleButtons151:
;ADC_Buttons.c,343 :: 		}
L_SampleButtons150:
;ADC_Buttons.c,344 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons154:
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
	GOTO        L_SampleButtons157
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons157
L__SampleButtons281:
;ADC_Buttons.c,345 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,346 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,347 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,348 :: 		Save_EncoderValue(Sps.RmpTmr);
	MOVF        _Sps+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,349 :: 		while(!RA2_bit);
L_SampleButtons158:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons159
	GOTO        L_SampleButtons158
L_SampleButtons159:
;ADC_Buttons.c,350 :: 		}
L_SampleButtons157:
;ADC_Buttons.c,351 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons160
;ADC_Buttons.c,352 :: 		Sps.RmpTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
	MOVF        R1, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,353 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,354 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,355 :: 		while(!RA2_bit);
L_SampleButtons162:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons163
	GOTO        L_SampleButtons162
L_SampleButtons163:
;ADC_Buttons.c,356 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,357 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,358 :: 		}
L_SampleButtons161:
;ADC_Buttons.c,359 :: 		}
L_SampleButtons160:
;ADC_Buttons.c,360 :: 		case 3:
L_SampleButtons164:
;ADC_Buttons.c,361 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr44_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr44_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,362 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr45_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr45_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,363 :: 		sprintf(txt4,"%3d",Sps.RmpDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_46_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_46_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_46_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,364 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,365 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr47_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr47_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,366 :: 		sprintf(txt4,"%3d",Sps.RmpTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_48_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_48_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_48_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,367 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,368 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr49_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr49_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,369 :: 		break;
	GOTO        L_SampleButtons137
;ADC_Buttons.c,370 :: 		default:    //clear screen & update cursor position
L_SampleButtons165:
;ADC_Buttons.c,371 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,372 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,373 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,374 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,375 :: 		break;
	GOTO        L_SampleButtons137
;ADC_Buttons.c,376 :: 		}
L_SampleButtons136:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons348
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons348:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons138
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons349
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons349:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons144
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons350
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons350:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons154
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons351
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons351:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons164
	GOTO        L_SampleButtons165
L_SampleButtons137:
;ADC_Buttons.c,377 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,378 :: 		case SoakSettings:
L_SampleButtons166:
;ADC_Buttons.c,379 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons352
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons352:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons167
;ADC_Buttons.c,380 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,381 :: 		}
L_SampleButtons167:
;ADC_Buttons.c,382 :: 		ret4:
___SampleButtons_ret4:
;ADC_Buttons.c,383 :: 		switch(enC){
	GOTO        L_SampleButtons168
;ADC_Buttons.c,384 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
L_SampleButtons170:
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
	GOTO        L_SampleButtons173
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons173
L__SampleButtons280:
;ADC_Buttons.c,385 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,386 :: 		while(!RA2_bit);
L_SampleButtons174:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons175
	GOTO        L_SampleButtons174
L_SampleButtons175:
;ADC_Buttons.c,387 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,388 :: 		goto ret4;
	GOTO        ___SampleButtons_ret4
;ADC_Buttons.c,389 :: 		}
L_SampleButtons173:
;ADC_Buttons.c,390 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons176:
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
	GOTO        L_SampleButtons179
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons179
L__SampleButtons279:
;ADC_Buttons.c,391 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,392 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,393 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,394 :: 		Save_EncoderValue(Sps.SokDeg);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,395 :: 		while(!RA2_bit);
L_SampleButtons180:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons181
	GOTO        L_SampleButtons180
L_SampleButtons181:
;ADC_Buttons.c,396 :: 		}
L_SampleButtons179:
;ADC_Buttons.c,397 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons182
;ADC_Buttons.c,398 :: 		Sps.SokDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
	MOVF        R1, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,399 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons183
;ADC_Buttons.c,400 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,401 :: 		while(!RA2_bit);
L_SampleButtons184:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons185
	GOTO        L_SampleButtons184
L_SampleButtons185:
;ADC_Buttons.c,402 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,403 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,404 :: 		}
L_SampleButtons183:
;ADC_Buttons.c,405 :: 		}
L_SampleButtons182:
;ADC_Buttons.c,406 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons186:
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
	GOTO        L_SampleButtons189
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons189
L__SampleButtons278:
;ADC_Buttons.c,407 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,408 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,409 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,410 :: 		Save_EncoderValue(Sps.SokTmr);
	MOVF        _Sps+6, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,411 :: 		while(!RA2_bit);
L_SampleButtons190:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons191
	GOTO        L_SampleButtons190
L_SampleButtons191:
;ADC_Buttons.c,412 :: 		}
L_SampleButtons189:
;ADC_Buttons.c,413 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons192
;ADC_Buttons.c,414 :: 		Sps.SokTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
	MOVF        R1, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,415 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons193
;ADC_Buttons.c,416 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,417 :: 		while(!RA2_bit);
L_SampleButtons194:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons195
	GOTO        L_SampleButtons194
L_SampleButtons195:
;ADC_Buttons.c,418 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,419 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,421 :: 		}
L_SampleButtons193:
;ADC_Buttons.c,422 :: 		}
L_SampleButtons192:
;ADC_Buttons.c,423 :: 		case 3:
L_SampleButtons196:
;ADC_Buttons.c,424 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr50_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr50_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,425 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr51_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr51_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,426 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_52_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_52_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_52_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,427 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,428 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr53_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr53_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,429 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_54_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_54_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_54_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,430 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,431 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr55_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr55_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,432 :: 		break;
	GOTO        L_SampleButtons169
;ADC_Buttons.c,433 :: 		default:    //clear screen & update cursor position
L_SampleButtons197:
;ADC_Buttons.c,434 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,435 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,436 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,437 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,438 :: 		break;
	GOTO        L_SampleButtons169
;ADC_Buttons.c,439 :: 		}
L_SampleButtons168:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons353
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons353:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons170
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons354
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons354:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons176
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons355
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons355:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons186
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons356
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons356:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons196
	GOTO        L_SampleButtons197
L_SampleButtons169:
;ADC_Buttons.c,440 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,441 :: 		case SpikeSettings:
L_SampleButtons198:
;ADC_Buttons.c,442 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons357
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons357:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons199
;ADC_Buttons.c,443 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,444 :: 		}
L_SampleButtons199:
;ADC_Buttons.c,445 :: 		ret5:
___SampleButtons_ret5:
;ADC_Buttons.c,446 :: 		switch(enC){
	GOTO        L_SampleButtons200
;ADC_Buttons.c,447 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
L_SampleButtons202:
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
	GOTO        L_SampleButtons205
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons205
L__SampleButtons277:
;ADC_Buttons.c,448 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,449 :: 		while(!RA2_bit);
L_SampleButtons206:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons207
	GOTO        L_SampleButtons206
L_SampleButtons207:
;ADC_Buttons.c,450 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,451 :: 		goto ret5;
	GOTO        ___SampleButtons_ret5
;ADC_Buttons.c,452 :: 		}
L_SampleButtons205:
;ADC_Buttons.c,453 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons208:
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
	GOTO        L_SampleButtons211
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons211
L__SampleButtons276:
;ADC_Buttons.c,454 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,455 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,456 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,457 :: 		Save_EncoderValue(Sps.SpkeDeg);
	MOVF        _Sps+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,458 :: 		}
L_SampleButtons211:
;ADC_Buttons.c,459 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons212
;ADC_Buttons.c,460 :: 		Sps.SpkeDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
	MOVF        R1, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,461 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons213
;ADC_Buttons.c,462 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,463 :: 		while(!RA2_bit);
L_SampleButtons214:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons215
	GOTO        L_SampleButtons214
L_SampleButtons215:
;ADC_Buttons.c,464 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,465 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,466 :: 		}
L_SampleButtons213:
;ADC_Buttons.c,467 :: 		}
L_SampleButtons212:
;ADC_Buttons.c,468 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons216:
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
	GOTO        L_SampleButtons219
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons219
L__SampleButtons275:
;ADC_Buttons.c,469 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,470 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,471 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,472 :: 		Save_EncoderValue(Sps.SpkeTmr);
	MOVF        _Sps+10, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,473 :: 		while(!RA2_bit);
L_SampleButtons220:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons221
	GOTO        L_SampleButtons220
L_SampleButtons221:
;ADC_Buttons.c,474 :: 		}
L_SampleButtons219:
;ADC_Buttons.c,475 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons222
;ADC_Buttons.c,476 :: 		Sps.SpkeTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
	MOVF        R1, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,477 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons223
;ADC_Buttons.c,478 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,479 :: 		while(!RA2_bit);
L_SampleButtons224:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons225
	GOTO        L_SampleButtons224
L_SampleButtons225:
;ADC_Buttons.c,480 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,481 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,482 :: 		}
L_SampleButtons223:
;ADC_Buttons.c,483 :: 		}
L_SampleButtons222:
;ADC_Buttons.c,484 :: 		case 3:
L_SampleButtons226:
;ADC_Buttons.c,485 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret       ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr56_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr56_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,486 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SpikeDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr57_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr57_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,487 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_58_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_58_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_58_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,488 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,489 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SpikeTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr59_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr59_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,490 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_60_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_60_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_60_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,491 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,492 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"          ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr61_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr61_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,493 :: 		break;
	GOTO        L_SampleButtons201
;ADC_Buttons.c,494 :: 		default:    //clear screen & update cursor position
L_SampleButtons227:
;ADC_Buttons.c,495 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,496 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,497 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,498 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,499 :: 		break;
	GOTO        L_SampleButtons201
;ADC_Buttons.c,500 :: 		}
L_SampleButtons200:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons358:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons202
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons359
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons359:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons208
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons360
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons360:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons216
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons361
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons361:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons226
	GOTO        L_SampleButtons227
L_SampleButtons201:
;ADC_Buttons.c,501 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,502 :: 		case CoolSettings:
L_SampleButtons228:
;ADC_Buttons.c,503 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons362
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons362:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons229
;ADC_Buttons.c,504 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,505 :: 		}
L_SampleButtons229:
;ADC_Buttons.c,506 :: 		ret6:
___SampleButtons_ret6:
;ADC_Buttons.c,507 :: 		switch(enC){
	GOTO        L_SampleButtons230
;ADC_Buttons.c,508 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
L_SampleButtons232:
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
	GOTO        L_SampleButtons235
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons235
L__SampleButtons274:
;ADC_Buttons.c,509 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,510 :: 		while(!RA2_bit);
L_SampleButtons236:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons237
	GOTO        L_SampleButtons236
L_SampleButtons237:
;ADC_Buttons.c,511 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,512 :: 		goto ret6;
	GOTO        ___SampleButtons_ret6
;ADC_Buttons.c,513 :: 		}
L_SampleButtons235:
;ADC_Buttons.c,514 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons238:
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
	GOTO        L_SampleButtons241
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons241
L__SampleButtons273:
;ADC_Buttons.c,515 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,516 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,517 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,518 :: 		Save_EncoderValue(Sps.CoolOffDeg);
	MOVF        _Sps+12, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,519 :: 		}
L_SampleButtons241:
;ADC_Buttons.c,520 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons242
;ADC_Buttons.c,521 :: 		Sps.CoolOffDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
	MOVF        R1, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,522 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons243
;ADC_Buttons.c,523 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,524 :: 		while(!RA2_bit);
L_SampleButtons244:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons245
	GOTO        L_SampleButtons244
L_SampleButtons245:
;ADC_Buttons.c,525 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,526 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,527 :: 		}
L_SampleButtons243:
;ADC_Buttons.c,528 :: 		}
L_SampleButtons242:
;ADC_Buttons.c,529 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons246:
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
	GOTO        L_SampleButtons249
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons249
L__SampleButtons272:
;ADC_Buttons.c,530 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,531 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,532 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,533 :: 		Save_EncoderValue(Sps.CoolOffTmr);
	MOVF        _Sps+14, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,534 :: 		while(!RA2_bit);
L_SampleButtons250:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons251
	GOTO        L_SampleButtons250
L_SampleButtons251:
;ADC_Buttons.c,535 :: 		}
L_SampleButtons249:
;ADC_Buttons.c,536 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons252
;ADC_Buttons.c,537 :: 		Sps.CoolOffTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
	MOVF        R1, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,538 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons253
;ADC_Buttons.c,539 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,540 :: 		while(!RA2_bit);
L_SampleButtons254:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons255
	GOTO        L_SampleButtons254
L_SampleButtons255:
;ADC_Buttons.c,541 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,542 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,543 :: 		}
L_SampleButtons253:
;ADC_Buttons.c,544 :: 		}
L_SampleButtons252:
;ADC_Buttons.c,545 :: 		case 3:
L_SampleButtons256:
;ADC_Buttons.c,546 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr62_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr62_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,547 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"CoolDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr63_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr63_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,548 :: 		sprintf(txt4,"%3d",Sps.CoolOffDeg);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_64_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_64_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_64_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,549 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,550 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"CoolTmr:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr65_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr65_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,551 :: 		sprintf(txt4,"%3d",Sps.CoolOffTmr);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_66_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_66_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_66_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,552 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,553 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr67_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr67_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,554 :: 		break;
	GOTO        L_SampleButtons231
;ADC_Buttons.c,555 :: 		default:    //clear screen & update cursor position
L_SampleButtons257:
;ADC_Buttons.c,556 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,557 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,558 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,559 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,560 :: 		break;
	GOTO        L_SampleButtons231
;ADC_Buttons.c,561 :: 		}
L_SampleButtons230:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons363
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons363:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons232
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons364
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons364:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons238
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons365
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons365:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons246
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons366
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons366:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons256
	GOTO        L_SampleButtons257
L_SampleButtons231:
;ADC_Buttons.c,562 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,563 :: 		default: Sps.State = Return;
L_SampleButtons258:
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,564 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,565 :: 		}
L_SampleButtons19:
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons21
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons50
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons82
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons134
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons166
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons198
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons228
	GOTO        L_SampleButtons258
L_SampleButtons20:
;ADC_Buttons.c,567 :: 		}
L_SampleButtons14:
;ADC_Buttons.c,569 :: 		if(EEWrt){
	BTFSS       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons259
;ADC_Buttons.c,570 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,571 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,572 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Writing To EEPROM...");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr68_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr68_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,573 :: 		Delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_SampleButtons260:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons260
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons260
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons260
	NOP
;ADC_Buttons.c,574 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,575 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,576 :: 		EEWrt = 0;
	BCF         ADC_Buttons_B+0, 4 
;ADC_Buttons.c,577 :: 		}
L_SampleButtons259:
;ADC_Buttons.c,580 :: 		if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 5 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 6 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B_+0, 7 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B+0, 5 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B+0, 6 
	GOTO        L_SampleButtons263
	BTFSC       ADC_Buttons_B+0, 7 
	GOTO        L_SampleButtons263
L__SampleButtons271:
;ADC_Buttons.c,582 :: 		if((valOf > 11)&&(valOf<50000))valOf = 11;
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_valOf+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons367
	MOVF        ADC_Buttons_valOf+0, 0 
	SUBLW       11
L__SampleButtons367:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons266
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons368
	MOVLW       80
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons368:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons266
L__SampleButtons270:
	MOVLW       11
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
	GOTO        L_SampleButtons267
L_SampleButtons266:
;ADC_Buttons.c,583 :: 		else if (valOf >= 50001)valOf = 0;
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons369
	MOVLW       81
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons369:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons268
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
L_SampleButtons268:
L_SampleButtons267:
;ADC_Buttons.c,584 :: 		}
L_SampleButtons263:
;ADC_Buttons.c,586 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,588 :: 		void ResetBits(){
;ADC_Buttons.c,589 :: 		valOf     = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,590 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,591 :: 		Menu_Bit  = 0;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,592 :: 		OK_Bit    = 0;
	BCF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,593 :: 		OK_A      = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,594 :: 		OK_B      = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,595 :: 		OK_C      = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,596 :: 		OK_D      = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,597 :: 		OK_E      = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,598 :: 		OK_F      = 0;
	BCF         ADC_Buttons_B_+0, 5 
;ADC_Buttons.c,599 :: 		OK_G      = 0;
	BCF         ADC_Buttons_B_+0, 6 
;ADC_Buttons.c,600 :: 		OK_H      = 0;
	BCF         ADC_Buttons_B_+0, 7 
;ADC_Buttons.c,601 :: 		OK_I      = 0;
	BCF         ADC_Buttons_B+0, 5 
;ADC_Buttons.c,602 :: 		OK_J      = 0;
	BCF         ADC_Buttons_B+0, 6 
;ADC_Buttons.c,603 :: 		OK_K      = 0;
	BCF         ADC_Buttons_B+0, 7 
;ADC_Buttons.c,604 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_SavedVals:

;ADC_Buttons.c,606 :: 		void SavedVals(){
;ADC_Buttons.c,608 :: 		}
L_end_SavedVals:
	RETURN      0
; end of _SavedVals

_doOFFBitoff:

;ADC_Buttons.c,610 :: 		void doOFFBitoff(){
;ADC_Buttons.c,612 :: 		}
L_end_doOFFBitoff:
	RETURN      0
; end of _doOFFBitoff

_EERead:

;ADC_Buttons.c,614 :: 		void EERead(){
;ADC_Buttons.c,616 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,617 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,618 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,619 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,620 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,621 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,622 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,623 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,624 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,625 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,626 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,627 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,628 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,629 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,630 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,631 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,634 :: 		Lo(pid_t.Kp)     = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,635 :: 		Hi(pid_t.Kp)     = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,636 :: 		Lo(pid_t.Ki)     = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,637 :: 		Hi(pid_t.Ki)     = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,638 :: 		Lo(pid_t.Kd)     = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,639 :: 		Hi(pid_t.Kd)     = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,642 :: 		Lo(TempTicks.RampTick)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,643 :: 		Hi(TempTicks.RampTick)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,644 :: 		Lo(TempTicks.SoakTick)  = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,645 :: 		Hi(TempTicks.SoakTick)  = EEPROM_Read(0x19);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,646 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,647 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,648 :: 		Lo(TempTicks.CoolTick)  = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,649 :: 		Hi(TempTicks.CoolTick)  = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,651 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,652 :: 		void EEWrite(){
;ADC_Buttons.c,653 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr69_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr69_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,655 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,656 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,657 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,658 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,659 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,660 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,661 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,662 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,663 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,664 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,665 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,666 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,667 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,668 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,669 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,670 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,673 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,674 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,675 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,676 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,677 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,678 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,681 :: 		EEPROM_Write(0x16, Lo(TempTicks.RampTick));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,682 :: 		EEPROM_Write(0x17, Hi(TempTicks.RampTick));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,683 :: 		EEPROM_Write(0x18, Lo(TempTicks.SoakTick));
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,684 :: 		EEPROM_Write(0x19, Hi(TempTicks.SoakTick));
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,685 :: 		EEPROM_Write(0x1A, Lo(TempTicks.SpikeTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,686 :: 		EEPROM_Write(0x1B, Hi(TempTicks.SpikeTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,687 :: 		EEPROM_Write(0x1C, Lo(TempTicks.CoolTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,688 :: 		EEPROM_Write(0x1D, Hi(TempTicks.CoolTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,689 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite269:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite269
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite269
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite269
	NOP
;ADC_Buttons.c,690 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
