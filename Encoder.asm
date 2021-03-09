
_Init_Encoder:

;Encoder.c,14 :: 		void Init_Encoder(uint8_t rotate_value){
;Encoder.c,15 :: 		enc.ROR = rotate_value;
	MOVF        FARG_Init_Encoder_rotate_value+0, 0 
	MOVWF       _enc+5 
;Encoder.c,16 :: 		}
L_end_Init_Encoder:
	RETURN      0
; end of _Init_Encoder

__SW:

;Encoder.c,21 :: 		uint8_t _SW(void){
;Encoder.c,22 :: 		if(EncSW)
	BTFSS       RA2_bit+0, BitPos(RA2_bit+0) 
	GOTO        L__SW0
;Encoder.c,23 :: 		return 0;
	CLRF        R0 
	GOTO        L_end__SW
L__SW0:
;Encoder.c,24 :: 		return 1;
	MOVLW       1
	MOVWF       R0 
;Encoder.c,25 :: 		}
L_end__SW:
	RETURN      0
; end of __SW

_SW_Store:

;Encoder.c,27 :: 		int8_t SW_Store(void){
;Encoder.c,28 :: 		enc.storeSW = enc.val;
	MOVF        _enc+4, 0 
	MOVWF       _enc+1 
;Encoder.c,29 :: 		return enc.storeSW;
	MOVF        _enc+4, 0 
	MOVWF       R0 
;Encoder.c,30 :: 		}
L_end_SW_Store:
	RETURN      0
; end of _SW_Store

_Encode:

;Encoder.c,32 :: 		void Encode(void){
;Encoder.c,33 :: 		enc.val = read_rotary();
	CALL        _read_rotary+0, 0
	MOVF        R0, 0 
	MOVWF       _enc+4 
;Encoder.c,34 :: 		enc.cntr += enc.val;
	MOVLW       0
	BTFSC       R0, 7 
	MOVLW       255
	MOVWF       R1 
	MOVF        _enc+2, 0 
	ADDWF       R0, 1 
	MOVF        _enc+3, 0 
	ADDWFC      R1, 1 
	MOVF        R0, 0 
	MOVWF       _enc+2 
	MOVF        R1, 0 
	MOVWF       _enc+3 
;Encoder.c,38 :: 		}
L_end_Encode:
	RETURN      0
; end of _Encode

_read_rotary:

;Encoder.c,40 :: 		int8_t read_rotary(){
;Encoder.c,41 :: 		enc.codePrevNext = (enc.codePrevNext << 2)& 0x0f;
	MOVF        _enc+0, 0 
	MOVWF       R0 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R0, 1 
	BCF         R0, 0 
	MOVLW       15
	ANDWF       R0, 0 
	MOVWF       R3 
	MOVF        R3, 0 
	MOVWF       _enc+0 
;Encoder.c,42 :: 		enc.codePrevNext |= (DATA >> enc.ROR);
	MOVLW       192
	ANDWF       PORTB+0, 0 
	MOVWF       R2 
	MOVF        _enc+5, 0 
	MOVWF       R1 
	MOVF        R2, 0 
	MOVWF       R0 
	MOVF        R1, 0 
L__read_rotary6:
	BZ          L__read_rotary7
	RRCF        R0, 1 
	BCF         R0, 7 
	ADDLW       255
	GOTO        L__read_rotary6
L__read_rotary7:
	MOVF        R3, 0 
	IORWF       R0, 1 
	MOVF        R0, 0 
	MOVWF       _enc+0 
;Encoder.c,43 :: 		return rot_enc_table[enc.codePrevNext & 0x0f];
	MOVLW       15
	ANDWF       R0, 1 
	MOVLW       _rot_enc_table+0
	ADDWF       R0, 0 
	MOVWF       TBLPTR+0 
	MOVLW       hi_addr(_rot_enc_table+0)
	MOVWF       TBLPTR+1 
	MOVLW       0
	ADDWFC      TBLPTR+1, 1 
	MOVLW       higher_addr(_rot_enc_table+0)
	MOVWF       TBLPTR+2 
	MOVLW       0
	ADDWFC      TBLPTR+2, 1 
	TBLRD*+
	MOVFF       TABLAT+0, R0
;Encoder.c,44 :: 		}
L_end_read_rotary:
	RETURN      0
; end of _read_rotary

_Get_EncoderValue:

;Encoder.c,46 :: 		int16_t Get_EncoderValue(void){
;Encoder.c,47 :: 		return enc.cntr;
	MOVF        _enc+2, 0 
	MOVWF       R0 
	MOVF        _enc+3, 0 
	MOVWF       R1 
;Encoder.c,48 :: 		}
L_end_Get_EncoderValue:
	RETURN      0
; end of _Get_EncoderValue

_Get_Layer_Count:

;Encoder.c,50 :: 		uint8_t Get_Layer_Count(void){
;Encoder.c,51 :: 		return enc.layer_cnt;
	MOVF        _enc+16, 0 
	MOVWF       R0 
;Encoder.c,52 :: 		}
L_end_Get_Layer_Count:
	RETURN      0
; end of _Get_Layer_Count

_Staged_Value:

;Encoder.c,54 :: 		uint8_t Staged_Value(uint8_t layer, uint8_t depth){
;Encoder.c,55 :: 		return  enc.layer_value[layer] = depth;
	MOVLW       _enc+6
	MOVWF       R0 
	MOVLW       hi_addr(_enc+6)
	MOVWF       R1 
	MOVF        FARG_Staged_Value_layer+0, 0 
	ADDWF       R0, 1 
	BTFSC       STATUS+0, 0 
	INCF        R1, 1 
	MOVFF       R0, FSR1L+0
	MOVFF       R1, FSR1H+0
	MOVF        FARG_Staged_Value_depth+0, 0 
	MOVWF       POSTINC1+0 
	MOVFF       R0, FSR0L+0
	MOVFF       R1, FSR0H+0
	MOVF        POSTINC0+0, 0 
	MOVWF       R0 
;Encoder.c,56 :: 		}
L_end_Staged_Value:
	RETURN      0
; end of _Staged_Value
