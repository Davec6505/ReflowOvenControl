
_main:

;ReflowOven.c,48 :: 		void main() {
;ReflowOven.c,50 :: 		I2Cxx = I2C1;
	MOVLW       1
	MOVWF       _I2Cxx+0 
	MOVLW       0
	MOVWF       _I2Cxx+1 
;ReflowOven.c,51 :: 		ConfPic();
	CALL        _ConfPic+0, 0
;ReflowOven.c,52 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;ReflowOven.c,53 :: 		UART1_Init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       138
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ReflowOven.c,55 :: 		I2C1_Init(100000);//INIT I2C AT 100KHZ  Delay_ms(100); // I2C1_SetTimeoutCallback(1000,&test);    // enable error flag for I2C1 test
	MOVLW       160
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;ReflowOven.c,56 :: 		I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle); // Sets the I2C1 module active
	MOVLW       _I2C1_Start+0
	MOVWF       FARG_I2C_Set_Active_start_ptr+0 
	MOVLW       hi_addr(_I2C1_Start+0)
	MOVWF       FARG_I2C_Set_Active_start_ptr+1 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_start_ptr+2 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_start_ptr+3 
	MOVLW       _I2C1_Repeated_Start+0
	MOVWF       FARG_I2C_Set_Active_restart_ptr+0 
	MOVLW       hi_addr(_I2C1_Repeated_Start+0)
	MOVWF       FARG_I2C_Set_Active_restart_ptr+1 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_restart_ptr+2 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_restart_ptr+3 
	MOVLW       _I2C1_Rd+0
	MOVWF       FARG_I2C_Set_Active_read_ptr+0 
	MOVLW       hi_addr(_I2C1_Rd+0)
	MOVWF       FARG_I2C_Set_Active_read_ptr+1 
	MOVLW       FARG_I2C1_Rd_ack+0
	MOVWF       FARG_I2C_Set_Active_read_ptr+2 
	MOVLW       hi_addr(FARG_I2C1_Rd_ack+0)
	MOVWF       FARG_I2C_Set_Active_read_ptr+3 
	MOVLW       _I2C1_Wr+0
	MOVWF       FARG_I2C_Set_Active_write_ptr+0 
	MOVLW       hi_addr(_I2C1_Wr+0)
	MOVWF       FARG_I2C_Set_Active_write_ptr+1 
	MOVLW       FARG_I2C1_Wr_data_+0
	MOVWF       FARG_I2C_Set_Active_write_ptr+2 
	MOVLW       hi_addr(FARG_I2C1_Wr_data_+0)
	MOVWF       FARG_I2C_Set_Active_write_ptr+3 
	MOVLW       _I2C1_Stop+0
	MOVWF       FARG_I2C_Set_Active_stop_ptr+0 
	MOVLW       hi_addr(_I2C1_Stop+0)
	MOVWF       FARG_I2C_Set_Active_stop_ptr+1 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_stop_ptr+2 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_stop_ptr+3 
	MOVLW       _I2C1_Is_Idle+0
	MOVWF       FARG_I2C_Set_Active_is_idle_ptr+0 
	MOVLW       hi_addr(_I2C1_Is_Idle+0)
	MOVWF       FARG_I2C_Set_Active_is_idle_ptr+1 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_is_idle_ptr+2 
	MOVLW       0
	MOVWF       FARG_I2C_Set_Active_is_idle_ptr+3 
	CALL        _I2C_Set_Active+0, 0
;ReflowOven.c,57 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
;ReflowOven.c,60 :: 		EERead();
	CALL        _EERead+0, 0
;ReflowOven.c,61 :: 		PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-900,'+',_PID);
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
;ReflowOven.c,62 :: 		Uart1_En();
	CALL        _Uart1_En+0, 0
;ReflowOven.c,63 :: 		Set_Priority();
	CALL        _Set_Priority+0, 0
;ReflowOven.c,64 :: 		ConfigSpi();
	CALL        _ConfigSpi+0, 0
;ReflowOven.c,65 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;ReflowOven.c,66 :: 		InitTimer1();
	CALL        _InitTimer1+0, 0
;ReflowOven.c,68 :: 		InitTimer3();
	CALL        _InitTimer3+0, 0
;ReflowOven.c,69 :: 		InitTimer5();
	CALL        _InitTimer5+0, 0
;ReflowOven.c,70 :: 		SetUp_IOCxInterrupts();
	CALL        _SetUp_IOCxInterrupts+0, 0
;ReflowOven.c,71 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ReflowOven.c,72 :: 		ClearAll();
	CALL        _ClearAll+0, 0
;ReflowOven.c,74 :: 		I2C_LCD_init(LCD_01_ADDRESS,_2Line);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_init_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_init_DispLines+0 
	CALL        _I2C_LCD_init+0, 0
;ReflowOven.c,75 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
;ReflowOven.c,76 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);          // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,77 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);     // Cursor off
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       7
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,79 :: 		Delay_ms(2000);
	MOVLW       163
	MOVWF       R11, 0
	MOVLW       87
	MOVWF       R12, 0
	MOVLW       2
	MOVWF       R13, 0
L_main2:
	DECFSZ      R13, 1, 1
	BRA         L_main2
	DECFSZ      R12, 1, 1
	BRA         L_main2
	DECFSZ      R11, 1, 1
	BRA         L_main2
	NOP
;ReflowOven.c,80 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);//Lcd_Cmd(0,0x01);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,81 :: 		Delay_ms(200);
	MOVLW       17
	MOVWF       R11, 0
	MOVLW       60
	MOVWF       R12, 0
	MOVLW       203
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
;ReflowOven.c,82 :: 		EI();
	CALL        _EI+0, 0
;ReflowOven.c,83 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_main4:
	DECFSZ      R13, 1, 1
	BRA         L_main4
	DECFSZ      R12, 1, 1
	BRA         L_main4
	DECFSZ      R11, 1, 1
	BRA         L_main4
	NOP
;ReflowOven.c,84 :: 		wait = off;
	BCF         _wait+0, BitPos(_wait+0) 
;ReflowOven.c,85 :: 		DegC.Temp_iPv = 0;
	CLRF        _DegC+16 
	CLRF        _DegC+17 
;ReflowOven.c,86 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;ReflowOven.c,87 :: 		Bits = 0;
	CLRF        ReflowOven_Bits+0 
;ReflowOven.c,88 :: 		Menu_Bit = 0;
	BCF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;ReflowOven.c,89 :: 		Ok_Bit = 0;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,90 :: 		CalcTimerTicks(0);
	CLRF        FARG_CalcTimerTicks_iPv+0 
	CLRF        FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,91 :: 		TempTicPlaceholder_last = 0;
	CLRF        ReflowOven_TempTicPlaceholder_last+0 
	CLRF        ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,92 :: 		while(1){
L_main5:
;ReflowOven.c,98 :: 		LATB5_bit  = Menu_Bit;
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L__main88
	BCF         LATB5_bit+0, BitPos(LATB5_bit+0) 
	GOTO        L__main89
L__main88:
	BSF         LATB5_bit+0, BitPos(LATB5_bit+0) 
L__main89:
;ReflowOven.c,100 :: 		if(Menu_Bit)
	BTFSS       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main7
;ReflowOven.c,101 :: 		SampleButtons();
	CALL        _SampleButtons+0, 0
L_main7:
;ReflowOven.c,103 :: 		if (!Menu_Bit && Button(&PORTA, 2, 100, 0)){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main10
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
	GOTO        L_main10
L__main86:
;ReflowOven.c,104 :: 		RstEntryBits();
	CALL        _RstEntryBits+0, 0
;ReflowOven.c,105 :: 		Menu_Bit = on;
	BSF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;ReflowOven.c,106 :: 		while(!RA2_bit);
L_main11:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_main12
	GOTO        L_main11
L_main12:
;ReflowOven.c,107 :: 		}
L_main10:
;ReflowOven.c,110 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main13
;ReflowOven.c,113 :: 		if((RA3_Bit)&&(!FinCycle)) DoTime();
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main16
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main16
L__main85:
	CALL        _DoTime+0, 0
L_main16:
;ReflowOven.c,116 :: 		if(tmr.SecNew != tmr.sec){
	MOVF        _tmr+17, 0 
	XORWF       _tmr+11, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main90
	MOVF        _tmr+10, 0 
	XORWF       _tmr+16, 0 
L__main90:
	BTFSC       STATUS+0, 2 
	GOTO        L_main17
;ReflowOven.c,117 :: 		sprintf(txt2,"%-2d",tmr.sec);
	MOVLW       _txt2+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt2+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_2_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_2_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_2_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _tmr+10, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _tmr+11, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,118 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
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
;ReflowOven.c,119 :: 		tmr.SecNew = tmr.sec;
	MOVF        _tmr+10, 0 
	MOVWF       _tmr+16 
	MOVF        _tmr+11, 0 
	MOVWF       _tmr+17 
;ReflowOven.c,120 :: 		}
L_main17:
;ReflowOven.c,123 :: 		if(tmr.MinNew != tmr.min){
	MOVF        _tmr+19, 0 
	XORWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main91
	MOVF        _tmr+12, 0 
	XORWF       _tmr+18, 0 
L__main91:
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
;ReflowOven.c,124 :: 		tmr.MinNew = tmr.min;
	MOVF        _tmr+12, 0 
	MOVWF       _tmr+18 
	MOVF        _tmr+13, 0 
	MOVWF       _tmr+19 
;ReflowOven.c,125 :: 		if(tmr.min>=1){
	MOVLW       0
	SUBWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main92
	MOVLW       1
	SUBWF       _tmr+12, 0 
L__main92:
	BTFSS       STATUS+0, 0 
	GOTO        L_main19
;ReflowOven.c,126 :: 		sprintf(txt3,"%3d",tmr.min);
	MOVLW       _txt3+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt3+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_3_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _tmr+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _tmr+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,127 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,10,txt3);
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
;ReflowOven.c,128 :: 		}else
	GOTO        L_main20
L_main19:
;ReflowOven.c,129 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,10,"  0");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       10
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
L_main20:
;ReflowOven.c,131 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,13,":");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       13
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr5_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr5_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,132 :: 		}
L_main18:
;ReflowOven.c,134 :: 		if(TempTicPlaceholder_last != TempTicPlaceholder){
	MOVF        ReflowOven_TempTicPlaceholder_last+1, 0 
	XORWF       main_TempTicPlaceholder_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main93
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	XORWF       ReflowOven_TempTicPlaceholder_last+0, 0 
L__main93:
	BTFSC       STATUS+0, 2 
	GOTO        L_main21
;ReflowOven.c,135 :: 		TempTicPlaceholder_last = TempTicPlaceholder;
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	MOVWF       ReflowOven_TempTicPlaceholder_last+0 
	MOVF        main_TempTicPlaceholder_L1+1, 0 
	MOVWF       ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,136 :: 		sprintf(txt4,"%4d",TempTicPlaceholder); //Phase counter
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_6_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_6_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_6_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_TempTicPlaceholder_L1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_TempTicPlaceholder_L1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,137 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,12,"'C+:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       12
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr7_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr7_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,138 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,17,txt4);
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
;ReflowOven.c,139 :: 		sprintf(txt4,"%4d",TempDegPlaceholder); //Phase counter
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_8_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_8_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_8_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        main_TempDegPlaceholder_L1+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        main_TempDegPlaceholder_L1+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,140 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,12,"Spt:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       12
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr9_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr9_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,141 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,17,txt4);
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
;ReflowOven.c,142 :: 		}
L_main21:
;ReflowOven.c,145 :: 		if(!SetPtSet){
	BTFSC       ReflowOven_Bits+0, 0 
	GOTO        L_main22
;ReflowOven.c,146 :: 		SetPtSet = on;
	BSF         ReflowOven_Bits+0, 0 
;ReflowOven.c,147 :: 		DegC.Deg_Sp = DegC.Temp_iPv;
	MOVF        _DegC+16, 0 
	MOVWF       _DegC+6 
	MOVF        _DegC+17, 0 
	MOVWF       _DegC+7 
;ReflowOven.c,148 :: 		CalcTimerTicks(DegC.Temp_iPv);
	MOVF        _DegC+16, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+0 
	MOVF        _DegC+17, 0 
	MOVWF       FARG_CalcTimerTicks_iPv+1 
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,149 :: 		if(!FinCycle){
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main23
;ReflowOven.c,150 :: 		UART1_Write_Text("Start");
	MOVLW       ?lstr10_ReflowOven+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr10_ReflowOven+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,151 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,152 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,153 :: 		}
L_main23:
;ReflowOven.c,154 :: 		}
L_main22:
;ReflowOven.c,156 :: 		if(RA3_Bit){
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main24
;ReflowOven.c,157 :: 		if(!RstTmr){
	BTFSC       ReflowOven_Bits+0, 2 
	GOTO        L_main25
;ReflowOven.c,158 :: 		RstTmr = on;
	BSF         ReflowOven_Bits+0, 2 
;ReflowOven.c,159 :: 		FinCycle = off;
	BCF         ReflowOven_Bits+0, 3 
;ReflowOven.c,160 :: 		SetPtSet = off;
	BCF         ReflowOven_Bits+0, 0 
;ReflowOven.c,161 :: 		SetCoolBit = off;
	BCF         ReflowOven_Bits+0, 1 
;ReflowOven.c,162 :: 		Ok_Bit = off;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,163 :: 		tmr.MinNew = -1;
	MOVLW       255
	MOVWF       _tmr+18 
	MOVLW       255
	MOVWF       _tmr+19 
;ReflowOven.c,164 :: 		TempTicPlaceholder_last = 0;
	CLRF        ReflowOven_TempTicPlaceholder_last+0 
	CLRF        ReflowOven_TempTicPlaceholder_last+1 
;ReflowOven.c,165 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;ReflowOven.c,166 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;ReflowOven.c,167 :: 		}
L_main25:
;ReflowOven.c,168 :: 		if(Ok_Bit){
	BTFSS       _OK_Bit+0, BitPos(_OK_Bit+0) 
	GOTO        L_main26
;ReflowOven.c,169 :: 		RstTmr = off;
	BCF         ReflowOven_Bits+0, 2 
;ReflowOven.c,170 :: 		}
L_main26:
;ReflowOven.c,172 :: 		if((DegC.Deg_Sp < Sps.RmpDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main94
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main94:
	BTFSC       STATUS+0, 0 
	GOTO        L_main29
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main29
L__main84:
;ReflowOven.c,173 :: 		if (SetCoolBit)SetCoolBit = off;
	BTFSS       ReflowOven_Bits+0, 1 
	GOTO        L_main30
	BCF         ReflowOven_Bits+0, 1 
L_main30:
;ReflowOven.c,174 :: 		TempDegPlaceholder = Sps.RmpDeg;
	MOVF        _Sps+0, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+1, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,175 :: 		TempTicPlaceholder = TempTicks.RampTick;
	MOVF        _TempTicks+2, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,176 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ramp");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr11_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr11_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,177 :: 		sprintf(txt6,"%3u",Sps.RmpDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_12_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_12_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_12_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,178 :: 		}
	GOTO        L_main31
L_main29:
;ReflowOven.c,179 :: 		else if((DegC.Deg_Sp >= Sps.RmpDeg)&&(DegC.Deg_Sp < Sps.SokDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main95
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main95:
	BTFSS       STATUS+0, 0 
	GOTO        L_main34
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main96
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main96:
	BTFSC       STATUS+0, 0 
	GOTO        L_main34
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main34
L__main83:
;ReflowOven.c,180 :: 		TempDegPlaceholder = Sps.SokDeg;
	MOVF        _Sps+4, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+5, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,181 :: 		TempTicPlaceholder = TempTicks.SoakTick;
	MOVF        _TempTicks+4, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,182 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Soak");
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
;ReflowOven.c,183 :: 		sprintf(txt6,"%3u",Sps.SokDeg);
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
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,184 :: 		}
	GOTO        L_main35
L_main34:
;ReflowOven.c,185 :: 		else if((DegC.Deg_Sp >= Sps.SokDeg)&&(DegC.Deg_Sp < Sps.SpkeDeg)&&(!SetCoolBit)){
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main97
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main97:
	BTFSS       STATUS+0, 0 
	GOTO        L_main38
	MOVF        _Sps+9, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main98
	MOVF        _Sps+8, 0 
	SUBWF       _DegC+6, 0 
L__main98:
	BTFSC       STATUS+0, 0 
	GOTO        L_main38
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main38
L__main82:
;ReflowOven.c,186 :: 		TempDegPlaceholder = Sps.SpkeDeg;
	MOVF        _Sps+8, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+9, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,187 :: 		TempTicPlaceholder = TempTicks.SpikeTick;
	MOVF        _TempTicks+6, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,188 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Spke");
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
;ReflowOven.c,189 :: 		sprintf(txt6,"%3u",Sps.SpkeDeg);
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
	MOVF        _Sps+8, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,190 :: 		}
	GOTO        L_main39
L_main38:
;ReflowOven.c,192 :: 		SetCoolBit = on;
	BSF         ReflowOven_Bits+0, 1 
;ReflowOven.c,193 :: 		TempTicPlaceholder = TempTicks.CoolTick;
	MOVF        _TempTicks+8, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,194 :: 		TempDegPlaceholder = Sps.CoolOffDeg;
	MOVF        _Sps+12, 0 
	MOVWF       main_TempDegPlaceholder_L1+0 
	MOVF        _Sps+13, 0 
	MOVWF       main_TempDegPlaceholder_L1+1 
;ReflowOven.c,195 :: 		if(!FinCycle)I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Cool");
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main40
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
	GOTO        L_main41
L_main40:
;ReflowOven.c,196 :: 		else I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Finn");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr18_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr18_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
L_main41:
;ReflowOven.c,197 :: 		if(DegC.Deg_Sp < Sps.CoolOffDeg)FinCycle = on;
	MOVF        _Sps+13, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main99
	MOVF        _Sps+12, 0 
	SUBWF       _DegC+6, 0 
L__main99:
	BTFSC       STATUS+0, 0 
	GOTO        L_main42
	BSF         ReflowOven_Bits+0, 3 
L_main42:
;ReflowOven.c,198 :: 		}
L_main39:
L_main35:
L_main31:
;ReflowOven.c,200 :: 		if(tmr.tenMilli > TempTicPlaceholder){
	MOVF        _tmr+5, 0 
	SUBWF       main_TempTicPlaceholder_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _tmr+4, 0 
	SUBWF       main_TempTicPlaceholder_L1+0, 0 
L__main100:
	BTFSC       STATUS+0, 0 
	GOTO        L_main43
;ReflowOven.c,201 :: 		tmr.tenMilli = 0;         //rest tick
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,202 :: 		TempTicks.tickActual++;   //keep track of ticks ??
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
;ReflowOven.c,203 :: 		if((SetPtSet)&&(!FinCycle)){
	BTFSS       ReflowOven_Bits+0, 0 
	GOTO        L_main46
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main46
L__main81:
;ReflowOven.c,204 :: 		if(!SetCoolBit)DegC.Deg_Sp++;
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main47
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
	GOTO        L_main48
L_main47:
;ReflowOven.c,205 :: 		else DegC.Deg_Sp--;
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
L_main48:
;ReflowOven.c,206 :: 		}
L_main46:
;ReflowOven.c,208 :: 		if(DegC.LastDeg != DegC.Deg_Sp){
	MOVF        _DegC+11, 0 
	XORWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main101
	MOVF        _DegC+6, 0 
	XORWF       _DegC+10, 0 
L__main101:
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
;ReflowOven.c,209 :: 		sprintf(txt1,"%3u",DegC.Deg_Sp);
	MOVLW       _txt1+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_19_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_19_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_19_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _DegC+6, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+7, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,210 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,1,"Deg:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr20_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr20_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,211 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,txt1);
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
;ReflowOven.c,212 :: 		WriteDataOut();
	CALL        _WriteDataOut+0, 0
;ReflowOven.c,213 :: 		DegC.LastDeg = DegC.Deg_Sp;
	MOVF        _DegC+6, 0 
	MOVWF       _DegC+10 
	MOVF        _DegC+7, 0 
	MOVWF       _DegC+11 
;ReflowOven.c,214 :: 		}
L_main49:
;ReflowOven.c,216 :: 		}
L_main43:
;ReflowOven.c,217 :: 		}else{
	GOTO        L_main50
L_main24:
;ReflowOven.c,218 :: 		SetCoolBit = off;
	BCF         ReflowOven_Bits+0, 1 
;ReflowOven.c,219 :: 		tmr.tenMilli = 0;
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,220 :: 		TempTicks.tickActual = 0;
	CLRF        _TempTicks+10 
	CLRF        _TempTicks+11 
;ReflowOven.c,221 :: 		SetPtSet = off;
	BCF         ReflowOven_Bits+0, 0 
;ReflowOven.c,222 :: 		RstTmr = off;
	BCF         ReflowOven_Bits+0, 2 
;ReflowOven.c,223 :: 		Ok_Bit = off;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,224 :: 		}
L_main50:
;ReflowOven.c,225 :: 		}
L_main13:
;ReflowOven.c,232 :: 		switch(Phs.PhaseCntr){
	GOTO        L_main51
;ReflowOven.c,233 :: 		case 1:  //pid output to ccp module for pHase control
L_main53:
;ReflowOven.c,234 :: 		Phs.an0_ = (unsigned int)pid_t.Mv;// ADC_Read(0);
	MOVF        _pid_t+20, 0 
	MOVWF       _Phs+6 
	MOVF        _pid_t+21, 0 
	MOVWF       _Phs+7 
;ReflowOven.c,235 :: 		if(Phs.an0_ < 1)Phs.an0_ = 1;
	MOVLW       0
	SUBWF       _pid_t+21, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main102
	MOVLW       1
	SUBWF       _pid_t+20, 0 
L__main102:
	BTFSC       STATUS+0, 0 
	GOTO        L_main54
	MOVLW       1
	MOVWF       _Phs+6 
	MOVLW       0
	MOVWF       _Phs+7 
L_main54:
;ReflowOven.c,236 :: 		Phs.an0_ = RevADC - Phs.an0_;
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
;ReflowOven.c,237 :: 		if(Phs.an0_ >= 1010)Phs.an0_ = 1010;
	MOVLW       3
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVLW       242
	SUBWF       R1, 0 
L__main103:
	BTFSS       STATUS+0, 0 
	GOTO        L_main55
	MOVLW       242
	MOVWF       _Phs+6 
	MOVLW       3
	MOVWF       _Phs+7 
L_main55:
;ReflowOven.c,238 :: 		break;
	GOTO        L_main52
;ReflowOven.c,239 :: 		case 2:  //pid output ccp for servo control
L_main56:
;ReflowOven.c,241 :: 		Phs.an1_ = ServoSub + pid_t.Mv;//Phs.an1_;
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
;ReflowOven.c,242 :: 		if(Phs.an1_ > 1500)Phs.an1_ = 1500;
	MOVF        R2, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        R1, 0 
	SUBLW       220
L__main104:
	BTFSC       STATUS+0, 0 
	GOTO        L_main57
	MOVLW       220
	MOVWF       _Phs+14 
	MOVLW       5
	MOVWF       _Phs+15 
L_main57:
;ReflowOven.c,243 :: 		break;
	GOTO        L_main52
;ReflowOven.c,244 :: 		case 3:  //hardware multiplier
L_main58:
;ReflowOven.c,245 :: 		if(Phs.olDan0_ != Phs.an0_){
	MOVF        _Phs+9, 0 
	XORWF       _Phs+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _Phs+6, 0 
	XORWF       _Phs+8, 0 
L__main105:
	BTFSC       STATUS+0, 2 
	GOTO        L_main59
;ReflowOven.c,246 :: 		Phs.an0_0 = (unsigned int)S_HWMul(Phs.an0_,mulFact);
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
;ReflowOven.c,249 :: 		Phs.olDan0_ = Phs.an0_;
	MOVF        _Phs+6, 0 
	MOVWF       _Phs+8 
	MOVF        _Phs+7, 0 
	MOVWF       _Phs+9 
;ReflowOven.c,250 :: 		}
L_main59:
;ReflowOven.c,252 :: 		break;
	GOTO        L_main52
;ReflowOven.c,253 :: 		case 4:  //hardware multiplier
L_main60:
;ReflowOven.c,254 :: 		if(Phs.olDan1_ != Phs.an1_){
	MOVF        _Phs+17, 0 
	XORWF       _Phs+15, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main106
	MOVF        _Phs+14, 0 
	XORWF       _Phs+16, 0 
L__main106:
	BTFSC       STATUS+0, 2 
	GOTO        L_main61
;ReflowOven.c,255 :: 		Phs.an1_1 = (unsigned int)S_HWMul(Phs.an1_,ServoPls);
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
;ReflowOven.c,258 :: 		Phs.olDan1_ = Phs.an1_;
	MOVF        _Phs+14, 0 
	MOVWF       _Phs+16 
	MOVF        _Phs+15, 0 
	MOVWF       _Phs+17 
;ReflowOven.c,259 :: 		}
L_main61:
;ReflowOven.c,260 :: 		break;
	GOTO        L_main52
;ReflowOven.c,261 :: 		case 5: // spi call to temp chip
L_main62:
;ReflowOven.c,262 :: 		if(!TempBit){
	BTFSC       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main63
;ReflowOven.c,263 :: 		DegC.sampleTimer++;
	MOVF        _DegC+21, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _DegC+21 
;ReflowOven.c,264 :: 		TempBit = on;
	BSF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
;ReflowOven.c,265 :: 		if(DegC.sampleTimer >= 20){
	MOVLW       128
	XORWF       _DegC+21, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       20
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main64
;ReflowOven.c,266 :: 		DegC.Temp_fPv = ReadMax31855J();
	CALL        _ReadMax31855J+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+12 
	MOVF        R1, 0 
	MOVWF       _DegC+13 
	MOVF        R2, 0 
	MOVWF       _DegC+14 
	MOVF        R3, 0 
	MOVWF       _DegC+15 
;ReflowOven.c,267 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main65
;ReflowOven.c,268 :: 		DegC.Temp_iPv = (int)DegC.Temp_fPv;
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
;ReflowOven.c,269 :: 		sprintf(txt5,"%3.2f",DegC.Temp_fPv); //DegC.Temp_
	MOVLW       _txt5+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_21_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_21_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_21_ReflowOven+0)
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
;ReflowOven.c,270 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr22_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr22_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,271 :: 		strcat(txt5, "'C");
	MOVLW       _txt5+0
	MOVWF       FARG_strcat_to+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_strcat_to+1 
	MOVLW       ?lstr23_ReflowOven+0
	MOVWF       FARG_strcat_from+0 
	MOVLW       hi_addr(?lstr23_ReflowOven+0)
	MOVWF       FARG_strcat_from+1 
	CALL        _strcat+0, 0
;ReflowOven.c,272 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
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
;ReflowOven.c,273 :: 		}
L_main65:
;ReflowOven.c,274 :: 		}
L_main64:
;ReflowOven.c,275 :: 		}
L_main63:
;ReflowOven.c,276 :: 		break;
	GOTO        L_main52
;ReflowOven.c,277 :: 		case 6://calculate Temp and display
L_main66:
;ReflowOven.c,278 :: 		if(!pidBit){
	BTFSC       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main67
;ReflowOven.c,279 :: 		pid_t.sample_tmr++;
	MOVF        _pid_t+32, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pid_t+32 
;ReflowOven.c,280 :: 		pidBit = on;
	BSF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
;ReflowOven.c,281 :: 		if(pid_t.sample_tmr >= pid_t.Kt){
	MOVLW       128
	XORWF       _pid_t+32, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _pid_t+33, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main68
;ReflowOven.c,283 :: 		if(!FinCycle)
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main69
;ReflowOven.c,284 :: 		PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
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
	GOTO        L_main70
L_main69:
;ReflowOven.c,286 :: 		pid_t.Mv = 0;
	CLRF        _pid_t+20 
	CLRF        _pid_t+21 
L_main70:
;ReflowOven.c,288 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main71
;ReflowOven.c,289 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Mv:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr24_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr24_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,290 :: 		sprintf(txt4,"%4d",pid_t.Mv);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_25_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_25_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_25_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+20, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+21, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,291 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,5,txt4);
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
;ReflowOven.c,292 :: 		}
L_main71:
;ReflowOven.c,294 :: 		}
L_main68:
;ReflowOven.c,295 :: 		}
L_main67:
;ReflowOven.c,296 :: 		break;
	GOTO        L_main52
;ReflowOven.c,297 :: 		case 7:   //write data out to pc every 70*4 ms
L_main72:
;ReflowOven.c,298 :: 		Phs.UartWriter++;
	MOVF        _Phs+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Phs+0 
;ReflowOven.c,299 :: 		if(Phs.UartWriter == 8){
	MOVF        _Phs+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main73
;ReflowOven.c,300 :: 		if(!WriteData){
	BTFSC       ReflowOven_Bits+0, 4 
	GOTO        L_main74
;ReflowOven.c,301 :: 		WriteData = on;
	BSF         ReflowOven_Bits+0, 4 
;ReflowOven.c,302 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,303 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,304 :: 		UART1_Write_Text(txt5);
	MOVLW       _txt5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,305 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,306 :: 		UART1_Write_Text(txt6);
	MOVLW       _txt6+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,307 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,308 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,309 :: 		}
L_main74:
;ReflowOven.c,310 :: 		}
L_main73:
;ReflowOven.c,311 :: 		break;
	GOTO        L_main52
;ReflowOven.c,312 :: 		default:
L_main75:
;ReflowOven.c,313 :: 		if(Phs.UartWriter > 8){
	MOVF        _Phs+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_main76
;ReflowOven.c,314 :: 		Phs.UartWriter = 0;
	CLRF        _Phs+0 
;ReflowOven.c,315 :: 		WriteData = off;
	BCF         ReflowOven_Bits+0, 4 
;ReflowOven.c,316 :: 		}
L_main76:
;ReflowOven.c,317 :: 		if(DegC.sampleTimer >= 20)DegC.sampleTimer = 0;
	MOVLW       128
	XORWF       _DegC+21, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       20
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main77
	CLRF        _DegC+21 
L_main77:
;ReflowOven.c,318 :: 		if(pid_t.sample_tmr >=5)pid_t.sample_tmr = 0;
	MOVLW       128
	XORWF       _pid_t+32, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main78
	CLRF        _pid_t+32 
L_main78:
;ReflowOven.c,319 :: 		if(TempBit)TempBit = off;
	BTFSS       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main79
	BCF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
L_main79:
;ReflowOven.c,320 :: 		if(pidBit) pidBit = off;
	BTFSS       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main80
	BCF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
L_main80:
;ReflowOven.c,321 :: 		Phs.PhaseCntr = 1;
	MOVLW       1
	MOVWF       _Phs+2 
;ReflowOven.c,322 :: 		break;
	GOTO        L_main52
;ReflowOven.c,323 :: 		}
L_main51:
	MOVF        _Phs+2, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main53
	MOVF        _Phs+2, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
	MOVF        _Phs+2, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
	MOVF        _Phs+2, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVF        _Phs+2, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
	MOVF        _Phs+2, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
	MOVF        _Phs+2, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_main72
	GOTO        L_main75
L_main52:
;ReflowOven.c,325 :: 		}
	GOTO        L_main5
;ReflowOven.c,327 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_HighPrioity:

;ReflowOven.c,332 :: 		void HighPrioity() iv 0x0008 ics ICS_AUTO {
;ReflowOven.c,333 :: 		High_Priority();
	CALL        _High_Priority+0, 0
;ReflowOven.c,334 :: 		}
L_end_HighPrioity:
L__HighPrioity108:
	RETFIE      1
; end of _HighPrioity

_Tmr1_Int:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;ReflowOven.c,336 :: 		void Tmr1_Int() iv 0x0018 ics ICS_AUTO {
;ReflowOven.c,337 :: 		Low_Priority();
	CALL        _Low_Priority+0, 0
;ReflowOven.c,338 :: 		}
L_end_Tmr1_Int:
L__Tmr1_Int110:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _Tmr1_Int
