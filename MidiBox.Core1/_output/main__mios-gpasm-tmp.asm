;--------------------------------------------------------
; File Created by SDCC : free open source ANSI-C Compiler
; Version 2.8.0 #5117 (Mar 23 2008) (MINGW32)
; This file was generated Sun Nov 22 19:11:42 2009
;--------------------------------------------------------
; PIC16 port for the Microchip 16-bit core micros
;--------------------------------------------------------
	list	p=18f452

	radix dec

;--------------------------------------------------------
; public variables in this module
;--------------------------------------------------------
	global _app_flags
	global _last_ain_pin
	global _last_din_pin
	global _last_dout_pin
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
	extern _MIOS_SRIO_NumberSet
	extern _MIOS_SRIO_TS_SensitivitySet
	extern _MIOS_SRIO_UpdateFrqSet
	extern _MIOS_SRIO_DebounceSet
	extern _MIOS_LCD_Clear
	extern _MIOS_LCD_CursorSet
	extern _MIOS_LCD_PrintBCD2
	extern _MIOS_LCD_PrintBCD3
	extern _MIOS_LCD_PrintChar
	extern _MIOS_LCD_PrintCString
	extern _mios_enc_pin_table
	extern _mios_mproc_event_table
	extern _MIOS_MPROC_EVENT_TABLE
	extern _MIOS_ENC_PIN_TABLE
;--------------------------------------------------------
;	Equates to used internal registers
;--------------------------------------------------------
STATUS	equ	0xfd8
TBLPTRL	equ	0xff6
TBLPTRH	equ	0xff7
TBLPTRU	equ	0xff8
TABLAT	equ	0xff5
FSR0L equ 0xfe1 ;; normaly 0xfe9, changed by mios-gpasm
FSR0H equ 0xfe2 ;; normaly 0xfea, changed by mios-gpasm
FSR1L equ 0xfe9 ;; normaly 0xfe1, changed by mios-gpasm
FSR2L	equ	0xfd9
INDF0 equ 0xfe7 ;; normaly 0xfef, changed by mios-gpasm
POSTINC0 equ 0xfe6 ;; normaly 0xfee, changed by mios-gpasm
POSTDEC1 equ 0xfed ;; normaly 0xfe5, changed by mios-gpasm
PREINC1 equ 0xfec ;; normaly 0xfe4, changed by mios-gpasm
PLUSW2	equ	0xfdb


	idata
_clipButtons	db	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
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

udata_main_0	udata
_app_flags	res	1

udata_main_1	udata
_last_ain_pin	res	1

udata_main_2	udata
_last_din_pin	res	1

udata_main_3	udata
_last_dout_pin	res	1

;--------------------------------------------------------
; global & static initialisations
;--------------------------------------------------------
; I code from now on!
; ; Starting pCode block
S_main__AIN_NotifyChange	code
_AIN_NotifyChange:
;	.line	338; main.c	void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVFF	r0x04, POSTDEC1
	MOVWF	r0x00
;	.line	347; main.c	MIOS_MIDI_BeginStream();
	CALL	_MIOS_MIDI_BeginStream
; ;multiply lit val:0x02 by variable r0x00 and store in r0x01
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	348; main.c	MIOS_MIDI_TxBufferPut(pot_event_map[pin][0]); // first value from table
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
;	.line	349; main.c	MIOS_MIDI_TxBufferPut(pot_event_map[pin][1]); // second value from table
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
;	.line	350; main.c	MIOS_MIDI_TxBufferPut(MIOS_AIN_Pin7bitGet(pin)); // 7bit pot value
	MOVF	r0x00, W
	CALL	_MIOS_AIN_Pin7bitGet
	MOVWF	r0x01
	MOVF	r0x01, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	351; main.c	MIOS_MIDI_EndStream();
	CALL	_MIOS_MIDI_EndStream
;	.line	354; main.c	last_ain_pin = pin;
	MOVFF	r0x00, _last_ain_pin
	BANKSEL	_app_flags
;	.line	355; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
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
;	.line	331; main.c	void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	333; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DIN_NotifyToggle	code
_DIN_NotifyToggle:
;	.line	286; main.c	void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
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
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
; ;multiply lit val:0x02 by variable r0x00 and store in r0x02
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	297; main.c	channel = button_event_map[pin][0];
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
;	.line	298; main.c	note = button_event_map[pin][1];
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
;	.line	301; main.c	if (pin_value == 0)
	MOVF	r0x01, W
	BNZ	_00176_DS_
; ;multiply lit val:0x02 by variable r0x05 and store in r0x03
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
;	.line	303; main.c	if (clipButtons[channel] != 0)
	BCF	STATUS, 0
	RLCF	r0x05, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	LOW(_clipButtons)
	ADDWF	r0x03, F
	MOVLW	HIGH(_clipButtons)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVFF	POSTINC0, r0x06
	MOVFF	INDF0, r0x07
	MOVF	r0x06, W
	IORWF	r0x07, W
;	.line	305; main.c	return;
	BNZ	_00178_DS_
;	.line	307; main.c	clipButtons[channel] = 1;
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x01
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	INDF0
	BRA	_00177_DS_
; ;multiply lit val:0x02 by variable r0x05 and store in r0x03
; ;Unrolled 8 X 8 multiplication
; ;FIXME: the function does not support result==WREG
_00176_DS_:
;	.line	311; main.c	clipButtons[channel] = 0;
	BCF	STATUS, 0
	RLCF	r0x05, W
	MOVWF	r0x03
	CLRF	r0x04
	MOVLW	LOW(_clipButtons)
	ADDWF	r0x03, F
	MOVLW	HIGH(_clipButtons)
	ADDWFC	r0x04, F
	MOVFF	r0x03, FSR0L
	MOVFF	r0x04, FSR0H
	MOVLW	0x00
	MOVWF	POSTINC0
	MOVLW	0x00
	MOVWF	INDF0
_00177_DS_:
;	.line	315; main.c	MIOS_MIDI_BeginStream();
	CALL	_MIOS_MIDI_BeginStream
;	.line	316; main.c	MIOS_MIDI_TxBufferPut(channel); // first value from table
	MOVF	r0x05, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	317; main.c	MIOS_MIDI_TxBufferPut(note); // second value from table
	MOVF	r0x02, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	318; main.c	MIOS_MIDI_TxBufferPut(pin_value ? 0x00 : 0x7f); // 7bit pot value
	MOVF	r0x01, W
	BZ	_00180_DS_
	CLRF	r0x01
	BRA	_00181_DS_
_00180_DS_:
	MOVLW	0x7f
	MOVWF	r0x01
_00181_DS_:
	MOVF	r0x01, W
	CALL	_MIOS_MIDI_TxBufferPut
;	.line	319; main.c	MIOS_MIDI_EndStream();
	CALL	_MIOS_MIDI_EndStream
;	.line	322; main.c	last_din_pin = pin;
	MOVFF	r0x00, _last_din_pin
	BANKSEL	_app_flags
;	.line	323; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
_00178_DS_:
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
S_main__SR_Service_Finish	code
_SR_Service_Finish:
;	.line	280; main.c	}
	RETURN	

; ; Starting pCode block
S_main__SR_Service_Prepare	code
_SR_Service_Prepare:
;	.line	273; main.c	}
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedByte	code
_MPROC_NotifyReceivedByte:
;	.line	264; main.c	void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	266; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyTimeout	code
_MPROC_NotifyTimeout:
;	.line	259; main.c	}
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyFoundEvent	code
_MPROC_NotifyFoundEvent:
;	.line	249; main.c	void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
;	.line	251; main.c	}
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__MPROC_NotifyReceivedEvnt	code
_MPROC_NotifyReceivedEvnt:
;	.line	228; main.c	void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
	MOVFF	FSR2L, POSTDEC1
	MOVFF	FSR1L, FSR2L
	MOVFF	r0x00, POSTDEC1
	MOVFF	r0x01, POSTDEC1
	MOVFF	r0x02, POSTDEC1
	MOVFF	r0x03, POSTDEC1
	MOVWF	r0x00
	MOVLW	0x02
	MOVFF	PLUSW2, r0x01
	MOVLW	0x03
	MOVFF	PLUSW2, r0x02
;	.line	231; main.c	if( evnt0 == 0x80 || evnt0 == 0x90 ) {
	CLRF	r0x03
	MOVF	r0x00, W
	XORLW	0x80
	BNZ	_00146_DS_
	INCF	r0x03, F
_00146_DS_:
	MOVF	r0x03, W
	BNZ	_00135_DS_
	MOVF	r0x00, W
	XORLW	0x90
	BNZ	_00138_DS_
_00135_DS_:
;	.line	233; main.c	if( evnt0 == 0x80 )
	MOVF	r0x03, W
	BZ	_00134_DS_
;	.line	234; main.c	evnt2 = 0;
	CLRF	r0x02
_00134_DS_:
;	.line	237; main.c	MIOS_DOUT_PinSet(evnt1, evnt2 ? 0x01 : 0x00);
	MOVF	r0x02, W
	BZ	_00140_DS_
	MOVLW	0x01
	MOVWF	r0x00
	BRA	_00141_DS_
_00140_DS_:
	CLRF	r0x00
_00141_DS_:
	MOVF	r0x00, W
	MOVWF	POSTDEC1
	MOVF	r0x01, W
	CALL	_MIOS_DOUT_PinSet
	INCF	FSR1L, F
;	.line	240; main.c	last_dout_pin = evnt1;
	MOVFF	r0x01, _last_dout_pin
	BANKSEL	_app_flags
;	.line	241; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
_00138_DS_:
	MOVFF	PREINC1, r0x03
	MOVFF	PREINC1, r0x02
	MOVFF	PREINC1, r0x01
	MOVFF	PREINC1, r0x00
	MOVFF	PREINC1, FSR2L
	RETURN	

; ; Starting pCode block
S_main__DISPLAY_Tick	code
_DISPLAY_Tick:
;	.line	199; main.c	void DISPLAY_Tick(void) __wparam
	MOVFF	r0x00, POSTDEC1
	BANKSEL	_app_flags
;	.line	202; main.c	if( !app_flags.DISPLAY_UPDATE_REQ )
	BTFSC	_app_flags, 0, B
	BRA	_00122_DS_
;	.line	203; main.c	return;
	BRA	_00123_DS_
_00122_DS_:
	BANKSEL	_app_flags
;	.line	206; main.c	app_flags.DISPLAY_UPDATE_REQ = 0;
	BCF	_app_flags, 0, B
;	.line	209; main.c	MIOS_LCD_CursorSet(0x40 + 0);
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_ain_pin
;	.line	210; main.c	MIOS_LCD_PrintBCD2(last_ain_pin + 1);
	INCF	_last_ain_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD2
;	.line	211; main.c	MIOS_LCD_PrintChar(':');
	MOVLW	0x3a
	CALL	_MIOS_LCD_PrintChar
	BANKSEL	_last_ain_pin
;	.line	212; main.c	MIOS_LCD_PrintBCD3(MIOS_AIN_Pin7bitGet(last_ain_pin));
	MOVF	_last_ain_pin, W, B
	CALL	_MIOS_AIN_Pin7bitGet
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
;	.line	215; main.c	MIOS_LCD_CursorSet(0x40 + 7);
	MOVLW	0x47
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_din_pin
;	.line	216; main.c	MIOS_LCD_PrintBCD3(last_din_pin + 1);
	INCF	_last_din_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
	BANKSEL	_last_din_pin
;	.line	217; main.c	MIOS_LCD_PrintChar(MIOS_DIN_PinGet(last_din_pin) ? 'o' : '*');
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
;	.line	220; main.c	MIOS_LCD_CursorSet(0x40 + 12);
	MOVLW	0x4c
	CALL	_MIOS_LCD_CursorSet
	BANKSEL	_last_dout_pin
;	.line	221; main.c	MIOS_LCD_PrintBCD3(last_dout_pin + 1);
	INCF	_last_dout_pin, W, B
	MOVWF	r0x00
	MOVF	r0x00, W
	CALL	_MIOS_LCD_PrintBCD3
	BANKSEL	_last_dout_pin
;	.line	222; main.c	MIOS_LCD_PrintChar(MIOS_DOUT_PinGet(last_dout_pin) ? '*' : 'o');
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
;	.line	183; main.c	MIOS_LCD_Clear();
	CALL	_MIOS_LCD_Clear
;	.line	186; main.c	MIOS_LCD_CursorSet(0x00); // first line
	MOVLW	0x00
	CALL	_MIOS_LCD_CursorSet
;	.line	187; main.c	MIOS_LCD_PrintCString("1AIN   DIN  DOUT");
	MOVLW	UPPER(__str_0)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_0)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_0)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
;	.line	188; main.c	MIOS_LCD_CursorSet(0x40); // second line
	MOVLW	0x40
	CALL	_MIOS_LCD_CursorSet
;	.line	189; main.c	MIOS_LCD_PrintCString("xx:xxx xxxx xxxx");
	MOVLW	UPPER(__str_1)
	MOVWF	POSTDEC1
	MOVLW	HIGH(__str_1)
	MOVWF	POSTDEC1
	MOVLW	LOW(__str_1)
	CALL	_MIOS_LCD_PrintCString
	MOVLW	0x02
	ADDWF	FSR1L, F
	BANKSEL	_app_flags
;	.line	192; main.c	app_flags.DISPLAY_UPDATE_REQ = 1;
	BSF	_app_flags, 0, B
	RETURN	

; ; Starting pCode block
S_main__Timer	code
_Timer:
;	.line	173; main.c	}
	RETURN	

; ; Starting pCode block
S_main__Tick	code
_Tick:
;	.line	165; main.c	}
	RETURN	

; ; Starting pCode block
S_main__Init	code
_Init:
;	.line	137; main.c	MIOS_MIDI_MergerSet(MIOS_MIDI_MERGER_MBLINK_FP);
	MOVLW	0x03
	CALL	_MIOS_MIDI_MergerSet
;	.line	140; main.c	MIOS_SRIO_UpdateFrqSet(1); // ms
	MOVLW	0x01
	CALL	_MIOS_SRIO_UpdateFrqSet
;	.line	143; main.c	MIOS_SRIO_NumberSet(NUMBER_OF_SRIO);
	MOVLW	0x10
	CALL	_MIOS_SRIO_NumberSet
;	.line	146; main.c	MIOS_SRIO_DebounceSet(DIN_DEBOUNCE_VALUE);
	MOVLW	0x0a
	CALL	_MIOS_SRIO_DebounceSet
;	.line	148; main.c	MIOS_SRIO_TS_SensitivitySet(DIN_TS_SENSITIVITY);
	MOVLW	0x00
	CALL	_MIOS_SRIO_TS_SensitivitySet
;	.line	151; main.c	MIOS_AIN_NumberSet(AIN_NUMBER_INPUTS);
	MOVLW	0x40
	CALL	_MIOS_AIN_NumberSet
;	.line	153; main.c	MIOS_AIN_Muxed();
	CALL	_MIOS_AIN_Muxed
;	.line	157; main.c	MIOS_AIN_DeadbandSet(AIN_DEADBAND);
	MOVLW	0x07
	CALL	_MIOS_AIN_DeadbandSet
	RETURN	

; ; Starting pCode block for Ival
	code
_pot_event_map:
	DB	0xb0, 0x07, 0xb1, 0x07, 0xb2, 0x07, 0xb3, 0x07, 0xb4, 0x07, 0xb5, 0x07
	DB	0xb6, 0x07, 0xb7, 0x07, 0xbc, 0x32, 0xbc, 0x33, 0xbc, 0x34, 0xbc, 0x35
	DB	0xb9, 0x32, 0xb9, 0x33, 0xb9, 0x34, 0xb9, 0x35, 0xb8, 0x32, 0xb8, 0x33
	DB	0xbb, 0x32, 0xbb, 0x33, 0xbb, 0x34, 0xbb, 0x35, 0xb8, 0x36, 0xb8, 0x37
	DB	0xb8, 0x34, 0xb8, 0x35, 0xba, 0x32, 0xba, 0x33, 0xba, 0x34, 0xba, 0x35
	DB	0xb8, 0x38, 0xb8, 0x39, 0xb0, 0x1f, 0xb1, 0x1f, 0xb2, 0x1f, 0xb3, 0x1f
	DB	0xb4, 0x1f, 0xb5, 0x1f, 0xb6, 0x1f, 0xb7, 0x1f, 0xb0, 0x1e, 0xb1, 0x1e
	DB	0xb2, 0x1e, 0xb3, 0x1e, 0xb4, 0x1e, 0xb5, 0x1e, 0xb6, 0x1e, 0xb7, 0x1e
	DB	0xb0, 0x1d, 0xb1, 0x1d, 0xb2, 0x1d, 0xb3, 0x1d, 0xb4, 0x1d, 0xb5, 0x1d
	DB	0xb6, 0x1d, 0xb7, 0x1d, 0xb0, 0x1c, 0xb1, 0x1c, 0xb2, 0x1c, 0xb3, 0x1c
	DB	0xb4, 0x1c, 0xb5, 0x1c, 0xb6, 0x1c, 0xb7, 0x1c
; ; Starting pCode block for Ival
_button_event_map:
	DB	0x91, 0x06, 0x91, 0x05, 0x90, 0x05, 0x90, 0x06, 0x90, 0x03, 0x90, 0x04
	DB	0x91, 0x04, 0x91, 0x03, 0x91, 0x08, 0x91, 0x07, 0x90, 0x07, 0x90, 0x08
	DB	0x90, 0x0a, 0x90, 0x09, 0x91, 0x09, 0x91, 0x0a, 0x92, 0x04, 0x92, 0x03
	DB	0x93, 0x03, 0x93, 0x04, 0x93, 0x06, 0x93, 0x05, 0x92, 0x05, 0x92, 0x06
	DB	0x93, 0x08, 0x93, 0x07, 0x92, 0x07, 0x92, 0x08, 0x92, 0x0a, 0x92, 0x09
	DB	0x93, 0x09, 0x93, 0x0a, 0x95, 0x04, 0x95, 0x03, 0x94, 0x03, 0x94, 0x04
	DB	0x94, 0x06, 0x94, 0x05, 0x95, 0x05, 0x95, 0x06, 0x95, 0x08, 0x95, 0x07
	DB	0x94, 0x07, 0x94, 0x08, 0x95, 0x0a, 0x95, 0x09, 0x94, 0x09, 0x94, 0x0a
	DB	0x97, 0x04, 0x97, 0x03, 0x96, 0x03, 0x96, 0x04, 0x97, 0x06, 0x97, 0x05
	DB	0x96, 0x05, 0x96, 0x06, 0x97, 0x08, 0x97, 0x07, 0x96, 0x07, 0x96, 0x08
	DB	0x96, 0x0a, 0x96, 0x09, 0x97, 0x09, 0x97, 0x0a
; ; Starting pCode block
__str_0:
	DB	0x31, 0x41, 0x49, 0x4e, 0x20, 0x20, 0x20, 0x44, 0x49, 0x4e, 0x20, 0x20
	DB	0x44, 0x4f, 0x55, 0x54, 0x00
; ; Starting pCode block
__str_1:
	DB	0x78, 0x78, 0x3a, 0x78, 0x78, 0x78, 0x20, 0x78, 0x78, 0x78, 0x78, 0x20
	DB	0x78, 0x78, 0x78, 0x78, 0x00


; Statistics:
; code size:	  964 (0x03c4) bytes ( 0.74%)
;           	  482 (0x01e2) words
; udata size:	    4 (0x0004) bytes ( 0.31%)
; access size:	    8 (0x0008) bytes


	end
