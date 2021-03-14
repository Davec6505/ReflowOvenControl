
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
;ADC_Buttons.c,54 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,55 :: 		if(!P0 && (enC != 0)){
	BTFSC       ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
	GOTO        L_SampleButtons3
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons316
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons316:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons3
L__SampleButtons313:
;ADC_Buttons.c,56 :: 		P0 = 1;
	BSF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,57 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,58 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,59 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,60 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,61 :: 		}
L_SampleButtons3:
;ADC_Buttons.c,63 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons6
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons6
L__SampleButtons312:
;ADC_Buttons.c,64 :: 		enC = Get_EncoderValue();//get encoder value
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
L_SampleButtons6:
;ADC_Buttons.c,66 :: 		if(enC < 0 || enC > 65000){
	MOVLW       0
	SUBWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons317
	MOVLW       0
	SUBWF       ADC_Buttons_enC+0, 0 
L__SampleButtons317:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons311
	MOVF        ADC_Buttons_enC+1, 0 
	SUBLW       253
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons318
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       232
L__SampleButtons318:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons311
	GOTO        L_SampleButtons9
L__SampleButtons311:
;ADC_Buttons.c,67 :: 		enC = 0;
	CLRF        ADC_Buttons_enC+0 
	CLRF        ADC_Buttons_enC+1 
;ADC_Buttons.c,68 :: 		enC = Save_EncoderValue(enC);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,69 :: 		}
L_SampleButtons9:
;ADC_Buttons.c,71 :: 		if(enC_last != enC){
	MOVF        ADC_Buttons_enC_last+1, 0 
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons319
	MOVF        ADC_Buttons_enC+0, 0 
	XORWF       ADC_Buttons_enC_last+0, 0 
L__SampleButtons319:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons10
;ADC_Buttons.c,72 :: 		enC_last = enC;
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_last+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,73 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E){
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons13
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons13
L__SampleButtons310:
;ADC_Buttons.c,74 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_last,1," ");
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
;ADC_Buttons.c,75 :: 		enC_line_inc =  enC % 4 + 1;
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
;ADC_Buttons.c,76 :: 		enC_line_last = enC_line_inc;
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC_line_last+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC_line_last+1 
;ADC_Buttons.c,77 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_inc,1,">");
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
;ADC_Buttons.c,78 :: 		enC_line_edit = enC_line_inc;
	MOVF        ADC_Buttons_enC_line_inc+0, 0 
	MOVWF       ADC_Buttons_enC_line_edit+0 
	MOVF        ADC_Buttons_enC_line_inc+1, 0 
	MOVWF       ADC_Buttons_enC_line_edit+1 
;ADC_Buttons.c,79 :: 		}
L_SampleButtons13:
;ADC_Buttons.c,80 :: 		}
L_SampleButtons10:
;ADC_Buttons.c,82 :: 		}
L_SampleButtons0:
;ADC_Buttons.c,84 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons14
;ADC_Buttons.c,87 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
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
L__SampleButtons309:
;ADC_Buttons.c,88 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15," ");
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
;ADC_Buttons.c,90 :: 		P1 = 1;
	BSF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,91 :: 		I2C_LCD_Out(LCD_01_ADDRESS,enC_line_edit,15,"@");
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
;ADC_Buttons.c,92 :: 		}
L_SampleButtons18:
;ADC_Buttons.c,99 :: 		state:
___SampleButtons_state:
;ADC_Buttons.c,100 :: 		switch(Sps.State){
	GOTO        L_SampleButtons19
;ADC_Buttons.c,101 :: 		case Return:   if(enC > 3){
L_SampleButtons21:
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons320
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons320:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons22
;ADC_Buttons.c,102 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,103 :: 		}
L_SampleButtons22:
;ADC_Buttons.c,104 :: 		close:
___SampleButtons_close:
;ADC_Buttons.c,105 :: 		switch(enC){
	GOTO        L_SampleButtons23
;ADC_Buttons.c,106 :: 		case 0: if (Button(&PORTA, 2, 100, 0) && Menu_Bit && !Ok_Bit){
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
L__SampleButtons308:
;ADC_Buttons.c,107 :: 		Ok_Bit = 1;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,108 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,109 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,110 :: 		}
L_SampleButtons28:
;ADC_Buttons.c,111 :: 		case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
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
L__SampleButtons307:
;ADC_Buttons.c,112 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,113 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,114 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,115 :: 		}
L_SampleButtons32:
;ADC_Buttons.c,117 :: 		case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
L__SampleButtons306:
;ADC_Buttons.c,118 :: 		Sps.State = PIDMenu;
	MOVLW       3
	MOVWF       _Sps+16 
;ADC_Buttons.c,119 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,120 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,121 :: 		}
L_SampleButtons36:
;ADC_Buttons.c,122 :: 		case 3:
L_SampleButtons37:
;ADC_Buttons.c,123 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
	GOTO        L_SampleButtons40
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons40
L__SampleButtons305:
;ADC_Buttons.c,124 :: 		Ok_Bit = 1;;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,125 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,126 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,127 :: 		}
L_SampleButtons40:
;ADC_Buttons.c,128 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
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
;ADC_Buttons.c,129 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
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
;ADC_Buttons.c,130 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
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
;ADC_Buttons.c,131 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"ReStart");
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
;ADC_Buttons.c,132 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,133 :: 		case 4:
L_SampleButtons41:
;ADC_Buttons.c,134 :: 		case 5:
L_SampleButtons42:
;ADC_Buttons.c,135 :: 		case 6:
L_SampleButtons43:
;ADC_Buttons.c,136 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons44:
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
;ADC_Buttons.c,137 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,138 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,139 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,140 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,141 :: 		case 8:
L_SampleButtons45:
;ADC_Buttons.c,142 :: 		case 9:
L_SampleButtons46:
;ADC_Buttons.c,143 :: 		case 10:
L_SampleButtons47:
;ADC_Buttons.c,144 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons48:
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
;ADC_Buttons.c,145 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,146 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,147 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,148 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,149 :: 		default:
L_SampleButtons49:
;ADC_Buttons.c,150 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,151 :: 		Delay_ms(800);
	MOVLW       65
	MOVWF       R11, 0
	MOVLW       240
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_SampleButtons50:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons50
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons50
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons50
;ADC_Buttons.c,152 :: 		if(P1) EEWrt = on;
	BTFSS       ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
	GOTO        L_SampleButtons51
	BSF         ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons52
L_SampleButtons51:
;ADC_Buttons.c,153 :: 		else Menu_Bit = off;
	BCF         ADC_Buttons_B+0, 0 
L_SampleButtons52:
;ADC_Buttons.c,154 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,155 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,156 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,157 :: 		}
L_SampleButtons23:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons321
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons321:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons25
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons322
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons322:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons29
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons323
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons323:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons33
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons324
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons324:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons37
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons325
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons325:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons41
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons326
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons326:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons42
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons327
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons327:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons43
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons328
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons328:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons44
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons329
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons329:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons45
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons330
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons330:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons46
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons331
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons331:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons47
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons332
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons332:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons48
	GOTO        L_SampleButtons49
L_SampleButtons24:
;ADC_Buttons.c,158 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,159 :: 		case TempMenu:
L_SampleButtons53:
;ADC_Buttons.c,160 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons333
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons333:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons54
;ADC_Buttons.c,161 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,162 :: 		}
L_SampleButtons54:
;ADC_Buttons.c,163 :: 		ret1:
___SampleButtons_ret1:
;ADC_Buttons.c,164 :: 		switch(enC){
	GOTO        L_SampleButtons55
;ADC_Buttons.c,165 :: 		case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
L_SampleButtons57:
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
	GOTO        L_SampleButtons60
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons60
L__SampleButtons304:
;ADC_Buttons.c,166 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,167 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,168 :: 		goto ret1;
	GOTO        ___SampleButtons_ret1
;ADC_Buttons.c,169 :: 		}
L_SampleButtons60:
;ADC_Buttons.c,170 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
L_SampleButtons61:
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
	GOTO        L_SampleButtons64
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons64
L__SampleButtons303:
;ADC_Buttons.c,171 :: 		Sps.State = RampSettings;
	MOVLW       4
	MOVWF       _Sps+16 
;ADC_Buttons.c,172 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,173 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,174 :: 		}
L_SampleButtons64:
;ADC_Buttons.c,175 :: 		case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
L_SampleButtons65:
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
	GOTO        L_SampleButtons68
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons68
L__SampleButtons302:
;ADC_Buttons.c,176 :: 		Sps.State = SoakSettings;
	MOVLW       5
	MOVWF       _Sps+16 
;ADC_Buttons.c,177 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,178 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,179 :: 		}
L_SampleButtons68:
;ADC_Buttons.c,180 :: 		case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
L_SampleButtons69:
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
	GOTO        L_SampleButtons72
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons72
L__SampleButtons301:
;ADC_Buttons.c,181 :: 		Sps.State = SpikeSettings;
	MOVLW       6
	MOVWF       _Sps+16 
;ADC_Buttons.c,182 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,183 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,184 :: 		}
L_SampleButtons72:
;ADC_Buttons.c,185 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
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
;ADC_Buttons.c,186 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
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
;ADC_Buttons.c,187 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
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
;ADC_Buttons.c,188 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
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
;ADC_Buttons.c,189 :: 		break;
	GOTO        L_SampleButtons56
;ADC_Buttons.c,190 :: 		case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
L_SampleButtons73:
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
	GOTO        L_SampleButtons76
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons76
L__SampleButtons300:
;ADC_Buttons.c,191 :: 		Sps.State = CoolSettings;
	MOVLW       7
	MOVWF       _Sps+16 
;ADC_Buttons.c,192 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,193 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,194 :: 		}
L_SampleButtons76:
;ADC_Buttons.c,195 :: 		case 5:
L_SampleButtons77:
;ADC_Buttons.c,196 :: 		case 6:
L_SampleButtons78:
;ADC_Buttons.c,197 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
L_SampleButtons79:
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
;ADC_Buttons.c,198 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,199 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,200 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,201 :: 		break;
	GOTO        L_SampleButtons56
;ADC_Buttons.c,202 :: 		case 8:
L_SampleButtons80:
;ADC_Buttons.c,203 :: 		case 9:
L_SampleButtons81:
;ADC_Buttons.c,204 :: 		case 10:
L_SampleButtons82:
;ADC_Buttons.c,205 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons83:
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
;ADC_Buttons.c,206 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,207 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,208 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,209 :: 		break;
	GOTO        L_SampleButtons56
;ADC_Buttons.c,210 :: 		default:    //clear screen & update cursor position
L_SampleButtons84:
;ADC_Buttons.c,211 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,212 :: 		Sps.State = 1;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,213 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,214 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,215 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,216 :: 		break;
	GOTO        L_SampleButtons56
;ADC_Buttons.c,217 :: 		}
L_SampleButtons55:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons334
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons334:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons57
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons335
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons335:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons61
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons336
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons336:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons65
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons337
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons337:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons69
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons338
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons338:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons73
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons339
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons339:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons77
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons340
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons340:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons78
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons341
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons341:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons79
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons342
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons342:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons80
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons343
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons343:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons81
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons344
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons344:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons82
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons345
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons345:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons83
	GOTO        L_SampleButtons84
L_SampleButtons56:
;ADC_Buttons.c,218 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,219 :: 		case PIDMenu:
L_SampleButtons85:
;ADC_Buttons.c,220 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons346
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons346:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons86
;ADC_Buttons.c,221 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,222 :: 		}
L_SampleButtons86:
;ADC_Buttons.c,223 :: 		ret2:
___SampleButtons_ret2:
;ADC_Buttons.c,224 :: 		switch(enC){
	GOTO        L_SampleButtons87
;ADC_Buttons.c,225 :: 		case 0:
L_SampleButtons89:
;ADC_Buttons.c,226 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
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
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons92
L__SampleButtons299:
;ADC_Buttons.c,227 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,228 :: 		while(!RA2_bit);
L_SampleButtons93:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons94
	GOTO        L_SampleButtons93
L_SampleButtons94:
;ADC_Buttons.c,229 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,230 :: 		goto ret2;
	GOTO        ___SampleButtons_ret2
;ADC_Buttons.c,231 :: 		}
L_SampleButtons92:
;ADC_Buttons.c,232 :: 		case 1:
L_SampleButtons95:
;ADC_Buttons.c,233 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	GOTO        L_SampleButtons98
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons98
L__SampleButtons298:
;ADC_Buttons.c,234 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,235 :: 		OK_A = 1;OK_B = 0;OK_C = 0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,236 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,237 :: 		Save_EncoderValue(pid_t.Kp);
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,238 :: 		while(!RA2_bit);
L_SampleButtons99:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons100
	GOTO        L_SampleButtons99
L_SampleButtons100:
;ADC_Buttons.c,239 :: 		}
L_SampleButtons98:
;ADC_Buttons.c,240 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons101
;ADC_Buttons.c,241 :: 		pid_t.Kp = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
	MOVF        R1, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,242 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons102
;ADC_Buttons.c,243 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,244 :: 		while(!RA2_bit);
L_SampleButtons103:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons104
	GOTO        L_SampleButtons103
L_SampleButtons104:
;ADC_Buttons.c,245 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,246 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,247 :: 		}
L_SampleButtons102:
;ADC_Buttons.c,248 :: 		}
L_SampleButtons101:
;ADC_Buttons.c,249 :: 		case 2:
L_SampleButtons105:
;ADC_Buttons.c,250 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
	GOTO        L_SampleButtons108
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons108
L__SampleButtons297:
;ADC_Buttons.c,251 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,252 :: 		OK_B = 1;OK_A=0;OK_C=0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,253 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,254 :: 		Save_EncoderValue(pid_t.Ki);
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,255 :: 		while(!RA2_bit);
L_SampleButtons109:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons110
	GOTO        L_SampleButtons109
L_SampleButtons110:
;ADC_Buttons.c,256 :: 		}
L_SampleButtons108:
;ADC_Buttons.c,257 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons111
;ADC_Buttons.c,258 :: 		pid_t.Ki = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
	MOVF        R1, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,259 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons112
;ADC_Buttons.c,260 :: 		OK_B = 0;OK_A=0;OK_C=0;OK_D=0;OK_E=0;
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,261 :: 		while(!RA2_bit);
L_SampleButtons113:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons114
	GOTO        L_SampleButtons113
L_SampleButtons114:
;ADC_Buttons.c,262 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,263 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,264 :: 		}
L_SampleButtons112:
;ADC_Buttons.c,265 :: 		}
L_SampleButtons111:
;ADC_Buttons.c,266 :: 		case 3:
L_SampleButtons115:
;ADC_Buttons.c,267 :: 		if(P2){
	BTFSS       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons116
;ADC_Buttons.c,268 :: 		P2 = 0;
	BCF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,269 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,270 :: 		}
L_SampleButtons116:
;ADC_Buttons.c,271 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_C){
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
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons119
L__SampleButtons296:
;ADC_Buttons.c,272 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,273 :: 		OK_C = 1;OK_A=0;OK_B=0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,274 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,275 :: 		Save_EncoderValue(pid_t.Kd);
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,276 :: 		while(!RA2_bit);
L_SampleButtons120:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons121
	GOTO        L_SampleButtons120
L_SampleButtons121:
;ADC_Buttons.c,277 :: 		}
L_SampleButtons119:
;ADC_Buttons.c,278 :: 		if(OK_C){
	BTFSS       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons122
;ADC_Buttons.c,279 :: 		pid_t.Kd = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
	MOVF        R1, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,280 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,281 :: 		OK_C = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,282 :: 		while(!RA2_bit);
L_SampleButtons124:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons125
	GOTO        L_SampleButtons124
L_SampleButtons125:
;ADC_Buttons.c,283 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,284 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,285 :: 		}
L_SampleButtons123:
;ADC_Buttons.c,286 :: 		}
L_SampleButtons122:
;ADC_Buttons.c,287 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu     ");
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
;ADC_Buttons.c,288 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp:=     ");
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
;ADC_Buttons.c,289 :: 		sprintf(txt4,"%3d",pid_t.Kp);
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
;ADC_Buttons.c,290 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,291 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki:=     ");
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
;ADC_Buttons.c,292 :: 		sprintf(txt4,"%3d",pid_t.Ki);
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
;ADC_Buttons.c,293 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,294 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd:=     ");
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
;ADC_Buttons.c,295 :: 		sprintf(txt4,"%3d",pid_t.Kd);
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
;ADC_Buttons.c,296 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,16,txt4);
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
;ADC_Buttons.c,297 :: 		break;
	GOTO        L_SampleButtons88
;ADC_Buttons.c,298 :: 		case 4:
L_SampleButtons126:
;ADC_Buttons.c,299 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_D){
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
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons129
L__SampleButtons295:
;ADC_Buttons.c,300 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,301 :: 		OK_D = 1;OK_A=0;OK_B=0;OK_C = 0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,302 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,303 :: 		Save_EncoderValue(pid_t.Kt);
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	BTFSC       _pid_t+33, 7 
	MOVLW       255
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,304 :: 		while(!RA2_bit);
L_SampleButtons130:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons131
	GOTO        L_SampleButtons130
L_SampleButtons131:
;ADC_Buttons.c,305 :: 		}
L_SampleButtons129:
;ADC_Buttons.c,306 :: 		if(OK_D){
	BTFSS       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons132
;ADC_Buttons.c,307 :: 		pid_t.Kt = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,308 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons133
;ADC_Buttons.c,309 :: 		OK_D = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,310 :: 		while(!RA2_bit);
L_SampleButtons134:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons135
	GOTO        L_SampleButtons134
L_SampleButtons135:
;ADC_Buttons.c,311 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,312 :: 		enC = Save_EncoderValue(enC_line_inc+4);
	MOVLW       4
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,313 :: 		}
L_SampleButtons133:
;ADC_Buttons.c,314 :: 		}
L_SampleButtons132:
;ADC_Buttons.c,315 :: 		case 5:
L_SampleButtons136:
;ADC_Buttons.c,316 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_E){
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
	GOTO        L_SampleButtons139
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons139
L__SampleButtons294:
;ADC_Buttons.c,317 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,318 :: 		OK_E = 1;OK_A=0;OK_B=0;OK_C = 0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 4 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,319 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,320 :: 		Save_EncoderValue(DegC.Deg_OffSet);
	MOVF        _DegC+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,321 :: 		while(!RA2_bit);
L_SampleButtons140:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons141
	GOTO        L_SampleButtons140
L_SampleButtons141:
;ADC_Buttons.c,322 :: 		}
L_SampleButtons139:
;ADC_Buttons.c,323 :: 		if(OK_E){
	BTFSS       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons142
;ADC_Buttons.c,324 :: 		DegC.Deg_OffSet = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
	MOVF        R1, 0 
	MOVWF       _DegC+9 
;ADC_Buttons.c,325 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons143
;ADC_Buttons.c,326 :: 		OK_E = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,327 :: 		while(!RA2_bit);
L_SampleButtons144:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons145
	GOTO        L_SampleButtons144
L_SampleButtons145:
;ADC_Buttons.c,328 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,329 :: 		enC = Save_EncoderValue(enC_line_inc+4);
	MOVLW       4
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,330 :: 		}
L_SampleButtons143:
;ADC_Buttons.c,331 :: 		}
L_SampleButtons142:
;ADC_Buttons.c,332 :: 		case 6:
L_SampleButtons146:
;ADC_Buttons.c,333 :: 		case 7:
L_SampleButtons147:
;ADC_Buttons.c,334 :: 		if(!P2){
	BTFSC       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons148
;ADC_Buttons.c,335 :: 		P2 = 1;
	BSF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,336 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,337 :: 		}
L_SampleButtons148:
;ADC_Buttons.c,338 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"*Kt");
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
;ADC_Buttons.c,339 :: 		sprintf(txt4,"%3d",pid_t.Kt);
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
;ADC_Buttons.c,340 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4);
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
;ADC_Buttons.c,341 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"*C Offset");
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
;ADC_Buttons.c,342 :: 		sprintf(txt4,"%3d",DegC.Deg_OffSet);
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
;ADC_Buttons.c,343 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,344 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
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
;ADC_Buttons.c,345 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
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
;ADC_Buttons.c,346 :: 		break;
	GOTO        L_SampleButtons88
;ADC_Buttons.c,347 :: 		case 8:
L_SampleButtons149:
;ADC_Buttons.c,348 :: 		case 9:
L_SampleButtons150:
;ADC_Buttons.c,349 :: 		case 10:
L_SampleButtons151:
;ADC_Buttons.c,350 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare    ");
L_SampleButtons152:
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
;ADC_Buttons.c,351 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare    ");
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
;ADC_Buttons.c,352 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
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
;ADC_Buttons.c,353 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
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
;ADC_Buttons.c,354 :: 		break;
	GOTO        L_SampleButtons88
;ADC_Buttons.c,355 :: 		default:   //clear screen & update cursor position
L_SampleButtons153:
;ADC_Buttons.c,356 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,357 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,358 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,359 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,360 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,361 :: 		break;
	GOTO        L_SampleButtons88
;ADC_Buttons.c,362 :: 		}
L_SampleButtons87:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons347
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons347:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons89
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons348
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons348:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons95
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons349
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons349:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons105
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons350
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons350:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons115
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons351
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons351:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons126
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons352
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons352:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons136
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons353
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons353:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons146
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons354
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons354:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons147
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons355
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons355:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons149
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons356
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons356:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons150
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons357
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons357:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons151
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons358
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons358:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons152
	GOTO        L_SampleButtons153
L_SampleButtons88:
;ADC_Buttons.c,363 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,364 :: 		case RampSettings:
L_SampleButtons154:
;ADC_Buttons.c,365 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons359
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons359:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons155
;ADC_Buttons.c,366 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,367 :: 		}
L_SampleButtons155:
;ADC_Buttons.c,368 :: 		ret3:
___SampleButtons_ret3:
;ADC_Buttons.c,369 :: 		switch(enC){
	GOTO        L_SampleButtons156
;ADC_Buttons.c,370 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
L_SampleButtons158:
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
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons161
L__SampleButtons293:
;ADC_Buttons.c,371 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,372 :: 		while(!RA2_bit);
L_SampleButtons162:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons163
	GOTO        L_SampleButtons162
L_SampleButtons163:
;ADC_Buttons.c,373 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,374 :: 		goto ret3;
	GOTO        ___SampleButtons_ret3
;ADC_Buttons.c,375 :: 		}
L_SampleButtons161:
;ADC_Buttons.c,376 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons167
L__SampleButtons292:
;ADC_Buttons.c,377 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,378 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,379 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,380 :: 		Save_EncoderValue(Sps.RmpDeg);
	MOVF        _Sps+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,381 :: 		while(!RA2_bit);
L_SampleButtons168:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons169
	GOTO        L_SampleButtons168
L_SampleButtons169:
;ADC_Buttons.c,382 :: 		}
L_SampleButtons167:
;ADC_Buttons.c,383 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons170
;ADC_Buttons.c,384 :: 		Sps.RmpDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
	MOVF        R1, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,385 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,386 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,387 :: 		while(!RA2_bit);
L_SampleButtons172:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons173
	GOTO        L_SampleButtons172
L_SampleButtons173:
;ADC_Buttons.c,388 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,389 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,390 :: 		}
L_SampleButtons171:
;ADC_Buttons.c,391 :: 		}
L_SampleButtons170:
;ADC_Buttons.c,392 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons174:
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
	GOTO        L_SampleButtons177
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons177
L__SampleButtons291:
;ADC_Buttons.c,393 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,394 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,395 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,396 :: 		Save_EncoderValue(Sps.RmpTmr);
	MOVF        _Sps+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,397 :: 		while(!RA2_bit);
L_SampleButtons178:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons179
	GOTO        L_SampleButtons178
L_SampleButtons179:
;ADC_Buttons.c,398 :: 		}
L_SampleButtons177:
;ADC_Buttons.c,399 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons180
;ADC_Buttons.c,400 :: 		Sps.RmpTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
	MOVF        R1, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,401 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons181
;ADC_Buttons.c,402 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,403 :: 		while(!RA2_bit);
L_SampleButtons182:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons183
	GOTO        L_SampleButtons182
L_SampleButtons183:
;ADC_Buttons.c,404 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,405 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,406 :: 		}
L_SampleButtons181:
;ADC_Buttons.c,407 :: 		}
L_SampleButtons180:
;ADC_Buttons.c,408 :: 		case 3:
L_SampleButtons184:
;ADC_Buttons.c,409 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
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
;ADC_Buttons.c,410 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
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
;ADC_Buttons.c,411 :: 		sprintf(txt4,"%3d",Sps.RmpDeg);
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
;ADC_Buttons.c,412 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,413 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpTmr:=");
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
;ADC_Buttons.c,414 :: 		sprintf(txt4,"%3d",Sps.RmpTmr);
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
	MOVF        _Sps+2, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,415 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,416 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
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
;ADC_Buttons.c,417 :: 		break;
	GOTO        L_SampleButtons157
;ADC_Buttons.c,418 :: 		default:    //clear screen & update cursor position
L_SampleButtons185:
;ADC_Buttons.c,419 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,420 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,421 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,422 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,423 :: 		break;
	GOTO        L_SampleButtons157
;ADC_Buttons.c,424 :: 		}
L_SampleButtons156:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons360
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons360:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons158
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons361
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons361:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons164
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons362
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons362:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons174
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons363
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons363:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons184
	GOTO        L_SampleButtons185
L_SampleButtons157:
;ADC_Buttons.c,425 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,426 :: 		case SoakSettings:
L_SampleButtons186:
;ADC_Buttons.c,427 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons364
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons364:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons187
;ADC_Buttons.c,428 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,429 :: 		}
L_SampleButtons187:
;ADC_Buttons.c,430 :: 		ret4:
___SampleButtons_ret4:
;ADC_Buttons.c,431 :: 		switch(enC){
	GOTO        L_SampleButtons188
;ADC_Buttons.c,432 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
L_SampleButtons190:
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
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons193
L__SampleButtons290:
;ADC_Buttons.c,433 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,434 :: 		while(!RA2_bit);
L_SampleButtons194:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons195
	GOTO        L_SampleButtons194
L_SampleButtons195:
;ADC_Buttons.c,435 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,436 :: 		goto ret4;
	GOTO        ___SampleButtons_ret4
;ADC_Buttons.c,437 :: 		}
L_SampleButtons193:
;ADC_Buttons.c,438 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons196:
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
	GOTO        L_SampleButtons199
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons199
L__SampleButtons289:
;ADC_Buttons.c,439 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,440 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,441 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,442 :: 		Save_EncoderValue(Sps.SokDeg);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,443 :: 		while(!RA2_bit);
L_SampleButtons200:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons201
	GOTO        L_SampleButtons200
L_SampleButtons201:
;ADC_Buttons.c,444 :: 		}
L_SampleButtons199:
;ADC_Buttons.c,445 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons202
;ADC_Buttons.c,446 :: 		Sps.SokDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
	MOVF        R1, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,447 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons203
;ADC_Buttons.c,448 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,449 :: 		while(!RA2_bit);
L_SampleButtons204:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons205
	GOTO        L_SampleButtons204
L_SampleButtons205:
;ADC_Buttons.c,450 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,451 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,452 :: 		}
L_SampleButtons203:
;ADC_Buttons.c,453 :: 		}
L_SampleButtons202:
;ADC_Buttons.c,454 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons206:
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
	GOTO        L_SampleButtons209
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons209
L__SampleButtons288:
;ADC_Buttons.c,455 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,456 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,457 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,458 :: 		Save_EncoderValue(Sps.SokTmr);
	MOVF        _Sps+6, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,459 :: 		while(!RA2_bit);
L_SampleButtons210:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons211
	GOTO        L_SampleButtons210
L_SampleButtons211:
;ADC_Buttons.c,460 :: 		}
L_SampleButtons209:
;ADC_Buttons.c,461 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons212
;ADC_Buttons.c,462 :: 		Sps.SokTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
	MOVF        R1, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,463 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,464 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,465 :: 		while(!RA2_bit);
L_SampleButtons214:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons215
	GOTO        L_SampleButtons214
L_SampleButtons215:
;ADC_Buttons.c,466 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,467 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,469 :: 		}
L_SampleButtons213:
;ADC_Buttons.c,470 :: 		}
L_SampleButtons212:
;ADC_Buttons.c,471 :: 		case 3:
L_SampleButtons216:
;ADC_Buttons.c,472 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
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
;ADC_Buttons.c,473 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
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
;ADC_Buttons.c,474 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
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
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,475 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,476 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakTmr:=");
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
;ADC_Buttons.c,477 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
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
	MOVF        _Sps+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,478 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,479 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
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
;ADC_Buttons.c,480 :: 		break;
	GOTO        L_SampleButtons189
;ADC_Buttons.c,481 :: 		default:    //clear screen & update cursor position
L_SampleButtons217:
;ADC_Buttons.c,482 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,483 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,484 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,485 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,486 :: 		break;
	GOTO        L_SampleButtons189
;ADC_Buttons.c,487 :: 		}
L_SampleButtons188:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons365
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons365:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons190
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons366
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons366:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons196
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons367
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons367:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons206
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons368
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons368:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons216
	GOTO        L_SampleButtons217
L_SampleButtons189:
;ADC_Buttons.c,488 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,489 :: 		case SpikeSettings:
L_SampleButtons218:
;ADC_Buttons.c,490 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons369
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons369:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons219
;ADC_Buttons.c,491 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,492 :: 		}
L_SampleButtons219:
;ADC_Buttons.c,493 :: 		ret5:
___SampleButtons_ret5:
;ADC_Buttons.c,494 :: 		switch(enC){
	GOTO        L_SampleButtons220
;ADC_Buttons.c,495 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
L_SampleButtons222:
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
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons225
L__SampleButtons287:
;ADC_Buttons.c,496 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,497 :: 		while(!RA2_bit);
L_SampleButtons226:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons227
	GOTO        L_SampleButtons226
L_SampleButtons227:
;ADC_Buttons.c,498 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,499 :: 		goto ret5;
	GOTO        ___SampleButtons_ret5
;ADC_Buttons.c,500 :: 		}
L_SampleButtons225:
;ADC_Buttons.c,501 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons228:
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
	GOTO        L_SampleButtons231
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons231
L__SampleButtons286:
;ADC_Buttons.c,502 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,503 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,504 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,505 :: 		Save_EncoderValue(Sps.SpkeDeg);
	MOVF        _Sps+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,506 :: 		}
L_SampleButtons231:
;ADC_Buttons.c,507 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons232
;ADC_Buttons.c,508 :: 		Sps.SpkeDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
	MOVF        R1, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,509 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons233
;ADC_Buttons.c,510 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,511 :: 		while(!RA2_bit);
L_SampleButtons234:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons235
	GOTO        L_SampleButtons234
L_SampleButtons235:
;ADC_Buttons.c,512 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,513 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,514 :: 		}
L_SampleButtons233:
;ADC_Buttons.c,515 :: 		}
L_SampleButtons232:
;ADC_Buttons.c,516 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons236:
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
	GOTO        L_SampleButtons239
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons239
L__SampleButtons285:
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
;ADC_Buttons.c,518 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,519 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,520 :: 		Save_EncoderValue(Sps.SpkeTmr);
	MOVF        _Sps+10, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,521 :: 		while(!RA2_bit);
L_SampleButtons240:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons241
	GOTO        L_SampleButtons240
L_SampleButtons241:
;ADC_Buttons.c,522 :: 		}
L_SampleButtons239:
;ADC_Buttons.c,523 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons242
;ADC_Buttons.c,524 :: 		Sps.SpkeTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
	MOVF        R1, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,525 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,526 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,527 :: 		while(!RA2_bit);
L_SampleButtons244:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons245
	GOTO        L_SampleButtons244
L_SampleButtons245:
;ADC_Buttons.c,528 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,529 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,530 :: 		}
L_SampleButtons243:
;ADC_Buttons.c,531 :: 		}
L_SampleButtons242:
;ADC_Buttons.c,532 :: 		case 3:
L_SampleButtons246:
;ADC_Buttons.c,533 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret       ");
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
;ADC_Buttons.c,534 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SpikeDeg:=");
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
;ADC_Buttons.c,535 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
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
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,536 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,537 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SpikeTmr:=");
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
;ADC_Buttons.c,538 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
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
	MOVF        _Sps+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,539 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,540 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"          ");
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
;ADC_Buttons.c,541 :: 		break;
	GOTO        L_SampleButtons221
;ADC_Buttons.c,542 :: 		default:    //clear screen & update cursor position
L_SampleButtons247:
;ADC_Buttons.c,543 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,544 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,545 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,546 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,547 :: 		break;
	GOTO        L_SampleButtons221
;ADC_Buttons.c,548 :: 		}
L_SampleButtons220:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons370
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons370:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons222
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons371
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons371:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons228
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons372
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons372:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons236
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons373
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons373:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons246
	GOTO        L_SampleButtons247
L_SampleButtons221:
;ADC_Buttons.c,549 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,550 :: 		case CoolSettings:
L_SampleButtons248:
;ADC_Buttons.c,551 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons374
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons374:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons249
;ADC_Buttons.c,552 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,553 :: 		}
L_SampleButtons249:
;ADC_Buttons.c,554 :: 		ret6:
___SampleButtons_ret6:
;ADC_Buttons.c,555 :: 		switch(enC){
	GOTO        L_SampleButtons250
;ADC_Buttons.c,556 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
L_SampleButtons252:
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
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons255
L__SampleButtons284:
;ADC_Buttons.c,557 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,558 :: 		while(!RA2_bit);
L_SampleButtons256:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons257
	GOTO        L_SampleButtons256
L_SampleButtons257:
;ADC_Buttons.c,559 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,560 :: 		goto ret6;
	GOTO        ___SampleButtons_ret6
;ADC_Buttons.c,561 :: 		}
L_SampleButtons255:
;ADC_Buttons.c,562 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
L_SampleButtons258:
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
	GOTO        L_SampleButtons261
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons261
L__SampleButtons283:
;ADC_Buttons.c,563 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,564 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,565 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,566 :: 		Save_EncoderValue(Sps.CoolOffDeg);
	MOVF        _Sps+12, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,567 :: 		}
L_SampleButtons261:
;ADC_Buttons.c,568 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons262
;ADC_Buttons.c,569 :: 		Sps.CoolOffDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
	MOVF        R1, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,570 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons263
;ADC_Buttons.c,571 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,572 :: 		while(!RA2_bit);
L_SampleButtons264:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons265
	GOTO        L_SampleButtons264
L_SampleButtons265:
;ADC_Buttons.c,573 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,574 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,575 :: 		}
L_SampleButtons263:
;ADC_Buttons.c,576 :: 		}
L_SampleButtons262:
;ADC_Buttons.c,577 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons266:
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
	GOTO        L_SampleButtons269
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons269
L__SampleButtons282:
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
;ADC_Buttons.c,579 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,580 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,581 :: 		Save_EncoderValue(Sps.CoolOffTmr);
	MOVF        _Sps+14, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,582 :: 		while(!RA2_bit);
L_SampleButtons270:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons271
	GOTO        L_SampleButtons270
L_SampleButtons271:
;ADC_Buttons.c,583 :: 		}
L_SampleButtons269:
;ADC_Buttons.c,584 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons272
;ADC_Buttons.c,585 :: 		Sps.CoolOffTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
	MOVF        R1, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,586 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,587 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,588 :: 		while(!RA2_bit);
L_SampleButtons274:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons275
	GOTO        L_SampleButtons274
L_SampleButtons275:
;ADC_Buttons.c,589 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,590 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,591 :: 		}
L_SampleButtons273:
;ADC_Buttons.c,592 :: 		}
L_SampleButtons272:
;ADC_Buttons.c,593 :: 		case 3:
L_SampleButtons276:
;ADC_Buttons.c,594 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
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
;ADC_Buttons.c,595 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"CoolDeg:=");
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
;ADC_Buttons.c,596 :: 		sprintf(txt4,"%3d",Sps.CoolOffDeg);
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
	MOVF        _Sps+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,597 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,598 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"CoolTmr:=");
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
;ADC_Buttons.c,599 :: 		sprintf(txt4,"%3d",Sps.CoolOffTmr);
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
	MOVF        _Sps+14, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,600 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,601 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
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
;ADC_Buttons.c,602 :: 		break;
	GOTO        L_SampleButtons251
;ADC_Buttons.c,603 :: 		default:    //clear screen & update cursor position
L_SampleButtons277:
;ADC_Buttons.c,604 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,605 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,606 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,607 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,608 :: 		break;
	GOTO        L_SampleButtons251
;ADC_Buttons.c,609 :: 		}
L_SampleButtons250:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons375
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons375:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons252
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons376
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons376:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons258
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons377
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons377:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons266
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons378
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons378:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons276
	GOTO        L_SampleButtons277
L_SampleButtons251:
;ADC_Buttons.c,610 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,611 :: 		default: Sps.State = Return;
L_SampleButtons278:
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,612 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,613 :: 		}
L_SampleButtons19:
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons21
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons53
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons85
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons154
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons186
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons218
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons248
	GOTO        L_SampleButtons278
L_SampleButtons20:
;ADC_Buttons.c,615 :: 		}
L_SampleButtons14:
;ADC_Buttons.c,617 :: 		if(EEWrt){
	BTFSS       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons279
;ADC_Buttons.c,618 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,619 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Writing To EEPROM...");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr70_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr70_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,620 :: 		Delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_SampleButtons280:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons280
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons280
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons280
	NOP
;ADC_Buttons.c,621 :: 		EERead();
	CALL        _EERead+0, 0
;ADC_Buttons.c,622 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,623 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,624 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,625 :: 		}
L_SampleButtons279:
;ADC_Buttons.c,627 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,629 :: 		void ResetBits(){
;ADC_Buttons.c,630 :: 		valOf     = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,631 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,632 :: 		Menu_Bit  = 0;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,633 :: 		OK_A      = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,634 :: 		OK_B      = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,635 :: 		OK_C      = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,636 :: 		OK_D      = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,637 :: 		OK_E      = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,638 :: 		OK_F      = 0;
	BCF         ADC_Buttons_B_+0, 5 
;ADC_Buttons.c,639 :: 		OK_G      = 0;
	BCF         ADC_Buttons_B_+0, 6 
;ADC_Buttons.c,640 :: 		OK_H      = 0;
	BCF         ADC_Buttons_B_+0, 7 
;ADC_Buttons.c,641 :: 		OK_I      = 0;
	BCF         ADC_Buttons_B+0, 5 
;ADC_Buttons.c,642 :: 		OK_J      = 0;
	BCF         ADC_Buttons_B+0, 6 
;ADC_Buttons.c,643 :: 		OK_K      = 0;
	BCF         ADC_Buttons_B+0, 7 
;ADC_Buttons.c,644 :: 		EEWrt = 0;
	BCF         ADC_Buttons_B+0, 4 
;ADC_Buttons.c,645 :: 		P1 = 0;
	BCF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,646 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_EERead:

;ADC_Buttons.c,648 :: 		void EERead(){
;ADC_Buttons.c,650 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,651 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,652 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,653 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,654 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,655 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,656 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,657 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,658 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,659 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,660 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,661 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,662 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,663 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,664 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,665 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,668 :: 		Lo(pid_t.Kp)         = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,669 :: 		Hi(pid_t.Kp)         = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,670 :: 		Lo(pid_t.Ki)         = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,671 :: 		Hi(pid_t.Ki)         = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,672 :: 		Lo(pid_t.Kd)         = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,673 :: 		Hi(pid_t.Kd)         = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,674 :: 		Lo(DegC.Deg_OffSet)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
;ADC_Buttons.c,675 :: 		Hi(DegC.Deg_OffSet)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+9 
;ADC_Buttons.c,676 :: 		pid_t.Kt             = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,679 :: 		Lo(TempTicks.RampTick)   = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,680 :: 		Hi(TempTicks.RampTick)   = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,681 :: 		Lo(TempTicks.SoakTick)   = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,682 :: 		Hi(TempTicks.SoakTick)   = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,683 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1E);
	MOVLW       30
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,684 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1F);
	MOVLW       31
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,685 :: 		Lo(TempTicks.CoolTick)   = EEPROM_Read(0x20);
	MOVLW       32
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,686 :: 		Hi(TempTicks.CoolTick)   = EEPROM_Read(0x21);
	MOVLW       33
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,688 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,689 :: 		void EEWrite(){
;ADC_Buttons.c,691 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,692 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,693 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,694 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,695 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,696 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,697 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,698 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,699 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,700 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,701 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,702 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,703 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,704 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,705 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,706 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,709 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,710 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,711 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,712 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,713 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,714 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,715 :: 		EEPROM_Write(0x16, Lo(DegC.Deg_OffSet));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _DegC+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,716 :: 		EEPROM_Write(0x17, Hi(DegC.Deg_OffSet));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,717 :: 		EEPROM_Write(0x18, pid_t.Kt);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,720 :: 		EEPROM_Write(0x1A, Lo(TempTicks.RampTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,721 :: 		EEPROM_Write(0x1B, Hi(TempTicks.RampTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,722 :: 		EEPROM_Write(0x1C, Lo(TempTicks.SoakTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,723 :: 		EEPROM_Write(0x1D, Hi(TempTicks.SoakTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,724 :: 		EEPROM_Write(0x1E, Lo(TempTicks.SpikeTick));
	MOVLW       30
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,725 :: 		EEPROM_Write(0x1F, Hi(TempTicks.SpikeTick));
	MOVLW       31
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,726 :: 		EEPROM_Write(0x20, Lo(TempTicks.CoolTick));
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,727 :: 		EEPROM_Write(0x21, Hi(TempTicks.CoolTick));
	MOVLW       33
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,728 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite281:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite281
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite281
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite281
	NOP
;ADC_Buttons.c,729 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
