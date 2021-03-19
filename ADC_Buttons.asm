
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
;ADC_Buttons.c,53 :: 		if(Menu_Bit){
	BTFSS       ADC_Buttons_B+0, 0 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,54 :: 		if(!P0 && (enC != 0)){
	BTFSC       ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
	GOTO        L_SampleButtons3
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons357
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons357:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons3
L__SampleButtons354:
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
;ADC_Buttons.c,62 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
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
L__SampleButtons353:
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
	GOTO        L__SampleButtons358
	MOVLW       0
	SUBWF       ADC_Buttons_enC+0, 0 
L__SampleButtons358:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons352
	MOVF        ADC_Buttons_enC+1, 0 
	SUBLW       253
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons359
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       232
L__SampleButtons359:
	BTFSS       STATUS+0, 0 
	GOTO        L__SampleButtons352
	GOTO        L_SampleButtons9
L__SampleButtons352:
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
	GOTO        L__SampleButtons360
	MOVF        ADC_Buttons_enC+0, 0 
	XORWF       ADC_Buttons_enC_last+0, 0 
L__SampleButtons360:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons10
;ADC_Buttons.c,71 :: 		enC_last = enC;
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       ADC_Buttons_enC_last+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,72 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E){
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
L__SampleButtons351:
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
;ADC_Buttons.c,86 :: 		if(!OK_A && !OK_B && !OK_C && !OK_D && !OK_E)
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
L__SampleButtons350:
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
;ADC_Buttons.c,100 :: 		case Return:   if(enC > 7){
L_SampleButtons21:
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons361
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons361:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons22
;ADC_Buttons.c,101 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
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
L__SampleButtons349:
;ADC_Buttons.c,106 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,107 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,108 :: 		}
L_SampleButtons28:
;ADC_Buttons.c,109 :: 		case 1:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != TempMenu)){
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
L__SampleButtons348:
;ADC_Buttons.c,110 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,111 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,112 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,113 :: 		}
L_SampleButtons32:
;ADC_Buttons.c,115 :: 		case 2:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
L__SampleButtons347:
;ADC_Buttons.c,116 :: 		Sps.State = PIDMenu;
	MOVLW       3
	MOVWF       _Sps+16 
;ADC_Buttons.c,117 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,118 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,119 :: 		}
L_SampleButtons36:
;ADC_Buttons.c,120 :: 		case 3:
L_SampleButtons37:
;ADC_Buttons.c,121 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
L__SampleButtons346:
;ADC_Buttons.c,122 :: 		Ok_Bit = 1;;
	BSF         ADC_Buttons_B+0, 1 
;ADC_Buttons.c,123 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,124 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,125 :: 		}
L_SampleButtons40:
;ADC_Buttons.c,126 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Info   ");
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
;ADC_Buttons.c,127 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Control");
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
;ADC_Buttons.c,128 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"PID    ");
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
;ADC_Buttons.c,129 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"ReStart");
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
;ADC_Buttons.c,130 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,131 :: 		case 4:
L_SampleButtons41:
;ADC_Buttons.c,132 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != PIDMenu)){
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
	GOTO        L_SampleButtons44
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons44
L__SampleButtons345:
;ADC_Buttons.c,133 :: 		OFF_Bit = 1;;
	BSF         ADC_Buttons_B+0, 3 
;ADC_Buttons.c,134 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,135 :: 		goto close;
	GOTO        ___SampleButtons_close
;ADC_Buttons.c,136 :: 		}
L_SampleButtons44:
;ADC_Buttons.c,137 :: 		case 5:
L_SampleButtons45:
;ADC_Buttons.c,138 :: 		case 6:
L_SampleButtons46:
;ADC_Buttons.c,139 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Stop   ");
L_SampleButtons47:
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
;ADC_Buttons.c,140 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,141 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,142 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,143 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,144 :: 		case 8:
L_SampleButtons48:
;ADC_Buttons.c,145 :: 		case 9:
L_SampleButtons49:
;ADC_Buttons.c,146 :: 		case 10:
L_SampleButtons50:
;ADC_Buttons.c,147 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons51:
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
;ADC_Buttons.c,148 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,149 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,150 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,151 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,152 :: 		default:
L_SampleButtons52:
;ADC_Buttons.c,153 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,154 :: 		Delay_ms(800);
	MOVLW       65
	MOVWF       R11, 0
	MOVLW       240
	MOVWF       R12, 0
	MOVLW       51
	MOVWF       R13, 0
L_SampleButtons53:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons53
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons53
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons53
;ADC_Buttons.c,155 :: 		if(P1) EEWrt = on;
	BTFSS       ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
	GOTO        L_SampleButtons54
	BSF         ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons55
L_SampleButtons54:
;ADC_Buttons.c,156 :: 		else Menu_Bit = off;
	BCF         ADC_Buttons_B+0, 0 
L_SampleButtons55:
;ADC_Buttons.c,157 :: 		P0 = 0;
	BCF         ADC_Buttons_P0+0, BitPos(ADC_Buttons_P0+0) 
;ADC_Buttons.c,158 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,159 :: 		break;
	GOTO        L_SampleButtons24
;ADC_Buttons.c,160 :: 		}
L_SampleButtons23:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons362
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons362:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons25
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons363
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons363:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons29
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons364
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons364:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons33
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons365
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons365:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons37
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons366
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons366:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons41
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons367
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons367:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons45
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons368
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons368:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons46
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons369
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons369:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons47
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons370
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons370:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons48
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons371
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons371:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons49
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons372
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons372:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons50
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons373
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons373:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons51
	GOTO        L_SampleButtons52
L_SampleButtons24:
;ADC_Buttons.c,161 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,162 :: 		case TempMenu:
L_SampleButtons56:
;ADC_Buttons.c,163 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons374
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons374:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons57
;ADC_Buttons.c,164 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,165 :: 		}
L_SampleButtons57:
;ADC_Buttons.c,166 :: 		ret1:
___SampleButtons_ret1:
;ADC_Buttons.c,167 :: 		switch(enC){
	GOTO        L_SampleButtons58
;ADC_Buttons.c,168 :: 		case 0:   if (Button(&PORTA, 2, 200, 0) && (Sps.State == TempMenu)){
L_SampleButtons60:
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
	GOTO        L_SampleButtons63
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons63
L__SampleButtons344:
;ADC_Buttons.c,169 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,170 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,171 :: 		goto ret1;
	GOTO        ___SampleButtons_ret1
;ADC_Buttons.c,172 :: 		}
L_SampleButtons63:
;ADC_Buttons.c,173 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && (Sps.State != RampSettings)){
L_SampleButtons64:
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
	GOTO        L_SampleButtons67
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons67
L__SampleButtons343:
;ADC_Buttons.c,174 :: 		Sps.State = RampSettings;
	MOVLW       4
	MOVWF       _Sps+16 
;ADC_Buttons.c,175 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,176 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,177 :: 		}
L_SampleButtons67:
;ADC_Buttons.c,178 :: 		case 2:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SoakSettings)){
L_SampleButtons68:
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
	GOTO        L_SampleButtons71
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons71
L__SampleButtons342:
;ADC_Buttons.c,179 :: 		Sps.State = SoakSettings;
	MOVLW       5
	MOVWF       _Sps+16 
;ADC_Buttons.c,180 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,181 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,182 :: 		}
L_SampleButtons71:
;ADC_Buttons.c,183 :: 		case 3:   if (Button(&PORTA, 2, 200, 0) && (Sps.State != SpikeSettings)){
L_SampleButtons72:
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
	GOTO        L_SampleButtons75
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons75
L__SampleButtons341:
;ADC_Buttons.c,184 :: 		Sps.State = SpikeSettings;
	MOVLW       6
	MOVWF       _Sps+16 
;ADC_Buttons.c,185 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,186 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,187 :: 		}
L_SampleButtons75:
;ADC_Buttons.c,188 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu   ");
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
;ADC_Buttons.c,189 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ramp   ");
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
;ADC_Buttons.c,190 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Soak   ");
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
;ADC_Buttons.c,191 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spike  ");
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
;ADC_Buttons.c,192 :: 		break;
	GOTO        L_SampleButtons59
;ADC_Buttons.c,193 :: 		case 4:  if (Button(&PORTA, 2, 200, 0) && (Sps.State != CoolSettings)){
L_SampleButtons76:
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
	GOTO        L_SampleButtons79
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons79
L__SampleButtons340:
;ADC_Buttons.c,194 :: 		Sps.State = CoolSettings;
	MOVLW       7
	MOVWF       _Sps+16 
;ADC_Buttons.c,195 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,196 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,197 :: 		}
L_SampleButtons79:
;ADC_Buttons.c,198 :: 		case 5:
L_SampleButtons80:
;ADC_Buttons.c,199 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State != TimeSettings)){
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
	GOTO        L_SampleButtons83
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons83
L__SampleButtons339:
;ADC_Buttons.c,200 :: 		Sps.State = TimeSettings;
	MOVLW       8
	MOVWF       _Sps+16 
;ADC_Buttons.c,201 :: 		enC = Save_EncoderValue(0);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,202 :: 		goto state;
	GOTO        ___SampleButtons_state
;ADC_Buttons.c,203 :: 		}
L_SampleButtons83:
;ADC_Buttons.c,204 :: 		case 6:
L_SampleButtons84:
;ADC_Buttons.c,205 :: 		case 7:    I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Cool   ");
L_SampleButtons85:
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
;ADC_Buttons.c,206 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Timers ");
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
;ADC_Buttons.c,207 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,208 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,209 :: 		break;
	GOTO        L_SampleButtons59
;ADC_Buttons.c,210 :: 		case 8:
L_SampleButtons86:
;ADC_Buttons.c,211 :: 		case 9:
L_SampleButtons87:
;ADC_Buttons.c,212 :: 		case 10:
L_SampleButtons88:
;ADC_Buttons.c,213 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare  ");
L_SampleButtons89:
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
;ADC_Buttons.c,214 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare  ");
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
;ADC_Buttons.c,215 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare  ");
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
;ADC_Buttons.c,216 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare  ");
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
;ADC_Buttons.c,217 :: 		break;
	GOTO        L_SampleButtons59
;ADC_Buttons.c,218 :: 		default:    //clear screen & update cursor position
L_SampleButtons90:
;ADC_Buttons.c,219 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,220 :: 		Sps.State = 1;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,221 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,222 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,223 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,224 :: 		break;
	GOTO        L_SampleButtons59
;ADC_Buttons.c,225 :: 		}
L_SampleButtons58:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons375
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons375:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons60
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons376
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons376:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons64
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons377
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons377:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons68
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons378
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons378:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons72
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons379
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons379:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons76
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons380
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons380:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons80
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons381
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons381:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons84
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons382
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons382:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons85
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons383
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons383:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons86
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons384
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons384:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons87
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons385
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons385:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons88
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons386
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons386:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons89
	GOTO        L_SampleButtons90
L_SampleButtons59:
;ADC_Buttons.c,226 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,227 :: 		case PIDMenu:
L_SampleButtons91:
;ADC_Buttons.c,228 :: 		if(enC > 7){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons387
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       7
L__SampleButtons387:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons92
;ADC_Buttons.c,229 :: 		enC = Save_EncoderValue(7);
	MOVLW       7
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,230 :: 		}
L_SampleButtons92:
;ADC_Buttons.c,231 :: 		ret2:
___SampleButtons_ret2:
;ADC_Buttons.c,232 :: 		switch(enC){
	GOTO        L_SampleButtons93
;ADC_Buttons.c,233 :: 		case 0:
L_SampleButtons95:
;ADC_Buttons.c,234 :: 		if (Button(&PORTA, 2, 200, 0) && (Sps.State == PIDMenu)){
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
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons98
L__SampleButtons338:
;ADC_Buttons.c,235 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,236 :: 		while(!RA2_bit);
L_SampleButtons99:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons100
	GOTO        L_SampleButtons99
L_SampleButtons100:
;ADC_Buttons.c,237 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,238 :: 		goto ret2;
	GOTO        ___SampleButtons_ret2
;ADC_Buttons.c,239 :: 		}
L_SampleButtons98:
;ADC_Buttons.c,240 :: 		case 1:
L_SampleButtons101:
;ADC_Buttons.c,241 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons104
L__SampleButtons337:
;ADC_Buttons.c,242 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,243 :: 		OK_A = 1;OK_B = 0;OK_C = 0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,244 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,245 :: 		Save_EncoderValue(pid_t.Kp);
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,246 :: 		while(!RA2_bit);
L_SampleButtons105:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons106
	GOTO        L_SampleButtons105
L_SampleButtons106:
;ADC_Buttons.c,247 :: 		}
L_SampleButtons104:
;ADC_Buttons.c,248 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons107
;ADC_Buttons.c,249 :: 		pid_t.Kp = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
	MOVF        R1, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,250 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,251 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,252 :: 		while(!RA2_bit);
L_SampleButtons109:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons110
	GOTO        L_SampleButtons109
L_SampleButtons110:
;ADC_Buttons.c,253 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,254 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,255 :: 		}
L_SampleButtons108:
;ADC_Buttons.c,256 :: 		}
L_SampleButtons107:
;ADC_Buttons.c,257 :: 		case 2:
L_SampleButtons111:
;ADC_Buttons.c,258 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_B){
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons114
L__SampleButtons336:
;ADC_Buttons.c,259 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,260 :: 		OK_B = 1;OK_A=0;OK_C=0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,261 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,262 :: 		Save_EncoderValue(pid_t.Ki);
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,263 :: 		while(!RA2_bit);
L_SampleButtons115:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons116
	GOTO        L_SampleButtons115
L_SampleButtons116:
;ADC_Buttons.c,264 :: 		}
L_SampleButtons114:
;ADC_Buttons.c,265 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons117
;ADC_Buttons.c,266 :: 		pid_t.Ki = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
	MOVF        R1, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,267 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons118
;ADC_Buttons.c,268 :: 		OK_B = 0;OK_A=0;OK_C=0;OK_D=0;OK_E=0;
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,269 :: 		while(!RA2_bit);
L_SampleButtons119:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons120
	GOTO        L_SampleButtons119
L_SampleButtons120:
;ADC_Buttons.c,270 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,271 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,272 :: 		}
L_SampleButtons118:
;ADC_Buttons.c,273 :: 		}
L_SampleButtons117:
;ADC_Buttons.c,274 :: 		case 3:
L_SampleButtons121:
;ADC_Buttons.c,275 :: 		if(P2){
	BTFSS       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons122
;ADC_Buttons.c,276 :: 		P2 = 0;
	BCF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,277 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,278 :: 		}
L_SampleButtons122:
;ADC_Buttons.c,279 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_C){
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
	BTFSC       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons125
L__SampleButtons335:
;ADC_Buttons.c,280 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,281 :: 		OK_C = 1;OK_A=0;OK_B=0;OK_D=0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,282 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,283 :: 		Save_EncoderValue(pid_t.Kd);
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,284 :: 		while(!RA2_bit);
L_SampleButtons126:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons127
	GOTO        L_SampleButtons126
L_SampleButtons127:
;ADC_Buttons.c,285 :: 		}
L_SampleButtons125:
;ADC_Buttons.c,286 :: 		if(OK_C){
	BTFSS       ADC_Buttons_B_+0, 2 
	GOTO        L_SampleButtons128
;ADC_Buttons.c,287 :: 		pid_t.Kd = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
	MOVF        R1, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,288 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,289 :: 		OK_C = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,290 :: 		while(!RA2_bit);
L_SampleButtons130:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons131
	GOTO        L_SampleButtons130
L_SampleButtons131:
;ADC_Buttons.c,291 :: 		enC_line_inc = 3;
	MOVLW       3
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,292 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,293 :: 		}
L_SampleButtons129:
;ADC_Buttons.c,294 :: 		}
L_SampleButtons128:
;ADC_Buttons.c,295 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Menu     ");
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
;ADC_Buttons.c,296 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Kp:=     ");
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
;ADC_Buttons.c,297 :: 		sprintf(txt4,"%3d",pid_t.Kp);
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
;ADC_Buttons.c,298 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,299 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Ki:=     ");
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
;ADC_Buttons.c,300 :: 		sprintf(txt4,"%3d",pid_t.Ki);
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
;ADC_Buttons.c,301 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,302 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Kd:=     ");
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
;ADC_Buttons.c,303 :: 		sprintf(txt4,"%3d",pid_t.Kd);
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
;ADC_Buttons.c,304 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,16,txt4);
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
;ADC_Buttons.c,305 :: 		break;
	GOTO        L_SampleButtons94
;ADC_Buttons.c,306 :: 		case 4:
L_SampleButtons132:
;ADC_Buttons.c,307 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_D){
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
	BTFSC       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons135
L__SampleButtons334:
;ADC_Buttons.c,308 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,309 :: 		OK_D = 1;OK_A=0;OK_B=0;OK_C = 0;OK_E=0;
	BSF         ADC_Buttons_B_+0, 3 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,310 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,311 :: 		Save_EncoderValue(pid_t.Kt);
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	BTFSC       _pid_t+33, 7 
	MOVLW       255
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,312 :: 		while(!RA2_bit);
L_SampleButtons136:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons137
	GOTO        L_SampleButtons136
L_SampleButtons137:
;ADC_Buttons.c,313 :: 		}
L_SampleButtons135:
;ADC_Buttons.c,314 :: 		if(OK_D){
	BTFSS       ADC_Buttons_B_+0, 3 
	GOTO        L_SampleButtons138
;ADC_Buttons.c,315 :: 		pid_t.Kt = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,316 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,317 :: 		OK_D = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,318 :: 		while(!RA2_bit);
L_SampleButtons140:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons141
	GOTO        L_SampleButtons140
L_SampleButtons141:
;ADC_Buttons.c,319 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,320 :: 		enC = Save_EncoderValue(enC_line_inc+4);
	MOVLW       4
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,321 :: 		}
L_SampleButtons139:
;ADC_Buttons.c,322 :: 		}
L_SampleButtons138:
;ADC_Buttons.c,323 :: 		case 5:
L_SampleButtons142:
;ADC_Buttons.c,324 :: 		if (Button(&PORTA, 2, 200, 0) && !OK_E){
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
	BTFSC       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons145
L__SampleButtons333:
;ADC_Buttons.c,325 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,326 :: 		OK_E = 1;OK_A=0;OK_B=0;OK_C = 0;OK_D=0;
	BSF         ADC_Buttons_B_+0, 4 
	BCF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 2 
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,327 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,328 :: 		Save_EncoderValue(DegC.Deg_OffSet);
	MOVF        _DegC+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,329 :: 		while(!RA2_bit);
L_SampleButtons146:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons147
	GOTO        L_SampleButtons146
L_SampleButtons147:
;ADC_Buttons.c,330 :: 		}
L_SampleButtons145:
;ADC_Buttons.c,331 :: 		if(OK_E){
	BTFSS       ADC_Buttons_B_+0, 4 
	GOTO        L_SampleButtons148
;ADC_Buttons.c,332 :: 		DegC.Deg_OffSet = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
	MOVF        R1, 0 
	MOVWF       _DegC+9 
;ADC_Buttons.c,333 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons149
;ADC_Buttons.c,334 :: 		OK_E = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,335 :: 		while(!RA2_bit);
L_SampleButtons150:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons151
	GOTO        L_SampleButtons150
L_SampleButtons151:
;ADC_Buttons.c,336 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,337 :: 		enC = Save_EncoderValue(enC_line_inc+4);
	MOVLW       5
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,338 :: 		}
L_SampleButtons149:
;ADC_Buttons.c,339 :: 		}
L_SampleButtons148:
;ADC_Buttons.c,340 :: 		case 6:
L_SampleButtons152:
;ADC_Buttons.c,341 :: 		case 7:
L_SampleButtons153:
;ADC_Buttons.c,342 :: 		if(!P2){
	BTFSC       ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
	GOTO        L_SampleButtons154
;ADC_Buttons.c,343 :: 		P2 = 1;
	BSF         ADC_Buttons_P2+0, BitPos(ADC_Buttons_P2+0) 
;ADC_Buttons.c,344 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,345 :: 		}
L_SampleButtons154:
;ADC_Buttons.c,346 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"*Kt");
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
;ADC_Buttons.c,347 :: 		sprintf(txt4,"%4d",pid_t.Kt);
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
;ADC_Buttons.c,348 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,16,txt4);
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
;ADC_Buttons.c,349 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"*C Offset");
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
;ADC_Buttons.c,350 :: 		sprintf(txt4,"%4d",DegC.Deg_OffSet);
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
;ADC_Buttons.c,351 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,352 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
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
;ADC_Buttons.c,353 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
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
;ADC_Buttons.c,354 :: 		break;
	GOTO        L_SampleButtons94
;ADC_Buttons.c,355 :: 		case 8:
L_SampleButtons155:
;ADC_Buttons.c,356 :: 		case 9:
L_SampleButtons156:
;ADC_Buttons.c,357 :: 		case 10:
L_SampleButtons157:
;ADC_Buttons.c,358 :: 		case 11:   I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Spare    ");
L_SampleButtons158:
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
;ADC_Buttons.c,359 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Spare    ");
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
;ADC_Buttons.c,360 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"Spare    ");
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
;ADC_Buttons.c,361 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"Spare    ");
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
;ADC_Buttons.c,362 :: 		break;
	GOTO        L_SampleButtons94
;ADC_Buttons.c,363 :: 		default:   //clear screen & update cursor position
L_SampleButtons159:
;ADC_Buttons.c,364 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,365 :: 		Sps.State = Return;
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,366 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,367 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,368 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,369 :: 		break;
	GOTO        L_SampleButtons94
;ADC_Buttons.c,370 :: 		}
L_SampleButtons93:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons388
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons388:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons95
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons389
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons389:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons101
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons390
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons390:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons111
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons391
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons391:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons121
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons392
	MOVLW       4
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons392:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons132
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons393
	MOVLW       5
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons393:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons142
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons394
	MOVLW       6
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons394:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons152
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons395
	MOVLW       7
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons395:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons153
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons396
	MOVLW       8
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons396:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons155
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons397
	MOVLW       9
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons397:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons156
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons398
	MOVLW       10
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons398:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons157
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons399
	MOVLW       11
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons399:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons158
	GOTO        L_SampleButtons159
L_SampleButtons94:
;ADC_Buttons.c,371 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,372 :: 		case RampSettings:
L_SampleButtons160:
;ADC_Buttons.c,373 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons400
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons400:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons161
;ADC_Buttons.c,374 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,375 :: 		}
L_SampleButtons161:
;ADC_Buttons.c,376 :: 		ret3:
___SampleButtons_ret3:
;ADC_Buttons.c,377 :: 		switch(enC){
	GOTO        L_SampleButtons162
;ADC_Buttons.c,378 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == RampSettings)){
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
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons167
L__SampleButtons332:
;ADC_Buttons.c,379 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,380 :: 		while(!RA2_bit);
L_SampleButtons168:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons169
	GOTO        L_SampleButtons168
L_SampleButtons169:
;ADC_Buttons.c,381 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,382 :: 		goto ret3;
	GOTO        ___SampleButtons_ret3
;ADC_Buttons.c,383 :: 		}
L_SampleButtons167:
;ADC_Buttons.c,384 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons173
L__SampleButtons331:
;ADC_Buttons.c,385 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,386 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,387 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,388 :: 		Save_EncoderValue(Sps.RmpDeg);
	MOVF        _Sps+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,389 :: 		while(!RA2_bit);
L_SampleButtons174:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons175
	GOTO        L_SampleButtons174
L_SampleButtons175:
;ADC_Buttons.c,390 :: 		}
L_SampleButtons173:
;ADC_Buttons.c,391 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons176
;ADC_Buttons.c,392 :: 		Sps.RmpDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
	MOVF        R1, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,393 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,394 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,395 :: 		while(!RA2_bit);
L_SampleButtons178:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons179
	GOTO        L_SampleButtons178
L_SampleButtons179:
;ADC_Buttons.c,396 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,397 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,398 :: 		}
L_SampleButtons177:
;ADC_Buttons.c,399 :: 		}
L_SampleButtons176:
;ADC_Buttons.c,400 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons180:
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons183
L__SampleButtons330:
;ADC_Buttons.c,401 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,402 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,403 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,404 :: 		Save_EncoderValue(Sps.RmpTmr);
	MOVF        _Sps+2, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,405 :: 		while(!RA2_bit);
L_SampleButtons184:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons185
	GOTO        L_SampleButtons184
L_SampleButtons185:
;ADC_Buttons.c,406 :: 		}
L_SampleButtons183:
;ADC_Buttons.c,407 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons186
;ADC_Buttons.c,408 :: 		Sps.RmpTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
	MOVF        R1, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,409 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons187
;ADC_Buttons.c,410 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,411 :: 		while(!RA2_bit);
L_SampleButtons188:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons189
	GOTO        L_SampleButtons188
L_SampleButtons189:
;ADC_Buttons.c,412 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,413 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,414 :: 		}
L_SampleButtons187:
;ADC_Buttons.c,415 :: 		}
L_SampleButtons186:
;ADC_Buttons.c,416 :: 		case 3:
L_SampleButtons190:
;ADC_Buttons.c,417 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret     ");
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
;ADC_Buttons.c,418 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"RmpDeg:=");
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
;ADC_Buttons.c,419 :: 		sprintf(txt4,"%3d",Sps.RmpDeg);
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
;ADC_Buttons.c,420 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,421 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"RmpTmr:=");
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
;ADC_Buttons.c,422 :: 		sprintf(txt4,"%3d",Sps.RmpTmr);
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
;ADC_Buttons.c,423 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,424 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"        ");
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
;ADC_Buttons.c,425 :: 		break;
	GOTO        L_SampleButtons163
;ADC_Buttons.c,426 :: 		default:    //clear screen & update cursor position
L_SampleButtons191:
;ADC_Buttons.c,427 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,428 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,429 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,430 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,431 :: 		break;
	GOTO        L_SampleButtons163
;ADC_Buttons.c,432 :: 		}
L_SampleButtons162:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons401
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons401:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons164
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons402
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons402:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons170
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons403
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons403:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons180
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons404
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons404:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons190
	GOTO        L_SampleButtons191
L_SampleButtons163:
;ADC_Buttons.c,433 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,434 :: 		case SoakSettings:
L_SampleButtons192:
;ADC_Buttons.c,435 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons405
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons405:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons193
;ADC_Buttons.c,436 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,437 :: 		}
L_SampleButtons193:
;ADC_Buttons.c,438 :: 		ret4:
___SampleButtons_ret4:
;ADC_Buttons.c,439 :: 		switch(enC){
	GOTO        L_SampleButtons194
;ADC_Buttons.c,440 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SoakSettings)){
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
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons199
L__SampleButtons329:
;ADC_Buttons.c,441 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,442 :: 		while(!RA2_bit);
L_SampleButtons200:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons201
	GOTO        L_SampleButtons200
L_SampleButtons201:
;ADC_Buttons.c,443 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,444 :: 		goto ret4;
	GOTO        ___SampleButtons_ret4
;ADC_Buttons.c,445 :: 		}
L_SampleButtons199:
;ADC_Buttons.c,446 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons205
L__SampleButtons328:
;ADC_Buttons.c,447 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,448 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,449 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,450 :: 		Save_EncoderValue(Sps.SokDeg);
	MOVF        _Sps+4, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,451 :: 		while(!RA2_bit);
L_SampleButtons206:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons207
	GOTO        L_SampleButtons206
L_SampleButtons207:
;ADC_Buttons.c,452 :: 		}
L_SampleButtons205:
;ADC_Buttons.c,453 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons208
;ADC_Buttons.c,454 :: 		Sps.SokDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
	MOVF        R1, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,455 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,456 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,457 :: 		while(!RA2_bit);
L_SampleButtons210:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons211
	GOTO        L_SampleButtons210
L_SampleButtons211:
;ADC_Buttons.c,458 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,459 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,460 :: 		}
L_SampleButtons209:
;ADC_Buttons.c,461 :: 		}
L_SampleButtons208:
;ADC_Buttons.c,462 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons212:
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons215
L__SampleButtons327:
;ADC_Buttons.c,463 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,464 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,465 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,466 :: 		Save_EncoderValue(Sps.SokTmr);
	MOVF        _Sps+6, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,467 :: 		while(!RA2_bit);
L_SampleButtons216:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons217
	GOTO        L_SampleButtons216
L_SampleButtons217:
;ADC_Buttons.c,468 :: 		}
L_SampleButtons215:
;ADC_Buttons.c,469 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons218
;ADC_Buttons.c,470 :: 		Sps.SokTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
	MOVF        R1, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,471 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,472 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,473 :: 		while(!RA2_bit);
L_SampleButtons220:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons221
	GOTO        L_SampleButtons220
L_SampleButtons221:
;ADC_Buttons.c,474 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,475 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,477 :: 		}
L_SampleButtons219:
;ADC_Buttons.c,478 :: 		}
L_SampleButtons218:
;ADC_Buttons.c,479 :: 		case 3:
L_SampleButtons222:
;ADC_Buttons.c,480 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
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
;ADC_Buttons.c,481 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SoakDeg:=");
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
;ADC_Buttons.c,482 :: 		sprintf(txt4,"%3d",Sps.SokDeg);
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
;ADC_Buttons.c,483 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,484 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SoakTmr:=");
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
;ADC_Buttons.c,485 :: 		sprintf(txt4,"%3d",Sps.SokTmr);
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
;ADC_Buttons.c,486 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,487 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
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
;ADC_Buttons.c,488 :: 		break;
	GOTO        L_SampleButtons195
;ADC_Buttons.c,489 :: 		default:    //clear screen & update cursor position
L_SampleButtons223:
;ADC_Buttons.c,490 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,491 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,492 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,493 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,494 :: 		break;
	GOTO        L_SampleButtons195
;ADC_Buttons.c,495 :: 		}
L_SampleButtons194:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons406
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons406:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons196
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons407
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons407:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons202
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons408
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons408:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons212
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons409
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons409:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons222
	GOTO        L_SampleButtons223
L_SampleButtons195:
;ADC_Buttons.c,496 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,497 :: 		case SpikeSettings:
L_SampleButtons224:
;ADC_Buttons.c,498 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons410
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons410:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons225
;ADC_Buttons.c,499 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,500 :: 		}
L_SampleButtons225:
;ADC_Buttons.c,501 :: 		ret5:
___SampleButtons_ret5:
;ADC_Buttons.c,502 :: 		switch(enC){
	GOTO        L_SampleButtons226
;ADC_Buttons.c,503 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == SpikeSettings)){
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
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons231
L__SampleButtons326:
;ADC_Buttons.c,504 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,505 :: 		while(!RA2_bit);
L_SampleButtons232:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons233
	GOTO        L_SampleButtons232
L_SampleButtons233:
;ADC_Buttons.c,506 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,507 :: 		goto ret5;
	GOTO        ___SampleButtons_ret5
;ADC_Buttons.c,508 :: 		}
L_SampleButtons231:
;ADC_Buttons.c,509 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons237
L__SampleButtons325:
;ADC_Buttons.c,510 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,511 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,512 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,513 :: 		Save_EncoderValue(Sps.SpkeDeg);
	MOVF        _Sps+8, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,514 :: 		}
L_SampleButtons237:
;ADC_Buttons.c,515 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons238
;ADC_Buttons.c,516 :: 		Sps.SpkeDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
	MOVF        R1, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,517 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,518 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,519 :: 		while(!RA2_bit);
L_SampleButtons240:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons241
	GOTO        L_SampleButtons240
L_SampleButtons241:
;ADC_Buttons.c,520 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,521 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,522 :: 		}
L_SampleButtons239:
;ADC_Buttons.c,523 :: 		}
L_SampleButtons238:
;ADC_Buttons.c,524 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons242:
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons245
L__SampleButtons324:
;ADC_Buttons.c,525 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,526 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,527 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,528 :: 		Save_EncoderValue(Sps.SpkeTmr);
	MOVF        _Sps+10, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,529 :: 		while(!RA2_bit);
L_SampleButtons246:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons247
	GOTO        L_SampleButtons246
L_SampleButtons247:
;ADC_Buttons.c,530 :: 		}
L_SampleButtons245:
;ADC_Buttons.c,531 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons248
;ADC_Buttons.c,532 :: 		Sps.SpkeTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
	MOVF        R1, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,533 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,534 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,535 :: 		while(!RA2_bit);
L_SampleButtons250:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons251
	GOTO        L_SampleButtons250
L_SampleButtons251:
;ADC_Buttons.c,536 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,537 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,538 :: 		}
L_SampleButtons249:
;ADC_Buttons.c,539 :: 		}
L_SampleButtons248:
;ADC_Buttons.c,540 :: 		case 3:
L_SampleButtons252:
;ADC_Buttons.c,541 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret       ");
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
;ADC_Buttons.c,542 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"SpikeDeg:=");
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
;ADC_Buttons.c,543 :: 		sprintf(txt4,"%3d",Sps.SpkeDeg);
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
	MOVF        _Sps+8, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,544 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,545 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"SpikeTmr:=");
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
;ADC_Buttons.c,546 :: 		sprintf(txt4,"%3d",Sps.SpkeTmr);
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
	MOVF        _Sps+10, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,547 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,548 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"          ");
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
;ADC_Buttons.c,549 :: 		break;
	GOTO        L_SampleButtons227
;ADC_Buttons.c,550 :: 		default:    //clear screen & update cursor position
L_SampleButtons253:
;ADC_Buttons.c,551 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,552 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,553 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,554 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,555 :: 		break;
	GOTO        L_SampleButtons227
;ADC_Buttons.c,556 :: 		}
L_SampleButtons226:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons411
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons411:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons228
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons412
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons412:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons234
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons413
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons413:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons242
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons414
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons414:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons252
	GOTO        L_SampleButtons253
L_SampleButtons227:
;ADC_Buttons.c,557 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,558 :: 		case CoolSettings:
L_SampleButtons254:
;ADC_Buttons.c,559 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons415
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons415:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons255
;ADC_Buttons.c,560 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,561 :: 		}
L_SampleButtons255:
;ADC_Buttons.c,562 :: 		ret6:
___SampleButtons_ret6:
;ADC_Buttons.c,563 :: 		switch(enC){
	GOTO        L_SampleButtons256
;ADC_Buttons.c,564 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == CoolSettings)){
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
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons261
L__SampleButtons323:
;ADC_Buttons.c,565 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,566 :: 		while(!RA2_bit);
L_SampleButtons262:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons263
	GOTO        L_SampleButtons262
L_SampleButtons263:
;ADC_Buttons.c,567 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,568 :: 		goto ret6;
	GOTO        ___SampleButtons_ret6
;ADC_Buttons.c,569 :: 		}
L_SampleButtons261:
;ADC_Buttons.c,570 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons267
L__SampleButtons322:
;ADC_Buttons.c,571 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,572 :: 		OK_A = 1;
	BSF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,573 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,574 :: 		Save_EncoderValue(Sps.CoolOffDeg);
	MOVF        _Sps+12, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,575 :: 		}
L_SampleButtons267:
;ADC_Buttons.c,576 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons268
;ADC_Buttons.c,577 :: 		Sps.CoolOffDeg = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
	MOVF        R1, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,578 :: 		if(Button(&PORTA, 2, 200, 0)){
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
;ADC_Buttons.c,579 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,580 :: 		while(!RA2_bit);
L_SampleButtons270:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons271
	GOTO        L_SampleButtons270
L_SampleButtons271:
;ADC_Buttons.c,581 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,582 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,583 :: 		}
L_SampleButtons269:
;ADC_Buttons.c,584 :: 		}
L_SampleButtons268:
;ADC_Buttons.c,585 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons272:
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons275
L__SampleButtons321:
;ADC_Buttons.c,586 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,587 :: 		OK_B = 1;
	BSF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,588 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,589 :: 		Save_EncoderValue(Sps.CoolOffTmr);
	MOVF        _Sps+14, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,590 :: 		while(!RA2_bit);
L_SampleButtons276:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons277
	GOTO        L_SampleButtons276
L_SampleButtons277:
;ADC_Buttons.c,591 :: 		}
L_SampleButtons275:
;ADC_Buttons.c,592 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons278
;ADC_Buttons.c,593 :: 		Sps.CoolOffTmr = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
	MOVF        R1, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,594 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons279
;ADC_Buttons.c,595 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,596 :: 		while(!RA2_bit);
L_SampleButtons280:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons281
	GOTO        L_SampleButtons280
L_SampleButtons281:
;ADC_Buttons.c,597 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,598 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,599 :: 		}
L_SampleButtons279:
;ADC_Buttons.c,600 :: 		}
L_SampleButtons278:
;ADC_Buttons.c,601 :: 		case 3:
L_SampleButtons282:
;ADC_Buttons.c,602 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
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
;ADC_Buttons.c,603 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"CoolDeg:=");
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
;ADC_Buttons.c,604 :: 		sprintf(txt4,"%3d",Sps.CoolOffDeg);
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
;ADC_Buttons.c,605 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,606 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"CoolTmr:=");
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
;ADC_Buttons.c,607 :: 		sprintf(txt4,"%3d",Sps.CoolOffTmr);
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
;ADC_Buttons.c,608 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,609 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
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
;ADC_Buttons.c,610 :: 		break;
	GOTO        L_SampleButtons257
;ADC_Buttons.c,611 :: 		default:    //clear screen & update cursor position
L_SampleButtons283:
;ADC_Buttons.c,612 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,613 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,614 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,615 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,616 :: 		break;
	GOTO        L_SampleButtons257
;ADC_Buttons.c,617 :: 		}
L_SampleButtons256:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons416
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons416:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons258
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons417
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons417:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons264
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons418
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons418:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons272
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons419
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons419:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons282
	GOTO        L_SampleButtons283
L_SampleButtons257:
;ADC_Buttons.c,618 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,619 :: 		case TimeSettings:
L_SampleButtons284:
;ADC_Buttons.c,620 :: 		if(enC > 3){
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_enC+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons420
	MOVF        ADC_Buttons_enC+0, 0 
	SUBLW       3
L__SampleButtons420:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons285
;ADC_Buttons.c,621 :: 		enC = Save_EncoderValue(3);
	MOVLW       3
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,622 :: 		}
L_SampleButtons285:
;ADC_Buttons.c,623 :: 		ret7:
___SampleButtons_ret7:
;ADC_Buttons.c,624 :: 		switch(enC){
	GOTO        L_SampleButtons286
;ADC_Buttons.c,625 :: 		case 0:    if (Button(&PORTA, 2, 200, 0) && (Sps.State == TimeSettings)){
L_SampleButtons288:
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
	GOTO        L_SampleButtons291
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_SampleButtons291
L__SampleButtons320:
;ADC_Buttons.c,626 :: 		Sps.State = TempMenu;
	MOVLW       2
	MOVWF       _Sps+16 
;ADC_Buttons.c,627 :: 		while(!RA2_bit);
L_SampleButtons292:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons293
	GOTO        L_SampleButtons292
L_SampleButtons293:
;ADC_Buttons.c,628 :: 		enC = 13;
	MOVLW       13
	MOVWF       ADC_Buttons_enC+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,629 :: 		goto ret7;
	GOTO        ___SampleButtons_ret7
;ADC_Buttons.c,630 :: 		}
L_SampleButtons291:
;ADC_Buttons.c,631 :: 		case 1:    if (Button(&PORTA, 2, 200, 0) && !OK_A){
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
	BTFSC       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons297
L__SampleButtons319:
;ADC_Buttons.c,632 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,633 :: 		OK_A = 1;OK_B=0;
	BSF         ADC_Buttons_B_+0, 0 
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,634 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,635 :: 		Save_EncoderValue(Sps.SerialWriteDly);
	MOVF        _Sps+17, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,636 :: 		}
L_SampleButtons297:
;ADC_Buttons.c,637 :: 		if(OK_A){
	BTFSS       ADC_Buttons_B_+0, 0 
	GOTO        L_SampleButtons298
;ADC_Buttons.c,638 :: 		Sps.SerialWriteDly = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+17 
;ADC_Buttons.c,639 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons299
;ADC_Buttons.c,640 :: 		OK_A = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,641 :: 		while(!RA2_bit);
L_SampleButtons300:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons301
	GOTO        L_SampleButtons300
L_SampleButtons301:
;ADC_Buttons.c,642 :: 		enC_line_inc = 1;
	MOVLW       1
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,643 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       1
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,644 :: 		}
L_SampleButtons299:
;ADC_Buttons.c,645 :: 		}
L_SampleButtons298:
;ADC_Buttons.c,646 :: 		case 2:    if (Button(&PORTA, 2, 200, 0) && !OK_B){
L_SampleButtons302:
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
	BTFSC       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons305
L__SampleButtons318:
;ADC_Buttons.c,647 :: 		enC = Save_EncoderValue(enC);
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,648 :: 		OK_B = 1;OK_A=0;
	BSF         ADC_Buttons_B_+0, 1 
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,649 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,650 :: 		Save_EncoderValue(DegC.SampleTmrSP);
	MOVF        _DegC+22, 0 
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
;ADC_Buttons.c,651 :: 		while(!RA2_bit);
L_SampleButtons306:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons307
	GOTO        L_SampleButtons306
L_SampleButtons307:
;ADC_Buttons.c,652 :: 		}
L_SampleButtons305:
;ADC_Buttons.c,653 :: 		if(OK_B){
	BTFSS       ADC_Buttons_B_+0, 1 
	GOTO        L_SampleButtons308
;ADC_Buttons.c,654 :: 		DegC.SampleTmrSP = Get_EncoderValue();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+22 
;ADC_Buttons.c,655 :: 		if(Button(&PORTA, 2, 200, 0)){
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
	GOTO        L_SampleButtons309
;ADC_Buttons.c,656 :: 		OK_B = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,657 :: 		while(!RA2_bit);
L_SampleButtons310:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_SampleButtons311
	GOTO        L_SampleButtons310
L_SampleButtons311:
;ADC_Buttons.c,658 :: 		enC_line_inc = 2;
	MOVLW       2
	MOVWF       ADC_Buttons_enC_line_inc+0 
	MOVLW       0
	MOVWF       ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,659 :: 		enC = Save_EncoderValue(enC_line_inc);
	MOVLW       2
	MOVWF       FARG_Save_EncoderValue_new_val+0 
	MOVLW       0
	MOVWF       FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,660 :: 		}
L_SampleButtons309:
;ADC_Buttons.c,661 :: 		}
L_SampleButtons308:
;ADC_Buttons.c,662 :: 		case 3:
L_SampleButtons312:
;ADC_Buttons.c,663 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,2,"Ret      ");
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
;ADC_Buttons.c,664 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,2,"Ser Dly:=");
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
;ADC_Buttons.c,665 :: 		sprintf(txt4,"%4d",Sps.SerialWriteDly);
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
	MOVF        _Sps+17, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,666 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,16,txt4);
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
;ADC_Buttons.c,667 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,2,"'C  Dly:=");
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
;ADC_Buttons.c,668 :: 		sprintf(txt4,"%4d",DegC.SampleTmrSP);
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
;ADC_Buttons.c,669 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,16,txt4);
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
;ADC_Buttons.c,670 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,2,"         ");
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
;ADC_Buttons.c,671 :: 		break;
	GOTO        L_SampleButtons287
;ADC_Buttons.c,672 :: 		default:    //clear screen & update cursor position
L_SampleButtons313:
;ADC_Buttons.c,673 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,674 :: 		enC_line_inc = 0;
	CLRF        ADC_Buttons_enC_line_inc+0 
	CLRF        ADC_Buttons_enC_line_inc+1 
;ADC_Buttons.c,675 :: 		enC = Save_EncoderValue(enC_line_inc);
	CLRF        FARG_Save_EncoderValue_new_val+0 
	CLRF        FARG_Save_EncoderValue_new_val+1 
	CALL        _Save_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,676 :: 		enC_last = -1;
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+0 
	MOVLW       255
	MOVWF       ADC_Buttons_enC_last+1 
;ADC_Buttons.c,677 :: 		break;
	GOTO        L_SampleButtons287
;ADC_Buttons.c,678 :: 		}
L_SampleButtons286:
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons421
	MOVLW       0
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons421:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons288
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons422
	MOVLW       1
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons422:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons294
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons423
	MOVLW       2
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons423:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons302
	MOVLW       0
	XORWF       ADC_Buttons_enC+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons424
	MOVLW       3
	XORWF       ADC_Buttons_enC+0, 0 
L__SampleButtons424:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons312
	GOTO        L_SampleButtons313
L_SampleButtons287:
;ADC_Buttons.c,679 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,680 :: 		default: Sps.State = Return;
L_SampleButtons314:
	MOVLW       1
	MOVWF       _Sps+16 
;ADC_Buttons.c,681 :: 		break;
	GOTO        L_SampleButtons20
;ADC_Buttons.c,682 :: 		}
L_SampleButtons19:
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons21
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons56
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons91
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons160
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons192
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons224
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons254
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons284
	GOTO        L_SampleButtons314
L_SampleButtons20:
;ADC_Buttons.c,684 :: 		}
L_SampleButtons14:
;ADC_Buttons.c,686 :: 		if(EEWrt){
	BTFSS       ADC_Buttons_B+0, 4 
	GOTO        L_SampleButtons315
;ADC_Buttons.c,687 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,688 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Writing To EEPROM...");
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
;ADC_Buttons.c,689 :: 		Delay_ms(1000);
	MOVLW       82
	MOVWF       R11, 0
	MOVLW       43
	MOVWF       R12, 0
	MOVLW       0
	MOVWF       R13, 0
L_SampleButtons316:
	DECFSZ      R13, 1, 1
	BRA         L_SampleButtons316
	DECFSZ      R12, 1, 1
	BRA         L_SampleButtons316
	DECFSZ      R11, 1, 1
	BRA         L_SampleButtons316
	NOP
;ADC_Buttons.c,690 :: 		EERead();
	CALL        _EERead+0, 0
;ADC_Buttons.c,691 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,692 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,693 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,694 :: 		}
L_SampleButtons315:
;ADC_Buttons.c,696 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,698 :: 		void ResetBits(){
;ADC_Buttons.c,699 :: 		valOf     = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,700 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,701 :: 		Menu_Bit  = 0;
	BCF         ADC_Buttons_B+0, 0 
;ADC_Buttons.c,702 :: 		OK_A      = 0;
	BCF         ADC_Buttons_B_+0, 0 
;ADC_Buttons.c,703 :: 		OK_B      = 0;
	BCF         ADC_Buttons_B_+0, 1 
;ADC_Buttons.c,704 :: 		OK_C      = 0;
	BCF         ADC_Buttons_B_+0, 2 
;ADC_Buttons.c,705 :: 		OK_D      = 0;
	BCF         ADC_Buttons_B_+0, 3 
;ADC_Buttons.c,706 :: 		OK_E      = 0;
	BCF         ADC_Buttons_B_+0, 4 
;ADC_Buttons.c,707 :: 		OK_F      = 0;
	BCF         ADC_Buttons_B_+0, 5 
;ADC_Buttons.c,708 :: 		OK_G      = 0;
	BCF         ADC_Buttons_B_+0, 6 
;ADC_Buttons.c,709 :: 		OK_H      = 0;
	BCF         ADC_Buttons_B_+0, 7 
;ADC_Buttons.c,710 :: 		OK_I      = 0;
	BCF         ADC_Buttons_B+0, 5 
;ADC_Buttons.c,711 :: 		OK_J      = 0;
	BCF         ADC_Buttons_B+0, 6 
;ADC_Buttons.c,712 :: 		OK_K      = 0;
	BCF         ADC_Buttons_B+0, 7 
;ADC_Buttons.c,713 :: 		EEWrt = 0;
	BCF         ADC_Buttons_B+0, 4 
;ADC_Buttons.c,714 :: 		P1 = 0;
	BCF         ADC_Buttons_P1+0, BitPos(ADC_Buttons_P1+0) 
;ADC_Buttons.c,715 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_EERead:

;ADC_Buttons.c,717 :: 		void EERead(){
;ADC_Buttons.c,719 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CLRF        FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,720 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,721 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,722 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,723 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,724 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,725 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,726 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,727 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,728 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,729 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,730 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,731 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,732 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,733 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,734 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,737 :: 		Lo(pid_t.Kp)         = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,738 :: 		Hi(pid_t.Kp)         = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,739 :: 		Lo(pid_t.Ki)         = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,740 :: 		Hi(pid_t.Ki)         = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,741 :: 		Lo(pid_t.Kd)         = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,742 :: 		Hi(pid_t.Kd)         = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,743 :: 		Lo(DegC.Deg_OffSet)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+8 
;ADC_Buttons.c,744 :: 		Hi(DegC.Deg_OffSet)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+9 
;ADC_Buttons.c,745 :: 		pid_t.Kt             = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+33 
;ADC_Buttons.c,748 :: 		Lo(TempTicks.RampTick)   = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,749 :: 		Hi(TempTicks.RampTick)   = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,750 :: 		Lo(TempTicks.SoakTick)   = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,751 :: 		Hi(TempTicks.SoakTick)   = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,752 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1E);
	MOVLW       30
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,753 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1F);
	MOVLW       31
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,754 :: 		Lo(TempTicks.CoolTick)   = EEPROM_Read(0x20);
	MOVLW       32
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,755 :: 		Hi(TempTicks.CoolTick)   = EEPROM_Read(0x21);
	MOVLW       33
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,758 :: 		Sps.SerialWriteDly   =  EEPROM_Read(0x22);
	MOVLW       34
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+17 
;ADC_Buttons.c,759 :: 		DegC.SampleTmrSP     =  EEPROM_Read(0x23);
	MOVLW       35
	MOVWF       FARG_EEPROM_Read_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Read_address+1 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+22 
;ADC_Buttons.c,760 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,761 :: 		void EEWrite(){
;ADC_Buttons.c,763 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	CLRF        FARG_EEPROM_Write_address+1 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,764 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,765 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,766 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,767 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,768 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,769 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,770 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,771 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,772 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,773 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,774 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,775 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,776 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,777 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,778 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,781 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,782 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,783 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,784 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,785 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,786 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,787 :: 		EEPROM_Write(0x16, Lo(DegC.Deg_OffSet));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,788 :: 		EEPROM_Write(0x17, Hi(DegC.Deg_OffSet));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,789 :: 		EEPROM_Write(0x18, pid_t.Kt);
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _pid_t+33, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,792 :: 		EEPROM_Write(0x1A, Lo(TempTicks.RampTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,793 :: 		EEPROM_Write(0x1B, Hi(TempTicks.RampTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,794 :: 		EEPROM_Write(0x1C, Lo(TempTicks.SoakTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,795 :: 		EEPROM_Write(0x1D, Hi(TempTicks.SoakTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,796 :: 		EEPROM_Write(0x1E, Lo(TempTicks.SpikeTick));
	MOVLW       30
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,797 :: 		EEPROM_Write(0x1F, Hi(TempTicks.SpikeTick));
	MOVLW       31
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,798 :: 		EEPROM_Write(0x20, Lo(TempTicks.CoolTick));
	MOVLW       32
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,799 :: 		EEPROM_Write(0x21, Hi(TempTicks.CoolTick));
	MOVLW       33
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,802 :: 		EEPROM_Write(0x22, Sps.SerialWriteDly);
	MOVLW       34
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _Sps+17, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,803 :: 		EEPROM_Write(0x23, DegC.SampleTmrSP);
	MOVLW       35
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVLW       0
	MOVWF       FARG_EEPROM_Write_address+1 
	MOVF        _DegC+22, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,806 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite317:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite317
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite317
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite317
	NOP
;ADC_Buttons.c,807 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
