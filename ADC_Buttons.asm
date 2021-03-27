
_RstEntryBits:

;ADC_Buttons.c,42 :: 		void RstEntryBits(){
;ADC_Buttons.c,43 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,44 :: 		P2 = 0;
	BCF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,45 :: 		enC = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,46 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,47 :: 		}
L_end_RstEntryBits:
	RETURN      0
; end of _RstEntryBits

_SampleButtons:

;ADC_Buttons.c,48 :: 		void SampleButtons(){
;ADC_Buttons.c,50 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,51 :: 		if(!P0 && (enC != 0)){
	BTFSC       ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
	GOTO        L_SampleButtons3
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons364
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons364:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons3
L__SampleButtons361:
;ADC_Buttons.c,52 :: 		P0 = 1;
	BSF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,53 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,54 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,55 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,56 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,57 :: 		}
L_SampleButtons3:
;ADC_Buttons.c,59 :: 		if(enC < 0 || enC > 65000){
	MOVLW       0
	SUBWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons365
	MOVLW       0
	SUBWF       ADC_Buttons_enC+0, 0 
L__SampleButtons365:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons360
	MOVF        ADC_Buttons_enC+1, 0 
	SUBLW       253
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons366
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       232
L__SampleButtons366:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons360
	GOTO        L_SampleButtons6
L__SampleButtons360:
;ADC_Buttons.c,60 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,61 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,62 :: 		}
L_SampleButtons6:
;ADC_Buttons.c,64 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons9
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons9
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons9
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons9
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons9
L__SampleButtons359:
;ADC_Buttons.c,65 :: 		if((Sps.State == Return)||(Sps.State == TempMenu)||(Sps.State == PIDMenu)||
	MOVF        _Sps+24, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVF        _Sps+24, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
;ADC_Buttons.c,66 :: 		(Sps.State == RampSettings)||(Sps.State == SoakSettings)||
	MOVF        _Sps+24, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVF        _Sps+24, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
;ADC_Buttons.c,67 :: 		(Sps.State == SpikeSettings)||(Sps.State == CoolSettings)){
	MOVF        _Sps+24, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVF        _Sps+24, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L__SampleButtons358
	GOTO        L_SampleButtons12
L__SampleButtons358:
;ADC_Buttons.c,68 :: 		enC = (uint8_t)Get_EncoderValue();//get encoder value
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,69 :: 		enC /= 4;
	RRCF        ADC_Buttons_enC+1, 1 
	RRCF        ADC_Buttons_enC+0, 1 
	BCF         ADC_Buttons_enC+1, 7 
	RRCF        ADC_Buttons_enC+1, 1 
	RRCF        ADC_Buttons_enC+0, 1 
	BCF         ADC_Buttons_enC+1, 7 
;ADC_Buttons.c,70 :: 		}
	GOTO        L_SampleButtons13
L_SampleButtons12:
;ADC_Buttons.c,72 :: 		enC = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
L_SampleButtons13:
L_SampleButtons9:
;ADC_Buttons.c,74 :: 		if(enC_last != enC){
	MOVF        ADC_Buttons_enC_last+1, 0 
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons367
	MOVF        ADC_Buttons_enC+0, 0 
	XORWF       ADC_Buttons_enC_last+0, 0 
L__SampleButtons367:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons14
;ADC_Buttons.c,75 :: 		enC_last = enC;
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_last+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,76 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons17
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons17
L__SampleButtons357:
;ADC_Buttons.c,77 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
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
;ADC_Buttons.c,78 :: 		if(enC > 0)
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons368
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       0
L__SampleButtons368:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons18
;ADC_Buttons.c,79 :: 		enC_line_inc =  enC % 4 + 1;
	MOVLW       3
	ANDWF       ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_line_inc+1 
	MOVLW       0
	ANDWF       ADC_Buttons_enC_line_inc+1, 1 
	INFSNZ      ADC_Buttons_enC_line_inc+0, 1 
	INCF        ADC_Buttons_enC_line_inc+1, 1 
	GOTO        L_SampleButtons19
L_SampleButtons18:
;ADC_Buttons.c,81 :: 		enC_line_inc =  enC % 4;
	MOVLW       3
	ANDWF       ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_line_inc+1 
	MOVLW       0
	ANDWF       ADC_Buttons_enC_line_inc+1, 1 
L_SampleButtons19:
;ADC_Buttons.c,82 :: 		enC_line_last = enC_line_inc;
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       ADC_Buttons_enC_line_last+0 
	MOVF        ADC_Buttons_enC_line_inc+1, 0 
	MOVWF       ADC_Buttons_enC_line_last+1 
;ADC_Buttons.c,83 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr2_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr2_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,84 :: 		enC_line_edit = enC_line_inc;
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       ADC_Buttons_enC_line_edit+0 
	MOVF        ADC_Buttons_enC_line_inc+1, 0 
	MOVWF       ADC_Buttons_enC_line_edit+1 
;ADC_Buttons.c,85 :: 		}
L_SampleButtons17:
;ADC_Buttons.c,86 :: 		}
L_SampleButtons14:
;ADC_Buttons.c,88 :: 		}
L_SampleButtons0:
;ADC_Buttons.c,90 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons20
;ADC_Buttons.c,93 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons23
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons23
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons23
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons23
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons23
L__SampleButtons356:
;ADC_Buttons.c,94 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15," ");
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
	GOTO        L_SampleButtons24
L_SampleButtons23:
;ADC_Buttons.c,96 :: 		P1 = 1;
	BSF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,97 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15,"@");
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
;ADC_Buttons.c,98 :: 		}
L_SampleButtons24:
;ADC_Buttons.c,105 :: 		state:
___SampleButtons_state:
;ADC_Buttons.c,106 :: 		switch(Sps.State){
	GOTO        L_SampleButtons25
;ADC_Buttons.c,107 :: 		case Return:   if(enC > 7){
L_SampleButtons27:
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons369
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons369:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons28
;ADC_Buttons.c,108 :: 		enC = (uint8_t)Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,109 :: 		}
L_SampleButtons28:
;ADC_Buttons.c,110 :: 		close:
___SampleButtons_close:
;ADC_Buttons.c,111 :: 		switch(enC){
	GOTO        L_SampleButtons29
;ADC_Buttons.c,112 :: 		case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
L_SampleButtons31:
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
	GOTO        L_SampleButtons34
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons34
	BTFSC       ADC_Buttons_B+0, 1 
	GOTO        L_SampleButtons34
L__SampleButtons355:
;ADC_Buttons.c,113 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,114 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,115 :: 		}
L_SampleButtons34:
;ADC_Buttons.c,116 :: 		case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
L_SampleButtons35:
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
	GOTO        L_SampleButtons38
	MOVF        _Sps+24, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons38
L__SampleButtons354:
;ADC_Buttons.c,117 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
;ADC_Buttons.c,118 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,119 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,120 :: 		}
L_SampleButtons38:
;ADC_Buttons.c,122 :: 		case 2: if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
L_SampleButtons39:
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
	GOTO        L_SampleButtons42
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons42
L__SampleButtons353:
;ADC_Buttons.c,123 :: 		Sps.State = PIDMenu;
	MOVLW       3
	MOVWF       _Sps+24 
;ADC_Buttons.c,124 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,125 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,126 :: 		}
L_SampleButtons42:
;ADC_Buttons.c,127 :: 		case 3:
L_SampleButtons43:
;ADC_Buttons.c,128 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
	GOTO        L_SampleButtons46
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons46
L__SampleButtons352:
;ADC_Buttons.c,129 :: 		Ok_Bit = 1;;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,130 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,131 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,132 :: 		}
L_SampleButtons46:
;ADC_Buttons.c,133 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
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
;ADC_Buttons.c,134 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
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
;ADC_Buttons.c,135 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
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
;ADC_Buttons.c,136 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"ReStart");
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
;ADC_Buttons.c,137 :: 		break;
	GOTO        L_SampleButtons30
;ADC_Buttons.c,138 :: 		case 4:
L_SampleButtons47:
;ADC_Buttons.c,139 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
	GOTO        L_SampleButtons50
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons50
L__SampleButtons351:
;ADC_Buttons.c,140 :: 		OFF_Bit = 1;;
	BSF         ADC_Buttons_B+0, 3 
;ADC_Buttons.c,141 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,142 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,143 :: 		}
L_SampleButtons50:
;ADC_Buttons.c,144 :: 		case 5:
L_SampleButtons51:
;ADC_Buttons.c,145 :: 		case 6:
L_SampleButtons52:
;ADC_Buttons.c,146 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Stop   ");
L_SampleButtons53:
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
;ADC_Buttons.c,147 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,148 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,149 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,150 :: 		break;
	GOTO        L_SampleButtons30
;ADC_Buttons.c,151 :: 		case 8:
L_SampleButtons54:
;ADC_Buttons.c,152 :: 		case 9:
L_SampleButtons55:
;ADC_Buttons.c,153 :: 		case 10:
L_SampleButtons56:
;ADC_Buttons.c,154 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons57:
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
;ADC_Buttons.c,155 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,156 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,157 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,158 :: 		break;
	GOTO        L_SampleButtons30
;ADC_Buttons.c,159 :: 		default:
L_SampleButtons58:
;ADC_Buttons.c,160 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,161 :: 		Delay_ms(800);
	MOVLW       65
	MOVWF       R11, 0
	MOVLW       240
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_SampleButtons59:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons59
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons59
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons59
;ADC_Buttons.c,162 :: 		if(P1) EEWrt = on;
	BTFSS       ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
	GOTO        L_SampleButtons60
	BSF         ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons61
L_SampleButtons60:
;ADC_Buttons.c,163 :: 		else Menu_Bit = off;
	BCF         ADC_Buttons_B+0, 0 
L_SampleButtons61:
;ADC_Buttons.c,164 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,165 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,166 :: 		break;
	GOTO        L_SampleButtons30
;ADC_Buttons.c,167 :: 		}
L_SampleButtons29:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons370
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons370:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons31
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons371
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons371:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons35
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons372
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons372:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons39
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons373
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons373:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons43
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons374
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons374:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons47
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons375
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons375:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons51
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons376
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons376:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons52
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons377
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons377:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons53
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons378
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons378:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons54
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons379
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons379:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons55
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons380
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons380:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons56
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons381
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons381:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons57
	GOTO        L_SampleButtons58
L_SampleButtons30:
;ADC_Buttons.c,168 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,169 :: 		case TempMenu:
L_SampleButtons62:
;ADC_Buttons.c,170 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons382
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons382:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons63
;ADC_Buttons.c,171 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,172 :: 		}
L_SampleButtons63:
;ADC_Buttons.c,173 :: 		ret1:
___SampleButtons_ret1:
;ADC_Buttons.c,174 :: 		switch(enC){
	GOTO        L_SampleButtons64
;ADC_Buttons.c,175 :: 		case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
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
	MOVF        _Sps+24, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons69
L__SampleButtons350:
;ADC_Buttons.c,176 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+24 
;ADC_Buttons.c,177 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,178 :: 		goto ret1;
	GOTO        ___SampleButtons_ret1
;ADC_Buttons.c,179 :: 		}
L_SampleButtons69:
;ADC_Buttons.c,180 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
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
	MOVF        _Sps+24, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons73
L__SampleButtons349:
;ADC_Buttons.c,181 :: 		Sps.State = RampSettings;
	MOVLW       4
	MOVWF       _Sps+24 
;ADC_Buttons.c,182 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,183 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,184 :: 		}
L_SampleButtons73:
;ADC_Buttons.c,185 :: 		case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
L_SampleButtons74:
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
	GOTO        L_SampleButtons77
	MOVF        _Sps+24, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons77
L__SampleButtons348:
;ADC_Buttons.c,186 :: 		Sps.State = SoakSettings;
	MOVLW       5
	MOVWF       _Sps+24 
;ADC_Buttons.c,187 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,188 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,189 :: 		}
L_SampleButtons77:
;ADC_Buttons.c,190 :: 		case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
L_SampleButtons78:
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
	GOTO        L_SampleButtons81
	MOVF        _Sps+24, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons81
L__SampleButtons347:
;ADC_Buttons.c,191 :: 		Sps.State = SpikeSettings;
	MOVLW       6
	MOVWF       _Sps+24 
;ADC_Buttons.c,192 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,193 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,194 :: 		}
L_SampleButtons81:
;ADC_Buttons.c,195 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
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
;ADC_Buttons.c,196 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
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
;ADC_Buttons.c,197 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
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
;ADC_Buttons.c,198 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
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
;ADC_Buttons.c,199 :: 		break;
	GOTO        L_SampleButtons65
;ADC_Buttons.c,200 :: 		case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
L_SampleButtons82:
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
	GOTO        L_SampleButtons85
	MOVF        _Sps+24, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons85
L__SampleButtons346:
;ADC_Buttons.c,201 :: 		Sps.State = CoolSettings;
	MOVLW       7
	MOVWF       _Sps+24 
;ADC_Buttons.c,202 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,203 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,204 :: 		}
L_SampleButtons85:
;ADC_Buttons.c,205 :: 		case 5:
L_SampleButtons86:
;ADC_Buttons.c,206 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != TimeSettings)){
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
	MOVF        _Sps+24, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons89
L__SampleButtons345:
;ADC_Buttons.c,207 :: 		Sps.State = TimeSettings;
	MOVLW       8
	MOVWF       _Sps+24 
;ADC_Buttons.c,208 :: 		enC = (uint8_t)Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,209 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,210 :: 		}
L_SampleButtons89:
;ADC_Buttons.c,211 :: 		case 6:
L_SampleButtons90:
;ADC_Buttons.c,212 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
L_SampleButtons91:
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
;ADC_Buttons.c,213 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Timers ");
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
;ADC_Buttons.c,214 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,215 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,216 :: 		break;
	GOTO        L_SampleButtons65
;ADC_Buttons.c,217 :: 		case 8:
L_SampleButtons92:
;ADC_Buttons.c,218 :: 		case 9:
L_SampleButtons93:
;ADC_Buttons.c,219 :: 		case 10:
L_SampleButtons94:
;ADC_Buttons.c,220 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons95:
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
;ADC_Buttons.c,221 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,222 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,223 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,224 :: 		break;
	GOTO        L_SampleButtons65
;ADC_Buttons.c,225 :: 		default:    //clear screen & update cursor position
L_SampleButtons96:
;ADC_Buttons.c,226 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,227 :: 		Sps.State = 1;
	MOVLW       1
	MOVWF       _Sps+24 
;ADC_Buttons.c,228 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,229 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,230 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,231 :: 		break;
	GOTO        L_SampleButtons65
;ADC_Buttons.c,232 :: 		}
L_SampleButtons64:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons383
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons383:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons66
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons384
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons384:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons70
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons385
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons385:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons74
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons386
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons386:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons78
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons387
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons387:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons82
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons388
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons388:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons86
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons389
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons389:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons90
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons390
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons390:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons91
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons391
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons391:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons92
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons392
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons392:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons93
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons393
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons393:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons94
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons394
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons394:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons95
	GOTO        L_SampleButtons96
L_SampleButtons65:
;ADC_Buttons.c,233 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,234 :: 		case PIDMenu:
L_SampleButtons97:
;ADC_Buttons.c,235 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons395
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons395:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons98
;ADC_Buttons.c,236 :: 		enC = (uint8_t)Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,237 :: 		}
L_SampleButtons98:
;ADC_Buttons.c,238 :: 		ret2:
___SampleButtons_ret2:
;ADC_Buttons.c,239 :: 		switch(enC){
	GOTO        L_SampleButtons99
;ADC_Buttons.c,240 :: 		case 0:
L_SampleButtons101:
;ADC_Buttons.c,241 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
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
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons104
L__SampleButtons344:
;ADC_Buttons.c,242 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+24 
;ADC_Buttons.c,243 :: 		while(!RA2_bit);
L_SampleButtons105:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons106
	GOTO        L_SampleButtons105
L_SampleButtons106:
;ADC_Buttons.c,244 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,245 :: 		goto ret2;
	GOTO        ___SampleButtons_ret2
;ADC_Buttons.c,246 :: 		}
L_SampleButtons104:
;ADC_Buttons.c,247 :: 		case 1:
L_SampleButtons107:
;ADC_Buttons.c,248 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	GOTO        L_SampleButtons110
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons110
L__SampleButtons343:
;ADC_Buttons.c,249 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,250 :: 		OK_A = 1;OK_B = 0;OK_C = 0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,251 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,252 :: 		Save_EncoderValue(pid_t.Kp);
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,253 :: 		while(!RA2_bit);
L_SampleButtons111:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons112
	GOTO        L_SampleButtons111
L_SampleButtons112:
;ADC_Buttons.c,254 :: 		}
L_SampleButtons110:
;ADC_Buttons.c,255 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons113
;ADC_Buttons.c,256 :: 		pid_t.Kp = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
	MOVLW       0
	MOVWF       _pid_t+1 
;ADC_Buttons.c,257 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons114
;ADC_Buttons.c,258 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,259 :: 		while(!RA2_bit);
L_SampleButtons115:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons116
	GOTO        L_SampleButtons115
L_SampleButtons116:
;ADC_Buttons.c,260 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,261 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,262 :: 		}
L_SampleButtons114:
;ADC_Buttons.c,263 :: 		}
L_SampleButtons113:
;ADC_Buttons.c,264 :: 		case 2:
L_SampleButtons117:
;ADC_Buttons.c,265 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
	GOTO        L_SampleButtons120
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons120
L__SampleButtons342:
;ADC_Buttons.c,266 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,267 :: 		OK_B = 1;OK_A=0;OK_C=0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,268 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,269 :: 		Save_EncoderValue(pid_t.Ki);
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,270 :: 		while(!RA2_bit);
L_SampleButtons121:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons122
	GOTO        L_SampleButtons121
L_SampleButtons122:
;ADC_Buttons.c,271 :: 		}
L_SampleButtons120:
;ADC_Buttons.c,272 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons123
;ADC_Buttons.c,273 :: 		pid_t.Ki = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
	MOVLW       0
	MOVWF       _pid_t+3 
;ADC_Buttons.c,274 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons124
;ADC_Buttons.c,275 :: 		OK_B = 0;OK_A=0;OK_C=0;OK_D=0;OK_E=0;
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,276 :: 		while(!RA2_bit);
L_SampleButtons125:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons126
	GOTO        L_SampleButtons125
L_SampleButtons126:
;ADC_Buttons.c,277 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,278 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,279 :: 		}
L_SampleButtons124:
;ADC_Buttons.c,280 :: 		}
L_SampleButtons123:
;ADC_Buttons.c,281 :: 		case 3:
L_SampleButtons127:
;ADC_Buttons.c,282 :: 		if(P2){
	BTFSS       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons128
;ADC_Buttons.c,283 :: 		P2 = 0;
	BCF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,284 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,285 :: 		}
L_SampleButtons128:
;ADC_Buttons.c,286 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_C){
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
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons131
L__SampleButtons341:
;ADC_Buttons.c,287 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,288 :: 		OK_C = 1;OK_A=0;OK_B=0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,289 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,290 :: 		Save_EncoderValue(pid_t.Kd);
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,291 :: 		while(!RA2_bit);
L_SampleButtons132:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons133
	GOTO        L_SampleButtons132
L_SampleButtons133:
;ADC_Buttons.c,292 :: 		}
L_SampleButtons131:
;ADC_Buttons.c,293 :: 		if(OK_C){
	BTFSS       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons134
;ADC_Buttons.c,294 :: 		pid_t.Kd = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
	MOVLW       0
	MOVWF       _pid_t+5 
;ADC_Buttons.c,295 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons135
;ADC_Buttons.c,296 :: 		OK_C = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,297 :: 		while(!RA2_bit);
L_SampleButtons136:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons137
	GOTO        L_SampleButtons136
L_SampleButtons137:
;ADC_Buttons.c,298 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,299 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,300 :: 		}
L_SampleButtons135:
;ADC_Buttons.c,301 :: 		}
L_SampleButtons134:
;ADC_Buttons.c,302 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu     ");
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
;ADC_Buttons.c,303 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp:=     ");
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
;ADC_Buttons.c,304 :: 		sprintf(txt4,"%3d",pid_t.Kp);
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
;ADC_Buttons.c,305 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,306 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki:=     ");
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
;ADC_Buttons.c,307 :: 		sprintf(txt4,"%3d",pid_t.Ki);
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
;ADC_Buttons.c,308 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,309 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd:=     ");
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
;ADC_Buttons.c,310 :: 		sprintf(txt4,"%3d",pid_t.Kd);
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
;ADC_Buttons.c,311 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,16,txt4);
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
;ADC_Buttons.c,312 :: 		break;
	GOTO        L_SampleButtons100
;ADC_Buttons.c,313 :: 		case 4:
L_SampleButtons138:
;ADC_Buttons.c,314 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_D){
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
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons141
L__SampleButtons340:
;ADC_Buttons.c,315 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,316 :: 		OK_D = 1;OK_A=0;OK_B=0;OK_C = 0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,317 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,318 :: 		Save_EncoderValue(pid_t.Kt);
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	BTFSC       _pid_t+33, 7 
	MOVLW       255
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,319 :: 		while(!RA2_bit);
L_SampleButtons142:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons143
	GOTO        L_SampleButtons142
L_SampleButtons143:
;ADC_Buttons.c,320 :: 		}
L_SampleButtons141:
;ADC_Buttons.c,321 :: 		if(OK_D){
	BTFSS       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons144
;ADC_Buttons.c,322 :: 		pid_t.Kt = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,323 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons145
;ADC_Buttons.c,324 :: 		OK_D = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,325 :: 		while(!RA2_bit);
L_SampleButtons146:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons147
	GOTO        L_SampleButtons146
L_SampleButtons147:
;ADC_Buttons.c,326 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,327 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc+4);
	MOVLW       4
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,328 :: 		}
L_SampleButtons145:
;ADC_Buttons.c,329 :: 		}
L_SampleButtons144:
;ADC_Buttons.c,330 :: 		case 5:
L_SampleButtons148:
;ADC_Buttons.c,331 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_E){
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
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons151
L__SampleButtons339:
;ADC_Buttons.c,332 :: 		enC = (uint8_t)Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,333 :: 		OK_E = 1;OK_A=0;OK_B=0;OK_C = 0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 4 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,334 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,335 :: 		Save_EncoderValue(DegC.Deg_OffSet);
	MOVF        _DegC+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,336 :: 		while(!RA2_bit);
L_SampleButtons152:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons153
	GOTO        L_SampleButtons152
L_SampleButtons153:
;ADC_Buttons.c,337 :: 		}
L_SampleButtons151:
;ADC_Buttons.c,338 :: 		if(OK_E){
	BTFSS       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons154
;ADC_Buttons.c,339 :: 		DegC.Deg_OffSet = (uint8_t)Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
	MOVLW       0
	MOVWF       _DegC+9 
;ADC_Buttons.c,340 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons155
;ADC_Buttons.c,341 :: 		OK_E = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,342 :: 		while(!RA2_bit);
L_SampleButtons156:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons157
	GOTO        L_SampleButtons156
L_SampleButtons157:
;ADC_Buttons.c,343 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,344 :: 		enC = (uint8_t)Save_EncoderValue(enC_line_inc+4);
	MOVLW       5
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,345 :: 		}
L_SampleButtons155:
;ADC_Buttons.c,346 :: 		}
L_SampleButtons154:
;ADC_Buttons.c,347 :: 		case 6:
L_SampleButtons158:
;ADC_Buttons.c,348 :: 		case 7:
L_SampleButtons159:
;ADC_Buttons.c,349 :: 		if(!P2){
	BTFSC       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons160
;ADC_Buttons.c,350 :: 		P2 = 1;
	BSF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,351 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,352 :: 		}
L_SampleButtons160:
;ADC_Buttons.c,353 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"*Kt");
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
;ADC_Buttons.c,354 :: 		sprintf(txt4,"%4d",pid_t.Kt);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_37_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_37_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_37_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,355 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       16
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,356 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"*C Offset");
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
;ADC_Buttons.c,357 :: 		sprintf(txt4,"%4d",DegC.Deg_OffSet);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_39_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_39_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_39_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+8, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,358 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,359 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr40_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr40_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,360 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr41_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr41_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,361 :: 		break;
	GOTO        L_SampleButtons100
;ADC_Buttons.c,362 :: 		case 8:
L_SampleButtons161:
;ADC_Buttons.c,363 :: 		case 9:
L_SampleButtons162:
;ADC_Buttons.c,364 :: 		case 10:
L_SampleButtons163:
;ADC_Buttons.c,365 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare    ");
L_SampleButtons164:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr42_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr42_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,366 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare    ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr43_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr43_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,367 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
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
;ADC_Buttons.c,368 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr45_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr45_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,369 :: 		break;
	GOTO        L_SampleButtons100
;ADC_Buttons.c,370 :: 		default:   //clear screen & update cursor position
L_SampleButtons165:
;ADC_Buttons.c,371 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,372 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+24 
;ADC_Buttons.c,373 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,374 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,375 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,376 :: 		break;
	GOTO        L_SampleButtons100
;ADC_Buttons.c,377 :: 		}
L_SampleButtons99:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons396
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons396:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons101
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons397
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons397:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons107
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons398
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons398:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons117
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons399
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons399:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons127
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons400
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons400:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons138
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons401
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons401:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons148
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons402
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons402:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons158
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons403
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons403:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons159
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons404
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons404:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons161
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons405
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons405:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons162
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons406
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons406:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons163
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons407
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons407:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons164
	GOTO        L_SampleButtons165
L_SampleButtons100:
;ADC_Buttons.c,378 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,379 :: 		case RampSettings:
L_SampleButtons166:
;ADC_Buttons.c,380 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons408
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons408:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons167
;ADC_Buttons.c,381 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,382 :: 		}
L_SampleButtons167:
;ADC_Buttons.c,383 :: 		ret3:
___SampleButtons_ret3:
;ADC_Buttons.c,384 :: 		switch(enC){
	GOTO        L_SampleButtons168
;ADC_Buttons.c,385 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
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
	MOVF        _Sps+24, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons173
L__SampleButtons338:
;ADC_Buttons.c,386 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
;ADC_Buttons.c,387 :: 		while(!RA2_bit);
L_SampleButtons174:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons175
	GOTO        L_SampleButtons174
L_SampleButtons175:
;ADC_Buttons.c,388 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,389 :: 		goto ret3;
	GOTO        ___SampleButtons_ret3
;ADC_Buttons.c,390 :: 		}
L_SampleButtons173:
;ADC_Buttons.c,391 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
L__SampleButtons337:
;ADC_Buttons.c,392 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,393 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,394 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,395 :: 		Save_EncoderValue(Sps.RmpDeg);
	MOVF        _Sps+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,396 :: 		while(!RA2_bit);
L_SampleButtons180:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons181
	GOTO        L_SampleButtons180
L_SampleButtons181:
;ADC_Buttons.c,397 :: 		}
L_SampleButtons179:
;ADC_Buttons.c,398 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons182
;ADC_Buttons.c,399 :: 		Sps.RmpDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
	MOVF        R1, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,400 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,401 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,402 :: 		while(!RA2_bit);
L_SampleButtons184:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons185
	GOTO        L_SampleButtons184
L_SampleButtons185:
;ADC_Buttons.c,403 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,404 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,405 :: 		}
L_SampleButtons183:
;ADC_Buttons.c,406 :: 		}
L_SampleButtons182:
;ADC_Buttons.c,407 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
L__SampleButtons336:
;ADC_Buttons.c,408 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,409 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,410 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,411 :: 		Save_EncoderValue(Sps.RmpSec);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,412 :: 		while(!RA2_bit);
L_SampleButtons190:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons191
	GOTO        L_SampleButtons190
L_SampleButtons191:
;ADC_Buttons.c,413 :: 		}
L_SampleButtons189:
;ADC_Buttons.c,414 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons192
;ADC_Buttons.c,415 :: 		Sps.RmpSec = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
	MOVF        R1, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,416 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,417 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,418 :: 		while(!RA2_bit);
L_SampleButtons194:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons195
	GOTO        L_SampleButtons194
L_SampleButtons195:
;ADC_Buttons.c,419 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,420 :: 		enC = Save_EncoderValue(enC_line_inc);
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
;ADC_Buttons.c,424 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr46_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr46_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,425 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr47_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr47_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,426 :: 		sprintf(txt4,"%3d",Sps.RmpDeg);
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
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
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
;ADC_Buttons.c,428 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpSec:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr49_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr49_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,429 :: 		sprintf(txt4,"%3d",Sps.RmpSec);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_50_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_50_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_50_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
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
;ADC_Buttons.c,431 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr51_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr51_ADC_Buttons+0)
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
	GOTO        L__SampleButtons409
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons409:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons170
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons410
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons410:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons176
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons411
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons411:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons186
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons412
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons412:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons196
	GOTO        L_SampleButtons197
L_SampleButtons169:
;ADC_Buttons.c,440 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,441 :: 		case SoakSettings:
L_SampleButtons198:
;ADC_Buttons.c,442 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons413
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons413:
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
;ADC_Buttons.c,445 :: 		ret4:
___SampleButtons_ret4:
;ADC_Buttons.c,446 :: 		switch(enC){
	GOTO        L_SampleButtons200
;ADC_Buttons.c,447 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
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
	MOVF        _Sps+24, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons205
L__SampleButtons335:
;ADC_Buttons.c,448 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
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
;ADC_Buttons.c,451 :: 		goto ret4;
	GOTO        ___SampleButtons_ret4
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
L__SampleButtons334:
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
;ADC_Buttons.c,457 :: 		Save_EncoderValue(Sps.SokDeg);
	MOVF        _Sps+6, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,458 :: 		while(!RA2_bit);
L_SampleButtons212:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons213
	GOTO        L_SampleButtons212
L_SampleButtons213:
;ADC_Buttons.c,459 :: 		}
L_SampleButtons211:
;ADC_Buttons.c,460 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons214
;ADC_Buttons.c,461 :: 		Sps.SokDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
	MOVF        R1, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,462 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons215
;ADC_Buttons.c,463 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,464 :: 		while(!RA2_bit);
L_SampleButtons216:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons217
	GOTO        L_SampleButtons216
L_SampleButtons217:
;ADC_Buttons.c,465 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,466 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,467 :: 		}
L_SampleButtons215:
;ADC_Buttons.c,468 :: 		}
L_SampleButtons214:
;ADC_Buttons.c,469 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons218:
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
	GOTO        L_SampleButtons221
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons221
L__SampleButtons333:
;ADC_Buttons.c,470 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,471 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,472 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,473 :: 		Save_EncoderValue(Sps.SokSec);
	MOVF        _Sps+10, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,474 :: 		while(!RA2_bit);
L_SampleButtons222:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons223
	GOTO        L_SampleButtons222
L_SampleButtons223:
;ADC_Buttons.c,475 :: 		}
L_SampleButtons221:
;ADC_Buttons.c,476 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons224
;ADC_Buttons.c,477 :: 		Sps.SokSec = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
	MOVF        R1, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,478 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons225
;ADC_Buttons.c,479 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,480 :: 		while(!RA2_bit);
L_SampleButtons226:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons227
	GOTO        L_SampleButtons226
L_SampleButtons227:
;ADC_Buttons.c,481 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,482 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,484 :: 		}
L_SampleButtons225:
;ADC_Buttons.c,485 :: 		}
L_SampleButtons224:
;ADC_Buttons.c,486 :: 		case 3:
L_SampleButtons228:
;ADC_Buttons.c,487 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr52_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr52_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,488 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr53_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr53_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,489 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
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
;ADC_Buttons.c,490 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,491 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakSec:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr55_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr55_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,492 :: 		sprintf(txt4,"%3d",Sps.SokSec);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_56_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_56_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_56_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,493 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,494 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr57_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr57_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,495 :: 		break;
	GOTO        L_SampleButtons201
;ADC_Buttons.c,496 :: 		default:    //clear screen & update cursor position
L_SampleButtons229:
;ADC_Buttons.c,497 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,498 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,499 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,500 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,501 :: 		break;
	GOTO        L_SampleButtons201
;ADC_Buttons.c,502 :: 		}
L_SampleButtons200:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons414
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons414:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons202
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons415
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons415:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons208
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons416
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons416:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons218
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons417
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons417:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons228
	GOTO        L_SampleButtons229
L_SampleButtons201:
;ADC_Buttons.c,503 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,504 :: 		case SpikeSettings:
L_SampleButtons230:
;ADC_Buttons.c,505 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons418
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons418:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons231
;ADC_Buttons.c,506 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,507 :: 		}
L_SampleButtons231:
;ADC_Buttons.c,508 :: 		ret5:
___SampleButtons_ret5:
;ADC_Buttons.c,509 :: 		switch(enC){
	GOTO        L_SampleButtons232
;ADC_Buttons.c,510 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
L_SampleButtons234:
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
	GOTO        L_SampleButtons237
	MOVF        _Sps+24, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons237
L__SampleButtons332:
;ADC_Buttons.c,511 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
;ADC_Buttons.c,512 :: 		while(!RA2_bit);
L_SampleButtons238:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons239
	GOTO        L_SampleButtons238
L_SampleButtons239:
;ADC_Buttons.c,513 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,514 :: 		goto ret5;
	GOTO        ___SampleButtons_ret5
;ADC_Buttons.c,515 :: 		}
L_SampleButtons237:
;ADC_Buttons.c,516 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons240:
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons243
L__SampleButtons331:
;ADC_Buttons.c,517 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,518 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,519 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,520 :: 		Save_EncoderValue(Sps.SpkeDeg);
	MOVF        _Sps+12, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,521 :: 		}
L_SampleButtons243:
;ADC_Buttons.c,522 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons244
;ADC_Buttons.c,523 :: 		Sps.SpkeDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
	MOVF        R1, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,524 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons245
;ADC_Buttons.c,525 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,526 :: 		while(!RA2_bit);
L_SampleButtons246:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons247
	GOTO        L_SampleButtons246
L_SampleButtons247:
;ADC_Buttons.c,527 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,528 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,529 :: 		}
L_SampleButtons245:
;ADC_Buttons.c,530 :: 		}
L_SampleButtons244:
;ADC_Buttons.c,531 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons248:
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
	GOTO        L_SampleButtons251
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons251
L__SampleButtons330:
;ADC_Buttons.c,532 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,533 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,534 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,535 :: 		Save_EncoderValue(Sps.SpkeSec);
	MOVF        _Sps+16, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+17, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,536 :: 		while(!RA2_bit);
L_SampleButtons252:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons253
	GOTO        L_SampleButtons252
L_SampleButtons253:
;ADC_Buttons.c,537 :: 		}
L_SampleButtons251:
;ADC_Buttons.c,538 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons254
;ADC_Buttons.c,539 :: 		Sps.SpkeSec = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+16 
	MOVF        R1, 0 
	MOVWF       _Sps+17 
;ADC_Buttons.c,540 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons255
;ADC_Buttons.c,541 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,542 :: 		while(!RA2_bit);
L_SampleButtons256:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons257
	GOTO        L_SampleButtons256
L_SampleButtons257:
;ADC_Buttons.c,543 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,544 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,545 :: 		}
L_SampleButtons255:
;ADC_Buttons.c,546 :: 		}
L_SampleButtons254:
;ADC_Buttons.c,547 :: 		case 3:
L_SampleButtons258:
;ADC_Buttons.c,548 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret       ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr58_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr58_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,549 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SpikeDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr59_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr59_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,550 :: 		sprintf(txt4,"%3d",Sps.SpkeDeg);
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
	MOVF        _Sps+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,551 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,552 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SpikeSec:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr61_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr61_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,553 :: 		sprintf(txt4,"%3d",Sps.SpkeSec);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_62_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_62_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_62_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+16, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+17, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,554 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,555 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"          ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr63_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr63_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,556 :: 		break;
	GOTO        L_SampleButtons233
;ADC_Buttons.c,557 :: 		default:    //clear screen & update cursor position
L_SampleButtons259:
;ADC_Buttons.c,558 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,559 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,560 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,561 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,562 :: 		break;
	GOTO        L_SampleButtons233
;ADC_Buttons.c,563 :: 		}
L_SampleButtons232:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons419
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons419:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons234
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons420
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons420:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons240
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons421
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons421:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons248
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons422
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons422:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons258
	GOTO        L_SampleButtons259
L_SampleButtons233:
;ADC_Buttons.c,564 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,565 :: 		case CoolSettings:
L_SampleButtons260:
;ADC_Buttons.c,566 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons423
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons423:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons261
;ADC_Buttons.c,567 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,568 :: 		}
L_SampleButtons261:
;ADC_Buttons.c,569 :: 		ret6:
___SampleButtons_ret6:
;ADC_Buttons.c,570 :: 		switch(enC){
	GOTO        L_SampleButtons262
;ADC_Buttons.c,571 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
L_SampleButtons264:
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
	GOTO        L_SampleButtons267
	MOVF        _Sps+24, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons267
L__SampleButtons329:
;ADC_Buttons.c,572 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
;ADC_Buttons.c,573 :: 		while(!RA2_bit);
L_SampleButtons268:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons269
	GOTO        L_SampleButtons268
L_SampleButtons269:
;ADC_Buttons.c,574 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,575 :: 		goto ret6;
	GOTO        ___SampleButtons_ret6
;ADC_Buttons.c,576 :: 		}
L_SampleButtons267:
;ADC_Buttons.c,577 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons270:
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
	GOTO        L_SampleButtons273
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons273
L__SampleButtons328:
;ADC_Buttons.c,578 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,579 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,580 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,581 :: 		Save_EncoderValue(Sps.CoolOffDeg);
	MOVF        _Sps+18, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+19, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,582 :: 		}
L_SampleButtons273:
;ADC_Buttons.c,583 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons274
;ADC_Buttons.c,584 :: 		Sps.CoolOffDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+18 
	MOVF        R1, 0 
	MOVWF       _Sps+19 
;ADC_Buttons.c,585 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons275
;ADC_Buttons.c,586 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,587 :: 		while(!RA2_bit);
L_SampleButtons276:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons277
	GOTO        L_SampleButtons276
L_SampleButtons277:
;ADC_Buttons.c,588 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,589 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,590 :: 		}
L_SampleButtons275:
;ADC_Buttons.c,591 :: 		}
L_SampleButtons274:
;ADC_Buttons.c,592 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons278:
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
	GOTO        L_SampleButtons281
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons281
L__SampleButtons327:
;ADC_Buttons.c,593 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,594 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,595 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,596 :: 		Save_EncoderValue(Sps.CoolOffSec);
	MOVF        _Sps+22, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+23, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,597 :: 		while(!RA2_bit);
L_SampleButtons282:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons283
	GOTO        L_SampleButtons282
L_SampleButtons283:
;ADC_Buttons.c,598 :: 		}
L_SampleButtons281:
;ADC_Buttons.c,599 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons284
;ADC_Buttons.c,600 :: 		Sps.CoolOffSec = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+22 
	MOVF        R1, 0 
	MOVWF       _Sps+23 
;ADC_Buttons.c,601 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons285
;ADC_Buttons.c,602 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,603 :: 		while(!RA2_bit);
L_SampleButtons286:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons287
	GOTO        L_SampleButtons286
L_SampleButtons287:
;ADC_Buttons.c,604 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,605 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,606 :: 		}
L_SampleButtons285:
;ADC_Buttons.c,607 :: 		}
L_SampleButtons284:
;ADC_Buttons.c,608 :: 		case 3:
L_SampleButtons288:
;ADC_Buttons.c,609 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr64_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr64_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,610 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"CoolDeg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr65_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr65_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,611 :: 		sprintf(txt4,"%3d",Sps.CoolOffDeg);
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
	MOVF        _Sps+18, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+19, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,612 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,613 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"CoolSec:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr67_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr67_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,614 :: 		sprintf(txt4,"%3d",Sps.CoolOffSec);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_68_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_68_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_68_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+22, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+23, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,615 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,616 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr69_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr69_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,617 :: 		break;
	GOTO        L_SampleButtons263
;ADC_Buttons.c,618 :: 		default:    //clear screen & update cursor position
L_SampleButtons289:
;ADC_Buttons.c,619 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,620 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,621 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,622 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,623 :: 		break;
	GOTO        L_SampleButtons263
;ADC_Buttons.c,624 :: 		}
L_SampleButtons262:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons424
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons424:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons264
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons425
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons425:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons270
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons426
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons426:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons278
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons427
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons427:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons288
	GOTO        L_SampleButtons289
L_SampleButtons263:
;ADC_Buttons.c,625 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,626 :: 		case TimeSettings:
L_SampleButtons290:
;ADC_Buttons.c,627 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons428
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons428:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons291
;ADC_Buttons.c,628 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,629 :: 		}
L_SampleButtons291:
;ADC_Buttons.c,630 :: 		ret7:
___SampleButtons_ret7:
;ADC_Buttons.c,631 :: 		switch(enC){
	GOTO        L_SampleButtons292
;ADC_Buttons.c,632 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == TimeSettings)){
L_SampleButtons294:
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
	GOTO        L_SampleButtons297
	MOVF        _Sps+24, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons297
L__SampleButtons326:
;ADC_Buttons.c,633 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+24 
;ADC_Buttons.c,634 :: 		while(!RA2_bit);
L_SampleButtons298:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons299
	GOTO        L_SampleButtons298
L_SampleButtons299:
;ADC_Buttons.c,635 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,636 :: 		goto ret7;
	GOTO        ___SampleButtons_ret7
;ADC_Buttons.c,637 :: 		}
L_SampleButtons297:
;ADC_Buttons.c,638 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons300:
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
	GOTO        L_SampleButtons303
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons303
L__SampleButtons325:
;ADC_Buttons.c,639 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,640 :: 		OK_A = 1;OK_B=0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,641 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,642 :: 		Save_EncoderValue(Sps.SerialWriteDly);
	MOVF        _Sps+25, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,643 :: 		}
L_SampleButtons303:
;ADC_Buttons.c,644 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons304
;ADC_Buttons.c,645 :: 		Sps.SerialWriteDly = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+25 
;ADC_Buttons.c,646 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons305
;ADC_Buttons.c,647 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,648 :: 		while(!RA2_bit);
L_SampleButtons306:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons307
	GOTO        L_SampleButtons306
L_SampleButtons307:
;ADC_Buttons.c,649 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,650 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,651 :: 		}
L_SampleButtons305:
;ADC_Buttons.c,652 :: 		}
L_SampleButtons304:
;ADC_Buttons.c,653 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons308:
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
	GOTO        L_SampleButtons311
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons311
L__SampleButtons324:
;ADC_Buttons.c,654 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,655 :: 		OK_B = 1;OK_A=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,656 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,657 :: 		Save_EncoderValue(DegC.SampleTmrSP);
	MOVF        _DegC+22, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,658 :: 		while(!RA2_bit);
L_SampleButtons312:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons313
	GOTO        L_SampleButtons312
L_SampleButtons313:
;ADC_Buttons.c,659 :: 		}
L_SampleButtons311:
;ADC_Buttons.c,660 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons314
;ADC_Buttons.c,661 :: 		DegC.SampleTmrSP = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+22 
;ADC_Buttons.c,662 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons315
;ADC_Buttons.c,663 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,664 :: 		while(!RA2_bit);
L_SampleButtons316:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons317
	GOTO        L_SampleButtons316
L_SampleButtons317:
;ADC_Buttons.c,665 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,666 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,667 :: 		}
L_SampleButtons315:
;ADC_Buttons.c,668 :: 		}
L_SampleButtons314:
;ADC_Buttons.c,669 :: 		case 3:
L_SampleButtons318:
;ADC_Buttons.c,670 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr70_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr70_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,671 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ser Dly:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr71_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr71_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,672 :: 		sprintf(txt4,"%4d",Sps.SerialWriteDly);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_72_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_72_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_72_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+25, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,673 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,674 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"'C  Dly:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr73_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr73_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,675 :: 		sprintf(txt4,"%4d",DegC.SampleTmrSP);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_74_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_74_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_74_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+22, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,676 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,677 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr75_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr75_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,678 :: 		break;
	GOTO        L_SampleButtons293
;ADC_Buttons.c,679 :: 		default:    //clear screen & update cursor position
L_SampleButtons319:
;ADC_Buttons.c,680 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,681 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,682 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,683 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,684 :: 		break;
	GOTO        L_SampleButtons293
;ADC_Buttons.c,685 :: 		}
L_SampleButtons292:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons429
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons429:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons294
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons430
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons430:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons300
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons431
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons431:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons308
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons432
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons432:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons318
	GOTO        L_SampleButtons319
L_SampleButtons293:
;ADC_Buttons.c,686 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,687 :: 		default: Sps.State = Return;
L_SampleButtons320:
	MOVLW       1
	MOVWF       _Sps+24 
;ADC_Buttons.c,688 :: 		break;
	GOTO        L_SampleButtons26
;ADC_Buttons.c,689 :: 		}
L_SampleButtons25:
	MOVF        _Sps+24, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons27
	MOVF        _Sps+24, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons62
	MOVF        _Sps+24, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons97
	MOVF        _Sps+24, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons166
	MOVF        _Sps+24, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons198
	MOVF        _Sps+24, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons230
	MOVF        _Sps+24, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons260
	MOVF        _Sps+24, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons290
	GOTO        L_SampleButtons320
L_SampleButtons26:
;ADC_Buttons.c,691 :: 		}
L_SampleButtons20:
;ADC_Buttons.c,693 :: 		if(EEWrt){
	BTFSS       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons321
;ADC_Buttons.c,694 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,695 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Writing To EEPROM...");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr76_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr76_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,696 :: 		Delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_SampleButtons322:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons322
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons322
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons322
	NOP
;ADC_Buttons.c,697 :: 		EERead();
	CALL        _EERead+0, 0
;ADC_Buttons.c,698 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,699 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,700 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,701 :: 		}
L_SampleButtons321:
;ADC_Buttons.c,703 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,705 :: 		void ResetBits(){
;ADC_Buttons.c,706 :: 		valOf     = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,707 :: 		Sps.State = 0;
	CLRF        _Sps+24 
;ADC_Buttons.c,708 :: 		Menu_Bit  = 0;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,709 :: 		OK_A      = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,710 :: 		OK_B      = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,711 :: 		OK_C      = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,712 :: 		OK_D      = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,713 :: 		OK_E      = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,714 :: 		OK_F      = 0;
	BCF         ADC_Buttons_B_+0, 5 
;ADC_Buttons.c,715 :: 		OK_G      = 0;
	BCF         ADC_Buttons_B_+0, 6 
;ADC_Buttons.c,716 :: 		OK_H      = 0;
	BCF         ADC_Buttons_B_+0, 7 
;ADC_Buttons.c,717 :: 		OK_I      = 0;
	BCF         ADC_Buttons_B+0, 5 
;ADC_Buttons.c,718 :: 		OK_J      = 0;
	BCF         ADC_Buttons_B+0, 6 
;ADC_Buttons.c,719 :: 		OK_K      = 0;
	BCF         ADC_Buttons_B+0, 7 
;ADC_Buttons.c,720 :: 		EEWrt = 0;
	BCF         ADC_Buttons_B+0, 4 
;ADC_Buttons.c,721 :: 		P1 = 0;
	BCF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,722 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_EERead:

;ADC_Buttons.c,724 :: 		void EERead(){
;ADC_Buttons.c,726 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,727 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,728 :: 		Lo(Sps.RmpSec)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,729 :: 		Hi(Sps.RmpSec)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,730 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,731 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,732 :: 		Lo(Sps.SokSec)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,733 :: 		Hi(Sps.SokSec)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,734 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,735 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,736 :: 		Lo(Sps.SpkeSec)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+16 
;ADC_Buttons.c,737 :: 		Hi(Sps.SpkeSec)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+17 
;ADC_Buttons.c,738 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+18 
;ADC_Buttons.c,739 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+19 
;ADC_Buttons.c,740 :: 		Lo(Sps.CoolOffSec)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+22 
;ADC_Buttons.c,741 :: 		Hi(Sps.CoolOffSec)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+23 
;ADC_Buttons.c,744 :: 		Lo(pid_t.Kp)         = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,745 :: 		Hi(pid_t.Kp)         = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,746 :: 		Lo(pid_t.Ki)         = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,747 :: 		Hi(pid_t.Ki)         = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,748 :: 		Lo(pid_t.Kd)         = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,749 :: 		Hi(pid_t.Kd)         = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,750 :: 		Lo(DegC.Deg_OffSet)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
;ADC_Buttons.c,751 :: 		Hi(DegC.Deg_OffSet)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+9 
;ADC_Buttons.c,752 :: 		pid_t.Kt             = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,755 :: 		Lo(TempTicks.RampTick)   = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,756 :: 		Hi(TempTicks.RampTick)   = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,757 :: 		Lo(TempTicks.SoakTick)   = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,758 :: 		Hi(TempTicks.SoakTick)   = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,759 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1E);
	MOVLW       30
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,760 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1F);
	MOVLW       31
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,761 :: 		Lo(TempTicks.CoolTick)   = EEPROM_Read(0x20);
	MOVLW       32
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,762 :: 		Hi(TempTicks.CoolTick)   = EEPROM_Read(0x21);
	MOVLW       33
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,765 :: 		Sps.SerialWriteDly   =  EEPROM_Read(0x22);
	MOVLW       34
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+25 
;ADC_Buttons.c,766 :: 		DegC.SampleTmrSP     =  EEPROM_Read(0x23);
	MOVLW       35
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+22 
;ADC_Buttons.c,767 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,768 :: 		void EEWrite(){
;ADC_Buttons.c,770 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,771 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,772 :: 		EEPROM_Write(0x02, Lo(Sps.RmpSec));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,773 :: 		EEPROM_Write(0x03, Hi(Sps.RmpSec));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,774 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,775 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,776 :: 		EEPROM_Write(0x06, Lo(Sps.SokSec));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,777 :: 		EEPROM_Write(0x07, Hi(Sps.SokSec));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,778 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,779 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,780 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeSec));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+16, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,781 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeSec));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+17, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,782 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+18, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,783 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+19, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,784 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffSec));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+22, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,785 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffSec));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+23, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,788 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,789 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,790 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,791 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,792 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,793 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,794 :: 		EEPROM_Write(0x16, Lo(DegC.Deg_OffSet));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,795 :: 		EEPROM_Write(0x17, Hi(DegC.Deg_OffSet));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,796 :: 		EEPROM_Write(0x18, pid_t.Kt);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,799 :: 		EEPROM_Write(0x1A, Lo(TempTicks.RampTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,800 :: 		EEPROM_Write(0x1B, Hi(TempTicks.RampTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,801 :: 		EEPROM_Write(0x1C, Lo(TempTicks.SoakTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,802 :: 		EEPROM_Write(0x1D, Hi(TempTicks.SoakTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,803 :: 		EEPROM_Write(0x1E, Lo(TempTicks.SpikeTick));
	MOVLW       30
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,804 :: 		EEPROM_Write(0x1F, Hi(TempTicks.SpikeTick));
	MOVLW       31
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,805 :: 		EEPROM_Write(0x20, Lo(TempTicks.CoolTick));
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,806 :: 		EEPROM_Write(0x21, Hi(TempTicks.CoolTick));
	MOVLW       33
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,809 :: 		EEPROM_Write(0x22, Sps.SerialWriteDly);
	MOVLW       34
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+25, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,810 :: 		EEPROM_Write(0x23, DegC.SampleTmrSP);
	MOVLW       35
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+22, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,813 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite323:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite323
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite323
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite323
	NOP
;ADC_Buttons.c,814 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
