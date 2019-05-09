EESchema Schematic File Version 2
LIBS:power
LIBS:device
LIBS:switches
LIBS:relays
LIBS:motors
LIBS:transistors
LIBS:conn
LIBS:linear
LIBS:regul
LIBS:74xx
LIBS:cmos4000
LIBS:adc-dac
LIBS:memory
LIBS:xilinx
LIBS:microcontrollers
LIBS:dsp
LIBS:microchip
LIBS:analog_switches
LIBS:motorola
LIBS:texas
LIBS:intel
LIBS:audio
LIBS:interface
LIBS:digital-audio
LIBS:philips
LIBS:display
LIBS:cypress
LIBS:siliconi
LIBS:opto
LIBS:atmel
LIBS:contrib
LIBS:valves
EELAYER 25 0
EELAYER END
$Descr A4 11693 8268
encoding utf-8
Sheet 1 1
Title ""
Date ""
Rev ""
Comp ""
Comment1 ""
Comment2 ""
Comment3 ""
Comment4 ""
$EndDescr
$Comp
L ATTINY13A-PU U1
U 1 1 5AF8FD74
P 2900 2000
F 0 "U1" H 2100 2400 50  0000 C CNN
F 1 "ATTINY13A-PU" H 3550 1600 50  0000 C CNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 3550 2000 50  0001 C CIN
F 3 "" H 2100 2350 50  0001 C CNN
	1    2900 2000
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x02 JPWR1
U 1 1 5AF8FEE0
P 2100 2650
F 0 "JPWR1" H 2100 2750 50  0000 C CNN
F 1 "Conn_01x02" H 2100 2450 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 2100 2650 50  0001 C CNN
F 3 "" H 2100 2650 50  0001 C CNN
	1    2100 2650
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x02 JPSW1
U 1 1 5AF8FF69
P 2100 3100
F 0 "JPSW1" H 2100 3200 50  0000 C CNN
F 1 "Conn_01x02" H 2100 2900 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x02_Pitch2.54mm" H 2100 3100 50  0001 C CNN
F 3 "" H 2100 3100 50  0001 C CNN
	1    2100 3100
	1    0    0    -1  
$EndComp
$Comp
L Conn_01x03 JLED1
U 1 1 5AF8FF8A
P 2100 3650
F 0 "JLED1" H 2100 3850 50  0000 C CNN
F 1 "Conn_01x03" H 2100 3450 50  0000 C CNN
F 2 "Socket_Strips:Socket_Strip_Straight_1x03_Pitch2.54mm" H 2100 3650 50  0001 C CNN
F 3 "" H 2100 3650 50  0001 C CNN
	1    2100 3650
	1    0    0    -1  
$EndComp
Wire Wire Line
	1900 1750 1550 1750
Wire Wire Line
	1900 1850 1550 1850
Wire Wire Line
	1900 1950 1550 1950
Wire Wire Line
	1900 2050 1550 2050
Wire Wire Line
	1900 2150 1550 2150
Wire Wire Line
	1900 2250 1550 2250
Wire Wire Line
	3900 1750 4250 1750
Wire Wire Line
	3900 2250 4250 2250
Wire Wire Line
	1900 2650 1550 2650
Wire Wire Line
	1900 2750 1550 2750
Wire Wire Line
	1900 3100 1550 3100
Wire Wire Line
	1900 3200 1550 3200
Wire Wire Line
	1900 3550 1550 3550
Wire Wire Line
	1900 3650 1550 3650
Wire Wire Line
	1900 3750 1550 3750
Wire Wire Line
	1900 4050 1550 4050
Wire Wire Line
	1900 4150 1550 4150
Wire Wire Line
	1900 4250 1550 4250
Wire Wire Line
	2400 4050 2750 4050
Wire Wire Line
	2400 4150 2750 4150
Wire Wire Line
	2400 4250 2750 4250
Text Label 3950 1750 0    60   ~ 0
vcc
Text Label 3950 2250 0    60   ~ 0
GND
Text Label 1600 2650 0    60   ~ 0
VCCIN
Text Label 1600 2750 0    60   ~ 0
GND
Text Label 1650 3100 0    60   ~ 0
VCCIN
Text Label 1650 3200 0    60   ~ 0
VCC
Text Label 1650 3550 0    60   ~ 0
VCC
Text Label 1650 3750 0    60   ~ 0
GND
Text Label 1650 3650 0    60   ~ 0
LED
Text Label 1600 1750 0    60   ~ 0
MOSI
Text Label 1600 1850 0    60   ~ 0
MISO
Text Label 1600 2250 0    60   ~ 0
RESET
Text Label 1600 2150 0    60   ~ 0
LED
Text Label 1600 1950 0    60   ~ 0
SCK
Text Label 1600 4050 0    60   ~ 0
MISO
Text Label 1600 4150 0    60   ~ 0
SCK
Text Label 1600 4250 0    60   ~ 0
RESET
Text Label 2450 4050 0    60   ~ 0
VCC
Text Label 2450 4150 0    60   ~ 0
MOSI
Text Label 2450 4250 0    60   ~ 0
GND
$Comp
L Conn_02x03_Odd_Even JICSP1
U 1 1 5AF911D9
P 2100 4150
F 0 "JICSP1" H 2150 4350 50  0000 C CNN
F 1 "Conn_02x03_Odd_Even" H 2150 3950 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 2100 4150 50  0001 C CNN
F 3 "" H 2100 4150 50  0001 C CNN
	1    2100 4150
	1    0    0    -1  
$EndComp
$EndSCHEMATC
