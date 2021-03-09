
_ConfigSpi:

;Max31855J.c,20 :: 		void ConfigSpi(){
;Max31855J.c,25 :: 		Chip_Select_Direction = 0;             // Set CS# pin as Output
	BCF         TRISC1_bit+0, BitPos(TRISC1_bit+0) 
;Max31855J.c,26 :: 		Chip_Select = 1;                       // Deselect DAC
	BSF         LATC1_bit+0, BitPos(LATC1_bit+0) 
;Max31855J.c,28 :: 		SPI2_Init_Advanced(_SPI_MASTER_OSC_DIV16 ,
	MOVLW       1
	MOVWF       FARG_SPI2_Init_Advanced_master+0 
;Max31855J.c,29 :: 		_SPI_DATA_SAMPLE_END,
	MOVLW       128
	MOVWF       FARG_SPI2_Init_Advanced_data_sample+0 
;Max31855J.c,30 :: 		_SPI_CLK_IDLE_LOW,
	CLRF        FARG_SPI2_Init_Advanced_clock_idle+0 
;Max31855J.c,31 :: 		_SPI_HIGH_2_LOW);
	CLRF        FARG_SPI2_Init_Advanced_transmit_edge+0 
	CALL        _SPI2_Init_Advanced+0, 0
;Max31855J.c,32 :: 		SPI_Set_Active(&SPI2_Read, &SPI2_Write);
	MOVLW       _SPI2_Read+0
	MOVWF       FARG_SPI_Set_Active_read_ptr+0 
	MOVLW       hi_addr(_SPI2_Read+0)
	MOVWF       FARG_SPI_Set_Active_read_ptr+1 
	MOVLW       FARG_SPI2_Read_buffer+0
	MOVWF       FARG_SPI_Set_Active_read_ptr+2 
	MOVLW       hi_addr(FARG_SPI2_Read_buffer+0)
	MOVWF       FARG_SPI_Set_Active_read_ptr+3 
	MOVLW       _SPI2_Write+0
	MOVWF       FARG_SPI_Set_Active_write_ptr+0 
	MOVLW       hi_addr(_SPI2_Write+0)
	MOVWF       FARG_SPI_Set_Active_write_ptr+1 
	MOVLW       FARG_SPI2_Write_data_+0
	MOVWF       FARG_SPI_Set_Active_write_ptr+2 
	MOVLW       hi_addr(FARG_SPI2_Write_data_+0)
	MOVWF       FARG_SPI_Set_Active_write_ptr+3 
	CALL        _SPI_Set_Active+0, 0
;Max31855J.c,33 :: 		}
L_end_ConfigSpi:
	RETURN      0
; end of _ConfigSpi

_ReadMax31855J:

;Max31855J.c,34 :: 		float ReadMax31855J(){
;Max31855J.c,35 :: 		Chip_Select = 0;
	BCF         LATC1_bit+0, BitPos(LATC1_bit+0) 
;Max31855J.c,36 :: 		DegC.TempBuff[0] = SPI2_Read(0);  //15-8
	CLRF        FARG_SPI2_Read_buffer+0 
	CALL        _SPI2_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+1 
;Max31855J.c,37 :: 		DegC.TempBuff[1] = SPI2_Read(0);  //7-0
	CLRF        FARG_SPI2_Read_buffer+0 
	CALL        _SPI2_Read+0, 0
	MOVF        R0, 0 
	MOVWF       _DegC+2 
;Max31855J.c,40 :: 		Chip_Select = 1;
	BSF         LATC1_bit+0, BitPos(LATC1_bit+0) 
;Max31855J.c,41 :: 		return GetTemp();//DegC.Temp_SP;
	CALL        _GetTemp+0, 0
;Max31855J.c,42 :: 		}
L_end_ReadMax31855J:
	RETURN      0
; end of _ReadMax31855J

_GetTemp:

;Max31855J.c,44 :: 		float GetTemp(void){
;Max31855J.c,52 :: 		TConnect = DegC.TempBuff[1] & 0x04;
	MOVLW       4
	ANDWF       _DegC+2, 0 
	MOVWF       GetTemp_TConnect_L0+0 
	CLRF        GetTemp_TConnect_L0+1 
	MOVLW       0
	ANDWF       GetTemp_TConnect_L0+1, 1 
	MOVLW       0
	MOVWF       GetTemp_TConnect_L0+1 
;Max31855J.c,53 :: 		if(TConnect != 0)
	MOVLW       0
	XORWF       GetTemp_TConnect_L0+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__GetTemp4
	MOVLW       0
	XORWF       GetTemp_TConnect_L0+0, 0 
L__GetTemp4:
	BTFSC       STATUS+0, 2 
	GOTO        L_GetTemp0
;Max31855J.c,54 :: 		return -1.0;//TConnect;
	MOVLW       0
	MOVWF       R0 
	MOVLW       0
	MOVWF       R1 
	MOVLW       128
	MOVWF       R2 
	MOVLW       127
	MOVWF       R3 
	GOTO        L_end_GetTemp
L_GetTemp0:
;Max31855J.c,56 :: 		decimal = (DegC.TempBuff[1] & 0x30)>>4;
	MOVLW       48
	ANDWF       _DegC+2, 0 
	MOVWF       GetTemp_decimal_L0+0 
	CLRF        GetTemp_decimal_L0+1 
	MOVLW       0
	ANDWF       GetTemp_decimal_L0+1, 1 
	MOVLW       4
	MOVWF       R0 
	MOVLW       0
	MOVWF       GetTemp_decimal_L0+1 
	MOVF        R0, 0 
L__GetTemp5:
	BZ          L__GetTemp6
	RRCF        GetTemp_decimal_L0+0, 1 
	BCF         GetTemp_decimal_L0+0, 7 
	ADDLW       255
	GOTO        L__GetTemp5
L__GetTemp6:
	MOVLW       0
	MOVWF       GetTemp_decimal_L0+1 
;Max31855J.c,57 :: 		fdec = dec[decimal];
	MOVF        GetTemp_decimal_L0+0, 0 
	MOVWF       R0 
	MOVF        GetTemp_decimal_L0+1, 0 
	MOVWF       R1 
	MOVLW       0
	BTFSC       GetTemp_decimal_L0+1, 7 
	MOVLW       255
	MOVWF       R2 
	MOVWF       R3 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	RLCF        R2, 1 
	RLCF        R3, 1 
	MOVLW       _dec+0
	ADDWF       R0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_dec+0)
	ADDWFC      R1, 0 
	MOVWF       TBLPTR+1 
	MOVLW       higher_addr(_dec+0)
	ADDWFC      R2, 0 
	MOVWF       TBLPTR+2 
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__GetTemp+0
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__GetTemp+1
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__GetTemp+2
	TBLRD*+
	MOVFF       TABLAT+0, FLOC__GetTemp+3
;Max31855J.c,58 :: 		Tmp  =  DegC.TempBuff[0] & 0x7f;
	MOVLW       127
	ANDWF       _DegC+1, 0 
	MOVWF       GetTemp_Tmp_L0+0 
	CLRF        GetTemp_Tmp_L0+1 
	MOVLW       0
	ANDWF       GetTemp_Tmp_L0+1, 1 
	MOVLW       0
	MOVWF       GetTemp_Tmp_L0+1 
;Max31855J.c,59 :: 		Tmp  =  Tmp<<8;
	MOVF        GetTemp_Tmp_L0+0, 0 
	MOVWF       R2 
	CLRF        R1 
	MOVF        R1, 0 
	MOVWF       GetTemp_Tmp_L0+0 
	MOVF        R2, 0 
	MOVWF       GetTemp_Tmp_L0+1 
;Max31855J.c,60 :: 		Tmp  =  Tmp  | (DegC.TempBuff[1] & 0xe0);
	MOVLW       224
	ANDWF       _DegC+2, 0 
	MOVWF       R0 
	MOVF        R0, 0 
	IORWF       R1, 0 
	MOVWF       R3 
	MOVF        R2, 0 
	MOVWF       R4 
	MOVLW       0
	IORWF       R4, 1 
	MOVF        R3, 0 
	MOVWF       GetTemp_Tmp_L0+0 
	MOVF        R4, 0 
	MOVWF       GetTemp_Tmp_L0+1 
;Max31855J.c,61 :: 		Tmp  =  (Tmp >> 6) & 0x03ff;
	MOVLW       6
	MOVWF       R2 
	MOVF        R3, 0 
	MOVWF       R0 
	MOVF        R4, 0 
	MOVWF       R1 
	MOVF        R2, 0 
L__GetTemp7:
	BZ          L__GetTemp8
	RRCF        R1, 1 
	RRCF        R0, 1 
	BCF         R1, 7 
	BTFSC       R1, 6 
	BSF         R1, 7 
	ADDLW       255
	GOTO        L__GetTemp7
L__GetTemp8:
	MOVLW       255
	ANDWF       R0, 1 
	MOVLW       3
	ANDWF       R1, 1 
	MOVF        R0, 0 
	MOVWF       GetTemp_Tmp_L0+0 
	MOVF        R1, 0 
	MOVWF       GetTemp_Tmp_L0+1 
;Max31855J.c,62 :: 		ftemp =  (float)Tmp + fdec;
	CALL        _int2double+0, 0
	MOVF        FLOC__GetTemp+0, 0 
	MOVWF       R4 
	MOVF        FLOC__GetTemp+1, 0 
	MOVWF       R5 
	MOVF        FLOC__GetTemp+2, 0 
	MOVWF       R6 
	MOVF        FLOC__GetTemp+3, 0 
	MOVWF       R7 
	CALL        _Add_32x32_FP+0, 0
;Max31855J.c,64 :: 		return ftemp;
;Max31855J.c,65 :: 		}
L_end_GetTemp:
	RETURN      0
; end of _GetTemp
