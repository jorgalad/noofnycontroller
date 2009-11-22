;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.0 #5117 (Mar 23 2008) (MINGW32)
; This file was generated Sat Nov 21 19:30:06 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _DisplayLED
	global _ClearMatrix
	global _DoStartupPattern
	global _DoShutdownPattern
	global _TestMatrix1
	global _TestMatrix2
	global _DoMichaelKnightPattern
	global _app_flags
	global _last_ain_pin
	global _last_din_pin
	global _last_dout_pin
	global _test_mode
	global _record_sysex
	global _last_sysex
	global _clock_ticks
	global _clock_beats
	global _clock_bars
	global _Init
	global _Tick
	global _Timer
	global _DISPLAY_Init
	global _DISPLAY_Tick
	global _MPROC_NotifyReceivedEvnt
	global _MPROC_NotifyFoundEvent
	global _MPROC_NotifyTimeout
	global _MPROC_NotifyReceivedByte
	global _SR_Service_Prepare
	global _SR_Service_Finish
	global _DIN_NotifyToggle
	global _ENC_NotifyChange
	global _AIN_NotifyChange
	global _pot_event_map
	global _button_event_map

;--------------------------------------------------------
; extern variables in this module
;--------------------------------------------------------
	extern _MIOS_BOX_CFG0
	extern _MIOS_BOX_CFG1
	extern _MIOS_BOX_STAT
	extern _MIOS_PARAMETER1
	extern _MIOS_PARAMETER2
	extern _MIOS_PARAMETER3
	extern _PORTAbits
	extern _PORTBbits
	extern _PORTCbits
	extern _PORTDbits
	extern _PORTEbits
	extern _LATAbits
	extern _LATBbits
	extern _LATCbits
	extern _LATDbits
	extern _LATEbits
	extern _TRISAbits
	extern _TRISBbits
	extern _TRISCbits
	extern _TRISDbits
	extern _TRISEbits
	extern _PIE1bits
	extern _PIR1bits
	extern _IPR1bits
	extern _PIE2bits
	extern _PIR2bits
	extern _IPR2bits
	extern _EECON1bits
	extern _RCSTAbits
	extern _TXSTAbits
	extern _T3CONbits
	extern _CCP2CONbits
	extern _CCP1CONbits
	extern _ADCON1bits
	extern _ADCON0bits
	extern _SSPCON2bits
	extern _SSPCON1bits
	extern _SSPSTATbits
	extern _T2CONbits
	extern _T1CONbits
	extern _RCONbits
	extern _WDTCONbits
	extern _LVDCONbits
	extern _OSCCONbits
	extern _T0CONbits
	extern _STATUSbits
	extern _INTCON3bits
	extern _INTCON2bits
	extern _INTCONbits
	extern _STKPTRbits
	extern _PORTA
	extern _PORTB
	extern _PORTC
	extern _PORTD
	extern _PORTE
	extern _LATA
	extern _LATB
	extern _LATC
	extern _LATD
	extern _LATE
	extern _TRISA
	extern _TRISB
	extern _TRISC
	extern _TRISD
	extern _TRISE
	extern _PIE1
	extern _PIR1
	extern _IPR1
	extern _PIE2
	extern _PIR2
	extern _IPR2
	extern _EECON1
	extern _EECON2
	extern _EEDATA
	extern _EEADR
	extern _RCSTA
	extern _TXSTA
	extern _TXREG
	extern _RCREG
	extern _SPBRG
	extern _T3CON
	extern _TMR3L
	extern _TMR3H
	extern _CCP2CON
	extern _CCPR2L
	extern _CCPR2H
	extern _CCP1CON
	extern _CCPR1L
	extern _CCPR1H
	extern _ADCON1
	extern _ADCON0
	extern _ADRESL
	extern _ADRESH
	extern _SSPCON2
	extern _SSPCON1
	extern _SSPSTAT
	extern _SSPADD
	extern _SSPBUF
	extern _T2CON
	extern _PR2
	extern _TMR2
	extern _T1CON
	extern _TMR1L
	extern _TMR1H
	extern _RCON
	extern _WDTCON
	extern _LVDCON
	extern _OSCCON
	extern _T0CON
	extern _TMR0L
	extern _TMR0H
	extern _STATUS
	extern _FSR2L
	extern _FSR2H
	extern _PLUSW2
	extern _PREINC2
	extern _POSTDEC2
	extern _POSTINC2
	extern _INDF2
	extern _BSR
	extern _FSR1L
	extern _FSR1H
	extern _PLUSW1
	extern _PREINC1
	extern _POSTDEC1
	extern _POSTINC1
	extern _INDF1
	extern _WREG
	extern _FSR0L
	extern _FSR0H
	extern _PLUSW0
	extern _PREINC0
	extern _POSTDEC0
	extern _POSTINC0
	extern _INDF0
	extern _INTCON3
	extern _INTCON2
	extern _INTCON
	extern _PRODL
	extern _PRODH
	extern _TABLAT
	extern _TBLPTRL
	extern _TBLPTRH
	extern _TBLPTRU
	extern _PCL
	extern _PCLATH
	extern _PCLATU
	extern _STKPTR
	extern _TOSL
	extern _TOSH
	extern _TOSU
	extern _MIOS_MIDI_BeginStream
	extern _MIOS_MIDI_EndStream
	extern _MIOS_MIDI_MergerSet
	extern _MIOS_MIDI_TxBufferPut
	extern _MIOS_AIN_DeadbandSet
	extern _MIOS_AIN_Muxed
	extern _MIOS_AIN_NumberSet
	extern _MIOS_AIN_Pin7bitGet
	extern _MIOS_DIN_PinGet
	extern _MIOS_DOUT_PinGet
	extern _MIOS_DOUT_PinSet
	extern _MIOS_DOUT_PinSet1
	extern _MIOS_DOUT_SRSet
	extern _MIOS_SRIO_NumberSet
	extern _MIOS_SRIO_TS_SensitivitySet
	extern _MIOS_SRIO_UpdateFrqSet
	extern _MIOS_SRIO_DebounceSet
	extern _MIOS_LCD_Clear
	extern _MIOS_LCD_CursorSet
	extern _MIOS_LCD_PrintBCD2
	extern _MIOS_LCD_PrintBCD3
	extern _MIOS_LCD_PrintBCD4
	extern _MIOS_LCD_PrintChar
	extern _MIOS_LCD_PrintCString
	extern _MIOS_Delay
	extern __moduint
	extern __mulint
	extern __divsint
	extern _mios_enc_pin_table
	extern _mios_mproc_event_table
	extern _MIOS_MPROC_EVENT_TABLE
	extern _MIOS_ENC_PIN_TABLE
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
PCL	equ	0xff9
PCLATH	equ	0xffa
PCLATU	equ	0xffb
WREG	equ	0xfe8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
FSR0L equ 0xfe1 ;; normaly 0xfe9, changed by mios-gpasm
FSR0H equ 0xfe2 ;; normaly 0xfea, changed by mios-gpasm
FSR1L equ 0xfe9 ;; normaly 0xfe1, changed by mios-gpasm
FSR2L	equ	0xfd9
INDF0 equ 0xfe7 ;; normaly 0xfef, changed by mios-gpasm
POSTDEC1 equ 0xfed ;; normaly 0xfe5, changed by mios-gpasm
PREINC1 equ 0xfec ;; normaly 0xfe4, changed by mios-gpasm
PLUSW2	equ	0xfdb
PRODL	equ	0xff3


	idata
_matrix_1	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00
_matrix_2	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
	db	0x00, 0x00, 0x00, 0x00


; Internal registers
.registers udata_ovr 0x0010 ;; normaly 0x0000, changed by mios-gpasm
r0x00	res	1
r0x01	res	1
r0x02	res	1
r0x03	res	1
r0x04	res	1
r0x05	res	1
r0x06	res	1
r0x07	res	1
r0x08	res	1
r0x09	res	1
r0x0a	res	1
r0x0b	res	1
r0x0c	res	1

udata_main_0	udata
_SR_Service_Prepare_row_1_1	res	1

udata_main_1	udata
_DoStartupPattern_row_1_1	res	2

udata_main_2	udata
_DoStartupPattern_column_1_1	res	2

udata_main_3	udata
_DoStartupPattern_color_1_1	res	1

udata_main_4	udata
_DoShutdownPattern_row_1_1	res	2

udata_main_5	udata
_DoShutdownPattern_column_1_1	res	2

udata_main_6	udata
_TestMatrix1_row_1_1	res	2

udata_main_7	udata
_TestMatrix1_column_1_1	res	2

udata_main_8	udata
_TestMatrix2_row_1_1	res	2

udata_main_9	udata
_TestMatrix2_column_1_1	res	2

udata_main_10	udata
_DoMichaelKnightPattern_column_1_1	res	2

udata_main_11	udata
_test_mode	res	2

udata_main_12	udata
_record_sysex	res	2

udata_main_13	udata
_last_sysex	res	1

udata_main_14	udata
_clock_ticks	res	2

udata_main_15	udata
_clock_beats	res	2

udata_main_16	udata
_clock_bars	res	2

udata_main_17	udata
_app_flags	res	1

udata_main_18	udata
_last_ain_pin	res	1

udata_main_19	udata
_last_din_pin	res	1

udata_main_20	udata
_last_dout_pin	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__DoMichaelKnightPattern	code
_DoMichaelKnightPattern:
;	.line	772; main.c	void DoMichaelKnightPattern(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
;	.line	775; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	776; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	777; main.c	for (column = -2; column < 21; column++)
	MOVLW	0xfe
	BANKSEL	_DoMichaelKnightPattern_column_1_1
	MOVWF	_DoMichaelKnightPattern_column_1_1, B
	MOVLW	0xff
; removed redundant BANKSEL
	MOVWF	(_DoMichaelKnightPattern_column_1_1 + 1), B
_00572_DS_:
	BANKSEL	(_DoMichaelKnightPattern_column_1_1 + 1)
	MOVF	(_DoMichaelKnightPattern_column_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00582_DS_
	MOVLW	0x15
; removed redundant BANKSEL
	SUBWF	_DoMichaelKnightPattern_column_1_1, W, B
_00582_DS_:
	BTFSC	STATUS, 0
	GOTO	_00575_DS_
;	.line	779; main.c	MIOS_Delay(50);
	MOVLW	0x32
	CALL	_MIOS_Delay
	BANKSEL	(_DoMichaelKnightPattern_column_1_1 + 1)
;	.line	780; main.c	switch (column)
	MOVF	(_DoMichaelKnightPattern_column_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x81
	BNZ	_00583_DS_
	MOVLW	0xff
; removed redundant BANKSEL
	SUBWF	_DoMichaelKnightPattern_column_1_1, W, B
_00583_DS_:
	BTFSS	STATUS, 0
	GOTO	_00574_DS_
	BANKSEL	(_DoMichaelKnightPattern_column_1_1 + 1)
	MOVF	(_DoMichaelKnightPattern_column_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00584_DS_
	MOVLW	0x12
; removed redundant BANKSEL
	SUBWF	_DoMichaelKnightPattern_column_1_1, W, B
_00584_DS_:
	BTFSC	STATUS, 0
	GOTO	_00574_DS_
	BANKSEL	_DoMichaelKnightPattern_column_1_1
	INCF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	CLRF	r0x07
	RLCF	r0x00, W
	RLCF	r0x07, F
	RLCF	WREG, W
	RLCF	r0x07, F
	ANDLW	0xfc
	MOVWF	r0x06
	MOVLW	UPPER(_00585_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00585_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00585_DS_)
	ADDWF	r0x06, F
	MOVF	r0x07, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x06, W
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVWF	PCL
_00585_DS_:
	GOTO	_00551_DS_
	GOTO	_00552_DS_
	GOTO	_00553_DS_
	GOTO	_00554_DS_
	GOTO	_00555_DS_
	GOTO	_00556_DS_
	GOTO	_00557_DS_
	GOTO	_00558_DS_
	GOTO	_00559_DS_
	GOTO	_00560_DS_
	GOTO	_00561_DS_
	GOTO	_00562_DS_
	GOTO	_00563_DS_
	GOTO	_00564_DS_
	GOTO	_00565_DS_
	GOTO	_00566_DS_
	GOTO	_00567_DS_
	GOTO	_00568_DS_
	GOTO	_00569_DS_
_00551_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	783; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	BTFSC	r0x00, 7
	SETF	r0x02
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	784; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	785; main.c	break;
	GOTO	_00574_DS_
_00552_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	787; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	BTFSC	r0x00, 7
	SETF	r0x02
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	788; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	789; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	790; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x00
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	791; main.c	break;
	GOTO	_00574_DS_
_00553_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	793; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	794; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	795; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x00, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	796; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	797; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x02
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	798; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	799; main.c	break;
	GOTO	_00574_DS_
_00554_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	801; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	802; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	803; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	804; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	805; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	806; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	807; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	808; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	809; main.c	break;
	GOTO	_00574_DS_
_00555_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	811; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	812; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	813; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	814; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	815; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	816; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	817; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	818; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	819; main.c	break;
	GOTO	_00574_DS_
_00556_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	821; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	822; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	823; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	824; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	825; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	826; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	827; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	828; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	829; main.c	break;
	GOTO	_00574_DS_
_00557_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	831; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	832; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	833; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	834; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	835; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	836; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	837; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	838; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	839; main.c	break;
	GOTO	_00574_DS_
_00558_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	841; main.c	matrix_2[4][column+1] 		= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	842; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	843; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	844; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	845; main.c	matrix_2[6][column+1] 		= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	846; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	847; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	848; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	849; main.c	break;
	GOTO	_00574_DS_
_00559_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	851; main.c	matrix_2[5][column-8+1]	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	852; main.c	matrix_2[4][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x02
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	853; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	854; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	855; main.c	matrix_2[7][column-8+1]	= _COLOR_WHITE;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	856; main.c	matrix_2[6][column] 		= _COLOR_CYAN;
	MOVFF	_DoMichaelKnightPattern_column_1_1, r0x01
	MOVFF	(_DoMichaelKnightPattern_column_1_1 + 1), r0x03
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	857; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	858; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	859; main.c	break;
	GOTO	_00574_DS_
_00560_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	861; main.c	matrix_2[5][column-8+1]	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	862; main.c	matrix_2[5][column-8]		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	863; main.c	matrix_2[4][column-1] 		= _COLOR_BLUE;
	DECF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	864; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	865; main.c	matrix_2[7][column-8+1]	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	866; main.c	matrix_2[7][column-8]		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	867; main.c	matrix_2[6][column-1] 		= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	868; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	869; main.c	break;
	GOTO	_00574_DS_
_00561_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	871; main.c	matrix_2[5][column-8+1]	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	872; main.c	matrix_2[5][column-8]		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	873; main.c	matrix_2[5][column-8-1]	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	874; main.c	matrix_2[4][column-2] 		= _COLOR_OFF;
	MOVLW	0xfe
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	875; main.c	matrix_2[7][column-8+1]	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	876; main.c	matrix_2[7][column-8]		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	877; main.c	matrix_2[7][column-8-1]	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	878; main.c	matrix_2[6][column-2] 		= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	879; main.c	break;
	GOTO	_00574_DS_
_00562_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	881; main.c	matrix_2[5][column-8+1] 	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	882; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	883; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	884; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	885; main.c	matrix_2[7][column-8+1] 	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	886; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	887; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	888; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	889; main.c	break;
	GOTO	_00574_DS_
_00563_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	891; main.c	matrix_2[5][column-8+1] 	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	892; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	893; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	894; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	895; main.c	matrix_2[7][column-8+1] 	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	896; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	897; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	898; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	899; main.c	break;
	GOTO	_00574_DS_
_00564_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	901; main.c	matrix_2[5][column-8+1] 	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	902; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	903; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	904; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	905; main.c	matrix_2[7][column-8+1] 	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	906; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	907; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	908; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	909; main.c	break;
	BRA	_00574_DS_
_00565_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	911; main.c	matrix_2[5][column-8+1] 	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	912; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	913; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	914; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	915; main.c	matrix_2[7][column-8+1] 	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	916; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	917; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	918; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	919; main.c	break;
	BRA	_00574_DS_
_00566_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	921; main.c	matrix_2[5][column-8+1] 	= _COLOR_WHITE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf9
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	922; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	923; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x03
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x03, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	924; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x04
	CLRF	r0x05
	BTFSC	r0x00, 7
	SETF	r0x05
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x05, F
	MOVFF	r0x04, FSR0L
	MOVFF	r0x05, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	925; main.c	matrix_2[7][column-8+1] 	= _COLOR_WHITE;
	CLRF	r0x04
	BTFSC	r0x01, 7
	SETF	r0x04
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x04, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
;	.line	926; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	927; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x03, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	928; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	929; main.c	break;
	BRA	_00574_DS_
_00567_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	931; main.c	matrix_2[5][column-8] 		= _COLOR_CYAN;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf8
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	932; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x02, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x02, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	933; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x03
	CLRF	r0x04
	BTFSC	r0x00, 7
	SETF	r0x04
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	934; main.c	matrix_2[7][column-8] 		= _COLOR_CYAN;
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x03, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x60
	MOVWF	INDF0
;	.line	935; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x01
	BTFSC	r0x02, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x02, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	936; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	937; main.c	break;
	BRA	_00574_DS_
_00568_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	939; main.c	matrix_2[5][column-8-1] 	= _COLOR_BLUE;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf7
	ADDWF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x01, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	940; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	BTFSC	r0x00, 7
	SETF	r0x03
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x03, F
	MOVFF	r0x02, FSR0L
	MOVFF	r0x03, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	941; main.c	matrix_2[7][column-8-1] 	= _COLOR_BLUE;
	CLRF	r0x02
	BTFSC	r0x01, 7
	SETF	r0x02
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
;	.line	942; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	943; main.c	break;
	BRA	_00574_DS_
_00569_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	945; main.c	matrix_2[5][column-8-2] 	= _COLOR_OFF;
	MOVF	_DoMichaelKnightPattern_column_1_1, W, B
	MOVWF	r0x00
	MOVLW	0xf6
	ADDWF	r0x00, F
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x00, W
	MOVWF	r0x01
	CLRF	r0x02
	BTFSC	r0x00, 7
	SETF	r0x02
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x02, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x02, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	946; main.c	matrix_2[7][column-8-2] 	= _COLOR_OFF;
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
_00574_DS_:
	BANKSEL	_DoMichaelKnightPattern_column_1_1
;	.line	777; main.c	for (column = -2; column < 21; column++)
	INCF	_DoMichaelKnightPattern_column_1_1, F, B
	BNC	_10551_DS_
; removed redundant BANKSEL
	INCF	(_DoMichaelKnightPattern_column_1_1 + 1), F, B
_10551_DS_:
	GOTO	_00572_DS_
_00575_DS_:
;	.line	953; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	954; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__TestMatrix2	code
_TestMatrix2:
;	.line	748; main.c	void TestMatrix2(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	752; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	753; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	BANKSEL	_TestMatrix2_row_1_1
;	.line	754; main.c	for (row = 0; row < 8; row++)
	CLRF	_TestMatrix2_row_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix2_row_1_1 + 1), B
_00532_DS_:
	BANKSEL	(_TestMatrix2_row_1_1 + 1)
	MOVF	(_TestMatrix2_row_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00544_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix2_row_1_1, W, B
_00544_DS_:
	BTFSC	STATUS, 0
	BRA	_00535_DS_
	BANKSEL	_TestMatrix2_column_1_1
;	.line	756; main.c	for (column = 0; column < 8; column++)
	CLRF	_TestMatrix2_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix2_column_1_1 + 1), B
_00524_DS_:
	MOVLW	0x00
	BANKSEL	(_TestMatrix2_column_1_1 + 1)
	SUBWF	(_TestMatrix2_column_1_1 + 1), W, B
	BNZ	_00545_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix2_column_1_1, W, B
_00545_DS_:
	BC	_00527_DS_
	BANKSEL	(_TestMatrix2_row_1_1 + 1)
;	.line	758; main.c	matrix_2[row][column] = _COLOR_WHITE;
	MOVF	(_TestMatrix2_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_TestMatrix2_row_1_1, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x01, F
	MOVFF	_TestMatrix2_column_1_1, r0x02
	MOVFF	(_TestMatrix2_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
	BANKSEL	_TestMatrix2_column_1_1
;	.line	756; main.c	for (column = 0; column < 8; column++)
	INCF	_TestMatrix2_column_1_1, F, B
	BNC	_20552_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix2_column_1_1 + 1), F, B
_20552_DS_:
	BRA	_00524_DS_
_00527_DS_:
	BANKSEL	_TestMatrix2_column_1_1
;	.line	760; main.c	for (column = 0; column < 8; column++)
	CLRF	_TestMatrix2_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix2_column_1_1 + 1), B
_00528_DS_:
	MOVLW	0x00
	BANKSEL	(_TestMatrix2_column_1_1 + 1)
	SUBWF	(_TestMatrix2_column_1_1 + 1), W, B
	BNZ	_00546_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix2_column_1_1, W, B
_00546_DS_:
	BC	_00531_DS_
	BANKSEL	_TestMatrix2_row_1_1
;	.line	762; main.c	matrix_2[row-1][column] = _COLOR_OFF;
	MOVF	_TestMatrix2_row_1_1, W, B
	MOVWF	r0x00
	DECF	r0x00, F
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x01, F
	MOVFF	_TestMatrix2_column_1_1, r0x02
	MOVFF	(_TestMatrix2_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_TestMatrix2_column_1_1
;	.line	760; main.c	for (column = 0; column < 8; column++)
	INCF	_TestMatrix2_column_1_1, F, B
	BNC	_30553_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix2_column_1_1 + 1), F, B
_30553_DS_:
	BRA	_00528_DS_
_00531_DS_:
;	.line	764; main.c	MIOS_Delay(250);
	MOVLW	0xfa
	CALL	_MIOS_Delay
;	.line	765; main.c	MIOS_Delay(250);
	MOVLW	0xfa
	CALL	_MIOS_Delay
	BANKSEL	_TestMatrix2_row_1_1
;	.line	754; main.c	for (row = 0; row < 8; row++)
	INCF	_TestMatrix2_row_1_1, F, B
	BNC	_40554_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix2_row_1_1 + 1), F, B
_40554_DS_:
	BRA	_00532_DS_
_00535_DS_:
;	.line	767; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	768; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__TestMatrix1	code
_TestMatrix1:
;	.line	725; main.c	void TestMatrix1(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	729; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	730; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	BANKSEL	_TestMatrix1_row_1_1
;	.line	731; main.c	for (row = 0; row < 8; row++)
	CLRF	_TestMatrix1_row_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix1_row_1_1 + 1), B
_00505_DS_:
	BANKSEL	(_TestMatrix1_row_1_1 + 1)
	MOVF	(_TestMatrix1_row_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00517_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix1_row_1_1, W, B
_00517_DS_:
	BTFSC	STATUS, 0
	BRA	_00508_DS_
	BANKSEL	_TestMatrix1_column_1_1
;	.line	733; main.c	for (column = 0; column < 8; column++)
	CLRF	_TestMatrix1_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix1_column_1_1 + 1), B
_00497_DS_:
	MOVLW	0x00
	BANKSEL	(_TestMatrix1_column_1_1 + 1)
	SUBWF	(_TestMatrix1_column_1_1 + 1), W, B
	BNZ	_00518_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix1_column_1_1, W, B
_00518_DS_:
	BC	_00500_DS_
	BANKSEL	(_TestMatrix1_row_1_1 + 1)
;	.line	735; main.c	matrix_1[row][column] = _COLOR_WHITE;
	MOVF	(_TestMatrix1_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_TestMatrix1_row_1_1, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_TestMatrix1_column_1_1, r0x02
	MOVFF	(_TestMatrix1_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
	BANKSEL	_TestMatrix1_column_1_1
;	.line	733; main.c	for (column = 0; column < 8; column++)
	INCF	_TestMatrix1_column_1_1, F, B
	BNC	_50555_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix1_column_1_1 + 1), F, B
_50555_DS_:
	BRA	_00497_DS_
_00500_DS_:
	BANKSEL	_TestMatrix1_column_1_1
;	.line	737; main.c	for (column = 0; column < 8; column++)
	CLRF	_TestMatrix1_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_TestMatrix1_column_1_1 + 1), B
_00501_DS_:
	MOVLW	0x00
	BANKSEL	(_TestMatrix1_column_1_1 + 1)
	SUBWF	(_TestMatrix1_column_1_1 + 1), W, B
	BNZ	_00519_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_TestMatrix1_column_1_1, W, B
_00519_DS_:
	BC	_00504_DS_
	BANKSEL	_TestMatrix1_row_1_1
;	.line	739; main.c	matrix_1[row-1][column] = _COLOR_OFF;
	MOVF	_TestMatrix1_row_1_1, W, B
	MOVWF	r0x00
	DECF	r0x00, F
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_TestMatrix1_column_1_1, r0x02
	MOVFF	(_TestMatrix1_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_TestMatrix1_column_1_1
;	.line	737; main.c	for (column = 0; column < 8; column++)
	INCF	_TestMatrix1_column_1_1, F, B
	BNC	_60556_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix1_column_1_1 + 1), F, B
_60556_DS_:
	BRA	_00501_DS_
_00504_DS_:
;	.line	741; main.c	MIOS_Delay(250);
	MOVLW	0xfa
	CALL	_MIOS_Delay
;	.line	742; main.c	MIOS_Delay(250);
	MOVLW	0xfa
	CALL	_MIOS_Delay
	BANKSEL	_TestMatrix1_row_1_1
;	.line	731; main.c	for (row = 0; row < 8; row++)
	INCF	_TestMatrix1_row_1_1, F, B
	BNC	_70557_DS_
; removed redundant BANKSEL
	INCF	(_TestMatrix1_row_1_1 + 1), F, B
_70557_DS_:
	BRA	_00505_DS_
_00508_DS_:
;	.line	744; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	745; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__DoShutdownPattern	code
_DoShutdownPattern:
;	.line	701; main.c	void DoShutdownPattern(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	705; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	BANKSEL	_DoShutdownPattern_row_1_1
;	.line	706; main.c	for (row = 0; row < 8; row++)
	CLRF	_DoShutdownPattern_row_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoShutdownPattern_row_1_1 + 1), B
_00478_DS_:
	MOVLW	0x00
	BANKSEL	(_DoShutdownPattern_row_1_1 + 1)
	SUBWF	(_DoShutdownPattern_row_1_1 + 1), W, B
	BNZ	_00490_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoShutdownPattern_row_1_1, W, B
_00490_DS_:
	BTFSC	STATUS, 0
	BRA	_00481_DS_
	BANKSEL	_DoShutdownPattern_column_1_1
;	.line	708; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoShutdownPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoShutdownPattern_column_1_1 + 1), B
_00470_DS_:
	MOVLW	0x00
	BANKSEL	(_DoShutdownPattern_column_1_1 + 1)
	SUBWF	(_DoShutdownPattern_column_1_1 + 1), W, B
	BNZ	_00491_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoShutdownPattern_column_1_1, W, B
_00491_DS_:
	BC	_00473_DS_
	BANKSEL	(_DoShutdownPattern_row_1_1 + 1)
;	.line	710; main.c	matrix_1[row][column] = _COLOR_BLUE;
	MOVF	(_DoShutdownPattern_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_DoShutdownPattern_row_1_1, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_DoShutdownPattern_column_1_1, r0x02
	MOVFF	(_DoShutdownPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x40
	MOVWF	INDF0
	BANKSEL	_DoShutdownPattern_column_1_1
;	.line	708; main.c	for (column = 0; column < 8; column++)
	INCF	_DoShutdownPattern_column_1_1, F, B
	BNC	_80558_DS_
; removed redundant BANKSEL
	INCF	(_DoShutdownPattern_column_1_1 + 1), F, B
_80558_DS_:
	BRA	_00470_DS_
_00473_DS_:
	BANKSEL	_DoShutdownPattern_column_1_1
;	.line	712; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoShutdownPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoShutdownPattern_column_1_1 + 1), B
_00474_DS_:
	MOVLW	0x00
	BANKSEL	(_DoShutdownPattern_column_1_1 + 1)
	SUBWF	(_DoShutdownPattern_column_1_1 + 1), W, B
	BNZ	_00492_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoShutdownPattern_column_1_1, W, B
_00492_DS_:
	BC	_00477_DS_
	BANKSEL	_DoShutdownPattern_row_1_1
;	.line	714; main.c	matrix_1[row-1][column] = _COLOR_OFF;
	MOVF	_DoShutdownPattern_row_1_1, W, B
	MOVWF	r0x00
	DECF	r0x00, F
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_DoShutdownPattern_column_1_1, r0x02
	MOVFF	(_DoShutdownPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_DoShutdownPattern_column_1_1
;	.line	712; main.c	for (column = 0; column < 8; column++)
	INCF	_DoShutdownPattern_column_1_1, F, B
	BNC	_90559_DS_
; removed redundant BANKSEL
	INCF	(_DoShutdownPattern_column_1_1 + 1), F, B
_90559_DS_:
	BRA	_00474_DS_
_00477_DS_:
;	.line	716; main.c	MIOS_Delay(40);
	MOVLW	0x28
	CALL	_MIOS_Delay
	BANKSEL	_DoShutdownPattern_row_1_1
;	.line	706; main.c	for (row = 0; row < 8; row++)
	INCF	_DoShutdownPattern_row_1_1, F, B
	BNC	_100560_DS_
; removed redundant BANKSEL
	INCF	(_DoShutdownPattern_row_1_1 + 1), F, B
_100560_DS_:
	BRA	_00478_DS_
_00481_DS_:
;	.line	718; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	719; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__DoStartupPattern	code
_DoStartupPattern:
;	.line	636; main.c	void DoStartupPattern(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
;	.line	641; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	642; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	643; main.c	for (row = 7; row > -1; row--)
	MOVLW	0x07
	BANKSEL	_DoStartupPattern_row_1_1
	MOVWF	_DoStartupPattern_row_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_row_1_1 + 1), B
_00427_DS_:
	BCF	STATUS, 0
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
	BTFSS	(_DoStartupPattern_row_1_1 + 1), 7, B
	BSF	STATUS, 0
	BTFSS	STATUS, 0
	BRA	_00430_DS_
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	645; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoStartupPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_column_1_1 + 1), B
_00419_DS_:
	MOVLW	0x00
	BANKSEL	(_DoStartupPattern_column_1_1 + 1)
	SUBWF	(_DoStartupPattern_column_1_1 + 1), W, B
	BNZ	_00459_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_column_1_1, W, B
_00459_DS_:
	BC	_00422_DS_
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
;	.line	647; main.c	matrix_1[row][column] = _COLOR_WHITE;
	MOVF	(_DoStartupPattern_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_DoStartupPattern_row_1_1, W, B
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_DoStartupPattern_column_1_1, r0x02
	MOVFF	(_DoStartupPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x70
	MOVWF	INDF0
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	645; main.c	for (column = 0; column < 8; column++)
	INCF	_DoStartupPattern_column_1_1, F, B
	BNC	_110561_DS_
; removed redundant BANKSEL
	INCF	(_DoStartupPattern_column_1_1 + 1), F, B
_110561_DS_:
	BRA	_00419_DS_
_00422_DS_:
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	649; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoStartupPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_column_1_1 + 1), B
_00423_DS_:
	MOVLW	0x00
	BANKSEL	(_DoStartupPattern_column_1_1 + 1)
	SUBWF	(_DoStartupPattern_column_1_1 + 1), W, B
	BNZ	_00460_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_column_1_1, W, B
_00460_DS_:
	BC	_00426_DS_
	BANKSEL	_DoStartupPattern_row_1_1
;	.line	651; main.c	matrix_1[row+1][column] = _COLOR_OFF;
	MOVF	_DoStartupPattern_row_1_1, W, B
	MOVWF	r0x00
	INCF	r0x00, F
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x01, F
	MOVFF	_DoStartupPattern_column_1_1, r0x02
	MOVFF	(_DoStartupPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	649; main.c	for (column = 0; column < 8; column++)
	INCF	_DoStartupPattern_column_1_1, F, B
	BNC	_120562_DS_
; removed redundant BANKSEL
	INCF	(_DoStartupPattern_column_1_1 + 1), F, B
_120562_DS_:
	BRA	_00423_DS_
_00426_DS_:
;	.line	653; main.c	MIOS_Delay(25);
	MOVLW	0x19
	CALL	_MIOS_Delay
;	.line	643; main.c	for (row = 7; row > -1; row--)
	MOVLW	0xff
	BANKSEL	_DoStartupPattern_row_1_1
	ADDWF	_DoStartupPattern_row_1_1, F, B
	BC	_130563_DS_
; removed redundant BANKSEL
	DECF	(_DoStartupPattern_row_1_1 + 1), F, B
_130563_DS_:
	BRA	_00427_DS_
_00430_DS_:
;	.line	655; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	656; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	BANKSEL	_DoStartupPattern_row_1_1
;	.line	657; main.c	for (row = 0; row < 6; row++)
	CLRF	_DoStartupPattern_row_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_row_1_1 + 1), B
_00439_DS_:
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
	MOVF	(_DoStartupPattern_row_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00461_DS_
	MOVLW	0x06
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_row_1_1, W, B
_00461_DS_:
	BTFSC	STATUS, 0
	BRA	_00442_DS_
;	.line	659; main.c	switch (row)
	BSF	STATUS, 0
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
	BTFSS	(_DoStartupPattern_row_1_1 + 1), 7, B
	BCF	STATUS, 0
	BTFSC	STATUS, 0
	BRA	_00417_DS_
; removed redundant BANKSEL
	MOVF	(_DoStartupPattern_row_1_1 + 1), W, B
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00462_DS_
	MOVLW	0x06
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_row_1_1, W, B
_00462_DS_:
	BTFSC	STATUS, 0
	BRA	_00417_DS_
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	CLRF	r0x05
	BANKSEL	_DoStartupPattern_row_1_1
	RLCF	_DoStartupPattern_row_1_1, W, B
	RLCF	r0x05, F
	RLCF	WREG, W
	RLCF	r0x05, F
	ANDLW	0xfc
	MOVWF	r0x04
	MOVLW	UPPER(_00463_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00463_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00463_DS_)
	ADDWF	r0x04, F
	MOVF	r0x05, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x04, W
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVWF	PCL
_00463_DS_:
	GOTO	_00411_DS_
	GOTO	_00412_DS_
	GOTO	_00413_DS_
	GOTO	_00414_DS_
	GOTO	_00415_DS_
	GOTO	_00416_DS_
_00411_DS_:
;	.line	662; main.c	color = _COLOR_CYAN;
	MOVLW	0x60
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	663; main.c	break;
	BRA	_00418_DS_
_00412_DS_:
;	.line	665; main.c	color = _COLOR_BLUE;
	MOVLW	0x40
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	666; main.c	break;
	BRA	_00418_DS_
_00413_DS_:
;	.line	668; main.c	color = _COLOR_MAGENTA;
	MOVLW	0x50
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	669; main.c	break;
	BRA	_00418_DS_
_00414_DS_:
;	.line	671; main.c	color = _COLOR_RED;
	MOVLW	0x10
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	672; main.c	break;
	BRA	_00418_DS_
_00415_DS_:
;	.line	674; main.c	color = _COLOR_YELLOW;
	MOVLW	0x30
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	675; main.c	break;
	BRA	_00418_DS_
_00416_DS_:
;	.line	677; main.c	color = _COLOR_GREEN;
	MOVLW	0x20
	BANKSEL	_DoStartupPattern_color_1_1
	MOVWF	_DoStartupPattern_color_1_1, B
;	.line	678; main.c	break;
	BRA	_00418_DS_
_00417_DS_:
	BANKSEL	_DoStartupPattern_color_1_1
;	.line	681; main.c	color = _COLOR_OFF;
	CLRF	_DoStartupPattern_color_1_1, B
_00418_DS_:
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	684; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoStartupPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_column_1_1 + 1), B
_00431_DS_:
	MOVLW	0x00
	BANKSEL	(_DoStartupPattern_column_1_1 + 1)
	SUBWF	(_DoStartupPattern_column_1_1 + 1), W, B
	BNZ	_00464_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_column_1_1, W, B
_00464_DS_:
	BC	_00434_DS_
;	.line	686; main.c	matrix_2[row/2][column] = color;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
	MOVF	(_DoStartupPattern_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_DoStartupPattern_row_1_1, W, B
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x08
	MOVWF	POSTDEC1
	CALL	__mulint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x01, F
	MOVFF	_DoStartupPattern_column_1_1, r0x02
	MOVFF	(_DoStartupPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVFF	_DoStartupPattern_color_1_1, INDF0
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	684; main.c	for (column = 0; column < 8; column++)
	INCF	_DoStartupPattern_column_1_1, F, B
	BNC	_140564_DS_
; removed redundant BANKSEL
	INCF	(_DoStartupPattern_column_1_1 + 1), F, B
_140564_DS_:
	BRA	_00431_DS_
_00434_DS_:
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	688; main.c	for (column = 0; column < 8; column++)
	CLRF	_DoStartupPattern_column_1_1, B
; removed redundant BANKSEL
	CLRF	(_DoStartupPattern_column_1_1 + 1), B
_00435_DS_:
	MOVLW	0x00
	BANKSEL	(_DoStartupPattern_column_1_1 + 1)
	SUBWF	(_DoStartupPattern_column_1_1 + 1), W, B
	BNZ	_00465_DS_
	MOVLW	0x08
; removed redundant BANKSEL
	SUBWF	_DoStartupPattern_column_1_1, W, B
_00465_DS_:
	BC	_00438_DS_
;	.line	690; main.c	matrix_2[(row/2)-1][column] = _COLOR_OFF;
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	MOVWF	POSTDEC1
	BANKSEL	(_DoStartupPattern_row_1_1 + 1)
	MOVF	(_DoStartupPattern_row_1_1 + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_DoStartupPattern_row_1_1, W, B
	MOVWF	POSTDEC1
	CALL	__divsint
	MOVWF	r0x00
	MOVFF	PRODL, r0x01
	MOVLW	0x04
	ADDWF	FSR1L, F
	DECF	r0x00, F
; ;multiply lit val:0x08 by variable r0x00 and store in r0x00
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x00, W
	MULLW	0x08
	MOVFF	PRODL, r0x00
	CLRF	r0x01
	BTFSC	r0x00, 7
	SETF	r0x01
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x00, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x01, F
	MOVFF	_DoStartupPattern_column_1_1, r0x02
	MOVFF	(_DoStartupPattern_column_1_1 + 1), r0x03
	MOVF	r0x02, W
	ADDWF	r0x00, F
	MOVF	r0x03, W
	ADDWFC	r0x01, F
	MOVFF	r0x00, FSR0L
	MOVFF	r0x01, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
	BANKSEL	_DoStartupPattern_column_1_1
;	.line	688; main.c	for (column = 0; column < 8; column++)
	INCF	_DoStartupPattern_column_1_1, F, B
	BNC	_150565_DS_
; removed redundant BANKSEL
	INCF	(_DoStartupPattern_column_1_1 + 1), F, B
_150565_DS_:
	BRA	_00435_DS_
_00438_DS_:
;	.line	692; main.c	MIOS_Delay(150);
	MOVLW	0x96
	CALL	_MIOS_Delay
	BANKSEL	_DoStartupPattern_row_1_1
;	.line	657; main.c	for (row = 0; row < 6; row++)
	INCF	_DoStartupPattern_row_1_1, F, B
	BNC	_160566_DS_
; removed redundant BANKSEL
	INCF	(_DoStartupPattern_row_1_1 + 1), F, B
_160566_DS_:
	BRA	_00439_DS_
_00442_DS_:
;	.line	694; main.c	ClearMatrix(1);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x01
	CALL	_ClearMatrix
	INCF	FSR1L, F
;	.line	695; main.c	ClearMatrix(2);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x02
	CALL	_ClearMatrix
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__ClearMatrix	code
_ClearMatrix:
;	.line	584; main.c	void ClearMatrix(unsigned int matrixIndex) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
;	.line	588; main.c	switch (matrixIndex)
	MOVF	r0x00, W
	XORLW	0x01
	BNZ	_00400_DS_
	MOVF	r0x01, W
	BZ	_00390_DS_
_00400_DS_:
	MOVF	r0x00, W
	XORLW	0x02
	BNZ	_00402_DS_
	MOVF	r0x01, W
	BZ	_00394_DS_
_00402_DS_:
	BRA	_00383_DS_
_00390_DS_:
;	.line	591; main.c	for (row = 0; row < 8; row++)
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00371_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00403_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00403_DS_:
	BC	_00374_DS_
;	.line	593; main.c	for (column = 0; column < 8; column++)
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	CLRF	r0x07
_00367_DS_:
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00404_DS_
	MOVLW	0x08
	SUBWF	r0x06, W
_00404_DS_:
	BC	_00373_DS_
;	.line	595; main.c	matrix_1[row][column] = _COLOR_OFF;
	MOVF	r0x06, W
	ADDWF	r0x04, W
	MOVWF	r0x08
	MOVF	r0x07, W
	ADDWFC	r0x05, W
	MOVWF	r0x09
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	593; main.c	for (column = 0; column < 8; column++)
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	BRA	_00367_DS_
_00373_DS_:
;	.line	591; main.c	for (row = 0; row < 8; row++)
	MOVLW	0x08
	ADDWF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00371_DS_
_00374_DS_:
;	.line	598; main.c	MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
;	.line	599; main.c	break;
	BRA	_00383_DS_
_00394_DS_:
;	.line	602; main.c	for (row = 0; row < 8; row++)
	CLRF	r0x00
	CLRF	r0x01
	CLRF	r0x02
	CLRF	r0x03
_00379_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00405_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00405_DS_:
	BC	_00382_DS_
;	.line	604; main.c	for (column = 0; column < 8; column++)
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x02, W
	MOVWF	r0x04
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x03, W
	MOVWF	r0x05
	CLRF	r0x06
	CLRF	r0x07
_00375_DS_:
	MOVLW	0x00
	SUBWF	r0x07, W
	BNZ	_00406_DS_
	MOVLW	0x08
	SUBWF	r0x06, W
_00406_DS_:
	BC	_00381_DS_
;	.line	606; main.c	matrix_2[row][column] = _COLOR_OFF;
	MOVF	r0x06, W
	ADDWF	r0x04, W
	MOVWF	r0x08
	MOVF	r0x07, W
	ADDWFC	r0x05, W
	MOVWF	r0x09
	MOVFF	r0x08, FSR0L
	MOVFF	r0x09, FSR0H
	MOVLW	0x00
	MOVWF	INDF0
;	.line	604; main.c	for (column = 0; column < 8; column++)
	INCF	r0x06, F
	BTFSC	STATUS, 0
	INCF	r0x07, F
	BRA	_00375_DS_
_00381_DS_:
;	.line	602; main.c	for (row = 0; row < 8; row++)
	MOVLW	0x08
	ADDWF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00379_DS_
_00382_DS_:
;	.line	609; main.c	MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
_00383_DS_:
;	.line	614; main.c	}
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__AIN_NotifyChange	code
_AIN_NotifyChange:
;	.line	554; main.c	void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVWF	r0x00
;	.line	556; main.c	MIOS_MIDI_BeginStream();
	CALL	_MIOS_MIDI_BeginStream
; ;multiply lit val:0x02 by variable r0x00 and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	557; main.c	MIOS_MIDI_TxBufferPut(pot_event_map[pin][0]); // first value from table
	BCF	STATUS, 0
	RLCF	r0x00, W
	MOVWF	r0x01
	MOVLW	LOW(_pot_event_map)
	ADDWF	r0x01, W
	MOVWF	r0x02
	CLRF	r0x03
	MOVLW	HIGH(_pot_event_map)
	ADDWFC	r0x03, F
	CLRF	r0x04
	MOVLW	UPPER(_pot_event_map)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
	MOVF	r0x02, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	558; main.c	MIOS_MIDI_TxBufferPut(pot_event_map[pin][1]); // second value from table
	CLRF	r0x02
	CLRF	r0x03
	MOVLW	LOW(_pot_event_map)
	ADDWF	r0x01, F
	MOVLW	HIGH(_pot_event_map)
	ADDWFC	r0x02, F
	MOVLW	UPPER(_pot_event_map)
	ADDWFC	r0x03, F
	INCF	r0x01, F
	BTFSC	STATUS, 0
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	MOVFF	r0x01, TBLPTRL
	MOVFF	r0x02, TBLPTRH
	MOVFF	r0x03, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x01
	MOVF	r0x01, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	559; main.c	MIOS_MIDI_TxBufferPut(MIOS_AIN_Pin7bitGet(pin)); // 7bit pot value
	MOVF	r0x00, W
	CALL	_MIOS_AIN_Pin7bitGet
	MOVWF	r0x01
	MOVF	r0x01, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	560; main.c	MIOS_MIDI_EndStream();
	CALL	_MIOS_MIDI_EndStream
;	.line	563; main.c	last_ain_pin = pin;
	MOVFF	r0x00, _last_ain_pin
	BANKSEL	_app_flags
;	.line	564; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__ENC_NotifyChange	code
_ENC_NotifyChange:
;	.line	547; main.c	void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	549; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DIN_NotifyToggle	code
_DIN_NotifyToggle:
;	.line	495; main.c	void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
; ;multiply lit val:0x02 by variable r0x00 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	499; main.c	channel = button_event_map[pin][0];
	BCF	STATUS, 0
	RLCF	r0x00, W
	MOVWF	r0x02
	CLRF	r0x03
	CLRF	r0x04
	MOVLW	LOW(_button_event_map)
	ADDWF	r0x02, F
	MOVLW	HIGH(_button_event_map)
	ADDWFC	r0x03, F
	MOVLW	UPPER(_button_event_map)
	ADDWFC	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x05
;	.line	500; main.c	note = button_event_map[pin][1];
	INCF	r0x02, F
	BTFSC	STATUS, 0
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x04, F
	MOVFF	r0x02, TBLPTRL
	MOVFF	r0x03, TBLPTRH
	MOVFF	r0x04, TBLPTRU
	TBLRD*+	
	MOVFF	TABLAT, r0x02
;	.line	502; main.c	MIOS_MIDI_BeginStream();
	CALL	_MIOS_MIDI_BeginStream
;	.line	503; main.c	MIOS_MIDI_TxBufferPut(channel); // first value from table
	MOVF	r0x05, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	504; main.c	MIOS_MIDI_TxBufferPut(note); // second value from table
	MOVF	r0x02, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	505; main.c	MIOS_MIDI_TxBufferPut(pin_value ? 0x00 : 0x7f); // 7bit pot value
	MOVF	r0x01, W
	BZ	_00330_DS_
	CLRF	r0x02
	BRA	_00331_DS_
_00330_DS_:
	MOVLW	0x7f
	MOVWF	r0x02
_00331_DS_:
	MOVF	r0x02, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	506; main.c	MIOS_MIDI_EndStream();
	CALL	_MIOS_MIDI_EndStream
	BANKSEL	_test_mode
;	.line	508; main.c	if (test_mode == 1 && pin_value == 0)
	MOVF	_test_mode, W, B
	XORLW	0x01
	BNZ	_00340_DS_
; removed redundant BANKSEL
	MOVF	(_test_mode + 1), W, B
	BZ	_00341_DS_
_00340_DS_:
	BRA	_00326_DS_
_00341_DS_:
	MOVF	r0x01, W
	BNZ	_00326_DS_
;	.line	510; main.c	switch (pin)
	MOVF	r0x00, W
	XORLW	0x10
	BZ	_00318_DS_
	MOVF	r0x00, W
	XORLW	0x11
	BZ	_00319_DS_
	MOVF	r0x00, W
	XORLW	0x12
	BZ	_00320_DS_
	MOVF	r0x00, W
	XORLW	0x13
	BZ	_00321_DS_
	MOVF	r0x00, W
	XORLW	0x17
	BZ	_00322_DS_
	BRA	_00326_DS_
_00318_DS_:
;	.line	513; main.c	DoStartupPattern();
	CALL	_DoStartupPattern
;	.line	514; main.c	break;
	BRA	_00326_DS_
_00319_DS_:
;	.line	517; main.c	DoShutdownPattern();
	CALL	_DoShutdownPattern
;	.line	518; main.c	break;
	BRA	_00326_DS_
_00320_DS_:
;	.line	521; main.c	TestMatrix1();
	CALL	_TestMatrix1
;	.line	522; main.c	break;
	BRA	_00326_DS_
_00321_DS_:
;	.line	525; main.c	TestMatrix2();
	CALL	_TestMatrix2
;	.line	526; main.c	break;
	BRA	_00326_DS_
_00322_DS_:
;	.line	529; main.c	DoMichaelKnightPattern();
	CALL	_DoMichaelKnightPattern
_00326_DS_:
;	.line	538; main.c	last_din_pin = pin;
	MOVFF	r0x00, _last_din_pin
	BANKSEL	_app_flags
;	.line	539; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Finish	code
_SR_Service_Finish:
;	.line	489; main.c	}
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Prepare	code
_SR_Service_Prepare:
;	.line	463; main.c	void SR_Service_Prepare(void) __wparam
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	BANKSEL	_SR_Service_Prepare_row_1_1
;	.line	468; main.c	row = ++row & 0x07; 						//<-- here you were cycling 16 rows i think you meant 8, no?  
	INCF	_SR_Service_Prepare_row_1_1, F, B
	MOVLW	0x07
; removed redundant BANKSEL
	ANDWF	_SR_Service_Prepare_row_1_1, F, B
;	.line	471; main.c	MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);	//<-- hardwire bad, napster good.  define constants 
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
;	.line	472; main.c	MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);	//    so you can move your matrix in the chain
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
	BANKSEL	_SR_Service_Prepare_row_1_1
;	.line	474; main.c	MIOS_DOUT_PinSet1(row + (_MATRIX_1_DOUT_START * 8));
	MOVF	_SR_Service_Prepare_row_1_1, W, B
	CALL	_MIOS_DOUT_PinSet1
;	.line	475; main.c	MIOS_DOUT_PinSet1(row + (_MATRIX_2_DOUT_START * 8));
	MOVLW	0x20
	BANKSEL	_SR_Service_Prepare_row_1_1
	ADDWF	_SR_Service_Prepare_row_1_1, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_DOUT_PinSet1
;	.line	476; main.c	for (x = 0; x < 8; x++)
	CLRF	r0x00
	CLRF	r0x01
_00299_DS_:
	MOVLW	0x00
	SUBWF	r0x01, W
	BNZ	_00309_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00309_DS_:
	BTFSC	STATUS, 0
	BRA	_00303_DS_
;	.line	478; main.c	DisplayLED(x + (_MATRIX_1_DOUT_START * 8), matrix_1[row][x]);
	MOVF	r0x00, W
	MOVWF	r0x02
; ;multiply lit val:0x08 by variable _SR_Service_Prepare_row_1_1 and store in r0x03
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_SR_Service_Prepare_row_1_1
	MOVF	_SR_Service_Prepare_row_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x04, F
	MOVF	r0x00, W
	ADDWF	r0x03, F
	MOVF	r0x01, W
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_DisplayLED
	INCF	FSR1L, F
;	.line	479; main.c	DisplayLED(x + (_MATRIX_2_DOUT_START * 8), matrix_2[row][x]);
	MOVLW	0x20
	ADDWF	r0x02, F
; ;multiply lit val:0x08 by variable _SR_Service_Prepare_row_1_1 and store in r0x03
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	BANKSEL	_SR_Service_Prepare_row_1_1
	MOVF	_SR_Service_Prepare_row_1_1, W, B
	MULLW	0x08
	MOVFF	PRODL, r0x03
	CLRF	r0x04
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x04, F
	MOVF	r0x00, W
	ADDWF	r0x03, F
	MOVF	r0x01, W
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	INDF0, r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_DisplayLED
	INCF	FSR1L, F
;	.line	476; main.c	for (x = 0; x < 8; x++)
	INCF	r0x00, F
	BTFSC	STATUS, 0
	INCF	r0x01, F
	BRA	_00299_DS_
_00303_DS_:
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__DisplayLED	code
_DisplayLED:
;	.line	447; main.c	void DisplayLED(unsigned char column, unsigned char color) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
;	.line	449; main.c	color >>= 4; 
	SWAPF	r0x01, W
	ANDLW	0x0f
	MOVWF	r0x01
;	.line	450; main.c	MIOS_DOUT_PinSet(column+8,		(color & 0x01)); 
	MOVLW	0x08
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	0x01
	ANDWF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	451; main.c	color >>= 1; 
	BCF	STATUS, 0
	RRCF	r0x01, F
;	.line	452; main.c	MIOS_DOUT_PinSet(column+8+8,	(color & 0x01));
	MOVLW	0x10
	ADDWF	r0x00, W
	MOVWF	r0x02
	MOVLW	0x01
	ANDWF	r0x01, W
	MOVWF	r0x03
	MOVF	r0x03, W
	MOVWF	POSTDEC1
	MOVF	r0x02, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	453; main.c	color >>= 1; 
	BCF	STATUS, 0
	RRCF	r0x01, F
;	.line	454; main.c	MIOS_DOUT_PinSet(column+8+16,	(color & 0x01));
	MOVLW	0x18
	ADDWF	r0x00, F
	MOVLW	0x01
	ANDWF	r0x01, F
	MOVF	r0x01, W
	MOVWF	POSTDEC1
	MOVF	r0x00, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedByte	code
_MPROC_NotifyReceivedByte:
;	.line	356; main.c	void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVWF	r0x00
;	.line	358; main.c	switch (byte)
	MOVF	r0x00, W
	XORLW	0x77
	BZ	_00219_DS_
	MOVF	r0x00, W
	XORLW	0xf0
	BZ	_00217_DS_
	MOVF	r0x00, W
	XORLW	0xf7
	BZ	_00218_DS_
	MOVF	r0x00, W
	XORLW	0xf8
	BNZ	_00273_DS_
	BRA	_00230_DS_
_00273_DS_:
	MOVF	r0x00, W
	XORLW	0xfa
	BZ	_00229_DS_
	MOVF	r0x00, W
	XORLW	0xfb
	BZ	_00229_DS_
	MOVF	r0x00, W
	XORLW	0xfc
	BZ	_00229_DS_
	BRA	_00244_DS_
_00217_DS_:
;	.line	361; main.c	record_sysex = 1;
	MOVLW	0x01
	BANKSEL	_record_sysex
	MOVWF	_record_sysex, B
; removed redundant BANKSEL
	CLRF	(_record_sysex + 1), B
;	.line	362; main.c	break;
	BRA	_00248_DS_
_00218_DS_:
	BANKSEL	_record_sysex
;	.line	365; main.c	record_sysex = 0;
	CLRF	_record_sysex, B
; removed redundant BANKSEL
	CLRF	(_record_sysex + 1), B
;	.line	366; main.c	break;
	BRA	_00248_DS_
_00219_DS_:
	BANKSEL	_record_sysex
;	.line	369; main.c	if (record_sysex == 1)
	MOVF	_record_sysex, W, B
	XORLW	0x01
	BNZ	_00280_DS_
; removed redundant BANKSEL
	MOVF	(_record_sysex + 1), W, B
	BZ	_00281_DS_
_00280_DS_:
	BRA	_00248_DS_
_00281_DS_:
	BANKSEL	_last_sysex
;	.line	371; main.c	if (last_sysex == 0x01)		// connect
	MOVF	_last_sysex, W, B
	XORLW	0x01
	BNZ	_00223_DS_
;	.line	373; main.c	DoMichaelKnightPattern();
	CALL	_DoMichaelKnightPattern
	BANKSEL	_test_mode
;	.line	374; main.c	test_mode = 0;
	CLRF	_test_mode, B
; removed redundant BANKSEL
	CLRF	(_test_mode + 1), B
	BRA	_00248_DS_
_00223_DS_:
	BANKSEL	_last_sysex
;	.line	376; main.c	else if (last_sysex == 0x02)	// disconnect
	MOVF	_last_sysex, W, B
	XORLW	0x02
	BZ	_00285_DS_
	BRA	_00248_DS_
_00285_DS_:
;	.line	378; main.c	DoShutdownPattern();
	CALL	_DoShutdownPattern
;	.line	379; main.c	test_mode = 1;
	MOVLW	0x01
	BANKSEL	_test_mode
	MOVWF	_test_mode, B
; removed redundant BANKSEL
	CLRF	(_test_mode + 1), B
;	.line	382; main.c	break;
	BRA	_00248_DS_
_00229_DS_:
	BANKSEL	_clock_ticks
;	.line	387; main.c	clock_ticks = 0;
	CLRF	_clock_ticks, B
; removed redundant BANKSEL
	CLRF	(_clock_ticks + 1), B
	BANKSEL	_clock_beats
;	.line	388; main.c	clock_beats = 0;
	CLRF	_clock_beats, B
; removed redundant BANKSEL
	CLRF	(_clock_beats + 1), B
	BANKSEL	_clock_bars
;	.line	389; main.c	clock_bars = 0;
	CLRF	_clock_bars, B
; removed redundant BANKSEL
	CLRF	(_clock_bars + 1), B
	BANKSEL	(_matrix_2 + 53)
;	.line	390; main.c	matrix_2[6][5] = _COLOR_OFF;
	CLRF	(_matrix_2 + 53), B
;	.line	391; main.c	break;
	BRA	_00248_DS_
_00230_DS_:
	BANKSEL	_clock_ticks
;	.line	394; main.c	clock_ticks++;
	INCF	_clock_ticks, F, B
	BNC	_170567_DS_
; removed redundant BANKSEL
	INCF	(_clock_ticks + 1), F, B
_170567_DS_:
;	.line	395; main.c	if (clock_ticks % 24 == 0)
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x18
	MOVWF	POSTDEC1
	BANKSEL	(_clock_ticks + 1)
	MOVF	(_clock_ticks + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_clock_ticks, W, B
	MOVWF	POSTDEC1
	CALL	__moduint
	MOVWF	r0x01
	MOVFF	PRODL, r0x02
	MOVLW	0x04
	ADDWF	FSR1L, F
	MOVF	r0x01, W
	IORWF	r0x02, W
	BTFSS	STATUS, 2
	BRA	_00234_DS_
	BANKSEL	_clock_beats
;	.line	397; main.c	clock_beats++;
	INCF	_clock_beats, F, B
	BNC	_180568_DS_
; removed redundant BANKSEL
	INCF	(_clock_beats + 1), F, B
_180568_DS_:
	BANKSEL	_clock_beats
;	.line	398; main.c	if (clock_beats % 4 == 0)
	MOVF	_clock_beats, W, B
	ANDLW	0x03
	BNZ	_00232_DS_
	BANKSEL	_clock_bars
;	.line	400; main.c	clock_bars++;
	INCF	_clock_bars, F, B
	BNC	_190569_DS_
; removed redundant BANKSEL
	INCF	(_clock_bars + 1), F, B
_190569_DS_:
	BANKSEL	_clock_beats
;	.line	401; main.c	clock_beats = 0;
	CLRF	_clock_beats, B
; removed redundant BANKSEL
	CLRF	(_clock_beats + 1), B
_00232_DS_:
;	.line	403; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	404; main.c	MIOS_LCD_CursorSet(0x00 + 0); 
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_clock_bars + 1)
;	.line	405; main.c	MIOS_LCD_PrintBCD4(clock_bars);
	MOVF	(_clock_bars + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_clock_bars, W, B
	CALL	_MIOS_LCD_PrintBCD4
	INCF	FSR1L, F
;	.line	406; main.c	MIOS_LCD_CursorSet(0x00 + 4);
	MOVLW	0x04
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_clock_beats + 1)
;	.line	407; main.c	MIOS_LCD_PrintBCD4(clock_beats);
	MOVF	(_clock_beats + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_clock_beats, W, B
	CALL	_MIOS_LCD_PrintBCD4
	INCF	FSR1L, F
;	.line	408; main.c	MIOS_LCD_CursorSet(0x00 + 8);
	MOVLW	0x08
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	(_clock_ticks + 1)
;	.line	409; main.c	MIOS_LCD_PrintBCD4(clock_ticks);
	MOVF	(_clock_ticks + 1), W, B
	MOVWF	POSTDEC1
; removed redundant BANKSEL
	MOVF	_clock_ticks, W, B
	CALL	_MIOS_LCD_PrintBCD4
	INCF	FSR1L, F
	BANKSEL	_app_flags
;	.line	410; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
	BANKSEL	_clock_ticks
;	.line	411; main.c	clock_ticks = 0;
	CLRF	_clock_ticks, B
; removed redundant BANKSEL
	CLRF	(_clock_ticks + 1), B
_00234_DS_:
;	.line	413; main.c	if (clock_ticks < 12)
	MOVLW	0x00
	BANKSEL	(_clock_ticks + 1)
	SUBWF	(_clock_ticks + 1), W, B
	BNZ	_00287_DS_
	MOVLW	0x0c
; removed redundant BANKSEL
	SUBWF	_clock_ticks, W, B
_00287_DS_:
	BC	_00242_DS_
	BANKSEL	_clock_beats
;	.line	415; main.c	if (clock_beats == 0)
	MOVF	_clock_beats, W, B
; removed redundant BANKSEL
	IORWF	(_clock_beats + 1), W, B
	BNZ	_00239_DS_
	BANKSEL	_clock_bars
;	.line	417; main.c	if (clock_bars % 4 == 0)
	MOVF	_clock_bars, W, B
	ANDLW	0x03
	BNZ	_00236_DS_
;	.line	419; main.c	matrix_2[6][5] = _COLOR_WHITE;
	MOVLW	0x70
	BANKSEL	(_matrix_2 + 53)
	MOVWF	(_matrix_2 + 53), B
	BRA	_00248_DS_
_00236_DS_:
;	.line	423; main.c	matrix_2[6][5] = _COLOR_GREEN;
	MOVLW	0x20
	BANKSEL	(_matrix_2 + 53)
	MOVWF	(_matrix_2 + 53), B
	BRA	_00248_DS_
_00239_DS_:
;	.line	428; main.c	matrix_2[6][5] = _COLOR_BLUE;
	MOVLW	0x40
	BANKSEL	(_matrix_2 + 53)
	MOVWF	(_matrix_2 + 53), B
	BRA	_00248_DS_
_00242_DS_:
	BANKSEL	(_matrix_2 + 53)
;	.line	433; main.c	matrix_2[6][5] = _COLOR_OFF;
	CLRF	(_matrix_2 + 53), B
;	.line	435; main.c	break;
	BRA	_00248_DS_
_00244_DS_:
	BANKSEL	_record_sysex
;	.line	438; main.c	if (record_sysex == 1)
	MOVF	_record_sysex, W, B
	XORLW	0x01
	BNZ	_00289_DS_
; removed redundant BANKSEL
	MOVF	(_record_sysex + 1), W, B
	BZ	_00290_DS_
_00289_DS_:
	BRA	_00248_DS_
_00290_DS_:
;	.line	440; main.c	last_sysex = byte;
	MOVFF	r0x00, _last_sysex
_00248_DS_:
;	.line	443; main.c	}
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyTimeout	code
_MPROC_NotifyTimeout:
;	.line	351; main.c	}
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyFoundEvent	code
_MPROC_NotifyFoundEvent:
;	.line	341; main.c	void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	343; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedEvnt	code
_MPROC_NotifyReceivedEvnt:
;	.line	271; main.c	void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVFF	r0x05, POSTDEC1
	MOVFF	r0x06, POSTDEC1
	MOVFF	r0x07, POSTDEC1
	MOVFF	r0x08, POSTDEC1
	MOVFF	r0x09, POSTDEC1
	MOVFF	r0x0a, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
	MOVLW	0x03
	MOVFF	PLUSW2, r0x02
;	.line	273; main.c	int channelIndex = evnt0-0x90;
	CLRF	r0x03
	MOVLW	0x70
	ADDWF	r0x00, F
	BTFSS	STATUS, 0
	DECF	r0x03, F
;	.line	274; main.c	int noteIndex = evnt1;
	CLRF	r0x04
;	.line	275; main.c	unsigned char value = evnt2;
	MOVFF	r0x02, r0x05
;	.line	276; main.c	if (channelIndex >= 0 && channelIndex <= 7)
	BSF	STATUS, 0
	BTFSS	r0x03, 7
	BCF	STATUS, 0
	BTFSC	STATUS, 0
	BRA	_00160_DS_
	MOVF	r0x03, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00190_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00190_DS_:
	BTFSC	STATUS, 0
	BRA	_00160_DS_
;	.line	279; main.c	switch(noteIndex-_NOTE_SEND_OFFSET)
	MOVF	r0x01, W
	ADDLW	0xe0
	MOVWF	r0x06
	MOVLW	0xff
	ADDWFC	r0x04, W
	MOVWF	r0x07
	BSF	STATUS, 0
	BTFSS	r0x07, 7
	BCF	STATUS, 0
	BTFSC	STATUS, 0
	BRA	_00167_DS_
	MOVF	r0x07, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00191_DS_
	MOVLW	0x0c
	SUBWF	r0x06, W
_00191_DS_:
	BTFSC	STATUS, 0
	BRA	_00167_DS_
	MOVFF	r0x0b, POSTDEC1
	MOVFF	r0x0c, POSTDEC1
	CLRF	r0x0c
	RLCF	r0x06, W
	RLCF	r0x0c, F
	RLCF	WREG, W
	RLCF	r0x0c, F
	ANDLW	0xfc
	MOVWF	r0x0b
	MOVLW	UPPER(_00192_DS_)
	MOVWF	PCLATU
	MOVLW	HIGH(_00192_DS_)
	MOVWF	PCLATH
	MOVLW	LOW(_00192_DS_)
	ADDWF	r0x0b, F
	MOVF	r0x0c, W
	ADDWFC	PCLATH, F
	BTFSC	STATUS, 0
	INCF	PCLATU, F
	MOVF	r0x0b, W
	MOVFF	PREINC1, r0x0c
	MOVFF	PREINC1, r0x0b
	MOVWF	PCL
_00192_DS_:
	GOTO	_00135_DS_
	GOTO	_00135_DS_
	GOTO	_00135_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00142_DS_
	GOTO	_00143_DS_
	GOTO	_00144_DS_
_00135_DS_:
;	.line	286; main.c	matrix_2[noteIndex-_NOTE_SEND_OFFSET][channelIndex] = value;
	MOVF	r0x01, W
	MOVWF	r0x06
	MOVLW	0xe0
	ADDWF	r0x06, F
; ;multiply lit val:0x08 by variable r0x06 and store in r0x06
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x06, W
	MULLW	0x08
	MOVFF	PRODL, r0x06
	CLRF	r0x07
	BTFSC	r0x06, 7
	SETF	r0x07
	MOVLW	LOW(_matrix_2)
	ADDWF	r0x06, F
	MOVLW	HIGH(_matrix_2)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	MOVF	r0x03, W
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x05, INDF0
;	.line	287; main.c	break;
	BRA	_00167_DS_
_00142_DS_:
_00143_DS_:
;	.line	298; main.c	matrix_1[noteIndex-_NOTE_SEND_OFFSET-3][channelIndex] = value;
	MOVF	r0x01, W
	MOVWF	r0x06
	MOVLW	0xdd
	ADDWF	r0x06, F
; ;multiply lit val:0x08 by variable r0x06 and store in r0x06
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
	MOVF	r0x06, W
	MULLW	0x08
	MOVFF	PRODL, r0x06
	CLRF	r0x07
	BTFSC	r0x06, 7
	SETF	r0x07
	MOVLW	LOW(_matrix_1)
	ADDWF	r0x06, F
	MOVLW	HIGH(_matrix_1)
	ADDWFC	r0x07, F
	MOVF	r0x00, W
	ADDWF	r0x06, F
	MOVF	r0x03, W
	ADDWFC	r0x07, F
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x05, INDF0
;	.line	299; main.c	break;
	BRA	_00167_DS_
_00144_DS_:
;	.line	303; main.c	matrix_2[3][channelIndex] = value;
	MOVLW	LOW(_matrix_2 + 24)
	ADDWF	r0x00, W
	MOVWF	r0x06
	MOVLW	HIGH(_matrix_2 + 24)
	ADDWFC	r0x03, W
	MOVWF	r0x07
	MOVFF	r0x06, FSR0L
	MOVFF	r0x07, FSR0H
	MOVFF	r0x02, INDF0
;	.line	304; main.c	break;
	BRA	_00167_DS_
_00160_DS_:
;	.line	311; main.c	else if (channelIndex >= 8 && channelIndex <= 15)
	MOVF	r0x03, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00193_DS_
	MOVLW	0x08
	SUBWF	r0x00, W
_00193_DS_:
	BTFSS	STATUS, 0
	BRA	_00167_DS_
	MOVF	r0x03, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00194_DS_
	MOVLW	0x10
	SUBWF	r0x00, W
_00194_DS_:
	BTFSC	STATUS, 0
	BRA	_00167_DS_
;	.line	314; main.c	if (noteIndex-_NOTE_SEND_OFFSET >= 0 && noteIndex-_NOTE_SEND_OFFSET <= 16)
	MOVF	r0x01, W
	ADDLW	0xe0
	MOVWF	r0x00
	MOVLW	0xff
	ADDWFC	r0x04, W
	MOVWF	r0x02
	BSF	STATUS, 0
	BTFSS	r0x02, 7
	BCF	STATUS, 0
	BTFSC	STATUS, 0
	BRA	_00148_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00195_DS_
	MOVLW	0x11
	SUBWF	r0x00, W
_00195_DS_:
	BTFSC	STATUS, 0
	BRA	_00148_DS_
;	.line	318; main.c	for(x = 0; x < 8; x++)
	CLRF	r0x03
	CLRF	r0x06
_00163_DS_:
	MOVF	r0x06, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00196_DS_
	MOVLW	0x08
	SUBWF	r0x03, W
_00196_DS_:
	BC	_00148_DS_
;	.line	320; main.c	matrix_2[4][x] = ((x+0) == noteIndex-_NOTE_SEND_OFFSET) ? value : _COLOR_OFF;
	MOVLW	LOW(_matrix_2 + 32)
	ADDWF	r0x03, W
	MOVWF	r0x07
	MOVLW	HIGH(_matrix_2 + 32)
	ADDWFC	r0x06, W
	MOVWF	r0x08
	MOVF	r0x03, W
	XORWF	r0x00, W
	BNZ	_00169_DS_
	MOVF	r0x06, W
	XORWF	r0x02, W
	BZ	_00198_DS_
_00197_DS_:
	BRA	_00169_DS_
_00198_DS_:
	MOVFF	r0x05, r0x09
	BRA	_00170_DS_
_00169_DS_:
	CLRF	r0x09
_00170_DS_:
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	321; main.c	matrix_2[5][x] = ((x+8) == noteIndex-_NOTE_SEND_OFFSET) ? value : _COLOR_OFF;
	MOVLW	LOW(_matrix_2 + 40)
	ADDWF	r0x03, W
	MOVWF	r0x07
	MOVLW	HIGH(_matrix_2 + 40)
	ADDWFC	r0x06, W
	MOVWF	r0x08
	MOVF	r0x03, W
	ADDLW	0x08
	MOVWF	r0x09
	MOVLW	0x00
	ADDWFC	r0x06, W
	MOVWF	r0x0a
	MOVF	r0x09, W
	XORWF	r0x00, W
	BNZ	_00171_DS_
	MOVF	r0x0a, W
	XORWF	r0x02, W
	BZ	_00200_DS_
_00199_DS_:
	BRA	_00171_DS_
_00200_DS_:
	MOVFF	r0x05, r0x09
	BRA	_00172_DS_
_00171_DS_:
	CLRF	r0x09
_00172_DS_:
	MOVFF	r0x07, FSR0L
	MOVFF	r0x08, FSR0H
	MOVFF	r0x09, INDF0
;	.line	318; main.c	for(x = 0; x < 8; x++)
	INCF	r0x03, F
	BTFSC	STATUS, 0
	INCF	r0x06, F
	BRA	_00163_DS_
_00148_DS_:
;	.line	325; main.c	if (noteIndex-_NOTE_SEND_OFFSET >= 17 && noteIndex-_NOTE_SEND_OFFSET <= 24)
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00201_DS_
	MOVLW	0x11
	SUBWF	r0x00, W
_00201_DS_:
	BNC	_00151_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00202_DS_
	MOVLW	0x19
	SUBWF	r0x00, W
_00202_DS_:
	BC	_00151_DS_
;	.line	327; main.c	matrix_2[6][noteIndex-_NOTE_SEND_OFFSET-17] = value;
	MOVF	r0x01, W
	MOVWF	r0x03
	MOVLW	0xcf
	ADDWF	r0x03, F
	CLRF	r0x06
	BTFSC	r0x03, 7
	SETF	r0x06
	MOVLW	LOW(_matrix_2 + 48)
	ADDWF	r0x03, F
	MOVLW	HIGH(_matrix_2 + 48)
	ADDWFC	r0x06, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x06, FSR0H
	MOVFF	r0x05, INDF0
_00151_DS_:
;	.line	330; main.c	if (noteIndex-_NOTE_SEND_OFFSET >= 25 && noteIndex-_NOTE_SEND_OFFSET <= 32)
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00203_DS_
	MOVLW	0x19
	SUBWF	r0x00, W
_00203_DS_:
	BNC	_00167_DS_
	MOVF	r0x02, W
	ADDLW	0x80
	ADDLW	0x80
	BNZ	_00204_DS_
	MOVLW	0x21
	SUBWF	r0x00, W
_00204_DS_:
	BC	_00167_DS_
;	.line	332; main.c	matrix_2[7][noteIndex-_NOTE_SEND_OFFSET-25] = value;
	MOVLW	0xc7
	ADDWF	r0x01, F
	CLRF	r0x00
	BTFSC	r0x01, 7
	SETF	r0x00
	MOVLW	LOW(_matrix_2 + 56)
	ADDWF	r0x01, F
	MOVLW	HIGH(_matrix_2 + 56)
	ADDWFC	r0x00, F
	MOVFF	r0x01, FSR0L
	MOVFF	r0x00, FSR0H
	MOVFF	r0x05, INDF0
_00167_DS_:
	MOVFF	PREINC1, r0x0a
	MOVFF	PREINC1, r0x09
	MOVFF	PREINC1, r0x08
	MOVFF	PREINC1, r0x07
	MOVFF	PREINC1, r0x06
	MOVFF	PREINC1, r0x05
	MOVFF	PREINC1, r0x04
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Tick	code
_DISPLAY_Tick:
;	.line	242; main.c	void DISPLAY_Tick(void) __wparam
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_app_flags
;	.line	245; main.c	if( !app_flags.DISPLAY_UPDATE_REQ )
	BTFSC	_app_flags, 0, B
	BRA	_00122_DS_
;	.line	246; main.c	return;
	BRA	_00123_DS_
_00122_DS_:
	BANKSEL	_app_flags
;	.line	249; main.c	app_flags.DISPLAY_UPDATE_REQ = 0;
	BCF	_app_flags, 0, B
;	.line	252; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_ain_pin
;	.line	253; main.c	MIOS_LCD_PrintBCD2(last_ain_pin + 1);
	INCF	_last_ain_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD2
;	.line	254; main.c	MIOS_LCD_PrintChar(':');
	MOVLW	0x3a
	CALL	_MIOS_LCD_PrintChar
	BANKSEL	_last_ain_pin
;	.line	255; main.c	MIOS_LCD_PrintBCD3(MIOS_AIN_Pin7bitGet(last_ain_pin));
	MOVF	_last_ain_pin, W, B
	CALL	_MIOS_AIN_Pin7bitGet
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
;	.line	258; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_din_pin
;	.line	259; main.c	MIOS_LCD_PrintBCD3(last_din_pin + 1);
	INCF	_last_din_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
	BANKSEL	_last_din_pin
;	.line	260; main.c	MIOS_LCD_PrintChar(MIOS_DIN_PinGet(last_din_pin) ? 'o' : '*');
	MOVF	_last_din_pin, W, B
	CALL	_MIOS_DIN_PinGet
	MOVWF	r0x00
	MOVF	r0x00, W
	BZ	_00125_DS_
	MOVLW	0x6f
	MOVWF	r0x00
	BRA	_00126_DS_
_00125_DS_:
	MOVLW	0x2a
	MOVWF	r0x00
_00126_DS_:
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintChar
;	.line	263; main.c	MIOS_LCD_CursorSet(0x40 + 12);
	MOVLW	0x4c
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_dout_pin
;	.line	264; main.c	MIOS_LCD_PrintBCD3(last_dout_pin + 1);
	INCF	_last_dout_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
	BANKSEL	_last_dout_pin
;	.line	265; main.c	MIOS_LCD_PrintChar(MIOS_DOUT_PinGet(last_dout_pin) ? '*' : 'o');
	MOVF	_last_dout_pin, W, B
	CALL	_MIOS_DOUT_PinGet
	MOVWF	r0x00
	MOVF	r0x00, W
	BZ	_00127_DS_
	MOVLW	0x2a
	MOVWF	r0x00
	BRA	_00128_DS_
_00127_DS_:
	MOVLW	0x6f
	MOVWF	r0x00
_00128_DS_:
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintChar
_00123_DS_:
	MOVFF	PREINC1, r0x00
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Init	code
_DISPLAY_Init:
;	.line	223; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	226; main.c	MIOS_LCD_CursorSet(0x00); // first line
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	227; main.c	MIOS_LCD_PrintCString("2AIN   DIN  DOUT");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	228; main.c	MIOS_LCD_CursorSet(0x40); // second line
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	229; main.c	MIOS_LCD_PrintCString("xx:xxx xxxx xxxx");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_app_flags
;	.line	232; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
;	.line	235; main.c	DoStartupPattern();
	CALL	_DoStartupPattern
	RETURN	

; ; Starting pCode block
S_main__Timer	code
_Timer:
;	.line	213; main.c	}
	RETURN	

; ; Starting pCode block
S_main__Tick	code
_Tick:
;	.line	205; main.c	}
	RETURN	

; ; Starting pCode block
S_main__Init	code
_Init:
;	.line	165; main.c	test_mode = 1;
	MOVLW	0x01
	BANKSEL	_test_mode
	MOVWF	_test_mode, B
; removed redundant BANKSEL
	CLRF	(_test_mode + 1), B
	BANKSEL	_record_sysex
;	.line	166; main.c	record_sysex = 0;
	CLRF	_record_sysex, B
; removed redundant BANKSEL
	CLRF	(_record_sysex + 1), B
	BANKSEL	_last_sysex
;	.line	167; main.c	last_sysex = 0x00;
	CLRF	_last_sysex, B
	BANKSEL	_clock_ticks
;	.line	168; main.c	clock_ticks = 0;
	CLRF	_clock_ticks, B
; removed redundant BANKSEL
	CLRF	(_clock_ticks + 1), B
	BANKSEL	_clock_beats
;	.line	169; main.c	clock_beats = 0;
	CLRF	_clock_beats, B
; removed redundant BANKSEL
	CLRF	(_clock_beats + 1), B
	BANKSEL	_clock_bars
;	.line	170; main.c	clock_bars = 0;
	CLRF	_clock_bars, B
; removed redundant BANKSEL
	CLRF	(_clock_bars + 1), B
;	.line	173; main.c	MIOS_MIDI_MergerSet(MIOS_MIDI_MERGER_MBLINK_EP);
	MOVLW	0x02
	CALL	_MIOS_MIDI_MergerSet
;	.line	176; main.c	MIOS_SRIO_UpdateFrqSet(1); // ms
	MOVLW	0x01
	CALL	_MIOS_SRIO_UpdateFrqSet
;	.line	179; main.c	MIOS_SRIO_NumberSet(NUMBER_OF_SRIO);
	MOVLW	0x08
	CALL	_MIOS_SRIO_NumberSet
;	.line	182; main.c	MIOS_SRIO_DebounceSet(DIN_DEBOUNCE_VALUE);
	MOVLW	0x0a
	CALL	_MIOS_SRIO_DebounceSet
;	.line	184; main.c	MIOS_SRIO_TS_SensitivitySet(DIN_TS_SENSITIVITY);
	MOVLW	0x00
	CALL	_MIOS_SRIO_TS_SensitivitySet
;	.line	187; main.c	MIOS_AIN_NumberSet(AIN_NUMBER_INPUTS);
	MOVLW	0x40
	CALL	_MIOS_AIN_NumberSet
;	.line	189; main.c	MIOS_AIN_Muxed();
	CALL	_MIOS_AIN_Muxed
;	.line	193; main.c	MIOS_AIN_DeadbandSet(AIN_DEADBAND);
	MOVLW	0x07
	CALL	_MIOS_AIN_DeadbandSet
;	.line	196; main.c	MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x00
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
;	.line	197; main.c	MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);
	MOVLW	0x00
	MOVWF	POSTDEC1
	MOVLW	0x04
	CALL	_MIOS_DOUT_SRSet
	INCF	FSR1L, F
	RETURN	

; ; Starting pCode block for Ival
	code
_pot_event_map:
	DB	0xb0, 0x32, 0xb1, 0x32, 0xb2, 0x32, 0xb3, 0x32, 0xb4, 0x32, 0xb5, 0x32
	DB	0xb6, 0x32, 0xb7, 0x32, 0xb0, 0x33, 0xb1, 0x33, 0xb2, 0x33, 0xb3, 0x33
	DB	0xb4, 0x33, 0xb5, 0x33, 0xb6, 0x33, 0xb7, 0x33, 0xb0, 0x34, 0xb1, 0x34
	DB	0xb2, 0x34, 0xb3, 0x34, 0xb4, 0x34, 0xb5, 0x34, 0xb6, 0x34, 0xb7, 0x34
	DB	0xb0, 0x35, 0xb1, 0x35, 0xb2, 0x35, 0xb3, 0x35, 0xb4, 0x35, 0xb5, 0x35
	DB	0xb6, 0x35, 0xb7, 0x35, 0xb0, 0x36, 0xb1, 0x36, 0xb2, 0x36, 0xb3, 0x36
	DB	0xb4, 0x36, 0xb5, 0x36, 0xb6, 0x36, 0xb7, 0x36, 0xb0, 0x37, 0xb1, 0x37
	DB	0xb2, 0x37, 0xb3, 0x37, 0xb4, 0x37, 0xb5, 0x37, 0xb6, 0x37, 0xb7, 0x37
	DB	0xb0, 0x38, 0xb1, 0x38, 0xb2, 0x38, 0xb3, 0x38, 0xb4, 0x38, 0xb5, 0x38
	DB	0xb6, 0x38, 0xb7, 0x38, 0xb0, 0x39, 0xb1, 0x39, 0xb2, 0x39, 0xb3, 0x39
	DB	0xb4, 0x39, 0xb5, 0x39, 0xb6, 0x39, 0xb7, 0x39
; ; Starting pCode block for Ival
_button_event_map:
	DB	0x98, 0x00, 0x98, 0x01, 0x98, 0x02, 0x98, 0x03, 0x98, 0x04, 0x98, 0x05
	DB	0x98, 0x06, 0x98, 0x07, 0x98, 0x08, 0x98, 0x09, 0x98, 0x0a, 0x98, 0x0b
	DB	0x98, 0x0c, 0x98, 0x0d, 0x98, 0x0e, 0x98, 0x0f, 0x98, 0x10, 0x98, 0x11
	DB	0x98, 0x12, 0x98, 0x13, 0x98, 0x14, 0x98, 0x15, 0x98, 0x16, 0x98, 0x17
	DB	0x98, 0x18, 0x98, 0x19, 0x98, 0x1a, 0x98, 0x1b, 0x98, 0x1c, 0x98, 0x1d
	DB	0x98, 0x1e, 0x98, 0x1f, 0x90, 0x0b, 0x91, 0x0b, 0x92, 0x0b, 0x93, 0x0b
	DB	0x97, 0x0b, 0x96, 0x0b, 0x95, 0x0b, 0x94, 0x0b, 0x91, 0x01, 0x91, 0x02
	DB	0x90, 0x01, 0x90, 0x02, 0x93, 0x02, 0x93, 0x01, 0x92, 0x01, 0x92, 0x02
	DB	0x90, 0x00, 0x91, 0x00, 0x93, 0x00, 0x92, 0x00, 0x95, 0x02, 0x95, 0x01
	DB	0x94, 0x01, 0x94, 0x02, 0x94, 0x00, 0x95, 0x00, 0x97, 0x00, 0x96, 0x00
	DB	0x97, 0x02, 0x97, 0x01, 0x96, 0x01, 0x96, 0x02
; ; Starting pCode block
__str_0:
	DB	0x32, 0x41, 0x49, 0x4e, 0x20, 0x20, 0x20, 0x44, 0x49, 0x4e, 0x20, 0x20
	DB	0x44, 0x4f, 0x55, 0x54, 0x00
; ; Starting pCode block
__str_1:
	DB	0x78, 0x78, 0x3a, 0x78, 0x78, 0x78, 0x20, 0x78, 0x78, 0x78, 0x78, 0x20
	DB	0x78, 0x78, 0x78, 0x78, 0x00


; Statistics:
; code size:	 8666 (0x21da) bytes ( 6.61%)
;           	 4333 (0x10ed) words
; udata size:	   35 (0x0023) bytes ( 2.73%)
; access size:	   13 (0x000d) bytes


	end
