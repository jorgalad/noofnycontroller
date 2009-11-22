#ifndef _MIKESHIT_H
#define _MIKESHIT_H

#define STUFF	0x00

extern void DisplayLED(unsigned char column, unsigned char color) __wparam;
extern void DoStartupPattern(void) __wparam;
extern void DoShutdownPattern(void) __wparam;
extern void TestMatrix1(void) __wparam;
extern void TestMatrix2(void) __wparam;
extern void DoMichaelKnightPattern(void) __wparam;
extern void ClearMatrix(unsigned int matrixIndex) __wparam;

#endif
