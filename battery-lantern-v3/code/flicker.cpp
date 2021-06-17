/*
 * Copyright (c) 2018 Stephen Warren
 *
 * Derived from code:
 * Copyright (c) 2013 Danny Havenith
 *
 * Boost Software License - Version 1.0 - August 17th, 2003
 *
 * Permission is hereby granted, free of charge, to any person or organization
 * obtaining a copy of the software and accompanying documentation covered by
 * this license (the "Software") to use, reproduce, display, distribute,
 * execute, and transmit the Software, and to prepare derivative works of the
 * Software, and to permit third-parties to whom the Software is furnished to
 * do so, all subject to the following:
 *
 * The copyright notices in the Software and this entire statement, including
 * the above license grant, this restriction and the following disclaimer,
 * must be included in all copies of the Software, in whole or in part, and
 * all derivative works of the Software, unless such copies or derivative
 * works are solely in the form of machine-executable object code generated by
 * a source language processor.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE, TITLE AND NON-INFRINGEMENT. IN NO EVENT
 * SHALL THE COPYRIGHT HOLDERS OR ANYONE DISTRIBUTING THE SOFTWARE BE LIABLE
 * FOR ANY DAMAGES OR OTHER LIABILITY, WHETHER IN CONTRACT, TORT OR OTHERWISE,
 * ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */

#include <stdlib.h>
#include <avr/io.h>
#include <util/delay.h>

// Bits of port B
// Some are more for documentation than auto-configuration of the code...
// (especially VIN_BIT)
#define LED_BIT		4
#define VIN_BIT		3
#define BUTTON_BIT	1

void led_reset(void) {
	PORTB = _BV(BUTTON_BIT);
	_delay_loop_1(250);
}

void led_send(uint8_t val)
{
	const uint8_t low_val = _BV(BUTTON_BIT);
	const uint8_t high_val = _BV(BUTTON_BIT) | _BV(LED_BIT);
	uint8_t bits = 8;

	asm volatile(
			"bit:									\n\t"
			"		out		%[portout], %[high_val]	\n\t"
			"		lsl		%[val]					\n\t"
			"		brcs	isone					\n\t"
			"		out		%[portout], %[low_val]	\n\t"
			"isone:									\n\t"
			"		rjmp	common					\n\t"
			"common:								\n\t"
			"		subi	%[bits], 1				\n\t"
			"		brne	morebits				\n\t"
			"		out		%[portout], %[low_val]	\n\t"
			"		rjmp	done					\n\t"
			"morebits:								\n\t"
			"		out		%[portout], %[low_val]	\n\t"
			"		rjmp	bit						\n\t"
			"done:									\n\t"
		: /* outputs */
		[val] "+r" (val),
		[bits] "+r" (bits)
		: /* inputs */
		[low_val] "r" (low_val),
		[high_val] "r" (high_val),
		[portout] "I" (_SFR_IO_ADDR(PORTB))
	);
}

uint8_t color_sel;
uint8_t btn_val_last;
uint8_t btn_ctr;

void led_send8_grb(uint8_t* grb) {
	led_reset();
	for (int led = 0; led < 8; led++) {
		led_send(grb[0]);
		led_send(grb[1]);
		led_send(grb[2]);
	}
}

#define NUM_COLORS 5

void led_send8_col(uint8_t val) {
	uint8_t grb[3];
	switch (color_sel) {
	case 0: // Yellow
		grb[0] = (val / 2) + (val / 4);
		grb[1] = val;
		grb[2] = val / 16;
		break;
	case 1: // Brighter yellow (slighty green)
		grb[0] = val;
		grb[1] = val;
		grb[2] = val / 8;
		break;
	case 2: // Yet another yellow; deeper, less blue
		grb[0] = val;
		grb[1] = val;
		grb[2] = 0;
		break;
	case 3: // Full
		grb[0] = val;
		grb[1] = val;
		grb[2] = val;
		break;
	default:
	case 4: // Full, no flicker
		grb[0] = 0xff;
		grb[1] = 0xff;
		grb[2] = 0xff;
		break;
	}
	led_send8_grb(grb);
}

void EEPROM_write(uint8_t addr, uint8_t data)
{
	while (EECR & _BV(EEPE))
		;
	EECR = 0;
	EEARL = addr;
	EEDR = data;
	EECR |= _BV(EEMPE);
	EECR |= _BV(EEPE);
}

uint8_t EEPROM_read(uint8_t addr)
{
	while (EECR & _BV(EEPE))
		;
	EEARL = addr;
	EECR |= _BV(EERE);
	return EEDR;
}

#define AD_MUX 3
#define AD_PRESCALE 3

void init() {
	DDRB = _BV(LED_BIT);
	PORTB = _BV(LED_BIT);
	DIDR0 = _BV(ADC3D);
	ADMUX = _BV(REFS0) | _BV(ADLAR) | AD_MUX;
	ADCSRA = AD_PRESCALE;
}

void ADC_start() {
	ADCSRA = _BV(ADEN) | _BV(ADSC) | AD_PRESCALE;
}

uint8_t ADC_get() {
	while (ADCSRA & _BV(ADSC))
		;
	uint8_t adc = ADCH;
	ADCSRA = AD_PRESCALE;
	return adc;
}

void on_low_bat() {
	uint8_t grb[3] = {0};
	for (int i = 0; i < 30; i++) {
		grb[1] = 0xff;
		led_send8_grb(grb);
		_delay_ms(50);
		grb[1] = 0;
		led_send8_grb(grb);
		_delay_ms(950);
	}
	for (;;) {
		MCUCR = _BV(SE) | _BV(SM1) | _BV(SM0);
		__asm__ __volatile__ ("sleep \n\t");
	}
}

int main()
{
	init();

	color_sel = EEPROM_read(0);

	uint8_t prev_val = 0;
	uint8_t low_bat_div = 250;
	uint8_t low_bat_cnt = 0;
	for(;;) {
		uint8_t new_val = 0x80 + (rand() & 0x7f);
		uint16_t delta = new_val - prev_val;
		uint16_t delta_2 = delta >> 2;
		for (int i = 0; i < 4; i++) {
			led_send8_col(prev_val + (delta_2 * i));
			_delay_ms(35);

			bool btn_val = (PINB & _BV(BUTTON_BIT)) == 0;
			if (btn_val == btn_val_last) {
				btn_ctr++;
			} else {
				btn_ctr = 0;
			}
			btn_val_last = btn_val;
			if (btn_val && btn_ctr == 7) {
				color_sel++;
				if (color_sel >= NUM_COLORS)
					color_sel = 0;
				EEPROM_write(0, color_sel);
			}
		}
		prev_val = new_val;

		low_bat_div++;
		if (low_bat_div >= 127) {
			low_bat_div = 0;
			ADC_start();
			uint8_t adc = ADC_get();
			// ((3.4V * (1K / (1K + 3.9K))) / 1.1V) * 255 == 161
			if (adc >= 161) {
				low_bat_cnt = 0;
			} else {
				low_bat_cnt++;
				if (low_bat_cnt >= 4) {
					on_low_bat();
				}
			
			}
		}
	}
}
