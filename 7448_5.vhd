-- Copyright (C) 1991-2010 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- PROGRAM		"Quartus II 64-Bit"
-- VERSION		"Version 9.1 Build 350 03/24/2010 Service Pack 2 SJ Full Version"
-- CREATED		"Tue Jun 11 20:17:13 2024"

LIBRARY ieee;
USE ieee.std_logic_1164.all; 

LIBRARY altera;
USE altera.maxplus2.all; 

LIBRARY work;

ENTITY 7448_5 IS 
PORT 
( 
	A	:	IN	 STD_LOGIC;
	C	:	IN	 STD_LOGIC;
	D	:	IN	 STD_LOGIC;
	B	:	IN	 STD_LOGIC;
	RBIN	:	IN	 STD_LOGIC;
	BIN	:	IN	 STD_LOGIC;
	LTN	:	IN	 STD_LOGIC;
	OC	:	OUT	 STD_LOGIC;
	OE	:	OUT	 STD_LOGIC;
	OD	:	OUT	 STD_LOGIC;
	OF	:	OUT	 STD_LOGIC;
	OG	:	OUT	 STD_LOGIC;
	OB	:	OUT	 STD_LOGIC;
	OA	:	OUT	 STD_LOGIC
); 
END 7448_5;

ARCHITECTURE bdf_type OF 7448_5 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst15 : 7448
PORT MAP(A => A,
		 C => C,
		 D => D,
		 B => B,
		 RBIN => RBIN,
		 BIN => BIN,
		 LTN => LTN,
		 OC => OC,
		 OE => OE,
		 OD => OD,
		 OF => OF,
		 OG => OG,
		 OB => OB,
		 OA => OA);

END bdf_type; 