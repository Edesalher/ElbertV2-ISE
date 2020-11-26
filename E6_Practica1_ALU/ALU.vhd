----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:19:00 02/15/2020 
-- Design Name: 
-- Module Name:    ALU - Behavioral 
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

entity ALU is
	Port (
		--Entradas:
		numero1:		in	std_logic_vector(3 downto 0);
		numero2:		in	std_logic_vector(7 downto 4);
		operacion:	in	std_logic_vector(5 downto 0);
		
		--Salida:
		resultado:	out	std_logic_vector(3 downto 0)
	);
end ALU;

architecture Behavioral of ALU is
--Señales intermedias
signal calculo:	  std_logic_vector(3 downto 0);
signal comparacion: std_logic_vector(3 downto 0);

begin


--ALU: process (calculo, operacion, comparacion)
--begin

   with operacion select
      calculo <= (numero1 or numero2)  when "111110",
                 (numero1 and numero2) when "111101",
					  (numero1 + numero2)   when "111011",
					  (numero1 - numero2)	when "110111",
					  comparacion			   when "011111",
                 "0000" when others;
	
--   calculo <= (numero1 or numero2)  when operacion = "111110" else
--              (numero1 and numero2) when operacion = "111101" else
--				  (numero1 + numero2)   when operacion = "111011" else
--				  (numero1 - numero2)   when operacion = "110111" else
--				  comparacion           when operacion = "011111" else
--              "0000";

CMP: process (comparacion)
begin
 
	if numero1 > numero2 then
      comparacion <= numero1;
   elsif numero1 < numero2 then
      comparacion <= numero2;
   else
      comparacion <= "0001";
   end if;	

--resultado <= calculo;

end process CMP;
	
resultado <= calculo;
	
end Behavioral;