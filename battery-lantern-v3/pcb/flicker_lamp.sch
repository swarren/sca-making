EESchema Schematic File Version 4
EELAYER 30 0
EELAYER END
$Descr USLetter 11000 8500
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
Wire Wire Line
	2600 1900 2850 1900
Wire Wire Line
	2600 2000 2850 2000
Text Label 2850 1900 2    50   ~ 0
MOSI
Text Label 2850 2000 2    50   ~ 0
MISO
$Comp
L Connector_Generic:Conn_02x03_Odd_Even J4
U 1 1 607ED090
P 6600 2000
F 0 "J4" H 6650 2317 50  0000 C CNN
F 1 "ISP" H 6650 2226 50  0000 C CNN
F 2 "Pin_Headers:Pin_Header_Straight_2x03_Pitch2.54mm" H 6600 2000 50  0001 C CNN
F 3 "~" H 6600 2000 50  0001 C CNN
	1    6600 2000
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 1900 6050 1900
Wire Wire Line
	6400 2000 6050 2000
Wire Wire Line
	6400 2100 6050 2100
Wire Wire Line
	6900 1900 7250 1900
Wire Wire Line
	6900 2000 7250 2000
Wire Wire Line
	6900 2100 7250 2100
Text Label 7250 1900 2    50   ~ 0
VBATSW
Text Label 7250 2000 2    50   ~ 0
MOSI
Text Label 7250 2100 2    50   ~ 0
GND
Text Label 6050 1900 0    50   ~ 0
MISO
Text Label 6050 2000 0    50   ~ 0
SCK
Text Label 6050 2100 0    50   ~ 0
RESET
Wire Wire Line
	2000 1600 2000 1350
Text Label 1000 1350 0    50   ~ 0
VBATSW
$Comp
L Connector_Generic:Conn_01x03 J3
U 1 1 607F14A9
P 6600 2450
F 0 "J3" H 6680 2492 50  0000 L CNN
F 1 "LED" H 6680 2401 50  0000 L CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x03_Pitch2.54mm" H 6600 2450 50  0001 C CNN
F 3 "~" H 6600 2450 50  0001 C CNN
	1    6600 2450
	1    0    0    -1  
$EndComp
Wire Wire Line
	6400 2350 6050 2350
Wire Wire Line
	6400 2450 6050 2450
Wire Wire Line
	6400 2550 6050 2550
Text Label 6050 2350 0    50   ~ 0
VBATSW
Text Label 6050 2450 0    50   ~ 0
LED
Text Label 6050 2550 0    50   ~ 0
GND
$Comp
L Connector_Generic:Conn_01x02 J2
U 1 1 607F91F6
P 8450 3800
F 0 "J2" V 8414 3612 50  0000 R CNN
F 1 "PSW" V 8323 3612 50  0000 R CNN
F 2 "Pin_Headers:Pin_Header_Straight_1x02_Pitch2.54mm" H 8450 3800 50  0001 C CNN
F 3 "" H 8450 3800 50  0001 C CNN
	1    8450 3800
	0    -1   -1   0   
$EndComp
Wire Wire Line
	8550 4000 8550 4100
Wire Wire Line
	8550 4100 8900 4100
Wire Wire Line
	8450 4000 8450 4100
Text Label 8900 4100 2    50   ~ 0
VBATSW
Wire Wire Line
	1350 4900 1100 4900
Wire Wire Line
	1350 5000 1100 5000
Wire Wire Line
	1350 5100 1100 5100
Wire Wire Line
	1350 5200 1100 5200
Wire Wire Line
	2400 4850 2800 4850
Text Label 1100 4900 0    50   ~ 0
GND
Text Label 1100 5000 0    50   ~ 0
GND
Text Label 1100 5100 0    50   ~ 0
GND
Text Label 1100 5200 0    50   ~ 0
GND
Text Label 2650 4850 2    50   ~ 0
VUSB
Text Label 2650 5250 2    50   ~ 0
GND
$Comp
L Device:C C1
U 1 1 6080D933
P 2800 5050
F 0 "C1" H 2915 5096 50  0000 L CNN
F 1 "10uF" H 2915 5005 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 2838 4900 50  0001 C CNN
F 3 "~" H 2800 5050 50  0001 C CNN
F 4 "CL21A106KAYNNNE" H 2800 5050 50  0001 C CNN "MPN"
F 5 "C15850" H 2800 5050 50  0001 C CNN "LCSC"
	1    2800 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	2800 4900 2800 4850
Connection ~ 2800 4850
Wire Wire Line
	2800 4850 3250 4850
Wire Wire Line
	2800 5250 2800 5200
Wire Wire Line
	2400 5250 2800 5250
$Comp
L Device:R R1
U 1 1 60811250
P 3250 5650
F 0 "R1" H 3320 5696 50  0000 L CNN
F 1 "1000R" H 3320 5605 50  0000 L CNN
F 2 "Resistors_SMD:R_0603" V 3180 5650 50  0001 C CNN
F 3 "~" H 3250 5650 50  0001 C CNN
F 4 "0603WAF1001T5E" H 3250 5650 50  0001 C CNN "MPN"
F 5 "C21190" H 3250 5650 50  0001 C CNN "LCSC"
	1    3250 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:R R2
U 1 1 608116DA
P 3650 5650
F 0 "R2" H 3720 5696 50  0000 L CNN
F 1 "1000R" H 3720 5605 50  0000 L CNN
F 2 "Resistors_SMD:R_0603" V 3580 5650 50  0001 C CNN
F 3 "~" H 3650 5650 50  0001 C CNN
F 4 "0603WAF1001T5E" H 3650 5650 50  0001 C CNN "MPN"
F 5 "C21190" H 3650 5650 50  0001 C CNN "LCSC"
	1    3650 5650
	1    0    0    -1  
$EndComp
$Comp
L Device:LED D1
U 1 1 60811C9A
P 3250 5050
F 0 "D1" V 3289 4932 50  0000 R CNN
F 1 "STBY" V 3198 4932 50  0000 R CNN
F 2 "LEDs:LED_0805" H 3250 5050 50  0001 C CNN
F 3 "~" H 3250 5050 50  0001 C CNN
F 4 "NCD0805R1" V 3250 5050 50  0001 C CNN "MPN"
F 5 "C84256" V 3250 5050 50  0001 C CNN "LCSC"
	1    3250 5050
	0    -1   -1   0   
$EndComp
$Comp
L Device:LED D2
U 1 1 608122F2
P 3650 5050
F 0 "D2" V 3689 4933 50  0000 R CNN
F 1 "CHRG" V 3598 4933 50  0000 R CNN
F 2 "LEDs:LED_0603" H 3650 5050 50  0001 C CNN
F 3 "~" H 3650 5050 50  0001 C CNN
F 4 "19-217/GHC-YR1S2/3T" V 3650 5050 50  0001 C CNN "MPN"
F 5 "C72043" V 3650 5050 50  0001 C CNN "LCSC"
	1    3650 5050
	0    -1   -1   0   
$EndComp
Wire Wire Line
	3250 4900 3250 4850
Connection ~ 3250 4850
Wire Wire Line
	3650 4900 3650 4850
Connection ~ 3650 4850
Wire Wire Line
	3250 5500 3250 5200
Wire Wire Line
	3650 5500 3650 5200
$Comp
L project-library:TP4056 U1
U 1 1 6081A84E
P 4500 5850
F 0 "U1" H 4300 6150 50  0000 C CNN
F 1 "TP4056" H 4600 6150 50  0000 C CNN
F 2 "project-library:LCSC-C16581-TP4056-ESOP-8" H 4300 5950 50  0001 C CNN
F 3 "" H 4300 5950 50  0001 C CNN
F 4 "TP4056-42-ESOP8" H 4500 5850 50  0001 C CNN "MPN"
F 5 "C16581" H 4500 5850 50  0001 C CNN "LCSC"
	1    4500 5850
	1    0    0    -1  
$EndComp
Wire Wire Line
	4100 5700 4000 5700
Wire Wire Line
	4000 5700 4000 4850
Wire Wire Line
	4100 5800 4000 5800
Wire Wire Line
	4000 5800 4000 5700
Wire Wire Line
	3250 6000 4100 6000
Wire Wire Line
	3650 5900 4100 5900
Wire Wire Line
	3650 4850 4000 4850
Wire Wire Line
	3250 4850 3650 4850
Wire Wire Line
	4900 6000 5000 6000
Wire Wire Line
	5000 6000 5000 6300
Wire Wire Line
	2800 6300 2800 5250
Connection ~ 2800 5250
$Comp
L Device:R R3
U 1 1 6082B502
P 5150 6100
F 0 "R3" H 5220 6146 50  0000 L CNN
F 1 "2000R" H 5220 6055 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" V 5080 6100 50  0001 C CNN
F 3 "~" H 5150 6100 50  0001 C CNN
F 4 "0805W8F2001T5E" H 5150 6100 50  0001 C CNN "MPN"
F 5 "C17604" H 5150 6100 50  0001 C CNN "LCSC"
	1    5150 6100
	1    0    0    -1  
$EndComp
Wire Wire Line
	4900 5800 5500 5800
Connection ~ 5000 6300
Wire Wire Line
	4900 5900 5150 5900
Wire Wire Line
	5150 5900 5150 5950
Wire Wire Line
	5000 6300 5150 6300
Wire Wire Line
	5150 6300 5150 6250
Connection ~ 5150 6300
$Comp
L project-library:DW01A-G U2
U 1 1 60849766
P 7400 4750
F 0 "U2" H 7200 5150 50  0000 C CNN
F 1 "DW01+G" H 7500 5150 50  0000 C CNN
F 2 "project-library:SOT-23-6-LCSC" H 7400 4750 50  0001 C CNN
F 3 "" H 7400 4750 50  0001 C CNN
F 4 "DW01+G" H 7400 4750 50  0001 C CNN "MPN"
F 5 "C14213 " H 7400 4750 50  0001 C CNN "LCSC"
	1    7400 4750
	1    0    0    -1  
$EndComp
$Comp
L Device:Battery_Cell BT1
U 1 1 6084A58C
P 6150 5150
F 0 "BT1" H 6268 5246 50  0000 L CNN
F 1 "18650" H 6268 5155 50  0000 L CNN
F 2 "project-library:Bat_Clip_Keystone_54_65mm" V 6150 5210 50  0001 C CNN
F 3 "~" V 6150 5210 50  0001 C CNN
	1    6150 5150
	1    0    0    -1  
$EndComp
$Comp
L Device:R R4
U 1 1 60857B45
P 6550 4300
F 0 "R4" H 6480 4254 50  0000 R CNN
F 1 "100R" H 6480 4345 50  0000 R CNN
F 2 "Resistors_SMD:R_0805" V 6480 4300 50  0001 C CNN
F 3 "~" H 6550 4300 50  0001 C CNN
F 4 "0805W8F1000T5E" V 6550 4300 50  0001 C CNN "MPN"
F 5 "C17408" H 6550 4300 50  0001 C CNN "LCSC"
	1    6550 4300
	-1   0    0    1   
$EndComp
$Comp
L Device:C C3
U 1 1 608582D4
P 6550 4700
F 0 "C3" H 6665 4746 50  0000 L CNN
F 1 "0.1uF" H 6665 4655 50  0000 L CNN
F 2 "Capacitors_SMD:C_0402" H 6588 4550 50  0001 C CNN
F 3 "~" H 6550 4700 50  0001 C CNN
F 4 "CL21B104KCFNCL05B104KO5NNNCNNE" H 6550 4700 50  0001 C CNN "MPN"
F 5 "C1525" H 6550 4700 50  0001 C CNN "LCSC"
	1    6550 4700
	1    0    0    -1  
$EndComp
$Comp
L Device:R R5
U 1 1 6085A55C
P 8050 5050
F 0 "R5" H 8120 5096 50  0000 L CNN
F 1 "2000R" H 8120 5005 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" V 7980 5050 50  0001 C CNN
F 3 "~" H 8050 5050 50  0001 C CNN
F 4 "0805W8F2001T5E" H 8050 5050 50  0001 C CNN "MPN"
F 5 "C17604" H 8050 5050 50  0001 C CNN "LCSC"
	1    8050 5050
	1    0    0    -1  
$EndComp
Wire Wire Line
	8050 4900 8050 4850
Wire Wire Line
	8050 4850 7800 4850
Wire Wire Line
	6550 4500 7000 4500
Wire Wire Line
	7000 4900 6550 4900
Wire Wire Line
	6150 4950 6150 4100
Wire Wire Line
	4900 5700 5500 5700
Wire Wire Line
	5500 5700 5500 4100
Text Label 1000 3050 0    50   ~ 0
GND
Wire Wire Line
	2000 2800 2000 3050
Text Label 2850 2400 2    50   ~ 0
RESET
Text Label 2850 2300 2    50   ~ 0
LED
Text Label 2850 2100 2    50   ~ 0
SCK
Wire Wire Line
	2600 2100 2850 2100
Wire Wire Line
	2600 2300 2850 2300
Wire Wire Line
	2600 2400 2850 2400
$Comp
L MCU_Microchip_ATtiny:ATtiny13A-PU U4
U 1 1 5AF8FD74
P 2000 2200
F 0 "U4" H 2050 2850 50  0000 L BNN
F 1 "ATTINY13A-PU" H 2050 2750 50  0000 L BNN
F 2 "Housings_DIP:DIP-8_W7.62mm" H 2650 2200 50  0001 C CIN
F 3 "" H 1200 2550 50  0001 C CNN
	1    2000 2200
	1    0    0    -1  
$EndComp
Connection ~ 6150 4100
Wire Wire Line
	6150 4100 6550 4100
Wire Wire Line
	6550 4150 6550 4100
Wire Wire Line
	8900 5900 8050 5900
Text Label 8900 5900 2    50   ~ 0
GND
$Comp
L project-library:FS8205 U3
U 1 1 6080E339
P 7400 5800
F 0 "U3" H 7400 6165 50  0000 C CNN
F 1 "FS8205" H 7400 6074 50  0000 C CNN
F 2 "project-library:SOT-23-6-LCSC" H 7400 5800 50  0001 C CNN
F 3 "" H 7400 5800 50  0001 C CNN
F 4 "FS8205" H 7400 5800 50  0001 C CNN "MPN"
F 5 "C32254" H 7400 5800 50  0001 C CNN "LCSC"
	1    7400 5800
	1    0    0    -1  
$EndComp
Wire Wire Line
	6150 5250 6150 5900
Wire Wire Line
	8050 6300 8050 5900
Connection ~ 8050 5900
Wire Wire Line
	8050 5900 7800 5900
Wire Wire Line
	7450 5200 7450 5300
Wire Wire Line
	7450 5300 7900 5300
Wire Wire Line
	7900 5300 7900 5700
Wire Wire Line
	7900 5700 7800 5700
Wire Wire Line
	7000 5700 6900 5700
Wire Wire Line
	6900 5700 6900 5300
Wire Wire Line
	6900 5300 7350 5300
Wire Wire Line
	7350 5300 7350 5200
Wire Wire Line
	8050 5200 8050 5900
Wire Wire Line
	5500 4100 5700 4100
Wire Wire Line
	2800 6300 4000 6300
$Comp
L Device:C C2
U 1 1 6085902A
P 5700 5100
F 0 "C2" H 5815 5146 50  0000 L CNN
F 1 "10uF" H 5815 5055 50  0000 L CNN
F 2 "Capacitors_SMD:C_0805" H 5738 4950 50  0001 C CNN
F 3 "~" H 5700 5100 50  0001 C CNN
F 4 "CL21A106KAYNNNE" H 5700 5100 50  0001 C CNN "MPN"
F 5 "C15850" H 5700 5100 50  0001 C CNN "LCSC"
	1    5700 5100
	1    0    0    -1  
$EndComp
Wire Wire Line
	5700 4950 5700 4100
Connection ~ 5700 4100
Wire Wire Line
	5700 4100 6150 4100
Wire Wire Line
	5700 5250 5700 6300
Wire Wire Line
	5500 5800 5500 6300
Wire Wire Line
	5150 6300 5500 6300
Connection ~ 5500 6300
Wire Wire Line
	5500 6300 5700 6300
Wire Wire Line
	6550 4100 8450 4100
$Comp
L Device:R R6
U 1 1 608B9815
P 3350 1950
F 0 "R6" H 3420 1996 50  0000 L CNN
F 1 "3900R" H 3420 1905 50  0000 L CNN
F 2 "Resistors_SMD:R_0805" V 3280 1950 50  0001 C CNN
F 3 "~" H 3350 1950 50  0001 C CNN
F 4 "0805W8F3901T5E" H 3350 1950 50  0001 C CNN "MPN"
F 5 "C17614" H 3350 1950 50  0001 C CNN "LCSC"
	1    3350 1950
	1    0    0    -1  
$EndComp
$Comp
L Device:R R7
U 1 1 608B9DF2
P 3350 2400
F 0 "R7" H 3420 2446 50  0000 L CNN
F 1 "1000R" H 3420 2355 50  0000 L CNN
F 2 "Resistors_SMD:R_0603" V 3280 2400 50  0001 C CNN
F 3 "~" H 3350 2400 50  0001 C CNN
F 4 "0603WAF1001T5E" H 3350 2400 50  0001 C CNN "MPN"
F 5 "C21190" H 3350 2400 50  0001 C CNN "LCSC"
	1    3350 2400
	1    0    0    -1  
$EndComp
Wire Wire Line
	3350 2100 3350 2200
Connection ~ 3350 2200
Wire Wire Line
	3350 2200 3350 2250
Text Label 2850 2200 2    50   ~ 0
AIN
Wire Wire Line
	2600 2200 3350 2200
Wire Wire Line
	2000 1350 1000 1350
Wire Wire Line
	2000 3050 1000 3050
Wire Wire Line
	2000 1350 3350 1350
Wire Wire Line
	3350 1350 3350 1800
Connection ~ 2000 1350
Wire Wire Line
	3350 3050 2000 3050
Wire Wire Line
	3350 2550 3350 3050
Connection ~ 2000 3050
$Comp
L Switch:SW_Push SW1
U 1 1 608DE41E
P 5150 2250
F 0 "SW1" H 5150 2535 50  0000 C CNN
F 1 "B3F-1050" H 5150 2444 50  0000 C CNN
F 2 "Buttons_Switches_THT:SW_PUSH_6mm" H 5150 2450 50  0001 C CNN
F 3 "~" H 5150 2450 50  0001 C CNN
	1    5150 2250
	1    0    0    -1  
$EndComp
Wire Wire Line
	5350 2250 5450 2250
Wire Wire Line
	5450 3050 3350 3050
Connection ~ 3350 3050
Text Label 4500 2250 0    50   ~ 0
MISO
Text Label 8400 4100 2    50   ~ 0
VBAT
Text Label 6200 5900 0    50   ~ 0
BATGND
Wire Wire Line
	5450 2250 5450 3050
Wire Wire Line
	4500 2250 4950 2250
$Comp
L Mechanical:MountingHole H1
U 1 1 60B49293
P 8200 1000
F 0 "H1" H 8300 1046 50  0000 L CNN
F 1 "Battery Strap Hole" H 8300 955 50  0000 L CNN
F 2 "project-library:hole-3mm-1.5mm-oval" H 8200 1000 50  0001 C CNN
F 3 "~" H 8200 1000 50  0001 C CNN
	1    8200 1000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H2
U 1 1 60B4A2A5
P 8200 1250
F 0 "H2" H 8300 1296 50  0000 L CNN
F 1 "Battery Strap Hole" H 8300 1205 50  0000 L CNN
F 2 "project-library:hole-3mm-1.5mm-oval" H 8200 1250 50  0001 C CNN
F 3 "~" H 8200 1250 50  0001 C CNN
	1    8200 1250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H3
U 1 1 60B4A850
P 8200 1500
F 0 "H3" H 8300 1546 50  0000 L CNN
F 1 "Battery Strap Hole" H 8300 1455 50  0000 L CNN
F 2 "project-library:hole-3mm-1.5mm-oval" H 8200 1500 50  0001 C CNN
F 3 "~" H 8200 1500 50  0001 C CNN
	1    8200 1500
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H4
U 1 1 60B4AE00
P 8200 1750
F 0 "H4" H 8300 1796 50  0000 L CNN
F 1 "Battery Strap Hole" H 8300 1705 50  0000 L CNN
F 2 "project-library:hole-3mm-1.5mm-oval" H 8200 1750 50  0001 C CNN
F 3 "~" H 8200 1750 50  0001 C CNN
	1    8200 1750
	1    0    0    -1  
$EndComp
NoConn ~ 7350 6100
NoConn ~ 2400 4950
NoConn ~ 2400 5050
NoConn ~ 2400 5150
Text Label 7800 5300 2    50   ~ 0
DW_OC
Text Label 7000 5300 0    50   ~ 0
DW_OD
Text Label 7850 4850 0    50   ~ 0
DW_CS
Wire Wire Line
	6150 5900 6550 5900
Wire Wire Line
	6550 5900 7000 5900
Text Label 6650 4500 0    50   ~ 0
DW_VCC
Wire Wire Line
	6550 4850 6550 4900
Wire Wire Line
	6550 4450 6550 4500
Connection ~ 6550 4500
Wire Wire Line
	6550 4500 6550 4550
Connection ~ 6550 4100
Connection ~ 6550 4900
Wire Wire Line
	6550 4900 6550 5900
Connection ~ 6550 5900
Text Label 3700 5900 0    50   ~ 0
TP_nCHRG
Text Label 3700 6000 0    50   ~ 0
TP_nSTDBY
Text Label 3250 5350 0    50   ~ 0
STBY_R
Text Label 3650 5350 0    50   ~ 0
CHRG_R
Connection ~ 4000 5700
Wire Wire Line
	3250 5800 3250 6000
Wire Wire Line
	3650 5800 3650 5900
Text Label 4950 5900 0    50   ~ 0
TP_PROG
Wire Wire Line
	4100 6100 4000 6100
Wire Wire Line
	4000 6100 4000 6300
Connection ~ 4000 6300
Wire Wire Line
	4000 6300 5000 6300
Connection ~ 5700 6300
Wire Wire Line
	5700 6300 8050 6300
$Comp
L project-library:MICRO-USB-B-U-F-M5DD-Y-L-HRO J1
U 1 1 607FE937
P 1850 5050
F 0 "J1" H 1600 5400 45  0000 C CNN
F 1 "uUSB" H 2050 5400 45  0000 C CNN
F 2 "project-library:LCSC-C10418-USB-uB" H 1850 5050 50  0001 C CNN
F 3 "" H 1850 5050 50  0001 C CNN
F 4 "C10418" H 1850 5050 50  0001 C CNN "LCSC"
F 5 "920-E52A2021S10100" H 1850 5050 50  0001 C CNN "MPN"
	1    1850 5050
	1    0    0    -1  
$EndComp
NoConn ~ 7450 6100
Text Notes 6500 4050 0    50   ~ 0
100R-470R\n100R best overcharge accuracy\n470R best ESD protection
$Comp
L Mechanical:MountingHole H5
U 1 1 60BDC2FE
P 9200 1000
F 0 "H5" H 9300 1046 50  0000 L CNN
F 1 "JLCPBC Tooling Hole" H 9300 955 50  0000 L CNN
F 2 "project-library:jlcpcb-smt-tooling-hole" H 9200 1000 50  0001 C CNN
F 3 "~" H 9200 1000 50  0001 C CNN
	1    9200 1000
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H6
U 1 1 60BDC8BF
P 9200 1250
F 0 "H6" H 9300 1296 50  0000 L CNN
F 1 "JLCPBC Tooling Hole" H 9300 1205 50  0000 L CNN
F 2 "project-library:jlcpcb-smt-tooling-hole" H 9200 1250 50  0001 C CNN
F 3 "~" H 9200 1250 50  0001 C CNN
	1    9200 1250
	1    0    0    -1  
$EndComp
$Comp
L Mechanical:MountingHole H7
U 1 1 60BDCAFD
P 9200 1500
F 0 "H7" H 9300 1546 50  0000 L CNN
F 1 "JLCPBC Tooling Hole" H 9300 1455 50  0000 L CNN
F 2 "project-library:jlcpcb-smt-tooling-hole" H 9200 1500 50  0001 C CNN
F 3 "~" H 9200 1500 50  0001 C CNN
	1    9200 1500
	1    0    0    -1  
$EndComp
$EndSCHEMATC
