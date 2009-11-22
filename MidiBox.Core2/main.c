// $Id: main.c 188 2008-03-08 20:39:39Z tk $
/* 
 * CORE 2
 *
 * This example demonstrates how to drive 64 pots, 128 buttons, 128 LEDs
 *
 * Note: hardware settings (e.g. number of pots, muxed/unmuxed mode)
 *       are specified in main.h
 * 
 * See also the README.txt for additional informations
 *
 * ==========================================================================
 *
 *  Copyright <year> <your name>
 *  Licensed for personal non-commercial use only.
 *  All other rights reserved.
 *
 * ==========================================================================
 */


/////////////////////////////////////////////////////////////////////////////
// Include files
/////////////////////////////////////////////////////////////////////////////

#include <cmios.h>
#include <pic18fregs.h>
#include "main.h"

#include <mikeshit.h>

/////////////////////////////////////////////////////////////////////////////
// Global variables
/////////////////////////////////////////////////////////////////////////////

// status of application (see bitfield declaration in main.h)
app_flags_t app_flags;

/////////////////////////////////////////////////////////////////////////////
// Local variables
/////////////////////////////////////////////////////////////////////////////



// last ain/din/dout
unsigned char last_ain_pin;
unsigned char last_din_pin;
unsigned char last_dout_pin;

//unsigned static int current_sysex_package = -1;
//static unsigned int record_sysex = 0;
//static unsigned char last_sysex = 0x00;
//static unsigned int clock_ticks = 0;
//static unsigned int clock_beats = 0;
//static unsigned int clock_bars = 0;

unsigned int test_mode;
unsigned int record_sysex;
unsigned char last_sysex;
unsigned int clock_ticks;
unsigned int clock_beats;
unsigned int clock_bars;


// this const definition creates a table of 128 bytes in flash memory
// we create a 2-dimensional array with 64 entries
// each entry consists of two bytes: 
// each entry consists of two bytes: 
//   o one for the first MIDI byte (MIDI status)
//   o a second for the second MIDI byte (here: CC number)
// The meaning of the bytes can be found in the MIDI spec
// (-> http://www.borg.com/~jglatt/tech/midispec.htm)

const unsigned char pot_event_map[64][2] = {
  // Pots 1-8 are PARAM 1 channels 1-8
  {0xb0, 0x32},   {0xb1, 0x32},   {0xb2, 0x32},   {0xb3, 0x32}, 
  {0xb4, 0x32},   {0xb5, 0x32},   {0xb6, 0x32},   {0xb7, 0x32}, 
  // Pots 9-16 are PARAM 2 channels 1-8
  {0xb0, 0x33},   {0xb1, 0x33},   {0xb2, 0x33},   {0xb3, 0x33}, 
  {0xb4, 0x33},   {0xb5, 0x33},   {0xb6, 0x33},   {0xb7, 0x33}, 
  // Pots 17-24 are PARAM 3 channels 1-8
  {0xb0, 0x34},   {0xb1, 0x34},   {0xb2, 0x34},   {0xb3, 0x34}, 
  {0xb4, 0x34},   {0xb5, 0x34},   {0xb6, 0x34},   {0xb7, 0x34}, 
  // Pots 25-32 are PARAM 4 channels 1-8
  {0xb0, 0x35},   {0xb1, 0x35},   {0xb2, 0x35},   {0xb3, 0x35}, 
  {0xb4, 0x35},   {0xb5, 0x35},   {0xb6, 0x35},   {0xb7, 0x35}, 
  // Pots 33-40 are PARAM 5 channels 1-8
  {0xb0, 0x36},   {0xb1, 0x36},   {0xb2, 0x36},   {0xb3, 0x36}, 
  {0xb4, 0x36},   {0xb5, 0x36},   {0xb6, 0x36},   {0xb7, 0x36}, 
  // Pots 41-48 are PARAM 6 channels 1-8
  {0xb0, 0x37},   {0xb1, 0x37},   {0xb2, 0x37},   {0xb3, 0x37}, 
  {0xb4, 0x37},   {0xb5, 0x37},   {0xb6, 0x37},   {0xb7, 0x37}, 
  // Pots 48-55 are PARAM 7 channels 1-8
  {0xb0, 0x38},   {0xb1, 0x38},   {0xb2, 0x38},   {0xb3, 0x38}, 
  {0xb4, 0x38},   {0xb5, 0x38},   {0xb6, 0x38},   {0xb7, 0x38}, 
  // Pots 56-64 are PARAM 8 channels 1-8
  {0xb0, 0x39},   {0xb1, 0x39},   {0xb2, 0x39},   {0xb3, 0x39}, 
  {0xb4, 0x39},   {0xb5, 0x39},   {0xb6, 0x39},   {0xb7, 0x39}, 
  };




const unsigned char button_event_map[64][2] = {
  // Buttons 1-32 are the system/function buttons
  {0x98, 0x00},   {0x98, 0x01},   {0x98, 0x02},   {0x98, 0x03}, 
  {0x98, 0x04},   {0x98, 0x05},   {0x98, 0x06},   {0x98, 0x07}, 
  {0x98, 0x08},   {0x98, 0x09},   {0x98, 0x0a},   {0x98, 0x0b}, 
  {0x98, 0x0c},   {0x98, 0x0d},   {0x98, 0x0e},   {0x98, 0x0f}, 
  {0x98, 0x10},   {0x98, 0x11},   {0x98, 0x12},   {0x98, 0x13}, 
  {0x98, 0x14},   {0x98, 0x15},   {0x98, 0x16},   {0x98, 0x17}, 
  {0x98, 0x18},   {0x98, 0x19},   {0x98, 0x1a},   {0x98, 0x1b}, 
  {0x98, 0x1c},   {0x98, 0x1d},   {0x98, 0x1e},   {0x98, 0x1f}, 
  // Buttons 33-40 are the master SOLOs for channels 1-8
  {0x90, 0x0B},   {0x91, 0x0B},   {0x92, 0x0B},   {0x93, 0x0B}, 
  {0x97, 0x0B},   {0x96, 0x0B},   {0x95, 0x0B},   {0x94, 0x0B}, 
  // Buttons 41-64 are the 3 option buttons for channels 1-8
  {0x91, 0x01},   {0x91, 0x02},   {0x90, 0x01},   {0x90, 0x02}, 
  {0x93, 0x02},   {0x93, 0x01},   {0x92, 0x01},   {0x92, 0x02},
  {0x90, 0x00},   {0x91, 0x00},   {0x93, 0x00},   {0x92, 0x00}, 
  {0x95, 0x02},   {0x95, 0x01},   {0x94, 0x01},   {0x94, 0x02}, 
  {0x94, 0x00},   {0x95, 0x00},   {0x97, 0x00},   {0x96, 0x00}, 
  {0x97, 0x02},   {0x97, 0x01},   {0x96, 0x01},   {0x96, 0x02}, 
  };




	
// ROW, COLUMN, COLOR
static unsigned char matrix_1[8][8] = {
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}
  };
static unsigned char matrix_2[8][8] = {
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00},
  {0x00,0x00,0x00,0x00,0x00,0x00,0x00,0x00}
  };




  



/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after startup to initialize the 
// application
/////////////////////////////////////////////////////////////////////////////
void Init(void) __wparam
{
	test_mode = 1;
	record_sysex = 0;
	last_sysex = 0x00;
	clock_ticks = 0;
	clock_beats = 0;
	clock_bars = 0;

	// configure the MIDIbox as MIDIbox Link END Point
	MIOS_MIDI_MergerSet(MIOS_MIDI_MERGER_MBLINK_EP);

	// set shift register update frequency
	MIOS_SRIO_UpdateFrqSet(1); // ms

	// we need to set at least one IO shift register pair
	MIOS_SRIO_NumberSet(NUMBER_OF_SRIO);

	// debouncing value for DINs
	MIOS_SRIO_DebounceSet(DIN_DEBOUNCE_VALUE);

	MIOS_SRIO_TS_SensitivitySet(DIN_TS_SENSITIVITY);

	// initialize the AIN driver
	MIOS_AIN_NumberSet(AIN_NUMBER_INPUTS);
#if AIN_MUXED_MODE
	MIOS_AIN_Muxed();
#else
	MIOS_AIN_UnMuxed();
#endif
	MIOS_AIN_DeadbandSet(AIN_DEADBAND);

	// reset the dout darlingtons
	MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);
	MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS in the mainloop when nothing else is to do
/////////////////////////////////////////////////////////////////////////////
void Tick(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is periodically called by MIOS. The frequency has to be
// initialized with MIOS_Timer_Set
/////////////////////////////////////////////////////////////////////////////
void Timer(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when the display content should be 
// initialized. Thats the case during startup and after a temporary message
// has been printed on the screen
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Init(void) __wparam
{
  // clear screen
  MIOS_LCD_Clear();

  // print static messages
  MIOS_LCD_CursorSet(0x00); // first line
  MIOS_LCD_PrintCString("2AIN   DIN  DOUT");
  MIOS_LCD_CursorSet(0x40); // second line
  MIOS_LCD_PrintCString("xx:xxx xxxx xxxx");

  // request display update
  app_flags.DISPLAY_UPDATE_REQ = 1;

	// do the bling
	DoStartupPattern();
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called in the mainloop when no temporary message is shown
//  on screen. Print the realtime messages here
/////////////////////////////////////////////////////////////////////////////
void DISPLAY_Tick(void) __wparam
{
  // do nothing if no update has been requested
  if( !app_flags.DISPLAY_UPDATE_REQ )
    return;

  // clear request
  app_flags.DISPLAY_UPDATE_REQ = 0;

  // print status of AIN
  MIOS_LCD_CursorSet(0x40 + 0);
  MIOS_LCD_PrintBCD2(last_ain_pin + 1);
  MIOS_LCD_PrintChar(':');
  MIOS_LCD_PrintBCD3(MIOS_AIN_Pin7bitGet(last_ain_pin));

  // print status of DIN
  MIOS_LCD_CursorSet(0x40 + 7);
  MIOS_LCD_PrintBCD3(last_din_pin + 1);
  MIOS_LCD_PrintChar(MIOS_DIN_PinGet(last_din_pin) ? 'o' : '*');

  // print status of DOUT
  MIOS_LCD_CursorSet(0x40 + 12);
  MIOS_LCD_PrintBCD3(last_dout_pin + 1);
  MIOS_LCD_PrintChar(MIOS_DOUT_PinGet(last_dout_pin) ? '*' : 'o');
}

/////////////////////////////////////////////////////////////////////////////
//  This function is called by MIOS when a complete MIDI event has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedEvnt(unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
	int channelIndex = evnt0-0x90;
	int noteIndex = evnt1;
	unsigned char value = evnt2;
	if (channelIndex >= 0 && channelIndex <= 7)
	{
		// NOTE ON - CHANNEL BUTTONS CLIPS/SOLO/FX
		switch(noteIndex-_NOTE_SEND_OFFSET)
		{
			// CHANNEL FX
			case 0:
			case 1:
			case 2:
			//case 11:
				matrix_2[noteIndex-_NOTE_SEND_OFFSET][channelIndex] = value;
				break;

			// CLIPS
			case 3:
			case 4:
			case 5:
			case 6:
			case 7:
			case 8:
			case 9:
			case 10:
				matrix_1[noteIndex-_NOTE_SEND_OFFSET-3][channelIndex] = value;
				break;
		
			//CHANNEL FX
			 case 11:
				 matrix_2[3][channelIndex] = value;
				 break;
			
			default:
				break;
		}
	}
	//NOTE ON - SYSTEM BUTTONS
	else if (channelIndex >= 8 && channelIndex <= 15)
	{
		// TOP ROW 1-16  (notes 1-16)  - current song
		if (noteIndex-_NOTE_SEND_OFFSET >= 0 && noteIndex-_NOTE_SEND_OFFSET <= 16)
		{
				// We do this because there's only ever 1 song selected and this saves sending LED_OFF's for all the off's.
				int x;
				for(x = 0; x < 8; x++)
				{
					matrix_2[4][x] = ((x+0) == noteIndex-_NOTE_SEND_OFFSET) ? value : _COLOR_OFF;
					matrix_2[5][x] = ((x+8) == noteIndex-_NOTE_SEND_OFFSET) ? value : _COLOR_OFF;
				}
		}
		// BOTTOM ROW 1-8  (notes 17-24)
		if (noteIndex-_NOTE_SEND_OFFSET >= 17 && noteIndex-_NOTE_SEND_OFFSET <= 24)
		{
				matrix_2[6][noteIndex-_NOTE_SEND_OFFSET-17] = value;
		}
		// BOTTOM ROW 9-16  (notes 25-32)
		if (noteIndex-_NOTE_SEND_OFFSET >= 25 && noteIndex-_NOTE_SEND_OFFSET <= 32)
		{
				matrix_2[7][noteIndex-_NOTE_SEND_OFFSET-25] = value;
		}
	}
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has been received
// which has been specified in the MIOS_MPROC_EVENT_TABLE
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyFoundEvent(unsigned entry, unsigned char evnt0, unsigned char evnt1, unsigned char evnt2) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI event has not been completly
// received within 2 seconds
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyTimeout(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a MIDI byte has been received
/////////////////////////////////////////////////////////////////////////////
void MPROC_NotifyReceivedByte(unsigned char byte) __wparam
{
	switch (byte)
	{
		case 0xF0: // SYSEX BEGIN
			record_sysex = 1;
			break;
			
		case 0xF7: // SYSEX END
			record_sysex = 0;
			break;
		
		case 0x77:	// MY CUSTOM BYTE - action defined by last_sysex
			if (record_sysex == 1)
			{
				if (last_sysex == 0x01)		// connect
				{
					DoMichaelKnightPattern();
					test_mode = 0;
				}
				else if (last_sysex == 0x02)	// disconnect
				{
					DoShutdownPattern();
					test_mode = 1;
				}
			}
			break;

		case 0xFA:	// START
		case 0xFB:	// PAUSE
		case 0xFC:	// STOP
			clock_ticks = 0;
			clock_beats = 0;
			clock_bars = 0;
			matrix_2[6][5] = _COLOR_OFF;
			break;
	
		case 0xF8:	// CLOCK
			clock_ticks++;
			if (clock_ticks % 24 == 0)
			{
				clock_beats++;
				if (clock_beats % 4 == 0)
				{
					clock_bars++;
					clock_beats = 0;
				}
				MIOS_LCD_Clear();
				MIOS_LCD_CursorSet(0x00 + 0); 
				MIOS_LCD_PrintBCD4(clock_bars);
				MIOS_LCD_CursorSet(0x00 + 4);
				MIOS_LCD_PrintBCD4(clock_beats);
				MIOS_LCD_CursorSet(0x00 + 8);
				MIOS_LCD_PrintBCD4(clock_ticks);
				app_flags.DISPLAY_UPDATE_REQ = 1;
				clock_ticks = 0;
			}
			if (clock_ticks < 12)
			{
				if (clock_beats == 0)
				{
					if (clock_bars % 4 == 0)
					{
						matrix_2[6][5] = _COLOR_WHITE;
					}
					else
					{
						matrix_2[6][5] = _COLOR_GREEN;
					}
				}
				else
				{
					matrix_2[6][5] = _COLOR_BLUE;
				}
			}
			else
			{
				matrix_2[6][5] = _COLOR_OFF;
			}
			break;
		
		default:
			if (record_sysex == 1)
			{
				last_sysex = byte;
			}
			break;
	}
}

	
void DisplayLED(unsigned char column, unsigned char color) __wparam
{
	color >>= 4; 
	MIOS_DOUT_PinSet(column+8,		(color & 0x01)); 
	color >>= 1; 
	MIOS_DOUT_PinSet(column+8+8,	(color & 0x01));
	color >>= 1; 
	MIOS_DOUT_PinSet(column+8+16,	(color & 0x01));
}




/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS before the shift register are loaded
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Prepare(void) __wparam
{
	// HELPED BY BUGFIGHT ON MIDIBOX - http://www.midibox.org/forum/index.php/topic,12786.0.html
	static unsigned char row;
	unsigned int x; 							//edit* just noticed, no reason for this to be static
	row = ++row & 0x07; 						//<-- here you were cycling 16 rows i think you meant 8, no?  
												//this would have resulted in a 6.25% duty cycle (vs 12.5%).  
												//note that the duomatrix uses a 25% duty cycle
	MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);	//<-- hardwire bad, napster good.  define constants 
	MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);	//    so you can move your matrix in the chain

	MIOS_DOUT_PinSet1(row + (_MATRIX_1_DOUT_START * 8));
	MIOS_DOUT_PinSet1(row + (_MATRIX_2_DOUT_START * 8));
	for (x = 0; x < 8; x++)
	{
		DisplayLED(x + (_MATRIX_1_DOUT_START * 8), matrix_1[row][x]);
		DisplayLED(x + (_MATRIX_2_DOUT_START * 8), matrix_2[row][x]);
	}
}


/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS after the shift register have been loaded
/////////////////////////////////////////////////////////////////////////////
void SR_Service_Finish(void) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an button has been toggled
// pin_value is 1 when button released, and 0 when button pressed
/////////////////////////////////////////////////////////////////////////////
void DIN_NotifyToggle(unsigned char pin, unsigned char pin_value) __wparam
{
	unsigned char channel;
	unsigned char note;
	channel = button_event_map[pin][0];
	note = button_event_map[pin][1];
		
	MIOS_MIDI_BeginStream();
	MIOS_MIDI_TxBufferPut(channel); // first value from table
	MIOS_MIDI_TxBufferPut(note); // second value from table
	MIOS_MIDI_TxBufferPut(pin_value ? 0x00 : 0x7f); // 7bit pot value
	MIOS_MIDI_EndStream();

	if (test_mode == 1 && pin_value == 0)
	{
		switch (pin)
		{
			case 16:
				DoStartupPattern();
				break;

			case 17:
				DoShutdownPattern();
				break;

			case 18:
				TestMatrix1();
				break;

			case 19:
				TestMatrix2();
				break;

			case 23:
				DoMichaelKnightPattern();
				break;
				
			default:
			break;
		}
	}
	
	// notify display handler in DISPLAY_Tick() that DIN value has changed
	last_din_pin = pin;
	app_flags.DISPLAY_UPDATE_REQ = 1;
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when an encoder has been moved
// incrementer is positive when encoder has been turned clockwise, else
// it is negative
/////////////////////////////////////////////////////////////////////////////
void ENC_NotifyChange(unsigned char encoder, char incrementer) __wparam
{
}

/////////////////////////////////////////////////////////////////////////////
// This function is called by MIOS when a pot has been moved
/////////////////////////////////////////////////////////////////////////////
void AIN_NotifyChange(unsigned char pin, unsigned int pin_value) __wparam
{
  MIOS_MIDI_BeginStream();
  MIOS_MIDI_TxBufferPut(pot_event_map[pin][0]); // first value from table
  MIOS_MIDI_TxBufferPut(pot_event_map[pin][1]); // second value from table
  MIOS_MIDI_TxBufferPut(MIOS_AIN_Pin7bitGet(pin)); // 7bit pot value
  MIOS_MIDI_EndStream();

  // notify display handler in DISPLAY_Tick() that AIN value has changed
  last_ain_pin = pin;
  app_flags.DISPLAY_UPDATE_REQ = 1;
}


















void ClearMatrix(unsigned int matrixIndex) __wparam
{
	unsigned int column = 0;
	unsigned int row = 0;
	switch (matrixIndex)
	{
		case 1:
			for (row = 0; row < 8; row++)
			{
				for (column = 0; column < 8; column++)
				{
					matrix_1[row][column] = _COLOR_OFF;
				}
			}
			MIOS_DOUT_SRSet(_MATRIX_1_DOUT_START, 0);
			break;
			
		case 2:
			for (row = 0; row < 8; row++)
			{
				for (column = 0; column < 8; column++)
				{
					matrix_2[row][column] = _COLOR_OFF;
				}
			}
			MIOS_DOUT_SRSet(_MATRIX_2_DOUT_START, 0);
			break;
			
		default:
			break;
	}
}




















void DoStartupPattern(void) __wparam
{
	static int row;
	static unsigned int column;
	static unsigned char color;
	ClearMatrix(1);
	ClearMatrix(2);
	for (row = 7; row > -1; row--)
	{
		for (column = 0; column < 8; column++)
		{
			matrix_1[row][column] = _COLOR_WHITE;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_1[row+1][column] = _COLOR_OFF;
		}
		MIOS_Delay(25);
	}
	ClearMatrix(1);
	ClearMatrix(2);
	for (row = 0; row < 6; row++)
	{
		switch (row)
		{
			case 0:
				color = _COLOR_CYAN;
				break;
			case 1:
				color = _COLOR_BLUE;
				break;
			case 2:
				color = _COLOR_MAGENTA;
				break;
			case 3:
				color = _COLOR_RED;
				break;
			case 4:
				color = _COLOR_YELLOW;
				break;
			case 5:
				color = _COLOR_GREEN;
				break;
				
			default:
				color = _COLOR_OFF;
				break;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_2[row/2][column] = color;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_2[(row/2)-1][column] = _COLOR_OFF;
		}
		MIOS_Delay(150);
	}
	ClearMatrix(1);
	ClearMatrix(2);
}




void DoShutdownPattern(void) __wparam
{
	static unsigned int row;
	static unsigned int column;
	ClearMatrix(2);
	for (row = 0; row < 8; row++)
	{
		for (column = 0; column < 8; column++)
		{
			matrix_1[row][column] = _COLOR_BLUE;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_1[row-1][column] = _COLOR_OFF;
		}
		MIOS_Delay(40);
	}
	ClearMatrix(1);
	ClearMatrix(2);
}




void TestMatrix1(void) __wparam
{
	static int row;
	static unsigned int column;
	ClearMatrix(1);
	ClearMatrix(2);
	for (row = 0; row < 8; row++)
	{
		for (column = 0; column < 8; column++)
		{
			matrix_1[row][column] = _COLOR_WHITE;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_1[row-1][column] = _COLOR_OFF;
		}
		MIOS_Delay(250);
		MIOS_Delay(250);
	}
	ClearMatrix(1);
	ClearMatrix(2);
}

void TestMatrix2(void) __wparam
{
	static int row;
	static unsigned int column;
	ClearMatrix(1);
	ClearMatrix(2);
	for (row = 0; row < 8; row++)
	{
		for (column = 0; column < 8; column++)
		{
			matrix_2[row][column] = _COLOR_WHITE;
		}
		for (column = 0; column < 8; column++)
		{
			matrix_2[row-1][column] = _COLOR_OFF;
		}
		MIOS_Delay(250);
		MIOS_Delay(250);
	}
	ClearMatrix(1);
	ClearMatrix(2);
}


void DoMichaelKnightPattern(void) __wparam
{
	static int column;
	ClearMatrix(1);
	ClearMatrix(2);
	for (column = -2; column < 21; column++)
	{
		MIOS_Delay(50);
		switch (column)
		{
			case -1:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				break;
			case 0:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				break;
			case 1:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				break;
			case 2:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 3:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 4:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 5:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 6:
				matrix_2[4][column+1] 		= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[6][column+1] 		= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 7:
				matrix_2[5][column-8+1]	= _COLOR_WHITE;
				matrix_2[4][column] 		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[7][column-8+1]	= _COLOR_WHITE;
				matrix_2[6][column] 		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 8:
				matrix_2[5][column-8+1]	= _COLOR_WHITE;
				matrix_2[5][column-8]		= _COLOR_CYAN;
				matrix_2[4][column-1] 		= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[7][column-8+1]	= _COLOR_WHITE;
				matrix_2[7][column-8]		= _COLOR_CYAN;
				matrix_2[6][column-1] 		= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 9:
				matrix_2[5][column-8+1]	= _COLOR_WHITE;
				matrix_2[5][column-8]		= _COLOR_CYAN;
				matrix_2[5][column-8-1]	= _COLOR_BLUE;
				matrix_2[4][column-2] 		= _COLOR_OFF;
				matrix_2[7][column-8+1]	= _COLOR_WHITE;
				matrix_2[7][column-8]		= _COLOR_CYAN;
				matrix_2[7][column-8-1]	= _COLOR_BLUE;
				matrix_2[6][column-2] 		= _COLOR_OFF;
				break;
			case 10:
				matrix_2[5][column-8+1] 	= _COLOR_WHITE;
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8+1] 	= _COLOR_WHITE;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 11:
				matrix_2[5][column-8+1] 	= _COLOR_WHITE;
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8+1] 	= _COLOR_WHITE;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 12:
				matrix_2[5][column-8+1] 	= _COLOR_WHITE;
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8+1] 	= _COLOR_WHITE;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 13:
				matrix_2[5][column-8+1] 	= _COLOR_WHITE;
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8+1] 	= _COLOR_WHITE;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 14:
				matrix_2[5][column-8+1] 	= _COLOR_WHITE;
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8+1] 	= _COLOR_WHITE;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 15:
				matrix_2[5][column-8] 		= _COLOR_CYAN;
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8] 		= _COLOR_CYAN;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 16:
				matrix_2[5][column-8-1] 	= _COLOR_BLUE;
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8-1] 	= _COLOR_BLUE;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;
			case 17:
				matrix_2[5][column-8-2] 	= _COLOR_OFF;
				matrix_2[7][column-8-2] 	= _COLOR_OFF;
				break;

			default:
				break;
		}
	}
	ClearMatrix(1);
	ClearMatrix(2);
}



