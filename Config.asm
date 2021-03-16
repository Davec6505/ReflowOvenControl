
_ConfPic:

;Config.c,6 :: 		void ConfPic(){
;Config.c,8 :: 		C1ON_bit = 0;  //turn off comparators
	BCF         C1ON_bit+0, BitPos(C1ON_bit+0) 
;Config.c,9 :: 		C2ON_bit = 0;
	BCF         C2ON_bit+0, BitPos(C2ON_bit+0) 
;Config.c,11 :: 		ANSELA = 0x03; //make RA0 to RA3 as analogs
	MOVLW       3
	MOVWF       ANSELA+0 
;Config.c,12 :: 		ANSELB = 0X00; //turn off all analogs attached to Port B
	CLRF        ANSELB+0 
;Config.c,13 :: 		ANSELC = 0X00;
	CLRF        ANSELC+0 
;Config.c,15 :: 		TRISA = 0x3F;  //RA0 - RA5 as inputs
	MOVLW       63
	MOVWF       TRISA+0 
;Config.c,16 :: 		TRISB = 0XC0;
	MOVLW       192
	MOVWF       TRISB+0 
;Config.c,17 :: 		TRISC = 0x08;  //RC port as outputs;
	MOVLW       8
	MOVWF       TRISC+0 
;Config.c,19 :: 		LATA  = 0;
	CLRF        LATA+0 
;Config.c,20 :: 		LATB  = 0;
	CLRF        LATB+0 
;Config.c,21 :: 		LATC  = 0;     //FORCE portc off
	CLRF        LATC+0 
;Config.c,25 :: 		CCPTMRS0 = 0xD0;
	MOVLW       208
	MOVWF       CCPTMRS0+0 
;Config.c,26 :: 		CCPTMRS1 = 0X0F;
	MOVLW       15
	MOVWF       CCPTMRS1+0 
;Config.c,28 :: 		I2C1_Init(100000);//INIT I2C AT 100KHZ
	MOVLW       160
	MOVWF       SSP1ADD+0 
	CALL        _I2C1_Init+0, 0
;Config.c,29 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_ConfPic0:
	DECFSZ      R13, 1, 1
	BRA         L_ConfPic0
	DECFSZ      R12, 1, 1
	BRA         L_ConfPic0
	DECFSZ      R11, 1, 1
	BRA         L_ConfPic0
	NOP
;Config.c,30 :: 		I2C1_SetTimeoutCallback(1000,I2C1_TimeoutCallback);    // enable error flag for I2C1 test
	MOVLW       232
	MOVWF       FARG_I2C1_SetTimeoutCallback_timeout+0 
	MOVLW       3
	MOVWF       FARG_I2C1_SetTimeoutCallback_timeout+1 
	MOVLW       0
	MOVWF       FARG_I2C1_SetTimeoutCallback_timeout+2 
	MOVWF       FARG_I2C1_SetTimeoutCallback_timeout+3 
	MOVLW       _I2C1_TimeoutCallback+0
	MOVWF       FARG_I2C1_SetTimeoutCallback_i2c1_timeout+0 
	MOVLW       hi_addr(_I2C1_TimeoutCallback+0)
	MOVWF       FARG_I2C1_SetTimeoutCallback_i2c1_timeout+1 
	MOVLW       FARG_I2C1_TimeoutCallback_errorCode+0
	MOVWF       FARG_I2C1_SetTimeoutCallback_i2c1_timeout+2 
	MOVLW       hi_addr(FARG_I2C1_TimeoutCallback_errorCode+0)
	MOVWF       FARG_I2C1_SetTimeoutCallback_i2c1_timeout+3 
	CALL        _I2C1_SetTimeoutCallback+0, 0
;Config.c,31 :: 		I2C_Set_Active(&I2C1_Start, &I2C1_Repeated_Start,&I2C1_Rd, &I2C1_Wr,&I2C1_Stop,&I2C1_Is_Idle); // Sets the I2C1 module active
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
;Config.c,32 :: 		ConfigSpi();
	CALL        _ConfigSpi+0, 0
;Config.c,33 :: 		SetUp_IOCxInterrupts();
	CALL        _SetUp_IOCxInterrupts+0, 0
;Config.c,34 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_ConfPic1:
	DECFSZ      R13, 1, 1
	BRA         L_ConfPic1
	DECFSZ      R12, 1, 1
	BRA         L_ConfPic1
	DECFSZ      R11, 1, 1
	BRA         L_ConfPic1
	NOP
;Config.c,35 :: 		UART1_Init(115200);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       138
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;Config.c,36 :: 		Uart1_En();
	CALL        _Uart1_En+0, 0
;Config.c,37 :: 		Delay_ms(100);
	MOVLW       9
	MOVWF       R11, 0
	MOVLW       30
	MOVWF       R12, 0
	MOVLW       228
	MOVWF       R13, 0
L_ConfPic2:
	DECFSZ      R13, 1, 1
	BRA         L_ConfPic2
	DECFSZ      R12, 1, 1
	BRA         L_ConfPic2
	DECFSZ      R11, 1, 1
	BRA         L_ConfPic2
	NOP
;Config.c,38 :: 		Set_Priority();
	CALL        _Set_Priority+0, 0
;Config.c,39 :: 		InitTimer0();
	CALL        _InitTimer0+0, 0
;Config.c,40 :: 		InitTimer1();
	CALL        _InitTimer1+0, 0
;Config.c,42 :: 		InitTimer3();
	CALL        _InitTimer3+0, 0
;Config.c,43 :: 		InitTimer5();
	CALL        _InitTimer5+0, 0
;Config.c,44 :: 		ADC_Init();
	CALL        _ADC_Init+0, 0
;Config.c,45 :: 		}
L_end_ConfPic:
	RETURN      0
; end of _ConfPic

_InitTimer0:

;Config.c,49 :: 		void InitTimer0(){
;Config.c,50 :: 		T0CON       =  0xF8;
	MOVLW       248
	MOVWF       T0CON+0 
;Config.c,51 :: 		TMR0L       =  0xFF; //To generate an immediate overflow
	MOVLW       255
	MOVWF       TMR0L+0 
;Config.c,52 :: 		TMR0IE_bit  = on;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Config.c,53 :: 		TMR0IP_bit  = on;    //assigne high priority
	BSF         TMR0IP_bit+0, BitPos(TMR0IP_bit+0) 
;Config.c,54 :: 		TMR0IF_bit  = off;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Config.c,55 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_InitTimer1:

;Config.c,58 :: 		void InitTimer1(){
;Config.c,59 :: 		T1CON       = 0x37;
	MOVLW       55
	MOVWF       T1CON+0 
;Config.c,60 :: 		TMR1GE_bit  = off;
	BCF         TMR1GE_bit+0, BitPos(TMR1GE_bit+0) 
;Config.c,61 :: 		TMR1IE_bit  = off;
	BCF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;Config.c,62 :: 		TMR1IF_bit  = off;
	BCF         TMR1IF_bit+0, BitPos(TMR1IF_bit+0) 
;Config.c,64 :: 		CCP1M3_bit = 1;     // |------
	BSF         CCP1M3_bit+0, BitPos(CCP1M3_bit+0) 
;Config.c,65 :: 		CCP1M2_bit = 0;     // | _ Special Event interrupt
	BCF         CCP1M2_bit+0, BitPos(CCP1M2_bit+0) 
;Config.c,66 :: 		CCP1M1_bit = 1;     // |
	BSF         CCP1M1_bit+0, BitPos(CCP1M1_bit+0) 
;Config.c,67 :: 		CCP1M0_bit = 1;     // |------
	BSF         CCP1M0_bit+0, BitPos(CCP1M0_bit+0) 
;Config.c,69 :: 		CCP1IE_bit = on;
	BSF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;Config.c,70 :: 		CCP1IF_bit = on;
	BSF         CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
;Config.c,71 :: 		CCP1IP_bit = on;
	BSF         CCP1IP_bit+0, BitPos(CCP1IP_bit+0) 
;Config.c,72 :: 		CCP1MD_bit = off;
	BCF         CCP1MD_bit+0, BitPos(CCP1MD_bit+0) 
;Config.c,74 :: 		CCPR1H = 0X00;
	CLRF        CCPR1H+0 
;Config.c,75 :: 		CCPR1L = 0XFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Config.c,77 :: 		}
L_end_InitTimer1:
	RETURN      0
; end of _InitTimer1

_InitTimer2:

;Config.c,80 :: 		void InitTimer2(){
;Config.c,81 :: 		TRISC2_bit = on;
	BSF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Config.c,82 :: 		CCP1MD_bit = off;
	BCF         CCP1MD_bit+0, BitPos(CCP1MD_bit+0) 
;Config.c,84 :: 		CCP1CON = 0x0C;
	MOVLW       12
	MOVWF       CCP1CON+0 
;Config.c,85 :: 		PR2 = 0X7D;//SetPwm();
	MOVLW       125
	MOVWF       PR2+0 
;Config.c,86 :: 		CCPR1L = 0;
	CLRF        CCPR1L+0 
;Config.c,87 :: 		DC1B1_bit = 0;
	BCF         DC1B1_bit+0, BitPos(DC1B1_bit+0) 
;Config.c,88 :: 		DC1B0_bit = 0;
	BCF         DC1B0_bit+0, BitPos(DC1B0_bit+0) 
;Config.c,89 :: 		T2CON              = 0x1C;
	MOVLW       28
	MOVWF       T2CON+0 
;Config.c,90 :: 		TRISC2_bit  = off;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Config.c,91 :: 		TMR2IF_bit  = off;
	BCF         TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
;Config.c,92 :: 		}
L_end_InitTimer2:
	RETURN      0
; end of _InitTimer2

_InitTimer3:

;Config.c,95 :: 		void InitTimer3(){
;Config.c,96 :: 		T3CON              = 0x01;
	MOVLW       1
	MOVWF       T3CON+0 
;Config.c,97 :: 		TMR3IF_bit  = 0;
	BCF         TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
;Config.c,98 :: 		TMR3H              = 0xC1;
	MOVLW       193
	MOVWF       TMR3H+0 
;Config.c,99 :: 		TMR3L              = 0x80;
	MOVLW       128
	MOVWF       TMR3L+0 
;Config.c,100 :: 		TMR3IE_bit  = on;
	BSF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;Config.c,101 :: 		TMR3IP_bit  = on;
	BSF         TMR3IP_bit+0, BitPos(TMR3IP_bit+0) 
;Config.c,102 :: 		TMR3IF_bit  = off;
	BCF         TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
;Config.c,103 :: 		}
L_end_InitTimer3:
	RETURN      0
; end of _InitTimer3

_InitTimer5:

;Config.c,107 :: 		void InitTimer5(){
;Config.c,108 :: 		T5CON       = 0x37;
	MOVLW       55
	MOVWF       T5CON+0 
;Config.c,109 :: 		TMR5GE_bit  = off;
	BCF         TMR5GE_bit+0, BitPos(TMR5GE_bit+0) 
;Config.c,110 :: 		TMR5IE_bit  = off;
	BCF         TMR5IE_bit+0, BitPos(TMR5IE_bit+0) 
;Config.c,112 :: 		CCP2M3_bit = 1;     // |------
	BSF         CCP2M3_bit+0, BitPos(CCP2M3_bit+0) 
;Config.c,113 :: 		CCP2M2_bit = 0;     // | _ Special Event interrupt
	BCF         CCP2M2_bit+0, BitPos(CCP2M2_bit+0) 
;Config.c,114 :: 		CCP2M1_bit = 1;     // |
	BSF         CCP2M1_bit+0, BitPos(CCP2M1_bit+0) 
;Config.c,115 :: 		CCP2M0_bit = 0;     // |------
	BCF         CCP2M0_bit+0, BitPos(CCP2M0_bit+0) 
;Config.c,117 :: 		CCP2IE_bit = on;
	BSF         CCP2IE_bit+0, BitPos(CCP2IE_bit+0) 
;Config.c,118 :: 		CCP2IP_bit = on;
	BSF         CCP2IP_bit+0, BitPos(CCP2IP_bit+0) 
;Config.c,119 :: 		CCP2IF_bit = off;
	BCF         CCP2IF_bit+0, BitPos(CCP2IF_bit+0) 
;Config.c,120 :: 		CCP2MD_bit = off;
	BCF         CCP2MD_bit+0, BitPos(CCP2MD_bit+0) 
;Config.c,122 :: 		CCPR2H = 0;
	CLRF        CCPR2H+0 
;Config.c,123 :: 		CCPR2L = 0;
	CLRF        CCPR2L+0 
;Config.c,125 :: 		}
L_end_InitTimer5:
	RETURN      0
; end of _InitTimer5

_Uart1_En:

;Config.c,127 :: 		void Uart1_En(){
;Config.c,128 :: 		RC1IE_bit = 1;  //turn on recieve interrupts
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;Config.c,129 :: 		RC1IP_bit = 0; //low priority interrupt
	BCF         RC1IP_bit+0, BitPos(RC1IP_bit+0) 
;Config.c,130 :: 		RC1IF_bit = 0;
	BCF         RC1IF_bit+0, BitPos(RC1IF_bit+0) 
;Config.c,131 :: 		}
L_end_Uart1_En:
	RETURN      0
; end of _Uart1_En

_Set_Priority:

;Config.c,133 :: 		void Set_Priority(){
;Config.c,134 :: 		IPEN_bit  = 1;  //PRIORITY INTERRUPTS ENABLE
	BSF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;Config.c,135 :: 		}
L_end_Set_Priority:
	RETURN      0
; end of _Set_Priority

_EI:

;Config.c,136 :: 		void EI(){
;Config.c,137 :: 		GIEH_bit  = 1;  //GLOBAL INTERRUPTS ENABLE
	BSF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;Config.c,138 :: 		GIEL_bit  = 1;  //PERIPHAL INTERRUPTS ENABLE
	BSF         GIEL_bit+0, BitPos(GIEL_bit+0) 
;Config.c,139 :: 		}
L_end_EI:
	RETURN      0
; end of _EI

_DI:

;Config.c,140 :: 		void DI(){
;Config.c,141 :: 		GIEH_bit  = 0;  //GLOBAL INTERRUPTS ENABLE
	BCF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;Config.c,142 :: 		GIEL_bit  = 0;  //PERIPHAL INTERRUPTS ENABLE
	BCF         GIEL_bit+0, BitPos(GIEL_bit+0) 
;Config.c,143 :: 		}
L_end_DI:
	RETURN      0
; end of _DI

_SetUp_IOCxInterrupts:

;Config.c,145 :: 		void SetUp_IOCxInterrupts(){
;Config.c,146 :: 		IOCB7_bit = 1;
	BSF         IOCB7_bit+0, BitPos(IOCB7_bit+0) 
;Config.c,147 :: 		IOCB6_bit = 1;
	BSF         IOCB6_bit+0, BitPos(IOCB6_bit+0) 
;Config.c,148 :: 		RBIE_bit  = on; //ENABLE IOCx
	BSF         RBIE_bit+0, BitPos(RBIE_bit+0) 
;Config.c,149 :: 		RBIP_bit  = 0;
	BCF         RBIP_bit+0, BitPos(RBIP_bit+0) 
;Config.c,150 :: 		RBIF_bit  = 0;
	BCF         RBIF_bit+0, BitPos(RBIF_bit+0) 
;Config.c,151 :: 		}
L_end_SetUp_IOCxInterrupts:
	RETURN      0
; end of _SetUp_IOCxInterrupts

_ClearAll:

;Config.c,152 :: 		void ClearAll(){
;Config.c,153 :: 		tmr.SecNew = -1;
	MOVLW       255
	MOVWF       _tmr+16 
	MOVLW       255
	MOVWF       _tmr+17 
;Config.c,154 :: 		tmr.MinNew = -1;
	MOVLW       255
	MOVWF       _tmr+18 
	MOVLW       255
	MOVWF       _tmr+19 
;Config.c,155 :: 		tmr.millis  = 0;
	CLRF        _tmr+2 
	CLRF        _tmr+3 
;Config.c,156 :: 		tmr.ms  = 0;
	CLRF        _tmr+6 
	CLRF        _tmr+7 
;Config.c,157 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;Config.c,158 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;Config.c,159 :: 		tmr.I_Dlys  = 0;
	CLRF        _tmr+0 
	CLRF        _tmr+1 
;Config.c,160 :: 		Phs.UartWriter = 0;
	CLRF        _Phs+0 
;Config.c,161 :: 		Phs.pwmOut = 0;
	CLRF        _Phs+1 
;Config.c,162 :: 		Phs.PhasePulsCntr = 0;
	CLRF        _Phs+3 
;Config.c,163 :: 		Phs.PhaseCntr = 1;
	MOVLW       1
	MOVWF       _Phs+2 
;Config.c,164 :: 		DegC.sampleTimer = 0;
	CLRF        _DegC+21 
;Config.c,165 :: 		wait = off;
	BCF         _wait+0, BitPos(_wait+0) 
;Config.c,166 :: 		DegC.Temp_iPv = 0;
	CLRF        _DegC+16 
	CLRF        _DegC+17 
;Config.c,167 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;Config.c,168 :: 		Menu_Bit = 0;
	BCF         _Menu_Bit+0, BitPos(_Menu_Bit+0) 
;Config.c,169 :: 		Ok_Bit = 0;
	BCF         _OK_Bit+0, BitPos(_OK_Bit+0) 
;Config.c,170 :: 		OFF_Bit = 0;
	BCF         _OFF_Bit+0, BitPos(_OFF_Bit+0) 
;Config.c,171 :: 		pid_t.Mv = 10;
	MOVLW       10
	MOVWF       _pid_t+20 
	MOVLW       0
	MOVWF       _pid_t+21 
;Config.c,172 :: 		}
L_end_ClearAll:
	RETURN      0
; end of _ClearAll

_WriteStart:

;Config.c,174 :: 		void WriteStart(){
;Config.c,175 :: 		UART1_Write_Text("Start");
	MOVLW       ?lstr1_Config+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr1_Config+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,176 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,177 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,178 :: 		}
L_end_WriteStart:
	RETURN      0
; end of _WriteStart

_WriteFin:

;Config.c,180 :: 		void WriteFin(){
;Config.c,181 :: 		UART1_Write_Text("Finnished");
	MOVLW       ?lstr2_Config+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(?lstr2_Config+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,182 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,183 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,184 :: 		}
L_end_WriteFin:
	RETURN      0
; end of _WriteFin

_WriteDataOut:

;Config.c,186 :: 		void WriteDataOut(){
;Config.c,187 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,188 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,189 :: 		UART1_Write_Text(txt5);
	MOVLW       _txt5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,190 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,191 :: 		UART1_Write_Text(txt6);
	MOVLW       _txt6+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,192 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,193 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,194 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,195 :: 		}
L_end_WriteDataOut:
	RETURN      0
; end of _WriteDataOut
