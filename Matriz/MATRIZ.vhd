----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    17:30:12 03/30/2019 
-- Design Name: 
-- Module Name:    MATRIZ - Behavioral 
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

entity MATRIZ is
	Port(
		Clk:		in		std_logic;
		Enable:	out	std_logic_vector(7 downto 0);
		Column:	out	std_logic_vector(7 downto 0)
	);
end MATRIZ;

architecture Behavioral of MATRIZ is

Type FSM is (Payasito0, Payasito1, Payasito2, Payasito3);

Signal Estado_Payasito: FSM;

signal cont_multiplex:	integer range 0 to 12000000; --Definirá la velocidad de multiplexacion
signal estado_enable:	std_logic_vector(7 downto 0);
signal data_column:	integer range 0 to 7;
signal cont_estado:  integer range 0 to 12000000;

begin

	Enable <= estado_enable;
	
	process(clk)
		begin
		
      if(rising_edge(Clk)) then

      -- MULTIPLEXACIÓN DE LA MATRIZ	
			if(cont_multiplex = 12000) then
				cont_multiplex <= 0;
				if(estado_enable = "00000001") then
					estado_enable <= "00000010";
					data_column <= 1;
				elsif(estado_enable = "00000010") then
					estado_enable <= "00000100";
					data_column <= 2;
				elsif(estado_enable = "00000100") then
					estado_enable <= "00001000";
					data_column <= 3;
			   elsif(estado_enable = "00001000") then
					estado_enable <= "00010000";
					data_column <= 4;
				elsif(estado_enable = "00010000") then
					estado_enable <= "00100000";
					data_column <= 5;
				elsif(estado_enable = "00100000") then
					estado_enable <= "01000000";
					data_column <= 6;
				elsif(estado_enable = "01000000") then
					estado_enable <= "10000000";
					data_column <= 7;
				else
					estado_enable <= "00000001";
					data_column <= 0;
				end if;
			 else
				cont_multiplex <= cont_multiplex + 1;
			 end if;

      -- CAMBIOS EN LA MAQUINA DE ESTADOS			  
			 if (cont_estado < 5999999) then
				 cont_estado <= cont_estado + 1;
			 else
				 cont_estado <= 0;
				 case Estado_Payasito is 
						when Payasito0 => Estado_Payasito <= Payasito1;
						when Payasito1 => Estado_Payasito <= Payasito2;
						when Payasito2 => Estado_Payasito <= Payasito3;
						when others => Estado_Payasito <= Payasito0;
				 end case;
			 end if;

      -- ESTADOS DE PAYASITO			
			 if (Estado_Payasito = Payasito1) then
					case data_column is
						when 0 => Column <= "00000000";
						when 1 => Column <= "10000010";
						when 2 => Column <= "10000100";
						when 3 => Column <= "01001011";
						when 4 => Column <= "00111111";
						when 5 => Column <= "01001011";
						when 6 => Column <= "10000100";
						when 7 => Column <= "10000010";
						when others => Column <= "00000000";
					end case;	
			 elsif (Estado_Payasito = Payasito2) then
					case data_column is
						when 0 => Column <= "00000000";
						when 1 => Column <= "10001000";
						when 2 => Column <= "10001000";
						when 3 => Column <= "01001011";
						when 4 => Column <= "00111111";
						when 5 => Column <= "01001011";
						when 6 => Column <= "10001000";
						when 7 => Column <= "10001000";
						when others => Column <= "00000000";
					end case;
			 elsif (Estado_Payasito = Payasito3) then
					case data_column is
						when 0 => Column <= "00000000";
						when 1 => Column <= "10100000";
						when 2 => Column <= "10010000";
						when 3 => Column <= "01001011";
						when 4 => Column <= "00111111";
						when 5 => Column <= "01001011";
						when 6 => Column <= "10010000";
						when 7 => Column <= "10100000";
						when others => Column <= "00000000";
					end case;					
			 else
					case data_column is
						when 0 => Column <= "00000000";
						when 1 => Column <= "10001000";
						when 2 => Column <= "10001000";
						when 3 => Column <= "01001011";
						when 4 => Column <= "00111111";
						when 5 => Column <= "01001011";
						when 6 => Column <= "10001000";
						when 7 => Column <= "10001000";
						when others => Column <= "00000000";
					end case;
			 end if;
	
      end if;
		
	end process;

end Behavioral;