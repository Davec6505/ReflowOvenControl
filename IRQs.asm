
_High_Priority:

;IRQs.c,6 :: 		void High_Priority(){
;IRQs.c,7 :: 		if (TMR3IF_bit){
	BTFSS       TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
	GOTO        L_High_Priority0
;IRQs.c,8 :: 		TMR3IF_bit = 0;
	BCF         TMR3IF_bit+0, BitPos(TMR3IF_bit+0) 
;IRQs.c,9 :: 		TMR3();
	CALL        _TMR3+0, 0
;IRQs.c,10 :: 		}
L_High_Priority0:
;IRQs.c,12 :: 		if(TMR0IF_bit){
	BTFSS       TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
	GOTO        L_High_Priority1
;IRQs.c,15 :: 		TMR0IF_bit  = off;
	BCF         TMR0IF_bit+0, BitPos(TMR0IF_bit+0) 
;IRQs.c,16 :: 		TMR0L       = 0xFF;
	MOVLW       255
	MOVWF       TMR0L+0 
;IRQs.c,18 :: 		if(Phs.PhasePulsCntr == 4)Phs.PhasePulsCntr = 0;
	MOVF        _Phs+3, 0 
	XORLW       4
	BTFSS       STATUS+0, 2 
	GOTO        L_High_Priority2
	CLRF        _Phs+3 
L_High_Priority2:
;IRQs.c,19 :: 		Phs.pwmOut = 0;
	CLRF        _Phs+1 
;IRQs.c,20 :: 		Phs.PhaseCntr++;
	MOVF        _Phs+2, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Phs+2 
;IRQs.c,21 :: 		TMR1H       = 0;
	CLRF        TMR1H+0 
;IRQs.c,22 :: 		TMR1L       = 0;
	CLRF        TMR1L+0 
;IRQs.c,23 :: 		CCPR1L      = Phs.an0_0 & 0XFF;
	MOVLW       255
	ANDWF       _Phs+12, 0 
	MOVWF       CCPR1L+0 
;IRQs.c,24 :: 		CCPR1H      = Phs.an0_0 >> 8 ;
	MOVF        _Phs+13, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       CCPR1H+0 
;IRQs.c,27 :: 		LATC0_bit   = on;
	BSF         LATC0_bit+0, BitPos(LATC0_bit+0) 
;IRQs.c,29 :: 		TMR5H       = 0;
	CLRF        TMR5H+0 
;IRQs.c,30 :: 		TMR5L       = 0;
	CLRF        TMR5L+0 
;IRQs.c,31 :: 		CCPR2L      = Phs.an1_1 & 0XFF;
	MOVLW       255
	ANDWF       _Phs+20, 0 
	MOVWF       CCPR2L+0 
;IRQs.c,32 :: 		CCPR2H      = Phs.an1_1 >> 8 ;
	MOVF        _Phs+21, 0 
	MOVWF       R0 
	CLRF        R1 
	MOVF        R0, 0 
	MOVWF       CCPR2H+0 
;IRQs.c,35 :: 		CCP1IF_bit  = off;
	BCF         CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
;IRQs.c,36 :: 		if(RA3_Bit)CCP1IE_bit  = on;
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_High_Priority3
	BSF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
L_High_Priority3:
;IRQs.c,37 :: 		CCP2IE_bit = on;
	BSF         CCP2IE_bit+0, BitPos(CCP2IE_bit+0) 
;IRQs.c,38 :: 		CCP2IF_bit = off;
	BCF         CCP2IF_bit+0, BitPos(CCP2IF_bit+0) 
;IRQs.c,39 :: 		}
L_High_Priority1:
;IRQs.c,41 :: 		if(CCP1IF_bit){
	BTFSS       CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
	GOTO        L_High_Priority4
;IRQs.c,42 :: 		CCP1IF_bit = off;
	BCF         CCP1IF_bit+0, BitPos(CCP1IF_bit+0) 
;IRQs.c,43 :: 		if((Phs.pwmOut == 0)&&(Phs.PhasePulsCntr < 4)){
	MOVF        _Phs+1, 0 
	XORLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L_High_Priority7
	MOVLW       4
	SUBWF       _Phs+3, 0 
	BTFSC       STATUS+0, 0 
	GOTO        L_High_Priority7
L__High_Priority31:
;IRQs.c,44 :: 		CCP1IE_bit  = off;
	BCF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;IRQs.c,45 :: 		if(RA3_Bit && (pid_t.Mv > 0))LATC2_bit = on;
	BTFSS       RA3_bit+0, BitPos(RA3_bit+0) 
	GOTO        L_High_Priority10
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       _pid_t+21, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__High_Priority34
	MOVF        _pid_t+20, 0 
	SUBLW       0
L__High_Priority34:
	BTFSC       STATUS+0, 0 
	GOTO        L_High_Priority10
L__High_Priority30:
	BSF         LATC2_bit+0, BitPos(LATC2_bit+0) 
L_High_Priority10:
;IRQs.c,46 :: 		Phs.pwmOut = 1;
	MOVLW       1
	MOVWF       _Phs+1 
;IRQs.c,47 :: 		TMR1H  = 0;
	CLRF        TMR1H+0 
;IRQs.c,48 :: 		TMR1L  = 0;
	CLRF        TMR1L+0 
;IRQs.c,49 :: 		CCPR1L = 250;//Phs.an1_ & 0XFF;
	MOVLW       250
	MOVWF       CCPR1L+0 
;IRQs.c,50 :: 		CCPR1H = 0;//Phs.an1_ >> 8 ;
	CLRF        CCPR1H+0 
;IRQs.c,52 :: 		wait = on;
	BSF         _wait+0, BitPos(_wait+0) 
;IRQs.c,54 :: 		}
L_High_Priority7:
;IRQs.c,56 :: 		if((Phs.pwmOut == 1)&&(!wait)){
	MOVF        _Phs+1, 0 
	XORLW       1
	BTFSS       STATUS+0, 2 
	GOTO        L_High_Priority13
	BTFSC       _wait+0, BitPos(_wait+0) 
	GOTO        L_High_Priority13
L__High_Priority29:
;IRQs.c,57 :: 		Phs.PhasePulsCntr++;
	MOVF        _Phs+3, 0 
	ADDLW       1
	MOVWF       R0 
	MOVF        R0, 0 
	MOVWF       _Phs+3 
;IRQs.c,58 :: 		TMR1H  = 0;
	CLRF        TMR1H+0 
;IRQs.c,59 :: 		TMR1L  = 0;
	CLRF        TMR1L+0 
;IRQs.c,60 :: 		CCPR1L = 50;
	MOVLW       50
	MOVWF       CCPR1L+0 
;IRQs.c,61 :: 		CCPR1H = 0;
	CLRF        CCPR1H+0 
;IRQs.c,62 :: 		LATC2_bit = off;
	BCF         LATC2_bit+0, BitPos(LATC2_bit+0) 
;IRQs.c,63 :: 		Phs.pwmOut = 0;
	CLRF        _Phs+1 
;IRQs.c,64 :: 		if(Phs.PhasePulsCntr >= 3){
	MOVLW       3
	SUBWF       _Phs+3, 0 
	BTFSS       STATUS+0, 0 
	GOTO        L_High_Priority14
;IRQs.c,65 :: 		CCP1IE_bit  = off;
	BCF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;IRQs.c,66 :: 		Phs.PhasePulsCntr = 4;
	MOVLW       4
	MOVWF       _Phs+3 
;IRQs.c,67 :: 		}
L_High_Priority14:
;IRQs.c,69 :: 		}
L_High_Priority13:
;IRQs.c,70 :: 		if(wait){
	BTFSS       _wait+0, BitPos(_wait+0) 
	GOTO        L_High_Priority15
;IRQs.c,71 :: 		wait = off;
	BCF         _wait+0, BitPos(_wait+0) 
;IRQs.c,72 :: 		CCP1IE_bit  = on;
	BSF         CCP1IE_bit+0, BitPos(CCP1IE_bit+0) 
;IRQs.c,73 :: 		}
L_High_Priority15:
;IRQs.c,75 :: 		}
L_High_Priority4:
;IRQs.c,76 :: 		if((CCP2IF_bit)&&(LATC1_bit)){
	BTFSS       CCP2IF_bit+0, BitPos(CCP2IF_bit+0) 
	GOTO        L_High_Priority18
	BTFSS       LATC1_bit+0, BitPos(LATC1_bit+0) 
	GOTO        L_High_Priority18
L__High_Priority28:
;IRQs.c,77 :: 		CCP2IE_bit = off;
	BCF         CCP2IE_bit+0, BitPos(CCP2IE_bit+0) 
;IRQs.c,78 :: 		CCP2IF_bit = off;
	BCF         CCP2IF_bit+0, BitPos(CCP2IF_bit+0) 
;IRQs.c,79 :: 		LATC0_bit   = off;
	BCF         LATC0_bit+0, BitPos(LATC0_bit+0) 
;IRQs.c,80 :: 		}
L_High_Priority18:
;IRQs.c,81 :: 		}
L_end_High_Priority:
	RETURN      0
; end of _High_Priority

_Low_Priority:

;IRQs.c,83 :: 		void Low_Priority(){
;IRQs.c,87 :: 		if(RBIF_bit){
	BTFSS       RBIF_bit+0, BitPos(RBIF_bit+0) 
	GOTO        L_Low_Priority19
;IRQs.c,88 :: 		RBIF_bit  = 0;
	BCF         RBIF_bit+0, BitPos(RBIF_bit+0) 
;IRQs.c,89 :: 		if((IOCB6_bit)||(IOCB7_bit))
	BTFSC       IOCB6_bit+0, BitPos(IOCB6_bit+0) 
	GOTO        L__Low_Priority32
	BTFSC       IOCB7_bit+0, BitPos(IOCB7_bit+0) 
	GOTO        L__Low_Priority32
	GOTO        L_Low_Priority22
L__Low_Priority32:
;IRQs.c,90 :: 		Encode();
	CALL        _Encode+0, 0
L_Low_Priority22:
;IRQs.c,91 :: 		}
L_Low_Priority19:
;IRQs.c,93 :: 		if(RC1IF_bit){
	BTFSS       RC1IF_bit+0, BitPos(RC1IF_bit+0) 
	GOTO        L_Low_Priority23
;IRQs.c,94 :: 		RCIF_bit = off;
	BCF         RCIF_bit+0, BitPos(RCIF_bit+0) 
;IRQs.c,95 :: 		Serial();
	CALL        _Serial+0, 0
;IRQs.c,96 :: 		}
L_Low_Priority23:
;IRQs.c,97 :: 		}
L_end_Low_Priority:
	RETURN      0
; end of _Low_Priority

_DoTime:

;IRQs.c,99 :: 		void DoTime(){
;IRQs.c,100 :: 		if(tmr.ms > 999){
	MOVF        _tmr+7, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__DoTime37
	MOVF        _tmr+6, 0 
	SUBLW       231
L__DoTime37:
	BTFSC       STATUS+0, 0 
	GOTO        L_DoTime24
;IRQs.c,101 :: 		tmr.ms = 0;
	CLRF        _tmr+6 
	CLRF        _tmr+7 
;IRQs.c,102 :: 		tmr.sec++;
	MOVLW       1
	ADDWF       _tmr+10, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+11, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+10 
	MOVF        R1, 0 
	MOVWF       _tmr+11 
;IRQs.c,104 :: 		if(tmr.sec > 59){
	MOVLW       0
	MOVWF       R0 
	MOVF        _tmr+11, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DoTime38
	MOVF        _tmr+10, 0 
	SUBLW       59
L__DoTime38:
	BTFSC       STATUS+0, 0 
	GOTO        L_DoTime25
;IRQs.c,106 :: 		tmr.sec = 0;
	CLRF        _tmr+10 
	CLRF        _tmr+11 
;IRQs.c,107 :: 		tmr.min++;
	MOVLW       1
	ADDWF       _tmr+12, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+13, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+12 
	MOVF        R1, 0 
	MOVWF       _tmr+13 
;IRQs.c,109 :: 		if(tmr.min > 59){
	MOVLW       0
	MOVWF       R0 
	MOVF        _tmr+13, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__DoTime39
	MOVF        _tmr+12, 0 
	SUBLW       59
L__DoTime39:
	BTFSC       STATUS+0, 0 
	GOTO        L_DoTime26
;IRQs.c,111 :: 		tmr.min = 0;
	CLRF        _tmr+12 
	CLRF        _tmr+13 
;IRQs.c,112 :: 		}
L_DoTime26:
;IRQs.c,113 :: 		}
L_DoTime25:
;IRQs.c,114 :: 		}
L_DoTime24:
;IRQs.c,115 :: 		}
L_end_DoTime:
	RETURN      0
; end of _DoTime

_TMR3:

;IRQs.c,117 :: 		void TMR3(){
;IRQs.c,118 :: 		TMR3H      = 0xC1;
	MOVLW       193
	MOVWF       TMR3H+0 
;IRQs.c,119 :: 		TMR3L      = 0x80;
	MOVLW       128
	MOVWF       TMR3L+0 
;IRQs.c,123 :: 		tmr.millis++;
	MOVLW       1
	ADDWF       _tmr+2, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+3, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+2 
	MOVF        R1, 0 
	MOVWF       _tmr+3 
;IRQs.c,127 :: 		tmr.tenMilli++;
	MOVLW       1
	ADDWF       _tmr+4, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+5, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+4 
	MOVF        R1, 0 
	MOVWF       _tmr+5 
;IRQs.c,131 :: 		tmr.ms++;
	MOVLW       1
	ADDWF       _tmr+6, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+7, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+6 
	MOVF        R1, 0 
	MOVWF       _tmr+7 
;IRQs.c,132 :: 		tmr.ten_ms++;
	MOVLW       1
	ADDWF       _tmr+8, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _tmr+9, 0 
	MOVWF       R1 
	MOVF        R0, 0 
	MOVWF       _tmr+8 
	MOVF        R1, 0 
	MOVWF       _tmr+9 
;IRQs.c,133 :: 		if(tmr.ten_ms > 9){
	MOVLW       0
	MOVWF       R0 
	MOVF        _tmr+9, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__TMR341
	MOVF        _tmr+8, 0 
	SUBLW       9
L__TMR341:
	BTFSC       STATUS+0, 0 
	GOTO        L_TMR327
;IRQs.c,134 :: 		tmr.ten_ms = 0;
	CLRF        _tmr+8 
	CLRF        _tmr+9 
;IRQs.c,135 :: 		}
L_TMR327:
;IRQs.c,136 :: 		}
L_end_TMR3:
	RETURN      0
; end of _TMR3

_Serial:

;IRQs.c,138 :: 		void Serial(){
;IRQs.c,139 :: 		TXREG1 = RCREG1;
	MOVF        RCREG1+0, 0 
	MOVWF       TXREG1+0 
;IRQs.c,140 :: 		}
L_end_Serial:
	RETURN      0
; end of _Serial
