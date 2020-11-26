----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:30:48 03/24/2019 
-- Design Name: 
-- Module Name:    Contador - Behavioral 
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

entity Contador is
    Port (
			clk :      in  STD_LOGIC;
			count_up : in  STD_LOGIC;
         reset :    in  STD_LOGIC;
         led :     out  STD_LOGIC_VECTOR(3 downto 0)
			);
end Contador;

architecture Behavioral of Contador is

signal numero: integer range 0 to 15;
signal conteo: integer range 0 to 12000000;
signal flag:	STD_LOGIC;

begin

Conteo_binario: process (clk, reset, count_up)
begin
   
   if (reset = '0') then
		conteo <= 0;
		numero <= 0;
	elsif (RISING_EDGE(clk)) then
	
			if (conteo = 1199999) then
				conteo <= 0;
				if (count_up = '1') then
					flag <= '1';
				end if;
			else
				conteo <= conteo + 1;
			end if;	
			
			if (count_up = '0' and flag = '1') then
				flag <= '0';
				if numero < 15 then
					numero <= numero + 1;
				else
					numero <= 0;
			   end if;
		   end if;
			
	else
      numero <= numero;
   end if;
	
	case (numero) is 
		when 0 => led <= "0000";
		when 1 => led <= "0001";
		when 2 => led <= "0010";
		when 3 => led <= "0011";
		when 4 => led <= "0100";
		when 5 => led <= "0101";
		when 6 => led <= "0110";
		when 7 => led <= "0111";
		when 8 => led <= "1000";
		when 9 => led <= "1001";
   	when 10 => led <= "1010";
		when 11 => led <= "1011";
		when 12 => led <= "1100";
		when 13 => led <= "1101";
		when 14 => led <= "1110";
		when 15 => led <= "1111";
		when others => led <= "0000";
	end case;
						
end process Conteo_binario;
			
end Behavioral;