----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:20:51 09/27/2020 
-- Design Name: 
-- Module Name:    Practica3 - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Practica3 is
    Port ( 
			  -- Señal de reloj de control.
			  Clk:   in  std_logic;
			  -- Bits de salida a conectar al R2R.
           bits : out std_logic_vector(7 downto 0)
			  );
end Practica3;

architecture Behavioral of Practica3 is
	-- Memoria para almacenar las 64 muestras del Seno.
	type memoria is array (0 to 63) of std_logic_vector(7 downto 0);
	signal muestras: memoria:=( "01111111", --127
										 "10001100", --140
										 "10011000", --152
										 "10100101", --165
										 "10110001", --177
										 "10111100", --188
										 "11000111", --199
										 "11010001", --209
										 "11011010", --218
										 "11100011", --227
										 "11101010", --234
										 "11110000", --240
										 "11110110", --246
										 "11111010", --250
										 "11111101", --253
										 "11111110", --254
										 "11111110", --254
										 "11111110", --254
										 "11111011", --251
										 "11111000", --248
										 "11110011", --243
										 "11101101", --237
										 "11100111", --231
										 "11011111", --223
										 "11010110", --214
										 "11001100", --204
										 "11000001", --193
										 "10110110", --182
										 "10101011", --171
										 "10011110", --158
										 "10010010", --146
										 "10000101", --133
										 "01111001", --121
										 "01101100", --108
										 "01100000", --96
										 "01010011", --83
										 "01001000", --72
										 "00111101", --61
										 "00110010", --50
										 "00101000", --40
										 "00011111", --31
										 "00010111", --23
										 "00010001", --17
										 "00001011", --11
										 "00000110", --6
										 "00000011", --3
										 "00000000", --0
										 "00000000", --0
										 "00000000", --0
										 "00000001", --1
										 "00000100", --4
										 "00001000", --8
										 "00001110", --14
										 "00010100", --20
										 "00011011", --27
										 "00100100", --36
										 "00101101", --45
										 "00110111", --55
										 "01000010", --66
										 "01001101", --77
										 "01011001", --89
										 "01100110", --102
										 "01110010", --114
										 "01111111"  --127
										);
	-- Señal para llevar la toma del tiempo. El 11999999 es por los 12Mhz
	-- de reloj que tiene la FPGA.
	signal count: 	 integer range 0 to 11999999;
	-- Indicará el número de muestra a mostrar en la salida "bits".
	signal muestra: integer range 0 to 63;
	
begin
	
SIGNAL_GENERATOR: process (Clk)
begin
   -- El 9375 equivale a 0.78ms ya que 12M = 1s.
   if count = 9375 then
		count <= 0;
		
		if muestra = 63 then
			muestra <= 0;
		else
			muestra <= muestra + 1;
		end if;
			
		bits <= muestras(muestra);
   else
      count <= count + 1;
   end if;
	
end process SIGNAL_GENERATOR;
			

end Behavioral;
