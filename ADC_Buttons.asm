
_SampleButtons:

;ADC_Buttons.c,41 :: 		void SampleButtons(){
;ADC_Buttons.c,43 :: 		if (Button(&PORTA, 2, 10, 0))
	MOVLW       PORTA+0
	MOVWF       FARG_Button_port+0 
	MOVLW       hi_addr(PORTA+0)
	MOVWF       FARG_Button_port+1 
	MOVLW       2
	MOVWF       FARG_Button_pin+0 
	MOVLW       10
	MOVWF       FARG_Button_time_ms+0 
	CLRF        FARG_Button_active_state+0 
	CALL        _Button+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons0
;ADC_Buttons.c,44 :: 		Menu_Bit = on;
	BSF         _B+0, 0 
	GOTO        L_SampleButtons1
L_SampleButtons0:
;ADC_Buttons.c,46 :: 		return;
	GOTO        L_end_SampleButtons
L_SampleButtons1:
;ADC_Buttons.c,48 :: 		if(Menu_Bit && !Ok_Bit){
	BTFSS       _B+0, 0 
	GOTO        L_SampleButtons4
	BTFSC       _B+0, 1 
	GOTO        L_SampleButtons4
L__SampleButtons104:
;ADC_Buttons.c,49 :: 		Ok_Bit = on;
	BSF         _B+0, 1 
;ADC_Buttons.c,50 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,51 :: 		}
L_SampleButtons4:
;ADC_Buttons.c,53 :: 		if(Menu_Bit){
	BTFSS       _B+0, 0 
	GOTO        L_SampleButtons5
;ADC_Buttons.c,54 :: 		enC = Get_EncoderValue();//ReadMax31855J();
	CALL        _Get_EncoderValue+0, 0
	MOVF        R0, 0 
	MOVWF       ADC_Buttons_enC+0 
	MOVF        R1, 0 
	MOVWF       ADC_Buttons_enC+1 
;ADC_Buttons.c,55 :: 		if(enC_temp != enC){
	MOVF        ADC_Buttons_enC_temp+1, 0 
	XORWF       R1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons106
	MOVF        R0, 0 
	XORWF       ADC_Buttons_enC_temp+0, 0 
L__SampleButtons106:
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons6
;ADC_Buttons.c,56 :: 		sprintf(txt1,"%4d",enC);
	MOVLW       _txt1+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_1_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_1_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_1_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_enC+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_enC+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,57 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ADC_Buttons.c,58 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,11,"Enc:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr2_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr2_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,59 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,17,txt1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       17
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt1+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,60 :: 		}
L_SampleButtons6:
;ADC_Buttons.c,61 :: 		}
L_SampleButtons5:
;ADC_Buttons.c,63 :: 		if(Ok_Bit){
	BTFSS       _B+0, 1 
	GOTO        L_SampleButtons7
;ADC_Buttons.c,64 :: 		if(EEWrt)EEWrt = off;
	BTFSS       _B+0, 4 
	GOTO        L_SampleButtons8
	BCF         _B+0, 4 
L_SampleButtons8:
;ADC_Buttons.c,65 :: 		switch(Sps.State){
	GOTO        L_SampleButtons9
;ADC_Buttons.c,66 :: 		case Return:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ret     ");
L_SampleButtons11:
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
;ADC_Buttons.c,68 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,69 :: 		case RampDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampDeg ");
L_SampleButtons12:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,70 :: 		if(OK_A){
	BTFSS       _B_+0, 0 
	GOTO        L_SampleButtons13
;ADC_Buttons.c,71 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons14
;ADC_Buttons.c,72 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKA");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr5_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr5_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,73 :: 		valOf = Sps.RmpDeg;
	MOVF        _Sps+0, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+1, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,74 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,75 :: 		}else Sps.RmpDeg = valOf;
	GOTO        L_SampleButtons15
L_SampleButtons14:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+0 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+1 
L_SampleButtons15:
;ADC_Buttons.c,76 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons16
L_SampleButtons13:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons16:
;ADC_Buttons.c,77 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,78 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,79 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,80 :: 		case RampTm:   I2C_LCD_Out(LCD_01_ADDRESS,1,1,"RampTm  ");
L_SampleButtons17:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr7_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr7_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,81 :: 		if(OK_B){
	BTFSS       _B_+0, 1 
	GOTO        L_SampleButtons18
;ADC_Buttons.c,82 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons19
;ADC_Buttons.c,83 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKB");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr8_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr8_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,84 :: 		valOf = Sps.RmpTmr;
	MOVF        _Sps+2, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+3, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,85 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,86 :: 		}else Sps.RmpTmr = valOf;
	GOTO        L_SampleButtons20
L_SampleButtons19:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+2 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+3 
L_SampleButtons20:
;ADC_Buttons.c,87 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons21
L_SampleButtons18:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons21:
;ADC_Buttons.c,88 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_9_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_9_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_9_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,89 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,90 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,91 :: 		case SoakDeg:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakDeg ");
L_SampleButtons22:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr10_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr10_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,92 :: 		if(OK_C){
	BTFSS       _B_+0, 2 
	GOTO        L_SampleButtons23
;ADC_Buttons.c,93 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons24
;ADC_Buttons.c,94 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKC");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr11_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr11_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,95 :: 		valOf = Sps.SokDeg;
	MOVF        _Sps+4, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+5, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,96 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,97 :: 		}else Sps.SokDeg = valOf;
	GOTO        L_SampleButtons25
L_SampleButtons24:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+4 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+5 
L_SampleButtons25:
;ADC_Buttons.c,98 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons26
L_SampleButtons23:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons26:
;ADC_Buttons.c,99 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_12_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_12_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_12_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,100 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,101 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,102 :: 		case SoakTm:  I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SoakTm  ");
L_SampleButtons27:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr13_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr13_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,103 :: 		if(OK_D){
	BTFSS       _B_+0, 3 
	GOTO        L_SampleButtons28
;ADC_Buttons.c,104 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons29
;ADC_Buttons.c,105 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKD");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr14_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr14_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,106 :: 		valOf = Sps.SokTmr;
	MOVF        _Sps+6, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+7, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,107 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,108 :: 		}else Sps.SokTmr = valOf;
	GOTO        L_SampleButtons30
L_SampleButtons29:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+6 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+7 
L_SampleButtons30:
;ADC_Buttons.c,109 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons31
L_SampleButtons28:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons31:
;ADC_Buttons.c,110 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_15_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_15_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_15_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,111 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,112 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,113 :: 		case SpikeDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeDeg");
L_SampleButtons32:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr16_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr16_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,114 :: 		if(OK_E){
	BTFSS       _B_+0, 4 
	GOTO        L_SampleButtons33
;ADC_Buttons.c,115 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons34
;ADC_Buttons.c,116 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKE");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr17_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr17_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,117 :: 		valOf = Sps.SpkeDeg;
	MOVF        _Sps+8, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+9, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,118 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,119 :: 		}else Sps.SpkeDeg = valOf;
	GOTO        L_SampleButtons35
L_SampleButtons34:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+8 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+9 
L_SampleButtons35:
;ADC_Buttons.c,120 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons36
L_SampleButtons33:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons36:
;ADC_Buttons.c,121 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_18_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_18_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_18_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,122 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,123 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,124 :: 		case SpikeTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"SpikeTm ");
L_SampleButtons37:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr19_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr19_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,125 :: 		if(OK_F){
	BTFSS       _B_+0, 5 
	GOTO        L_SampleButtons38
;ADC_Buttons.c,126 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons39
;ADC_Buttons.c,127 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKF");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr20_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr20_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,128 :: 		valOf = Sps.SpkeTmr;
	MOVF        _Sps+10, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+11, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,129 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,130 :: 		}else Sps.SpkeTmr = valOf;
	GOTO        L_SampleButtons40
L_SampleButtons39:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+10 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+11 
L_SampleButtons40:
;ADC_Buttons.c,131 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons41
L_SampleButtons38:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons41:
;ADC_Buttons.c,132 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_21_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_21_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_21_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,133 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,134 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,135 :: 		case CoolDownDeg: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolDeg ");
L_SampleButtons42:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr22_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr22_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,136 :: 		if(OK_G){
	BTFSS       _B_+0, 6 
	GOTO        L_SampleButtons43
;ADC_Buttons.c,137 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons44
;ADC_Buttons.c,138 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKG");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr23_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr23_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,139 :: 		valOf = Sps.CoolOffDeg;
	MOVF        _Sps+12, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+13, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,140 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,141 :: 		}else Sps.CoolOffDeg = valOf;
	GOTO        L_SampleButtons45
L_SampleButtons44:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+12 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+13 
L_SampleButtons45:
;ADC_Buttons.c,142 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons46
L_SampleButtons43:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons46:
;ADC_Buttons.c,143 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_24_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_24_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_24_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,144 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,145 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,146 :: 		case CoolDownTm: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"CoolTm ");
L_SampleButtons47:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr25_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr25_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,147 :: 		if(OK_H){
	BTFSS       _B_+0, 7 
	GOTO        L_SampleButtons48
;ADC_Buttons.c,148 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons49
;ADC_Buttons.c,149 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKH");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr26_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr26_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,150 :: 		valOf = Sps.CoolOffTmr;
	MOVF        _Sps+14, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _Sps+15, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,151 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,152 :: 		}else Sps.CoolOffTmr = valOf;
	GOTO        L_SampleButtons50
L_SampleButtons49:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+14 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _Sps+15 
L_SampleButtons50:
;ADC_Buttons.c,153 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons51
L_SampleButtons48:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons51:
;ADC_Buttons.c,154 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_27_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_27_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_27_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,155 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,156 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,157 :: 		case Kp_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kp    ");
L_SampleButtons52:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr28_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr28_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,158 :: 		if(OK_I){
	BTFSS       _B+0, 5 
	GOTO        L_SampleButtons53
;ADC_Buttons.c,159 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons54
;ADC_Buttons.c,160 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKI");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr29_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr29_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,161 :: 		valOf = pid_t.Kp;
	MOVF        _pid_t+0, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+1, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,162 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,163 :: 		}else pid_t.Kp = valOf;
	GOTO        L_SampleButtons55
L_SampleButtons54:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+0 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+1 
L_SampleButtons55:
;ADC_Buttons.c,164 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons56
L_SampleButtons53:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons56:
;ADC_Buttons.c,165 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_30_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_30_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_30_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,166 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,167 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,168 :: 		case Ki_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ki    ");
L_SampleButtons57:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr31_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr31_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,169 :: 		if(OK_J){
	BTFSS       _B+0, 6 
	GOTO        L_SampleButtons58
;ADC_Buttons.c,170 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons59
;ADC_Buttons.c,171 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKJ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr32_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr32_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,172 :: 		valOf = pid_t.Ki;
	MOVF        _pid_t+2, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+3, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,173 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,174 :: 		}else pid_t.Ki = valOf;
	GOTO        L_SampleButtons60
L_SampleButtons59:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+2 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+3 
L_SampleButtons60:
;ADC_Buttons.c,175 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons61
L_SampleButtons58:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons61:
;ADC_Buttons.c,176 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_33_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_33_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_33_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,177 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,178 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,179 :: 		case Kd_: I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Kd    ");
L_SampleButtons62:
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr34_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr34_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,180 :: 		if(OK_K){
	BTFSS       _B+0, 7 
	GOTO        L_SampleButtons63
;ADC_Buttons.c,181 :: 		if(!OFF_Bit){
	BTFSC       _B+0, 3 
	GOTO        L_SampleButtons64
;ADC_Buttons.c,182 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"OKK");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr35_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr35_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,183 :: 		valOf = pid_t.Kd;
	MOVF        _pid_t+4, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVF        _pid_t+5, 0 
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,184 :: 		OFF_Bit = on;
	BSF         _B+0, 3 
;ADC_Buttons.c,185 :: 		}else pid_t.Kd = valOf;
	GOTO        L_SampleButtons65
L_SampleButtons64:
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _pid_t+4 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       _pid_t+5 
L_SampleButtons65:
;ADC_Buttons.c,186 :: 		}else doOFFBitoff();
	GOTO        L_SampleButtons66
L_SampleButtons63:
	CALL        _doOFFBitoff+0, 0
L_SampleButtons66:
;ADC_Buttons.c,187 :: 		sprintf(txt4_,"%5u",valOf);
	MOVLW       _txt4_+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4_+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_36_ADC_Buttons+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_36_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_36_ADC_Buttons+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        ADC_Buttons_valOf+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ADC_Buttons.c,188 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,11,txt4_);
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
;ADC_Buttons.c,189 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,190 :: 		default: Sps.State = Return;
L_SampleButtons67:
	CLRF        _Sps+16 
;ADC_Buttons.c,191 :: 		valOf = Sps.State;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,192 :: 		break;
	GOTO        L_SampleButtons10
;ADC_Buttons.c,193 :: 		}
L_SampleButtons9:
	MOVF        _Sps+16, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons11
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons12
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons17
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons22
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons27
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons32
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons37
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons42
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons47
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons52
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons57
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSC       STATUS+0, 2 
	GOTO        L_SampleButtons62
	GOTO        L_SampleButtons67
L_SampleButtons10:
;ADC_Buttons.c,197 :: 		}else{
	GOTO        L_SampleButtons68
L_SampleButtons7:
;ADC_Buttons.c,198 :: 		if(!EEWrt){
	BTFSC       _B+0, 4 
	GOTO        L_SampleButtons69
;ADC_Buttons.c,199 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ADC_Buttons.c,200 :: 		EEWrite();
	CALL        _EEWrite+0, 0
;ADC_Buttons.c,201 :: 		EEWrt = on;
	BSF         _B+0, 4 
;ADC_Buttons.c,202 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ADC_Buttons.c,203 :: 		}
L_SampleButtons69:
;ADC_Buttons.c,204 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ADC_Buttons.c,205 :: 		}
L_SampleButtons68:
;ADC_Buttons.c,206 :: 		if((!OK_A)&&(!OK_B)&&(!OK_C)&&(!OK_D)&&(!OK_E)&&(!OK_F)&&(!OK_G)&&(!OK_H)&&(!OK_I)&&(!OK_J)&&(!OK_K)){
	BTFSC       _B_+0, 0 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 1 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 2 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 3 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 4 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 5 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 6 
	GOTO        L_SampleButtons72
	BTFSC       _B_+0, 7 
	GOTO        L_SampleButtons72
	BTFSC       _B+0, 5 
	GOTO        L_SampleButtons72
	BTFSC       _B+0, 6 
	GOTO        L_SampleButtons72
	BTFSC       _B+0, 7 
	GOTO        L_SampleButtons72
L__SampleButtons103:
;ADC_Buttons.c,207 :: 		Sps.State = valOf;
	MOVF        ADC_Buttons_valOf+0, 0 
	MOVWF       _Sps+16 
;ADC_Buttons.c,208 :: 		if((valOf > 11)&&(valOf<50000))valOf = 11;
	MOVLW       0
	MOVWF       R0 
	MOVF        ADC_Buttons_valOf+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons107
	MOVF        ADC_Buttons_valOf+0, 0 
	SUBLW       11
L__SampleButtons107:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons75
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons108
	MOVLW       80
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons108:
	BTFSC       STATUS+0, 0 
	GOTO        L_SampleButtons75
L__SampleButtons102:
	MOVLW       11
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
	GOTO        L_SampleButtons76
L_SampleButtons75:
;ADC_Buttons.c,209 :: 		else if (valOf >= 50001)valOf = 0;
	MOVLW       195
	SUBWF       ADC_Buttons_valOf+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__SampleButtons109
	MOVLW       81
	SUBWF       ADC_Buttons_valOf+0, 0 
L__SampleButtons109:
	BTFSS       STATUS+0, 0 
	GOTO        L_SampleButtons77
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
L_SampleButtons77:
L_SampleButtons76:
;ADC_Buttons.c,210 :: 		}
L_SampleButtons72:
;ADC_Buttons.c,212 :: 		}
L_end_SampleButtons:
	RETURN      0
; end of _SampleButtons

_ResetBits:

;ADC_Buttons.c,214 :: 		void ResetBits(){
;ADC_Buttons.c,215 :: 		valOf = 0;
	CLRF        ADC_Buttons_valOf+0 
	CLRF        ADC_Buttons_valOf+1 
;ADC_Buttons.c,216 :: 		Sps.State = 0;
	CLRF        _Sps+16 
;ADC_Buttons.c,217 :: 		OK_Bit = 0;
	BCF         _B+0, 1 
;ADC_Buttons.c,218 :: 		OK_A = 0;
	BCF         _B_+0, 0 
;ADC_Buttons.c,219 :: 		OK_B = 0;
	BCF         _B_+0, 1 
;ADC_Buttons.c,220 :: 		OK_C = 0;
	BCF         _B_+0, 2 
;ADC_Buttons.c,221 :: 		OK_D = 0;
	BCF         _B_+0, 3 
;ADC_Buttons.c,222 :: 		OK_E = 0;
	BCF         _B_+0, 4 
;ADC_Buttons.c,223 :: 		OK_F = 0;
	BCF         _B_+0, 5 
;ADC_Buttons.c,224 :: 		OK_G = 0;
	BCF         _B_+0, 6 
;ADC_Buttons.c,225 :: 		OK_H = 0;
	BCF         _B_+0, 7 
;ADC_Buttons.c,226 :: 		OK_I = 0;
	BCF         _B+0, 5 
;ADC_Buttons.c,227 :: 		OK_J = 0;
	BCF         _B+0, 6 
;ADC_Buttons.c,228 :: 		OK_K = 0;
	BCF         _B+0, 7 
;ADC_Buttons.c,229 :: 		}
L_end_ResetBits:
	RETURN      0
; end of _ResetBits

_SavedVals:

;ADC_Buttons.c,231 :: 		void SavedVals(){
;ADC_Buttons.c,232 :: 		if(Sps.State == RampDeg)          OK_A = !OK_A;
	MOVF        _Sps+16, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals78
	BTG         _B_+0, 0 
	GOTO        L_SavedVals79
L_SavedVals78:
;ADC_Buttons.c,233 :: 		else if(Sps.State == RampTm)      OK_B = !OK_B;
	MOVF        _Sps+16, 0 
	XORLW       2
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals80
	BTG         _B_+0, 1 
	GOTO        L_SavedVals81
L_SavedVals80:
;ADC_Buttons.c,234 :: 		else if(Sps.State == SoakDeg)     OK_C = !OK_C;
	MOVF        _Sps+16, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals82
	BTG         _B_+0, 2 
	GOTO        L_SavedVals83
L_SavedVals82:
;ADC_Buttons.c,235 :: 		else if(Sps.State == SoakTm)      OK_D = !OK_D;
	MOVF        _Sps+16, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals84
	BTG         _B_+0, 3 
	GOTO        L_SavedVals85
L_SavedVals84:
;ADC_Buttons.c,236 :: 		else if(Sps.State == SpikeDeg)    OK_E = !OK_E;
	MOVF        _Sps+16, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals86
	BTG         _B_+0, 4 
	GOTO        L_SavedVals87
L_SavedVals86:
;ADC_Buttons.c,237 :: 		else if(Sps.State == SpikeTM)     OK_F = !OK_F;
	MOVF        _Sps+16, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals88
	BTG         _B_+0, 5 
	GOTO        L_SavedVals89
L_SavedVals88:
;ADC_Buttons.c,238 :: 		else if(Sps.State == CoolDownDeg) OK_G = !OK_G;
	MOVF        _Sps+16, 0 
	XORLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals90
	BTG         _B_+0, 6 
	GOTO        L_SavedVals91
L_SavedVals90:
;ADC_Buttons.c,239 :: 		else if(Sps.State == CoolDowntM)  OK_H = !OK_H;
	MOVF        _Sps+16, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals92
	BTG         _B_+0, 7 
	GOTO        L_SavedVals93
L_SavedVals92:
;ADC_Buttons.c,240 :: 		else if(Sps.State == Kp_)         OK_I = !OK_I;
	MOVF        _Sps+16, 0 
	XORLW       9
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals94
	BTG         _B+0, 5 
	GOTO        L_SavedVals95
L_SavedVals94:
;ADC_Buttons.c,241 :: 		else if(Sps.State == Ki_)         OK_J = !OK_J;
	MOVF        _Sps+16, 0 
	XORLW       10
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals96
	BTG         _B+0, 6 
	GOTO        L_SavedVals97
L_SavedVals96:
;ADC_Buttons.c,242 :: 		else if(Sps.State == Kd_)         OK_K = !OK_K;
	MOVF        _Sps+16, 0 
	XORLW       11
	BTFSS       STATUS+0, 2 
	GOTO        L_SavedVals98
	BTG         _B+0, 7 
	GOTO        L_SavedVals99
L_SavedVals98:
;ADC_Buttons.c,243 :: 		else OK_Bit = !OK_Bit;
	BTG         _B+0, 1 
L_SavedVals99:
L_SavedVals97:
L_SavedVals95:
L_SavedVals93:
L_SavedVals91:
L_SavedVals89:
L_SavedVals87:
L_SavedVals85:
L_SavedVals83:
L_SavedVals81:
L_SavedVals79:
;ADC_Buttons.c,244 :: 		}
L_end_SavedVals:
	RETURN      0
; end of _SavedVals

_doOFFBitoff:

;ADC_Buttons.c,246 :: 		void doOFFBitoff(){
;ADC_Buttons.c,247 :: 		if(OFF_Bit){
	BTFSS       _B+0, 3 
	GOTO        L_doOFFBitoff100
;ADC_Buttons.c,248 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"   ");
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
;ADC_Buttons.c,249 :: 		valOf = Sps.State;
	MOVF        _Sps+16, 0 
	MOVWF       ADC_Buttons_valOf+0 
	MOVLW       0
	MOVWF       ADC_Buttons_valOf+1 
;ADC_Buttons.c,250 :: 		OFF_Bit = off;
	BCF         _B+0, 3 
;ADC_Buttons.c,251 :: 		}
L_doOFFBitoff100:
;ADC_Buttons.c,253 :: 		}
L_end_doOFFBitoff:
	RETURN      0
; end of _doOFFBitoff

_EERead:

;ADC_Buttons.c,255 :: 		void EERead(){
;ADC_Buttons.c,257 :: 		Lo(Sps.RmpDeg)  = EEPROM_Read(0x00);
	CLRF        FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+0 
;ADC_Buttons.c,258 :: 		Hi(Sps.RmpDeg)  = EEPROM_Read(0x01);
	MOVLW       1
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+1 
;ADC_Buttons.c,259 :: 		Lo(Sps.RmpTmr)  = EEPROM_Read(0x02);
	MOVLW       2
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+2 
;ADC_Buttons.c,260 :: 		Hi(Sps.RmpTmr)  = EEPROM_Read(0x03);
	MOVLW       3
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+3 
;ADC_Buttons.c,261 :: 		Lo(Sps.SokDeg)  = EEPROM_Read(0x04);
	MOVLW       4
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+4 
;ADC_Buttons.c,262 :: 		Hi(Sps.SokDeg)  = EEPROM_Read(0x05);
	MOVLW       5
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+5 
;ADC_Buttons.c,263 :: 		Lo(Sps.SokTmr)  = EEPROM_Read(0x06);
	MOVLW       6
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+6 
;ADC_Buttons.c,264 :: 		Hi(Sps.SokTmr)  = EEPROM_Read(0x07);
	MOVLW       7
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+7 
;ADC_Buttons.c,265 :: 		Lo(Sps.SpkeDeg)  = EEPROM_Read(0x08);
	MOVLW       8
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+8 
;ADC_Buttons.c,266 :: 		Hi(Sps.SpkeDeg)  = EEPROM_Read(0x09);
	MOVLW       9
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+9 
;ADC_Buttons.c,267 :: 		Lo(Sps.SpkeTmr)  = EEPROM_Read(0x0A);
	MOVLW       10
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+10 
;ADC_Buttons.c,268 :: 		Hi(Sps.SpkeTmr)  = EEPROM_Read(0x0B);
	MOVLW       11
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+11 
;ADC_Buttons.c,269 :: 		Lo(Sps.CoolOffDeg)  = EEPROM_Read(0x0C);
	MOVLW       12
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+12 
;ADC_Buttons.c,270 :: 		Hi(Sps.CoolOffDeg)  = EEPROM_Read(0x0D);
	MOVLW       13
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+13 
;ADC_Buttons.c,271 :: 		Lo(Sps.CoolOffTmr)  = EEPROM_Read(0x0E);
	MOVLW       14
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+14 
;ADC_Buttons.c,272 :: 		Hi(Sps.CoolOffTmr)  = EEPROM_Read(0x0F);
	MOVLW       15
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _Sps+15 
;ADC_Buttons.c,275 :: 		Lo(pid_t.Kp)     = EEPROM_Read(0x10);
	MOVLW       16
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+0 
;ADC_Buttons.c,276 :: 		Hi(pid_t.Kp)     = EEPROM_Read(0x11);
	MOVLW       17
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+1 
;ADC_Buttons.c,277 :: 		Lo(pid_t.Ki)     = EEPROM_Read(0x12);
	MOVLW       18
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+2 
;ADC_Buttons.c,278 :: 		Hi(pid_t.Ki)     = EEPROM_Read(0x13);
	MOVLW       19
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+3 
;ADC_Buttons.c,279 :: 		Lo(pid_t.Kd)     = EEPROM_Read(0x14);
	MOVLW       20
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+4 
;ADC_Buttons.c,280 :: 		Hi(pid_t.Kd)     = EEPROM_Read(0x15);
	MOVLW       21
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _pid_t+5 
;ADC_Buttons.c,283 :: 		Lo(TempTicks.RampTick)  = EEPROM_Read(0x16);
	MOVLW       22
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+2 
;ADC_Buttons.c,284 :: 		Hi(TempTicks.RampTick)  = EEPROM_Read(0x17);
	MOVLW       23
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+3 
;ADC_Buttons.c,285 :: 		Lo(TempTicks.SoakTick)  = EEPROM_Read(0x18);
	MOVLW       24
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+4 
;ADC_Buttons.c,286 :: 		Hi(TempTicks.SoakTick)  = EEPROM_Read(0x19);
	MOVLW       25
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+5 
;ADC_Buttons.c,287 :: 		Lo(TempTicks.SpikeTick)  = EEPROM_Read(0x1A);
	MOVLW       26
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+6 
;ADC_Buttons.c,288 :: 		Hi(TempTicks.SpikeTick)  = EEPROM_Read(0x1B);
	MOVLW       27
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+7 
;ADC_Buttons.c,289 :: 		Lo(TempTicks.CoolTick)  = EEPROM_Read(0x1C);
	MOVLW       28
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+8 
;ADC_Buttons.c,290 :: 		Hi(TempTicks.CoolTick)  = EEPROM_Read(0x1D);
	MOVLW       29
	MOVWF       FARG_EEPROM_Read_address+0 
	CALL        _EEPROM_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _TempTicks+9 
;ADC_Buttons.c,292 :: 		}
L_end_EERead:
	RETURN      0
; end of _EERead

_EEWrite:

;ADC_Buttons.c,293 :: 		void EEWrite(){
;ADC_Buttons.c,294 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,"EEW");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr38_ADC_Buttons+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr38_ADC_Buttons+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ADC_Buttons.c,296 :: 		EEPROM_Write(0x00, Lo(Sps.RmpDeg));
	CLRF        FARG_EEPROM_Write_address+0 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,297 :: 		EEPROM_Write(0x01, Hi(Sps.RmpDeg));
	MOVLW       1
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,298 :: 		EEPROM_Write(0x02, Lo(Sps.RmpTmr));
	MOVLW       2
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,299 :: 		EEPROM_Write(0x03, Hi(Sps.RmpTmr));
	MOVLW       3
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,300 :: 		EEPROM_Write(0x04, Lo(Sps.SokDeg));
	MOVLW       4
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,301 :: 		EEPROM_Write(0x05, Hi(Sps.SokDeg));
	MOVLW       5
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,302 :: 		EEPROM_Write(0x06, Lo(Sps.SokTmr));
	MOVLW       6
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,303 :: 		EEPROM_Write(0x07, Hi(Sps.SokTmr));
	MOVLW       7
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,304 :: 		EEPROM_Write(0x08, Lo(Sps.SpkeDeg));
	MOVLW       8
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,305 :: 		EEPROM_Write(0x09, Hi(Sps.SpkeDeg));
	MOVLW       9
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,306 :: 		EEPROM_Write(0x0A, Lo(Sps.SpkeTmr));
	MOVLW       10
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+10, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,307 :: 		EEPROM_Write(0x0B, Hi(Sps.SpkeTmr));
	MOVLW       11
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+11, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,308 :: 		EEPROM_Write(0x0C, Lo(Sps.CoolOffDeg));
	MOVLW       12
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+12, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,309 :: 		EEPROM_Write(0x0D, Hi(Sps.CoolOffDeg));
	MOVLW       13
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,310 :: 		EEPROM_Write(0x0E, Lo(Sps.CoolOffTmr));
	MOVLW       14
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+14, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,311 :: 		EEPROM_Write(0x0F, Hi(Sps.CoolOffTmr));
	MOVLW       15
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _Sps+15, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,314 :: 		EEPROM_Write(0x10, Lo(pid_t.Kp));
	MOVLW       16
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,315 :: 		EEPROM_Write(0x11, Hi(pid_t.Kp));
	MOVLW       17
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,316 :: 		EEPROM_Write(0x12, Lo(pid_t.Ki));
	MOVLW       18
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,317 :: 		EEPROM_Write(0x13, Hi(pid_t.Ki));
	MOVLW       19
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,318 :: 		EEPROM_Write(0x14, Lo(pid_t.Kd));
	MOVLW       20
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,319 :: 		EEPROM_Write(0x15, Hi(pid_t.Kd));
	MOVLW       21
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,322 :: 		EEPROM_Write(0x16, Lo(TempTicks.RampTick));
	MOVLW       22
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+2, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,323 :: 		EEPROM_Write(0x17, Hi(TempTicks.RampTick));
	MOVLW       23
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,324 :: 		EEPROM_Write(0x18, Lo(TempTicks.SoakTick));
	MOVLW       24
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+4, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,325 :: 		EEPROM_Write(0x19, Hi(TempTicks.SoakTick));
	MOVLW       25
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,326 :: 		EEPROM_Write(0x1A, Lo(TempTicks.SpikeTick));
	MOVLW       26
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+6, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,327 :: 		EEPROM_Write(0x1B, Hi(TempTicks.SpikeTick));
	MOVLW       27
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,328 :: 		EEPROM_Write(0x1C, Lo(TempTicks.CoolTick));
	MOVLW       28
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+8, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,329 :: 		EEPROM_Write(0x1D, Hi(TempTicks.CoolTick));
	MOVLW       29
	MOVWF       FARG_EEPROM_Write_address+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       FARG_EEPROM_Write_data_+0 
	CALL        _EEPROM_Write+0, 0
;ADC_Buttons.c,330 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_EEWrite101:
	DECFSZ      R13, 1, 1
	BRA         L_EEWrite101
	DECFSZ      R12, 1, 1
	BRA         L_EEWrite101
	DECFSZ      R11, 1, 1
	BRA         L_EEWrite101
	NOP
;ADC_Buttons.c,331 :: 		}
L_end_EEWrite:
	RETURN      0
; end of _EEWrite
