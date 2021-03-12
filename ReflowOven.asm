
_main:

;ReflowOven.c,46 :: 		void main() {
;ReflowOven.c,48 :: 		I2Cxx = I2C1;
	MOVLW       1
	MOVWF       _I2Cxx+0 
	MOVLW       0
	MOVWF       _I2Cxx+1 
;ReflowOven.c,49 :: 		ConfPic();
	CALL        _ConfPic+0, 0
;ReflowOven.c,50 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;ReflowOven.c,51 :: 		UART1_Init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       138
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;ReflowOven.c,53 :: 		I2C1_Init(100000);//INIT I2C AT 100KHZ  Delay_ms(100); // I2C1_SetTimeoutCallback(1000,&test);    // enable error flag for I2C1 test
	MOVLW       160
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;ReflowOven.c,54 :: 		I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle); // Sets the I2C1 module active
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
;ReflowOven.c,55 :: 		Delay_ms(100);
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
;ReflowOven.c,58 :: 		EERead();
	CALL        _EERead+0, 0
;ReflowOven.c,59 :: 		EEWrt = off;
	BCF         _EEWrt+0, BitPos(_EEWrt+0) 
;ReflowOven.c,60 :: 		PID_Init(&pid_t,pid_t.Kp,pid_t.Ki,pid_t.Kd,0,1010,-900,'+',_PID);
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
;ReflowOven.c,61 :: 		Uart1_En();
	CALL        _Uart1_En+0, 0
;ReflowOven.c,62 :: 		Set_Priority();
	CALL        _Set_Priority+0, 0
;ReflowOven.c,63 :: 		ConfigSpi();
	CALL        _ConfigSpi+0, 0
;ReflowOven.c,64 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;ReflowOven.c,65 :: 		InitTimer1();
	CALL        _InitTimer1+0, 0
;ReflowOven.c,67 :: 		InitTimer3();
	CALL        _InitTimer3+0, 0
;ReflowOven.c,68 :: 		InitTimer5();
	CALL        _InitTimer5+0, 0
;ReflowOven.c,69 :: 		SetUp_IOCxInterrupts();
	CALL        _SetUp_IOCxInterrupts+0, 0
;ReflowOven.c,70 :: 		ResetBits();
	CALL        _ResetBits+0, 0
;ReflowOven.c,71 :: 		ClearAll();
	CALL        _ClearAll+0, 0
;ReflowOven.c,73 :: 		I2C_LCD_init(LCD_01_ADDRESS,_2Line);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_init_addr+0 
	MOVLW       2
	MOVWF       FARG_I2C_LCD_init_DispLines+0 
	CALL        _I2C_LCD_init+0, 0
;ReflowOven.c,74 :: 		Delay_ms(100);
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
;ReflowOven.c,75 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);          // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,76 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CURSOR_OFF,1);     // Cursor off
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       7
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,77 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Starting UP");
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
;ReflowOven.c,78 :: 		Delay_ms(2000);
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
;ReflowOven.c,79 :: 		I2C_Lcd_Cmd(LCD_01_ADDRESS,_LCD_CLEAR,1);//Lcd_Cmd(0,0x01);               // Clear display
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_Lcd_Cmd_addr+0 
	MOVLW       5
	MOVWF       FARG_I2C_Lcd_Cmd_cmd+0 
	MOVLW       1
	MOVWF       FARG_I2C_Lcd_Cmd_col+0 
	CALL        _I2C_Lcd_Cmd+0, 0
;ReflowOven.c,80 :: 		Delay_ms(200);
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
;ReflowOven.c,81 :: 		EI();
	CALL        _EI+0, 0
;ReflowOven.c,82 :: 		Delay_ms(100);
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
;ReflowOven.c,83 :: 		wait = off;
	BCF         _wait+0, BitPos(_wait+0) 
;ReflowOven.c,84 :: 		DegC.Temp_iPv = 0;
	CLRF        _DegC+14 
	CLRF        _DegC+15 
;ReflowOven.c,85 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;ReflowOven.c,86 :: 		Bits = 0;
	CLRF        ReflowOven_Bits+0 
;ReflowOven.c,87 :: 		Menu_Bit = 0;
	BCF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;ReflowOven.c,88 :: 		Ok_Bit = 0;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;ReflowOven.c,89 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,90 :: 		phase_cntr_last = Phs.PhaseCntr;
	MOVF        _Phs+2, 0 
	MOVWF       ReflowOven_phase_cntr_last+0 
	MOVLW       0
	MOVWF       ReflowOven_phase_cntr_last+1 
;ReflowOven.c,91 :: 		while(1){
L_main5:
;ReflowOven.c,96 :: 		LATB5_bit  = Menu_Bit;
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L__main87
	BCF         LATB5_bit+0, BitPos(LATB5_bit+0) 
	GOTO        L__main88
L__main87:
	BSF         LATB5_bit+0, BitPos(LATB5_bit+0) 
L__main88:
;ReflowOven.c,97 :: 		if(Menu_Bit)
	BTFSS       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main7
;ReflowOven.c,98 :: 		SampleButtons();
	CALL        _SampleButtons+0, 0
L_main7:
;ReflowOven.c,100 :: 		if (!Menu_Bit && !Ok_Bit && Button(&PORTA, 2, 100, 0)){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main10
	BTFSC       _OK_Bit+0, BitPos(_OK_Bit+0) 
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
L__main85:
;ReflowOven.c,101 :: 		RstEntryBits();
	CALL        _RstEntryBits+0, 0
;ReflowOven.c,102 :: 		Menu_Bit = on;
	BSF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;ReflowOven.c,103 :: 		while(!RA2_bit);
L_main11:
	BTFSC       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L_main12
	GOTO        L_main11
L_main12:
;ReflowOven.c,104 :: 		}
L_main10:
;ReflowOven.c,107 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main13
;ReflowOven.c,109 :: 		if(phase_cntr_last != Phs.PhaseCntr){
	MOVLW       0
	XORWF       ReflowOven_phase_cntr_last+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main89
	MOVF        _Phs+2, 0 
	XORWF       ReflowOven_phase_cntr_last+0, 0 
L__main89:
	BTFSC       STATUS+0, 2 
	GOTO        L_main14
;ReflowOven.c,110 :: 		phase_cntr_last = Phs.PhaseCntr;
	MOVF        _Phs+2, 0 
	MOVWF       ReflowOven_phase_cntr_last+0 
	MOVLW       0
	MOVWF       ReflowOven_phase_cntr_last+1 
;ReflowOven.c,111 :: 		sprintf(txt7,"%2u",Phs.PhaseCntr); //Phase counter
	MOVLW       _txt7+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt7+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_3_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_3_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Phs+2, 0 
	MOVWF       FARG_sprintf_wh+5 
	CALL        _sprintf+0, 0
;ReflowOven.c,112 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,14,"Phs:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       14
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr4_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr4_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,113 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,19,txt7);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       19
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt7+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt7+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,114 :: 		}
L_main14:
;ReflowOven.c,117 :: 		if((RA3_Bit)&&(!FinCycle)) DoTime();
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main17
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main17
L__main84:
	CALL        _DoTime+0, 0
L_main17:
;ReflowOven.c,120 :: 		if(tmr.SecNew != tmr.sec){
	MOVF        _tmr+17, 0 
	XORWF       _tmr+11, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main90
	MOVF        _tmr+10, 0 
	XORWF       _tmr+16, 0 
L__main90:
	BTFSC       STATUS+0, 2 
	GOTO        L_main18
;ReflowOven.c,121 :: 		if(!OK_Bit){
	BTFSC       _OK_Bit+0, BitPos(_OK_Bit+0) 
	GOTO        L_main19
;ReflowOven.c,122 :: 		sprintf(txt2,"%-2d",tmr.sec);
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
;ReflowOven.c,123 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,14,txt2);
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
;ReflowOven.c,124 :: 		}
L_main19:
;ReflowOven.c,125 :: 		tmr.SecNew = tmr.sec;
	MOVF        _tmr+10, 0 
	MOVWF       _tmr+16 
	MOVF        _tmr+11, 0 
	MOVWF       _tmr+17 
;ReflowOven.c,126 :: 		}
L_main18:
;ReflowOven.c,129 :: 		if(tmr.MinNew != tmr.min){
	MOVF        _tmr+19, 0 
	XORWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main91
	MOVF        _tmr+12, 0 
	XORWF       _tmr+18, 0 
L__main91:
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;ReflowOven.c,130 :: 		if(!OK_Bit){
	BTFSC       _OK_Bit+0, BitPos(_OK_Bit+0) 
	GOTO        L_main21
;ReflowOven.c,131 :: 		if(tmr.min>=1){
	MOVLW       0
	SUBWF       _tmr+13, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main92
	MOVLW       1
	SUBWF       _tmr+12, 0 
L__main92:
	BTFSS       STATUS+0, 0 
	GOTO        L_main22
;ReflowOven.c,132 :: 		sprintf(txt3,"%3d",tmr.min);
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
;ReflowOven.c,133 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,10,txt3);
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
;ReflowOven.c,134 :: 		}else I2C_LCD_Out(LCD_01_ADDRESS,1,10,"  0");
	GOTO        L_main23
L_main22:
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
;ReflowOven.c,135 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,13,":");
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
;ReflowOven.c,136 :: 		}
L_main21:
;ReflowOven.c,137 :: 		tmr.MinNew = tmr.min;
	MOVF        _tmr+12, 0 
	MOVWF       _tmr+18 
	MOVF        _tmr+13, 0 
	MOVWF       _tmr+19 
;ReflowOven.c,138 :: 		}
L_main20:
;ReflowOven.c,141 :: 		if(RA3_Bit){
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_main24
;ReflowOven.c,142 :: 		if(!RstTmr){
	BTFSC       ReflowOven_Bits+0, 2 
	GOTO        L_main25
;ReflowOven.c,143 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;ReflowOven.c,144 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;ReflowOven.c,145 :: 		RstTmr = on;
	BSF         ReflowOven_Bits+0, 2 
;ReflowOven.c,146 :: 		FinCycle = off;
	BCF         ReflowOven_Bits+0, 3 
;ReflowOven.c,147 :: 		}
L_main25:
;ReflowOven.c,148 :: 		if(!SetPtSet){
	BTFSC       ReflowOven_Bits+0, 0 
	GOTO        L_main26
;ReflowOven.c,149 :: 		DegC.Deg_Sp = DegC.Temp_iPv;
	MOVF        _DegC+14, 0 
	MOVWF       _DegC+6 
	MOVF        _DegC+15, 0 
	MOVWF       _DegC+7 
;ReflowOven.c,150 :: 		CalcTimerTicks();
	CALL        _CalcTimerTicks+0, 0
;ReflowOven.c,151 :: 		if(!FinCycle){
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main27
;ReflowOven.c,152 :: 		SetPtSet = on;
	BSF         ReflowOven_Bits+0, 0 
;ReflowOven.c,153 :: 		UART1_Write_Text("Start");
	MOVLW       ?lstr9_ReflowOven+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr9_ReflowOven+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,154 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,155 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,156 :: 		}
L_main27:
;ReflowOven.c,157 :: 		}
L_main26:
;ReflowOven.c,158 :: 		if((DegC.Deg_Sp < Sps.RmpDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main93
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main93:
	BTFSC       STATUS+0, 0 
	GOTO        L_main30
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main30
L__main83:
;ReflowOven.c,159 :: 		if (SetCoolBit)SetCoolBit = off;
	BTFSS       ReflowOven_Bits+0, 1 
	GOTO        L_main31
	BCF         ReflowOven_Bits+0, 1 
L_main31:
;ReflowOven.c,160 :: 		TempTicPlaceholder = TempTicks.RampTick;
	MOVF        _TempTicks+2, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+3, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,161 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Ramp");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr10_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr10_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,162 :: 		sprintf(txt6,"%3u",Sps.RmpDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_11_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_11_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_11_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+0, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+1, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,163 :: 		}
	GOTO        L_main32
L_main30:
;ReflowOven.c,164 :: 		else if((DegC.Deg_Sp >= Sps.RmpDeg)&&(DegC.Deg_Sp < Sps.SokDeg)&&(!SetCoolBit)){
	MOVF        _Sps+1, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main94
	MOVF        _Sps+0, 0 
	SUBWF       _DegC+6, 0 
L__main94:
	BTFSS       STATUS+0, 0 
	GOTO        L_main35
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main95
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main95:
	BTFSC       STATUS+0, 0 
	GOTO        L_main35
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main35
L__main82:
;ReflowOven.c,165 :: 		TempTicPlaceholder = TempTicks.SoakTick;
	MOVF        _TempTicks+4, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+5, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,166 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Soak");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr12_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr12_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,167 :: 		sprintf(txt6,"%3u",Sps.SokDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_13_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_13_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_13_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+4, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+5, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,168 :: 		}
	GOTO        L_main36
L_main35:
;ReflowOven.c,169 :: 		else if((DegC.Deg_Sp >= Sps.SokDeg)&&(DegC.Deg_Sp < Sps.SpkeDeg)&&(!SetCoolBit)){
	MOVF        _Sps+5, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main96
	MOVF        _Sps+4, 0 
	SUBWF       _DegC+6, 0 
L__main96:
	BTFSS       STATUS+0, 0 
	GOTO        L_main39
	MOVF        _Sps+9, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main97
	MOVF        _Sps+8, 0 
	SUBWF       _DegC+6, 0 
L__main97:
	BTFSC       STATUS+0, 0 
	GOTO        L_main39
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main39
L__main81:
;ReflowOven.c,170 :: 		TempTicPlaceholder = TempTicks.SpikeTick;
	MOVF        _TempTicks+6, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+7, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,171 :: 		I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Spke");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr14_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr14_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,172 :: 		sprintf(txt6,"%3u",Sps.SpkeDeg);
	MOVLW       _txt6+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_15_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_15_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_15_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _Sps+8, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+9, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,173 :: 		}
	GOTO        L_main40
L_main39:
;ReflowOven.c,175 :: 		SetCoolBit = on;
	BSF         ReflowOven_Bits+0, 1 
;ReflowOven.c,176 :: 		TempTicPlaceholder = TempTicks.CoolTick;
	MOVF        _TempTicks+8, 0 
	MOVWF       main_TempTicPlaceholder_L1+0 
	MOVF        _TempTicks+9, 0 
	MOVWF       main_TempTicPlaceholder_L1+1 
;ReflowOven.c,177 :: 		if(!FinCycle)I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Cool");
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main41
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr16_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr16_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
	GOTO        L_main42
L_main41:
;ReflowOven.c,178 :: 		else I2C_LCD_Out(LCD_01_ADDRESS,1,1,"Finn");
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
L_main42:
;ReflowOven.c,179 :: 		sprintf(txt6,"%3u",Sps.CoolOffDeg);
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
	MOVF        _Sps+12, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _Sps+13, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,180 :: 		if(DegC.Deg_Sp < Sps.CoolOffDeg)FinCycle = on;
	MOVF        _Sps+13, 0 
	SUBWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main98
	MOVF        _Sps+12, 0 
	SUBWF       _DegC+6, 0 
L__main98:
	BTFSC       STATUS+0, 0 
	GOTO        L_main43
	BSF         ReflowOven_Bits+0, 3 
L_main43:
;ReflowOven.c,181 :: 		}
L_main40:
L_main36:
L_main32:
;ReflowOven.c,183 :: 		if(tmr.tenMilli > TempTicPlaceholder){
	MOVF        _tmr+5, 0 
	SUBWF       main_TempTicPlaceholder_L1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main99
	MOVF        _tmr+4, 0 
	SUBWF       main_TempTicPlaceholder_L1+0, 0 
L__main99:
	BTFSC       STATUS+0, 0 
	GOTO        L_main44
;ReflowOven.c,184 :: 		tmr.tenMilli = 0;         //rest tick
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,185 :: 		TempTicks.tickActual++;   //keep track of ticks ??
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
;ReflowOven.c,186 :: 		if((SetPtSet)&&(!FinCycle)){
	BTFSS       ReflowOven_Bits+0, 0 
	GOTO        L_main47
	BTFSC       ReflowOven_Bits+0, 3 
	GOTO        L_main47
L__main80:
;ReflowOven.c,187 :: 		if(!SetCoolBit)DegC.Deg_Sp++;
	BTFSC       ReflowOven_Bits+0, 1 
	GOTO        L_main48
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
	GOTO        L_main49
L_main48:
;ReflowOven.c,188 :: 		else DegC.Deg_Sp--;
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
L_main49:
;ReflowOven.c,189 :: 		}
L_main47:
;ReflowOven.c,191 :: 		if(DegC.LastDeg != DegC.Deg_Sp){
	MOVF        _DegC+9, 0 
	XORWF       _DegC+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main100
	MOVF        _DegC+6, 0 
	XORWF       _DegC+8, 0 
L__main100:
	BTFSC       STATUS+0, 2 
	GOTO        L_main50
;ReflowOven.c,192 :: 		sprintf(txt1,"%3u",DegC.Deg_Sp);
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
;ReflowOven.c,193 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,1,"Deg:=");
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
;ReflowOven.c,194 :: 		I2C_LCD_Out(LCD_01_ADDRESS,2,6,txt1);
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
;ReflowOven.c,195 :: 		WriteDataOut();
	CALL        _WriteDataOut+0, 0
;ReflowOven.c,196 :: 		DegC.LastDeg = DegC.Deg_Sp;
	MOVF        _DegC+6, 0 
	MOVWF       _DegC+8 
	MOVF        _DegC+7, 0 
	MOVWF       _DegC+9 
;ReflowOven.c,197 :: 		}
L_main50:
;ReflowOven.c,199 :: 		}
L_main44:
;ReflowOven.c,200 :: 		}else{
	GOTO        L_main51
L_main24:
;ReflowOven.c,201 :: 		SetCoolBit = off;
	BCF         ReflowOven_Bits+0, 1 
;ReflowOven.c,202 :: 		tmr.tenMilli = 0;
	CLRF        _tmr+4 
	CLRF        _tmr+5 
;ReflowOven.c,203 :: 		TempTicks.tickActual = 0;
	CLRF        _TempTicks+10 
	CLRF        _TempTicks+11 
;ReflowOven.c,204 :: 		SetPtSet = off;
	BCF         ReflowOven_Bits+0, 0 
;ReflowOven.c,205 :: 		RstTmr = off;
	BCF         ReflowOven_Bits+0, 2 
;ReflowOven.c,206 :: 		}
L_main51:
;ReflowOven.c,207 :: 		}
L_main13:
;ReflowOven.c,214 :: 		switch(Phs.PhaseCntr){
	GOTO        L_main52
;ReflowOven.c,215 :: 		case 1:  //pid output to ccp module for pHase control
L_main54:
;ReflowOven.c,216 :: 		Phs.an0_ = (unsigned int)pid_t.Mv;// ADC_Read(0);
	MOVF        _pid_t+20, 0 
	MOVWF       _Phs+6 
	MOVF        _pid_t+21, 0 
	MOVWF       _Phs+7 
;ReflowOven.c,217 :: 		if(Phs.an0_ < 1)Phs.an0_ = 1;
	MOVLW       0
	SUBWF       _pid_t+21, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main101
	MOVLW       1
	SUBWF       _pid_t+20, 0 
L__main101:
	BTFSC       STATUS+0, 0 
	GOTO        L_main55
	MOVLW       1
	MOVWF       _Phs+6 
	MOVLW       0
	MOVWF       _Phs+7 
L_main55:
;ReflowOven.c,218 :: 		Phs.an0_ = RevADC - Phs.an0_;
	MOVF        _Phs+6, 0 
	SUBLW       255
	MOVWF       R1 
	MOVF        _Phs+7, 0 
	MOVWF       R2 
	MOVLW       3
	SUBFWB      R2, 1 
	MOVF        R1, 0 
	MOVWF       _Phs+6 
	MOVF        R2, 0 
	MOVWF       _Phs+7 
;ReflowOven.c,219 :: 		if(Phs.an0_ >= 980)Phs.an0_ = 980;
	MOVLW       3
	SUBWF       R2, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main102
	MOVLW       212
	SUBWF       R1, 0 
L__main102:
	BTFSS       STATUS+0, 0 
	GOTO        L_main56
	MOVLW       212
	MOVWF       _Phs+6 
	MOVLW       3
	MOVWF       _Phs+7 
L_main56:
;ReflowOven.c,220 :: 		break;
	GOTO        L_main53
;ReflowOven.c,221 :: 		case 2:  //pid output ccp for servo control
L_main57:
;ReflowOven.c,223 :: 		Phs.an1_ = ServoSub + pid_t.Mv;//Phs.an1_;
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
;ReflowOven.c,224 :: 		if(Phs.an1_ > 1500)Phs.an1_ = 1500;
	MOVF        R2, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__main103
	MOVF        R1, 0 
	SUBLW       220
L__main103:
	BTFSC       STATUS+0, 0 
	GOTO        L_main58
	MOVLW       220
	MOVWF       _Phs+14 
	MOVLW       5
	MOVWF       _Phs+15 
L_main58:
;ReflowOven.c,225 :: 		break;
	GOTO        L_main53
;ReflowOven.c,226 :: 		case 3:  //hardware multiplier
L_main59:
;ReflowOven.c,227 :: 		if(Phs.olDan0_ != Phs.an0_){
	MOVF        _Phs+9, 0 
	XORWF       _Phs+7, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main104
	MOVF        _Phs+6, 0 
	XORWF       _Phs+8, 0 
L__main104:
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
;ReflowOven.c,228 :: 		Phs.an0_0 = (unsigned int)S_HWMul(Phs.an0_,mulFact);
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
;ReflowOven.c,231 :: 		Phs.olDan0_ = Phs.an0_;
	MOVF        _Phs+6, 0 
	MOVWF       _Phs+8 
	MOVF        _Phs+7, 0 
	MOVWF       _Phs+9 
;ReflowOven.c,232 :: 		}
L_main60:
;ReflowOven.c,234 :: 		break;
	GOTO        L_main53
;ReflowOven.c,235 :: 		case 4:  //hardware multiplier
L_main61:
;ReflowOven.c,236 :: 		if(Phs.olDan1_ != Phs.an1_){
	MOVF        _Phs+17, 0 
	XORWF       _Phs+15, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main105
	MOVF        _Phs+14, 0 
	XORWF       _Phs+16, 0 
L__main105:
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
;ReflowOven.c,237 :: 		Phs.an1_1 = (unsigned int)S_HWMul(Phs.an1_,ServoPls);
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
;ReflowOven.c,240 :: 		Phs.olDan1_ = Phs.an1_;
	MOVF        _Phs+14, 0 
	MOVWF       _Phs+16 
	MOVF        _Phs+15, 0 
	MOVWF       _Phs+17 
;ReflowOven.c,241 :: 		}
L_main62:
;ReflowOven.c,242 :: 		break;
	GOTO        L_main53
;ReflowOven.c,243 :: 		case 5: // spi call to temp chip
L_main63:
;ReflowOven.c,244 :: 		if(!TempBit){
	BTFSC       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main64
;ReflowOven.c,245 :: 		DegC.sampleTimer++;
	MOVF        _DegC+19, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _DegC+19 
;ReflowOven.c,246 :: 		TempBit = on;
	BSF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
;ReflowOven.c,247 :: 		if(DegC.sampleTimer >= 20){
	MOVLW       128
	XORWF       _DegC+19, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       20
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main65
;ReflowOven.c,248 :: 		DegC.Temp_fPv = ReadMax31855J();
	CALL        _ReadMax31855J+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+10 
	MOVF        R1, 0 
	MOVWF       _DegC+11 
	MOVF        R2, 0 
	MOVWF       _DegC+12 
	MOVF        R3, 0 
	MOVWF       _DegC+13 
;ReflowOven.c,249 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main66
;ReflowOven.c,250 :: 		DegC.Temp_iPv = (int)DegC.Temp_fPv;
	MOVF        _DegC+10, 0 
	MOVWF       R0 
	MOVF        _DegC+11, 0 
	MOVWF       R1 
	MOVF        _DegC+12, 0 
	MOVWF       R2 
	MOVF        _DegC+13, 0 
	MOVWF       R3 
	CALL        _double2int+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+14 
	MOVF        R1, 0 
	MOVWF       _DegC+15 
;ReflowOven.c,251 :: 		sprintf(txt5,"%3.2f",DegC.Temp_fPv); //DegC.Temp_
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
	MOVF        _DegC+10, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+11, 0 
	MOVWF       FARG_sprintf_wh+6 
	MOVF        _DegC+12, 0 
	MOVWF       FARG_sprintf_wh+7 
	MOVF        _DegC+13, 0 
	MOVWF       FARG_sprintf_wh+8 
	CALL        _sprintf+0, 0
;ReflowOven.c,252 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,1,"Pv:=");
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
;ReflowOven.c,253 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,5,txt5);
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
;ReflowOven.c,254 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,11,"'C");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       11
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr23_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr23_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,255 :: 		sprintf(txt5,"%3d",DegC.Temp_iPv); //DegC.Temp_
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
	MOVF        _DegC+14, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _DegC+15, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,256 :: 		I2C_LCD_Out(LCD_01_ADDRESS,3,14,txt5);
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       3
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       14
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       _txt5+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,257 :: 		}
L_main66:
;ReflowOven.c,258 :: 		}
L_main65:
;ReflowOven.c,259 :: 		}
L_main64:
;ReflowOven.c,260 :: 		break;
	GOTO        L_main53
;ReflowOven.c,261 :: 		case 6://calculate Temp and display
L_main67:
;ReflowOven.c,262 :: 		if(!pidBit){
	BTFSC       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main68
;ReflowOven.c,263 :: 		pid_t.sample_tmr++;
	MOVF        _pid_t+32, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _pid_t+32 
;ReflowOven.c,264 :: 		pidBit = on;
	BSF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
;ReflowOven.c,265 :: 		if(pid_t.sample_tmr >= 5){
	MOVLW       128
	XORWF       _pid_t+32, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main69
;ReflowOven.c,266 :: 		PID_Calc(&pid_t,DegC.Deg_Sp,DegC.Temp_iPv);
	MOVLW       _pid_t+0
	MOVWF       FARG_PID_Calc_PID_t+0 
	MOVLW       hi_addr(_pid_t+0)
	MOVWF       FARG_PID_Calc_PID_t+1 
	MOVF        _DegC+6, 0 
	MOVWF       FARG_PID_Calc_Sp+0 
	MOVF        _DegC+7, 0 
	MOVWF       FARG_PID_Calc_Sp+1 
	MOVF        _DegC+14, 0 
	MOVWF       FARG_PID_Calc_Pv+0 
	MOVF        _DegC+15, 0 
	MOVWF       FARG_PID_Calc_Pv+1 
	CALL        _PID_Calc+0, 0
;ReflowOven.c,267 :: 		if(!Menu_Bit){
	BTFSC       _Menu_Bit+0, BitPos(_Menu_Bit+0) 
	GOTO        L_main70
;ReflowOven.c,268 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,1,"Mv:=");
	MOVF        _LCD_01_ADDRESS+0, 0 
	MOVWF       FARG_I2C_LCD_Out_addr+0 
	MOVLW       4
	MOVWF       FARG_I2C_LCD_Out_row+0 
	MOVLW       1
	MOVWF       FARG_I2C_LCD_Out_col+0 
	MOVLW       ?lstr25_ReflowOven+0
	MOVWF       FARG_I2C_LCD_Out_s+0 
	MOVLW       hi_addr(?lstr25_ReflowOven+0)
	MOVWF       FARG_I2C_LCD_Out_s+1 
	CALL        _I2C_LCD_Out+0, 0
;ReflowOven.c,269 :: 		sprintf(txt4,"%5d",pid_t.Mv);
	MOVLW       _txt4+0
	MOVWF       FARG_sprintf_wh+0 
	MOVLW       hi_addr(_txt4+0)
	MOVWF       FARG_sprintf_wh+1 
	MOVLW       ?lstr_26_ReflowOven+0
	MOVWF       FARG_sprintf_f+0 
	MOVLW       hi_addr(?lstr_26_ReflowOven+0)
	MOVWF       FARG_sprintf_f+1 
	MOVLW       higher_addr(?lstr_26_ReflowOven+0)
	MOVWF       FARG_sprintf_f+2 
	MOVF        _pid_t+20, 0 
	MOVWF       FARG_sprintf_wh+5 
	MOVF        _pid_t+21, 0 
	MOVWF       FARG_sprintf_wh+6 
	CALL        _sprintf+0, 0
;ReflowOven.c,270 :: 		I2C_LCD_Out(LCD_01_ADDRESS,4,5,txt4);
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
;ReflowOven.c,271 :: 		}
L_main70:
;ReflowOven.c,272 :: 		}
L_main69:
;ReflowOven.c,273 :: 		}
L_main68:
;ReflowOven.c,274 :: 		break;
	GOTO        L_main53
;ReflowOven.c,275 :: 		case 7:   //write data out to pc every 70*4 ms
L_main71:
;ReflowOven.c,276 :: 		Phs.UartWriter++;
	MOVF        _Phs+0, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Phs+0 
;ReflowOven.c,277 :: 		if(Phs.UartWriter == 8){
	MOVF        _Phs+0, 0 
	XORLW       8
	BTFSS       STATUS+0, 2 
	GOTO        L_main72
;ReflowOven.c,278 :: 		if(!WriteData){
	BTFSC       ReflowOven_Bits+0, 4 
	GOTO        L_main73
;ReflowOven.c,279 :: 		WriteData = on;
	BSF         ReflowOven_Bits+0, 4 
;ReflowOven.c,280 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,281 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,282 :: 		UART1_Write_Text(txt5);
	MOVLW       _txt5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,283 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,284 :: 		UART1_Write_Text(txt6);
	MOVLW       _txt6+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;ReflowOven.c,285 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,286 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;ReflowOven.c,287 :: 		}
L_main73:
;ReflowOven.c,288 :: 		}
L_main72:
;ReflowOven.c,289 :: 		break;
	GOTO        L_main53
;ReflowOven.c,290 :: 		default:
L_main74:
;ReflowOven.c,291 :: 		if(Phs.UartWriter > 8){
	MOVF        _Phs+0, 0 
	SUBLW       8
	BTFSC       STATUS+0, 0 
	GOTO        L_main75
;ReflowOven.c,292 :: 		Phs.UartWriter = 0;
	CLRF        _Phs+0 
;ReflowOven.c,293 :: 		WriteData = off;
	BCF         ReflowOven_Bits+0, 4 
;ReflowOven.c,294 :: 		}
L_main75:
;ReflowOven.c,295 :: 		if(DegC.sampleTimer >= 20)DegC.sampleTimer = 0;
	MOVLW       128
	XORWF       _DegC+19, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       20
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main76
	CLRF        _DegC+19 
L_main76:
;ReflowOven.c,296 :: 		if(pid_t.sample_tmr >=5)pid_t.sample_tmr = 0;
	MOVLW       128
	XORWF       _pid_t+32, 0 
	MOVWF       R0 
	MOVLW       128
	XORLW       5
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_main77
	CLRF        _pid_t+32 
L_main77:
;ReflowOven.c,297 :: 		if(TempBit)TempBit = off;
	BTFSS       ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
	GOTO        L_main78
	BCF         ReflowOven_TempBit+0, BitPos(ReflowOven_TempBit+0) 
L_main78:
;ReflowOven.c,298 :: 		if(pidBit) pidBit = off;
	BTFSS       ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
	GOTO        L_main79
	BCF         ReflowOven_pidBit+0, BitPos(ReflowOven_pidBit+0) 
L_main79:
;ReflowOven.c,299 :: 		Phs.PhaseCntr = 1;
	MOVLW       1
	MOVWF       _Phs+2 
;ReflowOven.c,300 :: 		break;
	GOTO        L_main53
;ReflowOven.c,301 :: 		}
L_main52:
	MOVF        _Phs+2, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
	MOVF        _Phs+2, 0 
	XORLW       2
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVF        _Phs+2, 0 
	XORLW       3
	BTFSC       STATUS+0, 2 
	GOTO        L_main59
	MOVF        _Phs+2, 0 
	XORLW       4
	BTFSC       STATUS+0, 2 
	GOTO        L_main61
	MOVF        _Phs+2, 0 
	XORLW       5
	BTFSC       STATUS+0, 2 
	GOTO        L_main63
	MOVF        _Phs+2, 0 
	XORLW       6
	BTFSC       STATUS+0, 2 
	GOTO        L_main67
	MOVF        _Phs+2, 0 
	XORLW       7
	BTFSC       STATUS+0, 2 
	GOTO        L_main71
	GOTO        L_main74
L_main53:
;ReflowOven.c,303 :: 		}
	GOTO        L_main5
;ReflowOven.c,305 :: 		}
L_end_main:
	GOTO        $+0
; end of _main

_HighPrioity:

;ReflowOven.c,310 :: 		void HighPrioity() iv 0x0008 ics ICS_AUTO {
;ReflowOven.c,311 :: 		High_Priority();
	CALL        _High_Priority+0, 0
;ReflowOven.c,312 :: 		}
L_end_HighPrioity:
L__HighPrioity107:
	RETFIE      1
; end of _HighPrioity

_Tmr1_Int:
	MOVWF       ___Low_saveWREG+0 
	MOVF        STATUS+0, 0 
	MOVWF       ___Low_saveSTATUS+0 
	MOVF        BSR+0, 0 
	MOVWF       ___Low_saveBSR+0 

;ReflowOven.c,314 :: 		void Tmr1_Int() iv 0x0018 ics ICS_AUTO {
;ReflowOven.c,315 :: 		Low_Priority();
	CALL        _Low_Priority+0, 0
;ReflowOven.c,316 :: 		}
L_end_Tmr1_Int:
L__Tmr1_Int109:
	MOVF        ___Low_saveBSR+0, 0 
	MOVWF       BSR+0 
	MOVF        ___Low_saveSTATUS+0, 0 
	MOVWF       STATUS+0 
	SWAPF       ___Low_saveWREG+0, 1 
	SWAPF       ___Low_saveWREG+0, 0 
	RETFIE      0
; end of _Tmr1_Int
