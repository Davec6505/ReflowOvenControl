
_main:

;ReflowOven.c,48 :: 		void main() {
;ReflowOven.c,49 :: 		I2Cxx = I2C1;
	MOVLW       1
	MOVWF       _I2Cxx+0 
	MOVLW       0
	MOVWF       _I2Cxx+1 
;ReflowOven.c,50 :: 		DI();
	CALL        _DI+0, 0
;ReflowOven.c,51 :: 		ConfPic();
	CALL        _ConfPic+0, 0
;ReflowOven.c,52 :: 		I2C_LCD_init(LCD_01_ADDRESS,_2Line);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_init_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_init_DispLines+0 
	CALL        _I2C_LCD_init+0, 0
;ReflowOven.c,53 :: 		Delay_ms(500);
	MOVLW       41
	MOVWF       R11, 0
	MOVLW       150
	MOVWF       R12, 0
	MOVLW       127
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
;ReflowOven.c,54 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);          // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,55 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);     // Cursor off
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       7
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,56 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Starting UP");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr2_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr2_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,57 :: 		Delay_ms(2000);
	MOVLW       163
	MOVWF       R11, 0
	MOVLW       87
	MOVWF       R12, 0
	MOVLW       2
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;ReflowOven.c,58 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);//Lcd_Cmd(0,0x01);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,60 :: 		EERead();
	CALL        _EERead+0, 0
;ReflowOven.c,62 :: 		PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-900,'+',_PID);
	MOVLW       _pid_t+0
	MOVWF       FARG_PID_Init_PID_t+0 
	MOVLW       hi_addr(_pid_t+0)
	MOVWF       FARG_PID_Init_PID_t+1 
	MOVF        _pid_t+0, 0 
	MOVWF       FARG_PID_Init_kp+0 
	MOVF        _pid_t+1, 0 
	MOVWF       FARG_PID_Init_kp+1 
	MOVF        _pid_t+2, 0 
	MOVWF       FARG_PID_Init_ki+0 
	MOVF        _pid_t+3, 0 
	MOVWF       FARG_PID_Init_ki+1 
	MOVF        _pid_t+4, 0 
	MOVWF       FARG_PID_Init_kd+0 
	MOVF        _pid_t+5, 0 
	MOVWF       FARG_PID_Init_kd+1 
	CLRF        FARG_PID_Init_offst+0 
	CLRF        FARG_PID_Init_offst+1 
	MOVLW       242
	MOVWF       FARG_PID_Init_Max+0 
	MOVLW       3
	MOVWF       FARG_PID_Init_Max+1 
	MOVLW       124
	MOVWF       FARG_PID_Init_Min+0 
	MOVLW       252
	MOVWF       FARG_PID_Init_Min+1 
	MOVLW       43
	MOVWF       FARG_PID_Init_Dirct+0 
	MOVLW       3
	MOVWF       FARG_PID_Init_Cntl+0 
	CALL        _PID_Init+0, 0
;ReflowOven.c,63 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ReflowOven.c,64 :: 		ClearAll();
	CALL        _ClearAll+0, 0
;ReflowOven.c,65 :: 		RstLocals();
	CALL        _RstLocals+0, 0
;ReflowOven.c,66 :: 		DegC.Temp_iPv = (int)ReadMax31855J();
	CALL        _ReadMax31855J+0, 0
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+16 
	MOVF        R1, 0 
	MOVWF       _DegC+17 
;ReflowOven.c,67 :: 		sprintf(txt5,"%3d",DegC.Temp_iPv); //DegC.Temp_
	MOVLW       _txt5+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_3_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        R0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        R1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,68 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,13,"iC:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       13
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,70 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,18,txt5);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       18
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt5+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,71 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,72 :: 		EI();
	CALL        _EI+0, 0
;ReflowOven.c,73 :: 		while(1){
L_main2:
;ReflowOven.c,80 :: 		LATC5_bit = RA3_bit && !FinCycle;
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main5
	BTFSC       _Bits+0, 3 
	GOTO        L_main5
	MOVLW       1
	MOVWF       R0 
	GOTO        L_main4
L_main5:
	CLRF        R0 
L_main4:
	BTFSC       R0, 0 
	GOTO        L__main101
	BCF         LATC5_bit+0, BitPos(LATC5_bit+0) 
	GOTO        L__main102
L__main101:
	BSF         LATC5_bit+0, BitPos(LATC5_bit+0) 
L__main102:
;ReflowOven.c,84 :: 		if(Menu_Bit)
	BTFSS       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main6
;ReflowOven.c,85 :: 		SampleButtons();
	CALL        _SampleButtons+0, 0
L_main6:
;ReflowOven.c,88 :: 		if(!Menu_Bit && fp){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main9
	BTFSS       main_fp_L1+0, BitPos(main_fp_L1+0) 
	GOTO        L_main9
L__main99:
;ReflowOven.c,89 :: 		fp = off;
	BCF         main_fp_L1+0, BitPos(main_fp_L1+0) 
;ReflowOven.c,90 :: 		DegC.Deg_Sp = DegSP_last;
	MOVF        main_DegSP_last_L1+0, 0 
	MOVWF       _DegC+6 
	MOVF        main_DegSP_last_L1+1, 0 
	MOVWF       _DegC+7 
;ReflowOven.c,91 :: 		TempTicPlaceholder_last = -1;
	MOVLW       255
	MOVWF       ReflowOven_TempTicPlaceholder_last+0 
	MOVLW       255
	MOVWF       ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,92 :: 		tmr.MinNew = -1;
	MOVLW       255
	MOVWF       _tmr+18 
	MOVLW       255
	MOVWF       _tmr+19 
;ReflowOven.c,93 :: 		if(!Ok_Bit){
	BTFSC       _OK_Bit+0, BitPos(_OK_Bit+0) 
	GOTO        L_main10
;ReflowOven.c,94 :: 		SetPtSet = on;
	BSF         _Bits+0, 0 
;ReflowOven.c,95 :: 		RstTmr = on;
	BSF         _Bits+0, 2 
;ReflowOven.c,96 :: 		}
L_main10:
;ReflowOven.c,97 :: 		}
L_main9:
;ReflowOven.c,99 :: 		if (!Menu_Bit && Button(&PORTA, 2, 100, 0)){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main13
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
	GOTO        L_main13
L__main98:
;ReflowOven.c,100 :: 		fp = on;
	BSF         main_fp_L1+0, BitPos(main_fp_L1+0) 
;ReflowOven.c,101 :: 		DegSP_last = DegC.Deg_Sp;
	MOVF        _DegC+6, 0 
	MOVWF       main_DegSP_last_L1+0 
	MOVF        _DegC+7, 0 
	MOVWF       main_DegSP_last_L1+1 
;ReflowOven.c,102 :: 		RstEntryBits();
	CALL        _RstEntryBits+0, 0
;ReflowOven.c,103 :: 		Menu_Bit = on;
	BSF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;ReflowOven.c,104 :: 		while(!RA2_bit);
L_main14:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_main15
	GOTO        L_main14
L_main15:
;ReflowOven.c,105 :: 		}
L_main13:
;ReflowOven.c,110 :: 		if((RA3_Bit)&&(!FinCycle))
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main18
	BTFSC       _Bits+0, 3 
	GOTO        L_main18
L__main97:
;ReflowOven.c,111 :: 		DoTime();
	CALL        _DoTime+0, 0
L_main18:
;ReflowOven.c,116 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main19
;ReflowOven.c,119 :: 		if(tmr.SecNew != tmr.sec){
	MOVF        _tmr+17, 0 
	XORWF       _tmr+11, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVF        _tmr+10, 0 
	XORWF       _tmr+16, 0 
L__main103:
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;ReflowOven.c,120 :: 		sprintf(txt2,"%-2d",tmr.sec);
	MOVLW       _txt2+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_5_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_5_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_5_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _tmr+10, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _tmr+11, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,121 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       14
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt2+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,122 :: 		tmr.SecNew = tmr.sec;
	MOVF        _tmr+10, 0 
	MOVWF       _tmr+16 
	MOVF        _tmr+11, 0 
	MOVWF       _tmr+17 
;ReflowOven.c,123 :: 		}
L_main20:
;ReflowOven.c,126 :: 		if(tmr.MinNew != tmr.min){
	MOVF        _tmr+19, 0 
	XORWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        _tmr+12, 0 
	XORWF       _tmr+18, 0 
L__main104:
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
;ReflowOven.c,127 :: 		tmr.MinNew = tmr.min;
	MOVF        _tmr+12, 0 
	MOVWF       _tmr+18 
	MOVF        _tmr+13, 0 
	MOVWF       _tmr+19 
;ReflowOven.c,128 :: 		if(tmr.min>=1){
	MOVLW       0
	SUBWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVLW       1
	SUBWF       _tmr+12, 0 
L__main105:
	BTFSS       STATUS+0, 0 
	GOTO        L_main22
;ReflowOven.c,129 :: 		sprintf(txt3,"%3d",tmr.min);
	MOVLW       _txt3+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _tmr+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _tmr+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,130 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,10,txt3);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       10
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt3+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,131 :: 		}else
	GOTO        L_main23
L_main22:
;ReflowOven.c,132 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,10,"  0");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       10
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr7_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr7_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
L_main23:
;ReflowOven.c,134 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,13,":");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       13
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr8_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr8_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,135 :: 		}
L_main21:
;ReflowOven.c,137 :: 		if(TempTicPlaceholder_last != TempTicPlaceholder){
	MOVF        ReflowOven_TempTicPlaceholder_last+1, 0 
	XORWF       main_TempTicPlaceholder_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	XORWF       ReflowOven_TempTicPlaceholder_last+0, 0 
L__main106:
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
;ReflowOven.c,138 :: 		TempTicPlaceholder_last = TempTicPlaceholder;
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	MOVWF       ReflowOven_TempTicPlaceholder_last+0 
	MOVF        main_TempTicPlaceholder_L1+1, 0 
	MOVWF       ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,139 :: 		sprintf(txt4,"%4d",TempTicPlaceholder); //Phase counter
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_9_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_9_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_9_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_TempTicPlaceholder_L1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,140 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,12,"'C+:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       12
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr10_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr10_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,141 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,17,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       17
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,142 :: 		sprintf(txt4,"%4d",TempDegPlaceholder); //Phase counter
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_11_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_11_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_11_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_TempDegPlaceholder_L1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_TempDegPlaceholder_L1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,143 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,12,"Spt:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       12
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr12_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr12_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,144 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,17,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       17
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,145 :: 		}
L_main24:
;ReflowOven.c,148 :: 		if(!SetPtSet){
	BTFSC       _Bits+0, 0 
	GOTO        L_main25
;ReflowOven.c,149 :: 		SetPtSet = on;
	BSF         _Bits+0, 0 
;ReflowOven.c,150 :: 		DegC.Deg_Sp = DegC.Temp_iPv;
	MOVF        _DegC+16, 0 
	MOVWF       _DegC+6 
	MOVF        _DegC+17, 0 
	MOVWF       _DegC+7 
;ReflowOven.c,151 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,152 :: 		if(!FinCycle){
	BTFSC       _Bits+0, 3 
	GOTO        L_main26
;ReflowOven.c,153 :: 		WriteStart();
	CALL        _WriteStart+0, 0
;ReflowOven.c,154 :: 		}
L_main26:
;ReflowOven.c,155 :: 		}
L_main25:
;ReflowOven.c,157 :: 		if(RA3_Bit){
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main27
;ReflowOven.c,159 :: 		if(OFF_Bit){
	BTFSS       _OFF_Bit+0, BitPos(_OFF_Bit+0) 
	GOTO        L_main28
;ReflowOven.c,160 :: 		FinCycle = on;
	BSF         _Bits+0, 3 
;ReflowOven.c,161 :: 		SetCoolBit = on;
	BSF         _Bits+0, 1 
;ReflowOven.c,162 :: 		OFF_Bit = off;
	BCF         _OFF_Bit+0, BitPos(_OFF_Bit+0) 
;ReflowOven.c,163 :: 		}
L_main28:
;ReflowOven.c,165 :: 		if(!RstTmr){
	BTFSC       _Bits+0, 2 
	GOTO        L_main29
;ReflowOven.c,166 :: 		RstTmr = on;
	BSF         _Bits+0, 2 
;ReflowOven.c,167 :: 		FinCycle = off;
	BCF         _Bits+0, 3 
;ReflowOven.c,168 :: 		SetPtSet = off;
	BCF         _Bits+0, 0 
;ReflowOven.c,169 :: 		SetCoolBit = off;
	BCF         _Bits+0, 1 
;ReflowOven.c,170 :: 		Ok_Bit = off;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,171 :: 		tmr.MinNew = -1;
	MOVLW       255
	MOVWF       _tmr+18 
	MOVLW       255
	MOVWF       _tmr+19 
;ReflowOven.c,172 :: 		TempTicPlaceholder_last = 0;
	CLRF        ReflowOven_TempTicPlaceholder_last+0 
	CLRF        ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,173 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;ReflowOven.c,174 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;ReflowOven.c,175 :: 		}
L_main29:
;ReflowOven.c,176 :: 		if(Ok_Bit){
	BTFSS       _OK_Bit+0, BitPos(_OK_Bit+0) 
	GOTO        L_main30
;ReflowOven.c,177 :: 		RstTmr = off;
	BCF         _Bits+0, 2 
;ReflowOven.c,178 :: 		}
L_main30:
;ReflowOven.c,181 :: 		if((DegC.Deg_Sp < Sps.RmpDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main107
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main107:
	BTFSC       STATUS+0, 0 
	GOTO        L_main33
	BTFSC       _Bits+0, 1 
	GOTO        L_main33
L__main96:
;ReflowOven.c,182 :: 		if (SetCoolBit)SetCoolBit = off;
	BTFSS       _Bits+0, 1 
	GOTO        L_main34
	BCF         _Bits+0, 1 
L_main34:
;ReflowOven.c,183 :: 		TempDegPlaceholder = Sps.RmpDeg;
	MOVF        _Sps+0, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+1, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,184 :: 		TempTicPlaceholder = TempTicks.RampTick;
	MOVF        _TempTicks+2, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,185 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ramp");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr13_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr13_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,186 :: 		sprintf(txt6,"%3u",Sps.RmpDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_14_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_14_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_14_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,187 :: 		}
	GOTO        L_main35
L_main33:
;ReflowOven.c,188 :: 		else if((DegC.Deg_Sp >= Sps.RmpDeg)&&(DegC.Deg_Sp < Sps.SokDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main108
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main108:
	BTFSS       STATUS+0, 0 
	GOTO        L_main38
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main109
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main109:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	BTFSC       _Bits+0, 1 
	GOTO        L_main38
L__main95:
;ReflowOven.c,189 :: 		TempDegPlaceholder = Sps.SokDeg;
	MOVF        _Sps+4, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+5, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,190 :: 		TempTicPlaceholder = TempTicks.SoakTick;
	MOVF        _TempTicks+4, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,191 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Soak");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr15_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr15_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,192 :: 		sprintf(txt6,"%3u",Sps.SokDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_16_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_16_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_16_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,193 :: 		}
	GOTO        L_main39
L_main38:
;ReflowOven.c,194 :: 		else if((DegC.Deg_Sp >= Sps.SokDeg)&&(DegC.Deg_Sp < Sps.SpkeDeg)&&(!SetCoolBit)){
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main110
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main110:
	BTFSS       STATUS+0, 0 
	GOTO        L_main42
	MOVF        _Sps+9, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main111
	MOVF        _Sps+8, 0 
	SUBWF       _DegC+6, 0 
L__main111:
	BTFSC       STATUS+0, 0 
	GOTO        L_main42
	BTFSC       _Bits+0, 1 
	GOTO        L_main42
L__main94:
;ReflowOven.c,195 :: 		TempDegPlaceholder = Sps.SpkeDeg;
	MOVF        _Sps+8, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+9, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,196 :: 		TempTicPlaceholder = TempTicks.SpikeTick;
	MOVF        _TempTicks+6, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,197 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Spke");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr17_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr17_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,198 :: 		sprintf(txt6,"%3u",Sps.SpkeDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_18_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_18_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_18_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,199 :: 		}
	GOTO        L_main43
L_main42:
;ReflowOven.c,201 :: 		SetCoolBit = on;
	BSF         _Bits+0, 1 
;ReflowOven.c,202 :: 		TempTicPlaceholder = TempTicks.CoolTick;
	MOVF        _TempTicks+8, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,203 :: 		TempDegPlaceholder = Sps.CoolOffDeg;
	MOVF        _Sps+12, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+13, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,204 :: 		if(!FinCycle)I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Cool");
	BTFSC       _Bits+0, 3 
	GOTO        L_main44
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr19_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr19_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
	GOTO        L_main45
L_main44:
;ReflowOven.c,205 :: 		else I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Finn");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr20_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr20_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
L_main45:
;ReflowOven.c,206 :: 		if(DegC.Deg_Sp < Sps.CoolOffDeg)FinCycle = on;
	MOVF        _Sps+13, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main112
	MOVF        _Sps+12, 0 
	SUBWF       _DegC+6, 0 
L__main112:
	BTFSC       STATUS+0, 0 
	GOTO        L_main46
	BSF         _Bits+0, 3 
L_main46:
;ReflowOven.c,207 :: 		}
L_main43:
L_main39:
L_main35:
;ReflowOven.c,209 :: 		if(tmr.tenMilli > TempTicPlaceholder){
	MOVF        _tmr+5, 0 
	SUBWF       main_TempTicPlaceholder_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main113
	MOVF        _tmr+4, 0 
	SUBWF       main_TempTicPlaceholder_L1+0, 0 
L__main113:
	BTFSC       STATUS+0, 0 
	GOTO        L_main47
;ReflowOven.c,210 :: 		tmr.tenMilli = 0;         //rest tick
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,211 :: 		TempTicks.tickActual++;   //keep track of ticks ??
	MOVLW       1
	ADDWF       _TempTicks+10, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _TempTicks+11, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _TempTicks+10 
	MOVF        R1, 0 
	MOVWF       _TempTicks+11 
;ReflowOven.c,212 :: 		if((SetPtSet)&&(!FinCycle)){
	BTFSS       _Bits+0, 0 
	GOTO        L_main50
	BTFSC       _Bits+0, 3 
	GOTO        L_main50
L__main93:
;ReflowOven.c,213 :: 		if(!SetCoolBit)DegC.Deg_Sp++;
	BTFSC       _Bits+0, 1 
	GOTO        L_main51
	MOVLW       1
	ADDWF       _DegC+6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _DegC+7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _DegC+6 
	MOVF        R1, 0 
	MOVWF       _DegC+7 
	GOTO        L_main52
L_main51:
;ReflowOven.c,214 :: 		else DegC.Deg_Sp--;
	MOVLW       1
	SUBWF       _DegC+6, 0 
	MOVWF       R0 
	MOVLW       0
	SUBWFB      _DegC+7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _DegC+6 
	MOVF        R1, 0 
	MOVWF       _DegC+7 
L_main52:
;ReflowOven.c,215 :: 		}
L_main50:
;ReflowOven.c,217 :: 		if(DegC.LastDeg != DegC.Deg_Sp){
	MOVF        _DegC+11, 0 
	XORWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main114
	MOVF        _DegC+6, 0 
	XORWF       _DegC+10, 0 
L__main114:
	BTFSC       STATUS+0, 2 
	GOTO        L_main53
;ReflowOven.c,218 :: 		sprintf(txt1,"%4d",DegC.Deg_Sp);
	MOVLW       _txt1+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_21_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_21_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_21_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,219 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,1,"Deg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr22_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr22_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,220 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,txt1);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       6
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt1+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,221 :: 		DegC.LastDeg = DegC.Deg_Sp;
	MOVF        _DegC+6, 0 
	MOVWF       _DegC+10 
	MOVF        _DegC+7, 0 
	MOVWF       _DegC+11 
;ReflowOven.c,222 :: 		}
L_main53:
;ReflowOven.c,224 :: 		}
L_main47:
;ReflowOven.c,225 :: 		}else{
	GOTO        L_main54
L_main27:
;ReflowOven.c,226 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Off ");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr23_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr23_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,227 :: 		SetCoolBit = off;
	BCF         _Bits+0, 1 
;ReflowOven.c,228 :: 		tmr.tenMilli = 0;
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,229 :: 		TempTicks.tickActual = 0;
	CLRF        _TempTicks+10 
	CLRF        _TempTicks+11 
;ReflowOven.c,230 :: 		SetPtSet = off;
	BCF         _Bits+0, 0 
;ReflowOven.c,231 :: 		RstTmr = off;
	BCF         _Bits+0, 2 
;ReflowOven.c,232 :: 		Ok_Bit = off;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,233 :: 		}
L_main54:
;ReflowOven.c,234 :: 		}
L_main19:
;ReflowOven.c,241 :: 		switch(Phs.PhaseCntr){
	GOTO        L_main55
;ReflowOven.c,242 :: 		case 1:  //pid output to ccp module for pHase control
L_main57:
;ReflowOven.c,243 :: 		Phs.an0_ = (unsigned int)pid_t.Mv;// ADC_Read(0);
	MOVF        _pid_t+20, 0 
	MOVWF       _Phs+6 
	MOVF        _pid_t+21, 0 
	MOVWF       _Phs+7 
;ReflowOven.c,244 :: 		if(Phs.an0_ < 1)Phs.an0_ = 1;
	MOVLW       0
	SUBWF       _pid_t+21, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main115
	MOVLW       1
	SUBWF       _pid_t+20, 0 
L__main115:
	BTFSC       STATUS+0, 0 
	GOTO        L_main58
	MOVLW       1
	MOVWF       _Phs+6 
	MOVLW       0
	MOVWF       _Phs+7 
L_main58:
;ReflowOven.c,245 :: 		Phs.an0_ = RevADC - Phs.an0_;
	MOVF        _Phs+6, 0 
	SUBLW       243
	MOVWF       R1 
	MOVF        _Phs+7, 0 
	MOVWF       R2 
	MOVLW       3
	SUBFWB      R2, 1 
	MOVF        R1, 0 
	MOVWF       _Phs+6 
	MOVF        R2, 0 
	MOVWF       _Phs+7 
;ReflowOven.c,246 :: 		if(Phs.an0_ >= 1010)Phs.an0_ = 1010;
	MOVLW       3
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main116
	MOVLW       242
	SUBWF       R1, 0 
L__main116:
	BTFSS       STATUS+0, 0 
	GOTO        L_main59
	MOVLW       242
	MOVWF       _Phs+6 
	MOVLW       3
	MOVWF       _Phs+7 
L_main59:
;ReflowOven.c,247 :: 		break;
	GOTO        L_main56
;ReflowOven.c,248 :: 		case 2:  //pid output ccp for servo control
L_main60:
;ReflowOven.c,250 :: 		Phs.an1_ = ServoSub + pid_t.Mv;//Phs.an1_;
	MOVLW       220
	ADDWF       _pid_t+20, 0 
	MOVWF       R1 
	MOVLW       5
	ADDWFC      _pid_t+21, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       _Phs+14 
	MOVF        R2, 0 
	MOVWF       _Phs+15 
;ReflowOven.c,251 :: 		if(Phs.an1_ > 1500)Phs.an1_ = 1500;
	MOVF        R2, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__main117
	MOVF        R1, 0 
	SUBLW       220
L__main117:
	BTFSC       STATUS+0, 0 
	GOTO        L_main61
	MOVLW       220
	MOVWF       _Phs+14 
	MOVLW       5
	MOVWF       _Phs+15 
L_main61:
;ReflowOven.c,252 :: 		break;
	GOTO        L_main56
;ReflowOven.c,253 :: 		case 3:  //hardware multiplier
L_main62:
;ReflowOven.c,254 :: 		if(Phs.olDan0_ != Phs.an0_){
	MOVF        _Phs+9, 0 
	XORWF       _Phs+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main118
	MOVF        _Phs+6, 0 
	XORWF       _Phs+8, 0 
L__main118:
	BTFSC       STATUS+0, 2 
	GOTO        L_main63
;ReflowOven.c,255 :: 		Phs.an0_0 = (unsigned int)S_HWMul(Phs.an0_,mulFact);
	MOVF        _Phs+6, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Phs+7, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       18
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Phs+12 
	MOVF        R1, 0 
	MOVWF       _Phs+13 
;ReflowOven.c,258 :: 		Phs.olDan0_ = Phs.an0_;
	MOVF        _Phs+6, 0 
	MOVWF       _Phs+8 
	MOVF        _Phs+7, 0 
	MOVWF       _Phs+9 
;ReflowOven.c,259 :: 		}
L_main63:
;ReflowOven.c,261 :: 		break;
	GOTO        L_main56
;ReflowOven.c,262 :: 		case 4:  //hardware multiplier
L_main64:
;ReflowOven.c,263 :: 		if(Phs.olDan1_ != Phs.an1_){
	MOVF        _Phs+17, 0 
	XORWF       _Phs+15, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main119
	MOVF        _Phs+14, 0 
	XORWF       _Phs+16, 0 
L__main119:
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
;ReflowOven.c,264 :: 		Phs.an1_1 = (unsigned int)S_HWMul(Phs.an1_,ServoPls);
	MOVF        _Phs+14, 0 
	MOVWF       FARG_S_HWMul_valA+0 
	MOVF        _Phs+15, 0 
	MOVWF       FARG_S_HWMul_valA+1 
	MOVLW       4
	MOVWF       FARG_S_HWMul_valB+0 
	MOVLW       0
	MOVWF       FARG_S_HWMul_valB+1 
	CALL        _S_HWMul+0, 0
	MOVF        R0, 0 
	MOVWF       _Phs+20 
	MOVF        R1, 0 
	MOVWF       _Phs+21 
;ReflowOven.c,267 :: 		Phs.olDan1_ = Phs.an1_;
	MOVF        _Phs+14, 0 
	MOVWF       _Phs+16 
	MOVF        _Phs+15, 0 
	MOVWF       _Phs+17 
;ReflowOven.c,268 :: 		}
L_main65:
;ReflowOven.c,269 :: 		break;
	GOTO        L_main56
;ReflowOven.c,270 :: 		case 5: // spi call to temp chip
L_main66:
;ReflowOven.c,271 :: 		if(!TempBit){
	BTFSC       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main67
;ReflowOven.c,272 :: 		DegC.sampleTimer++;
	MOVF        _DegC+21, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _DegC+21 
;ReflowOven.c,273 :: 		TempBit = on;
	BSF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
;ReflowOven.c,274 :: 		if(DegC.sampleTimer == DegC.SampleTmrSP){
	MOVF        _DegC+21, 0 
	XORWF       _DegC+22, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main68
;ReflowOven.c,275 :: 		DegC.Temp_fPv = ReadMax31855J();
	CALL        _ReadMax31855J+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+12 
	MOVF        R1, 0 
	MOVWF       _DegC+13 
	MOVF        R2, 0 
	MOVWF       _DegC+14 
	MOVF        R3, 0 
	MOVWF       _DegC+15 
;ReflowOven.c,276 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main69
;ReflowOven.c,277 :: 		DegC.Temp_iPv = (int)DegC.Temp_fPv;
	MOVF        _DegC+12, 0 
	MOVWF       R0 
	MOVF        _DegC+13, 0 
	MOVWF       R1 
	MOVF        _DegC+14, 0 
	MOVWF       R2 
	MOVF        _DegC+15, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+16 
	MOVF        R1, 0 
	MOVWF       _DegC+17 
;ReflowOven.c,278 :: 		sprintf(txt5,"%3.2f",DegC.Temp_fPv); //DegC.Temp_
	MOVLW       _txt5+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_24_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_24_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_24_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _DegC+14, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _DegC+15, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;ReflowOven.c,279 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr25_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr25_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,280 :: 		strcat(txt5, "'C");
	MOVLW       _txt5+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr26_ReflowOven+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr26_ReflowOven+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;ReflowOven.c,281 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       5
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt5+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,282 :: 		sprintf(txt5,"%3d",DegC.Temp_iPv); //DegC.Temp_
	MOVLW       _txt5+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_27_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_27_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_27_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+16, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,283 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,13,"iC:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       13
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr28_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr28_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,285 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,18,txt5);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       18
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt5+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,286 :: 		}
L_main69:
;ReflowOven.c,287 :: 		}
L_main68:
;ReflowOven.c,288 :: 		}
L_main67:
;ReflowOven.c,289 :: 		break;
	GOTO        L_main56
;ReflowOven.c,290 :: 		case 6://calculate Temp and display
L_main70:
;ReflowOven.c,291 :: 		if(!pidBit){
	BTFSC       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main71
;ReflowOven.c,292 :: 		pid_t.sample_tmr++;
	MOVF        _pid_t+32, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pid_t+32 
;ReflowOven.c,293 :: 		pidBit = on;
	BSF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
;ReflowOven.c,294 :: 		if(pid_t.sample_tmr == pid_t.Kt){
	MOVF        _pid_t+32, 0 
	XORWF       _pid_t+33, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main72
;ReflowOven.c,296 :: 		if(!FinCycle)
	BTFSC       _Bits+0, 3 
	GOTO        L_main73
;ReflowOven.c,297 :: 		PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
	MOVLW       _pid_t+0
	MOVWF       FARG_PID_Calc_PID_t+0 
	MOVLW       hi_addr(_pid_t+0)
	MOVWF       FARG_PID_Calc_PID_t+1 
	MOVF        _DegC+6, 0 
	MOVWF       FARG_PID_Calc_Sp+0 
	MOVF        _DegC+7, 0 
	MOVWF       FARG_PID_Calc_Sp+1 
	MOVF        _DegC+16, 0 
	MOVWF       FARG_PID_Calc_Pv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_PID_Calc_Pv+1 
	CALL        _PID_Calc+0, 0
	GOTO        L_main74
L_main73:
;ReflowOven.c,299 :: 		pid_t.Mv = 0;
	CLRF        _pid_t+20 
	CLRF        _pid_t+21 
L_main74:
;ReflowOven.c,301 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main75
;ReflowOven.c,302 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Mv:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr29_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr29_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,303 :: 		sprintf(txt4,"%4d",pid_t.Mv);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_30_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_30_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_30_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+20, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+21, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,304 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,5,txt4);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       5
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt4+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,305 :: 		}
L_main75:
;ReflowOven.c,307 :: 		}
L_main72:
;ReflowOven.c,308 :: 		}
L_main71:
;ReflowOven.c,309 :: 		break;
	GOTO        L_main56
;ReflowOven.c,310 :: 		case 7:   //write data out to pc every 70*4 ms
L_main76:
;ReflowOven.c,311 :: 		Phs.UartWriter++;
	MOVF        _Phs+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Phs+0 
;ReflowOven.c,312 :: 		if(Phs.UartWriter == Sps.SerialWriteDly){
	MOVF        _Phs+0, 0 
	XORWF       _Sps+17, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L_main77
;ReflowOven.c,313 :: 		if(!WriteData){
	BTFSC       _Bits+0, 4 
	GOTO        L_main78
;ReflowOven.c,314 :: 		WriteData = on;
	BSF         _Bits+0, 4 
;ReflowOven.c,315 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,316 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,317 :: 		UART1_Write_Text(txt5);
	MOVLW       _txt5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,318 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,319 :: 		UART1_Write_Text(txt6);
	MOVLW       _txt6+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,320 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,321 :: 		UART1_Write_Text(txt4);
	MOVLW       _txt4+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,322 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,323 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,325 :: 		if(FinCycle)
	BTFSS       _Bits+0, 3 
	GOTO        L_main79
;ReflowOven.c,326 :: 		WriteFin();
	CALL        _WriteFin+0, 0
L_main79:
;ReflowOven.c,327 :: 		}
L_main78:
;ReflowOven.c,328 :: 		}
L_main77:
;ReflowOven.c,329 :: 		break;
	GOTO        L_main56
;ReflowOven.c,330 :: 		default:
L_main80:
;ReflowOven.c,331 :: 		if((Phs.UartWriter > Sps.SerialWriteDly)&&(!FinCycle)){
	MOVF        _Phs+0, 0 
	SUBWF       _Sps+17, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_main83
	BTFSC       _Bits+0, 3 
	GOTO        L_main83
L__main92:
;ReflowOven.c,332 :: 		Phs.UartWriter = 0;
	CLRF        _Phs+0 
;ReflowOven.c,333 :: 		WriteData = off;
	BCF         _Bits+0, 4 
;ReflowOven.c,334 :: 		}
L_main83:
;ReflowOven.c,335 :: 		if(DegC.sampleTimer >= DegC.SampleTmrSP)DegC.sampleTimer = 0;
	MOVF        _DegC+22, 0 
	SUBWF       _DegC+21, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main84
	CLRF        _DegC+21 
L_main84:
;ReflowOven.c,336 :: 		if(pid_t.sample_tmr >= pid_t.Kt)pid_t.sample_tmr = 0;
	MOVLW       128
	XORWF       _pid_t+32, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pid_t+33, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main85
	CLRF        _pid_t+32 
L_main85:
;ReflowOven.c,337 :: 		if(TempBit)TempBit = off;
	BTFSS       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main86
	BCF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
L_main86:
;ReflowOven.c,338 :: 		if(pidBit) pidBit = off;
	BTFSS       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main87
	BCF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
L_main87:
;ReflowOven.c,339 :: 		Phs.PhaseCntr = 1;
	MOVLW       1
	MOVWF       _Phs+2 
;ReflowOven.c,340 :: 		break;
	GOTO        L_main56
;ReflowOven.c,341 :: 		}
L_main55:
	MOVF        _Phs+2, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVF        _Phs+2, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVF        _Phs+2, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
	MOVF        _Phs+2, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
	MOVF        _Phs+2, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
	MOVF        _Phs+2, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main70
	MOVF        _Phs+2, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_main76
	GOTO        L_main80
L_main56:
;ReflowOven.c,343 :: 		}
	GOTO        L_main2
;ReflowOven.c,345 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_HighPriority:

;ReflowOven.c,350 :: 		void HighPriority() iv 0x0008 ics ICS_AUTO {
;ReflowOven.c,351 :: 		High_Priority();
	CALL        _High_Priority+0, 0
;ReflowOven.c,352 :: 		}
L_end_HighPriority:
L__HighPriority121:
	RETFIE      1
; end of _HighPriority

_LowPriority:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;ReflowOven.c,354 :: 		void LowPriority() iv 0x0018 ics ICS_AUTO {
;ReflowOven.c,355 :: 		Low_Priority();
	CALL        _Low_Priority+0, 0
;ReflowOven.c,356 :: 		}
L_end_LowPriority:
L__LowPriority123:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _LowPriority

_RstLocals:

;ReflowOven.c,358 :: 		void RstLocals(){
;ReflowOven.c,359 :: 		TempTicPlaceholder_last = 0;
	CLRF        ReflowOven_TempTicPlaceholder_last+0 
	CLRF        ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,360 :: 		Bits = 0;
	CLRF        _Bits+0 
;ReflowOven.c,361 :: 		SetPtSet = 0;
	BCF         _Bits+0, 0 
;ReflowOven.c,362 :: 		RstTmr = 0;
	BCF         _Bits+0, 2 
;ReflowOven.c,363 :: 		}
L_end_RstLocals:
	RETURN      0
; end of _RstLocals

_I2C1_TimeoutCallback:

;ReflowOven.c,366 :: 		void I2C1_TimeoutCallback(char errorCode) {
;ReflowOven.c,368 :: 		if (errorCode == _I2C_TIMEOUT_RD) {
	MOVF        FARG_I2C1_TimeoutCallback_errorCode+0, 0 
	XORLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback88
;ReflowOven.c,369 :: 		return;
	GOTO        L_end_I2C1_TimeoutCallback
;ReflowOven.c,370 :: 		}
L_I2C1_TimeoutCallback88:
;ReflowOven.c,372 :: 		if (errorCode == _I2C_TIMEOUT_WR) {
	MOVF        FARG_I2C1_TimeoutCallback_errorCode+0, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback89
;ReflowOven.c,374 :: 		LATC5_bit = !LATC5_bit;
	BTG         LATC5_bit+0, BitPos(LATC5_bit+0) 
;ReflowOven.c,375 :: 		return;
	GOTO        L_end_I2C1_TimeoutCallback
;ReflowOven.c,376 :: 		}
L_I2C1_TimeoutCallback89:
;ReflowOven.c,378 :: 		if (errorCode == _I2C_TIMEOUT_START) {
	MOVF        FARG_I2C1_TimeoutCallback_errorCode+0, 0 
	XORLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback90
;ReflowOven.c,380 :: 		LATC5_bit = on;
	BSF         LATC5_bit+0, BitPos(LATC5_bit+0) 
;ReflowOven.c,381 :: 		return;
	GOTO        L_end_I2C1_TimeoutCallback
;ReflowOven.c,383 :: 		}
L_I2C1_TimeoutCallback90:
;ReflowOven.c,385 :: 		if (errorCode == _I2C_TIMEOUT_REPEATED_START) {
	MOVF        FARG_I2C1_TimeoutCallback_errorCode+0, 0 
	XORLW       6
	BTFSS       STATUS+0, 2 
	GOTO        L_I2C1_TimeoutCallback91
;ReflowOven.c,387 :: 		}
L_I2C1_TimeoutCallback91:
;ReflowOven.c,388 :: 		}
L_end_I2C1_TimeoutCallback:
	RETURN      0
; end of _I2C1_TimeoutCallback
