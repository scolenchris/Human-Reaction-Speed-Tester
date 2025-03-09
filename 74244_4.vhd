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

ENTITY 74244_4 IS 
PORT 
( 
	1A2	:	IN	 STD_LOGIC;
	1A4	:	IN	 STD_LOGIC;
	1A1	:	IN	 STD_LOGIC;
	1A3	:	IN	 STD_LOGIC;
	1GN	:	IN	 STD_LOGIC;
	2A3	:	IN	 STD_LOGIC;
	2GN	:	IN	 STD_LOGIC;
	2A1	:	IN	 STD_LOGIC;
	2A4	:	IN	 STD_LOGIC;
	2A2	:	IN	 STD_LOGIC;
	1Y2	:	OUT	 STD_LOGIC;
	1Y4	:	OUT	 STD_LOGIC;
	2Y1	:	OUT	 STD_LOGIC;
	1Y1	:	OUT	 STD_LOGIC;
	2Y3	:	OUT	 STD_LOGIC;
	2Y4	:	OUT	 STD_LOGIC;
	1Y3	:	OUT	 STD_LOGIC;
	2Y2	:	OUT	 STD_LOGIC
); 
END 74244_4;

ARCHITECTURE bdf_type OF 74244_4 IS 
BEGIN 

-- instantiate macrofunction 

b2v_inst14 : 74244
PORT MAP(1A2 => 1A2,
		 1A4 => 1A4,
		 1A1 => 1A1,
		 1A3 => 1A3,
		 1GN => 1GN,
		 2A3 => 2A3,
		 2GN => 2GN,
		 2A1 => 2A1,
		 2A4 => 2A4,
		 2A2 => 2A2,
		 1Y2 => 1Y2,
		 1Y4 => 1Y4,
		 2Y1 => 2Y1,
		 1Y1 => 1Y1,
		 2Y3 => 2Y3,
		 2Y4 => 2Y4,
		 1Y3 => 1Y3,
		 2Y2 => 2Y2);

END bdf_type; 