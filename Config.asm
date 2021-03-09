
_ConfPic:

;Config.c,6 :: 		void ConfPic(){
;Config.c,8 :: 		ANSELA = 0x07; //make RA0 to RA3 as analogs
	MOVLW       7
	MOVWF       ANSELA+0 
;Config.c,9 :: 		ANSELB = 0X00; //turn off all analogs attached to Port B
	CLRF        ANSELB+0 
;Config.c,10 :: 		ANSELC = 0X00;
	CLRF        ANSELC+0 
;Config.c,12 :: 		TRISA = 0x3F;  //RA0 - RA5 as inputs
	MOVLW       63
	MOVWF       TRISA+0 
;Config.c,13 :: 		TRISB = 0X00;
	CLRF        TRISB+0 
;Config.c,14 :: 		TRISC = 0x08;  //RC port as outputs;
	MOVLW       8
	MOVWF       TRISC+0 
;Config.c,15 :: 		LATC  = 0;     //FORCE portc off
	CLRF        LATC+0 
;Config.c,19 :: 		C1ON_bit = 0;  //turn off comparators
	BCF         C1ON_bit+0, BitPos(C1ON_bit+0) 
;Config.c,20 :: 		C2ON_bit = 0;
	BCF         C2ON_bit+0, BitPos(C2ON_bit+0) 
;Config.c,22 :: 		CCPTMRS0 = 0xD0;
	MOVLW       208
	MOVWF       CCPTMRS0+0 
;Config.c,23 :: 		CCPTMRS1 = 0X0F;
	MOVLW       15
	MOVWF       CCPTMRS1+0 
;Config.c,24 :: 		}
L_end_ConfPic:
	RETURN      0
; end of _ConfPic

_InitTimer0:

;Config.c,27 :: 		void InitTimer0(){
;Config.c,28 :: 		T0CON       =  0xF8;
	MOVLW       248
	MOVWF       T0CON+0 
;Config.c,29 :: 		TMR0L       =  0xFF; //To generate an immediate overflow
	MOVLW       255
	MOVWF       TMR0L+0 
;Config.c,30 :: 		TMR0IE_bit  = on;
	BSF         TMR0IE_bit+0, BitPos(TMR0IE_bit+0) 
;Config.c,31 :: 		TMR0IF_bit  = off;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;Config.c,32 :: 		TMR0IP_bit  = on;    //assigne high priority
	BSF         TMR0IP_bit+0, BitPos(TMR0IP_bit+0) 
;Config.c,33 :: 		}
L_end_InitTimer0:
	RETURN      0
; end of _InitTimer0

_InitTimer1:

;Config.c,36 :: 		void InitTimer1(){
;Config.c,37 :: 		T1CON       = 0x37;
	MOVLW       55
	MOVWF       T1CON+0 
;Config.c,38 :: 		TMR1GE_bit  = off;
	BCF         TMR1GE_bit+0, BitPos(TMR1GE_bit+0) 
;Config.c,39 :: 		TMR1IE_bit  = off;
	BCF         TMR1IE_bit+0, BitPos(TMR1IE_bit+0) 
;Config.c,41 :: 		CCP1M3_bit = 1;     // |------
	BSF         CCP1M3_bit+0, BitPos(CCP1M3_bit+0) 
;Config.c,42 :: 		CCP1M2_bit = 0;     // | _ Special Event interrupt
	BCF         CCP1M2_bit+0, BitPos(CCP1M2_bit+0) 
;Config.c,43 :: 		CCP1M1_bit = 1;     // |
	BSF         CCP1M1_bit+0, BitPos(CCP1M1_bit+0) 
;Config.c,44 :: 		CCP1M0_bit = 1;     // |------
	BSF         CCP1M0_bit+0, BitPos(CCP1M0_bit+0) 
;Config.c,46 :: 		CCP1IE_bit = on;
	BSF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;Config.c,47 :: 		CCP1IF_bit = on;
	BSF         CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
;Config.c,48 :: 		CCP1IP_bit = on;
	BSF         CCP1IP_bit+0, BitPos(CCP1IP_bit+0) 
;Config.c,49 :: 		CCP1MD_bit = off;
	BCF         CCP1MD_bit+0, BitPos(CCP1MD_bit+0) 
;Config.c,51 :: 		CCPR1H = 0X00;
	CLRF        CCPR1H+0 
;Config.c,52 :: 		CCPR1L = 0XFF;
	MOVLW       255
	MOVWF       CCPR1L+0 
;Config.c,54 :: 		}
L_end_InitTimer1:
	RETURN      0
; end of _InitTimer1

_InitTimer2:

;Config.c,57 :: 		void InitTimer2(){
;Config.c,58 :: 		TRISC2_bit = on;
	BSF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Config.c,59 :: 		CCP1MD_bit = off;
	BCF         CCP1MD_bit+0, BitPos(CCP1MD_bit+0) 
;Config.c,61 :: 		CCP1CON = 0x0C;
	MOVLW       12
	MOVWF       CCP1CON+0 
;Config.c,62 :: 		PR2 = 0X7D;//SetPwm();
	MOVLW       125
	MOVWF       PR2+0 
;Config.c,63 :: 		CCPR1L = 0;
	CLRF        CCPR1L+0 
;Config.c,64 :: 		DC1B1_bit = 0;
	BCF         DC1B1_bit+0, BitPos(DC1B1_bit+0) 
;Config.c,65 :: 		DC1B0_bit = 0;
	BCF         DC1B0_bit+0, BitPos(DC1B0_bit+0) 
;Config.c,66 :: 		T2CON              = 0x1C;
	MOVLW       28
	MOVWF       T2CON+0 
;Config.c,67 :: 		TMR2IF_bit  = off;
	BCF         TMR2IF_bit+0, BitPos(TMR2IF_bit+0) 
;Config.c,68 :: 		TRISC2_bit  = off;
	BCF         TRISC2_bit+0, BitPos(TRISC2_bit+0) 
;Config.c,69 :: 		}
L_end_InitTimer2:
	RETURN      0
; end of _InitTimer2

_InitTimer3:

;Config.c,72 :: 		void InitTimer3(){
;Config.c,73 :: 		T3CON              = 0x01;
	MOVLW       1
	MOVWF       T3CON+0 
;Config.c,74 :: 		TMR3IF_bit  = 0;
	BCF         TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
;Config.c,75 :: 		TMR3H              = 0xC1;
	MOVLW       193
	MOVWF       TMR3H+0 
;Config.c,76 :: 		TMR3L              = 0x80;
	MOVLW       128
	MOVWF       TMR3L+0 
;Config.c,77 :: 		TMR3IE_bit  = 1;
	BSF         TMR3IE_bit+0, BitPos(TMR3IE_bit+0) 
;Config.c,78 :: 		TMR3IP_bit  = 0;
	BCF         TMR3IP_bit+0, BitPos(TMR3IP_bit+0) 
;Config.c,80 :: 		}
L_end_InitTimer3:
	RETURN      0
; end of _InitTimer3

_InitTimer5:

;Config.c,83 :: 		void InitTimer5(){
;Config.c,84 :: 		T5CON       = 0x37;
	MOVLW       55
	MOVWF       T5CON+0 
;Config.c,85 :: 		TMR5GE_bit  = off;
	BCF         TMR5GE_bit+0, BitPos(TMR5GE_bit+0) 
;Config.c,86 :: 		TMR5IE_bit  = off;
	BCF         TMR5IE_bit+0, BitPos(TMR5IE_bit+0) 
;Config.c,88 :: 		CCP2M3_bit = 1;     // |------
	BSF         CCP2M3_bit+0, BitPos(CCP2M3_bit+0) 
;Config.c,89 :: 		CCP2M2_bit = 0;     // | _ Special Event interrupt
	BCF         CCP2M2_bit+0, BitPos(CCP2M2_bit+0) 
;Config.c,90 :: 		CCP2M1_bit = 1;     // |
	BSF         CCP2M1_bit+0, BitPos(CCP2M1_bit+0) 
;Config.c,91 :: 		CCP2M0_bit = 0;     // |------
	BCF         CCP2M0_bit+0, BitPos(CCP2M0_bit+0) 
;Config.c,93 :: 		CCP2IE_bit = on;
	BSF         CCP2IE_bit+0, BitPos(CCP2IE_bit+0) 
;Config.c,94 :: 		CCP2IF_bit = off;
	BCF         CCP2IF_bit+0, BitPos(CCP2IF_bit+0) 
;Config.c,95 :: 		CCP2IP_bit = on;
	BSF         CCP2IP_bit+0, BitPos(CCP2IP_bit+0) 
;Config.c,96 :: 		CCP2MD_bit = off;
	BCF         CCP2MD_bit+0, BitPos(CCP2MD_bit+0) 
;Config.c,98 :: 		CCPR2H = 0;
	CLRF        CCPR2H+0 
;Config.c,99 :: 		CCPR2L = 0;
	CLRF        CCPR2L+0 
;Config.c,101 :: 		}
L_end_InitTimer5:
	RETURN      0
; end of _InitTimer5

_Uart1_En:

;Config.c,103 :: 		void Uart1_En(){
;Config.c,104 :: 		RC1IE_bit = 1;  //turn on recieve interrupts
	BSF         RC1IE_bit+0, BitPos(RC1IE_bit+0) 
;Config.c,105 :: 		RC1IF_bit = 0;
	BCF         RC1IF_bit+0, BitPos(RC1IF_bit+0) 
;Config.c,106 :: 		RC1IP_bit = 0; //low priority interrupt
	BCF         RC1IP_bit+0, BitPos(RC1IP_bit+0) 
;Config.c,107 :: 		}
L_end_Uart1_En:
	RETURN      0
; end of _Uart1_En

_Set_Priority:

;Config.c,109 :: 		void Set_Priority(){
;Config.c,110 :: 		IPEN_bit  = 1;  //PRIORITY INTERRUPTS ENABLE
	BSF         IPEN_bit+0, BitPos(IPEN_bit+0) 
;Config.c,111 :: 		}
L_end_Set_Priority:
	RETURN      0
; end of _Set_Priority

_EI:

;Config.c,112 :: 		void EI(){
;Config.c,113 :: 		GIEH_bit  = 1;  //GLOBAL INTERRUPTS ENABLE
	BSF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;Config.c,114 :: 		GIEL_bit  = 1;  //PERIPHAL INTERRUPTS ENABLE
	BSF         GIEL_bit+0, BitPos(GIEL_bit+0) 
;Config.c,115 :: 		}
L_end_EI:
	RETURN      0
; end of _EI

_DI:

;Config.c,116 :: 		void DI(){
;Config.c,117 :: 		GIEH_bit  = 0;  //GLOBAL INTERRUPTS ENABLE
	BCF         GIEH_bit+0, BitPos(GIEH_bit+0) 
;Config.c,119 :: 		}
L_end_DI:
	RETURN      0
; end of _DI

_ClearAll:

;Config.c,120 :: 		void ClearAll(){
;Config.c,121 :: 		tmr.SecNew = -1;
	MOVLW       255
	MOVWF       _tmr+16 
	MOVLW       255
	MOVWF       _tmr+17 
;Config.c,122 :: 		tmr.MinNew = -1;
	MOVLW       255
	MOVWF       _tmr+18 
	MOVLW       255
	MOVWF       _tmr+19 
;Config.c,123 :: 		tmr.millis  = 0;
	CLRF        _tmr+2 
	CLRF        _tmr+3 
;Config.c,124 :: 		tmr.ms  = 0;
	CLRF        _tmr+6 
	CLRF        _tmr+7 
;Config.c,125 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;Config.c,126 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;Config.c,127 :: 		tmr.I_Dlys  = 0;
	CLRF        _tmr+0 
	CLRF        _tmr+1 
;Config.c,128 :: 		Phs.UartWriter = 0;
	CLRF        _Phs+0 
;Config.c,129 :: 		Phs.pwmOut = 0;
	CLRF        _Phs+1 
;Config.c,130 :: 		Phs.PhasePulsCntr = 0;
	CLRF        _Phs+3 
;Config.c,131 :: 		Phs.PhaseCntr = 1;
	MOVLW       1
	MOVWF       _Phs+2 
;Config.c,132 :: 		DegC.sampleTimer = 0;
	CLRF        _DegC+19 
;Config.c,133 :: 		}
L_end_ClearAll:
	RETURN      0
; end of _ClearAll

_WriteDataOut:

;Config.c,136 :: 		void WriteDataOut(){
;Config.c,137 :: 		UART1_Write_Text(txt1);
	MOVLW       _txt1+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt1+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,138 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,139 :: 		UART1_Write_Text(txt5);
	MOVLW       _txt5+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt5+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,140 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,141 :: 		UART1_Write_Text(txt6);
	MOVLW       _txt6+0
	MOVWF       FARG_UART1_Write_Text_uart_text+0 
	MOVLW       hi_addr(_txt6+0)
	MOVWF       FARG_UART1_Write_Text_uart_text+1 
	CALL        _UART1_Write_Text+0, 0
;Config.c,142 :: 		UART1_Write(',');
	MOVLW       44
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,143 :: 		UART1_Write(0x0D);
	MOVLW       13
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,144 :: 		UART1_Write(0x0A);
	MOVLW       10
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;Config.c,145 :: 		}
L_end_WriteDataOut:
	RETURN      0
; end of _WriteDataOut
