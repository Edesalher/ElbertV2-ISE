----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:48:22 03/12/2019 
-- Design Name: 
-- Module Name:    LEDs - Behavioral 
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

entity LEDs is
    Port ( push_button : in  STD_LOGIC;
           Led : out  STD_LOGIC);
end LEDs;

architecture Behavioral of LEDs is

begin

LED_ONOFF: process (push_button)
begin
   
   if push_button='0' then
      Led<='1';
   else
      Led<='0';
   end if;
			
end process LED_ONOFF;
			

end Behavioral;

