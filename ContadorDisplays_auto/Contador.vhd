----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:37:24 03/30/2019 
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
	Port(
		--Señales de control; reset y señal de reloj.
		clk:		in		std_logic;
		--Salidas para el control de los Display's.
		Enable:	out	std_logic_vector(2 downto 0);
		Display: out 	std_logic_vector(7 downto 0)
	);
end Contador;

architecture Behavioral of Contador is

signal bus_clk:	std_logic;

signal bus_enable:	std_logic_vector(2 downto 0);
signal bus_display:	std_logic_vector(7 downto 0);
signal bus_display1:	integer range 0 to 9;
signal bus_display2: integer range 0 to 9;
signal bus_display3: integer range 0 to 9;

signal conteo: integer range 0 to 12000000;

signal unidades:	integer range 0 to 9;
signal decenas:	integer range 0 to 9;
signal centenas:	integer range 0 to 9;

component displays
	Port(
		clk:		in		std_logic;
		
		enable:	out	std_logic_vector(2 downto 0);
		Display:	out	std_logic_vector(7 downto 0);
		
		Display1: in	integer range 0 to 9;
		Display2: in 	integer range 0 to 9;
		Display3: in 	integer range 0 to 9
	);
end component;

begin

	Inst_Displays: displays port map(
		clk => bus_clk,
		enable => bus_enable,
		Display => bus_display,
		display1 => bus_display1,
		display2 => bus_display2,
		display3 => bus_display3
	);
	
	bus_clk <= clk;
	
	bus_display1 <= unidades;
	bus_display2 <= decenas;
	bus_display3 <= centenas;
	
	Enable <= bus_enable;
	Display <= bus_display;

   process(clk)
		begin
		if(rising_edge(clk)) then
		
			if(conteo < 5999999) then
				conteo <= conteo + 1;
			else
				conteo <= 0;
				if(unidades <= 8) then
					unidades <= unidades + 1;
				else
					unidades <= 0;
					
					if(decenas <= 8) then
						decenas <= decenas + 1;
					else
						decenas <= 0;
						
						if(centenas <= 8) then
							centenas <= centenas + 1;
						else
							unidades <= 0;
							decenas <= 0;
							centenas <= 0;
						end if;
					end if;
				end if;
			end if;	
				
		end if;
	end process;

end Behavioral;