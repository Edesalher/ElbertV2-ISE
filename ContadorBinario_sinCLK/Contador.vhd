----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    12:51:16 03/26/2019 
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
	port(
		count_up: in STD_LOGIC;
		reset:    in STD_LOGIC;
		conteo:  out STD_LOGIC_VECTOR(3 downto 0)
		);
end Contador;

architecture Behavioral of Contador is

signal aux: STD_LOGIC_VECTOR(3 downto 0):= "0000";

begin

contador: process (reset, count_up)
begin

	if (reset = '0') then
		aux <= "0000";
	else 
		if (count_up'EVENT and count_up = '0') then
			if (aux = "1111") then
				aux <= "0000";
			else
				aux <= aux + 1; 
			end if;
		else
			aux <= aux;
		end if;
	end if;

conteo <= aux;
			
end process contador;
			
end Behavioral;