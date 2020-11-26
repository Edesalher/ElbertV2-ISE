----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:32:09 11/24/2020 
-- Design Name: 	 LCD control
-- Module Name:    lcd_control - Behavioral 
-- Project Name: 	 LCD control
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity lcd_control is
	port (
    clk    : in  std_logic;
    lcd_e  : out std_logic;
    lcd_rs : out std_logic;
    lcd_rw : out std_logic;
    lcd_db : out std_logic_vector(7 downto 4));

end lcd_control;

architecture Behavioral of lcd_control is
	--
	signal timer : natural range 0 to 100000000 := 0;
	signal switch_lines : std_logic := '0';
	signal line1 : std_logic_vector(127 downto 0);
	signal line2 : std_logic_vector(127 downto 0);

	-- component generics
	constant CLK_PERIOD_NS : positive := 10;  -- 100 Mhz

	-- component ports
	signal rst          : std_logic;
	signal line1_buffer : std_logic_vector(127 downto 0);
	signal line2_buffer : std_logic_vector(127 downto 0);

begin

	-- component instantiation
	DUT : entity work.lcd_config
	 generic map (
		CLK_PERIOD_NS => CLK_PERIOD_NS)
	 port map (
		clk          => clk,
		rst          => rst,
		lcd_e        => lcd_e,
		lcd_rs       => lcd_rs,
		lcd_rw       => lcd_rw,
		lcd_db       => lcd_db,
		line1_buffer => line1_buffer,
		line2_buffer => line2_buffer);

	rst <= '0';

	-- see the display's datasheet for the character map
	line1(127 downto 120) <= X"4E";  -- N
	line1(119 downto 112) <= X"75";  -- u
	line1(111 downto 104) <= X"6D";  -- m
	line1(103 downto 96)  <= X"61";  -- a
	line1(95 downto 88)   <= X"74";  -- t
	line1(87 downto 80)   <= X"6F";  -- o
	line1(79 downto 72)   <= X"20";  -- space
	line1(71 downto 64)   <= X"4C";  -- L
	line1(63 downto 56)   <= X"61";  -- a
	line1(55 downto 48)   <= X"62";  -- b
	line1(47 downto 40)   <= X"73";  -- s
	line1(39 downto 32)   <= X"20";  -- space
	line1(31 downto 24)   <= X"46";  -- F
	line1(23 downto 16)   <= X"50";  -- P
	line1(15 downto 8)    <= X"47";  -- G
	line1(7 downto 0)     <= X"41";  -- A

	line2(127 downto 120) <= X"56";  -- V
	line2(119 downto 112) <= X"48";  -- H
	line2(111 downto 104) <= X"44";  -- D
	line2(103 downto 96)  <= X"4C";  -- L
	line2(95 downto 88)   <= X"20";  -- space
	line2(87 downto 80)   <= X"4C";  -- L
	line2(79 downto 72)   <= X"43";  -- C
	line2(71 downto 64)   <= X"44";  -- D
	line2(63 downto 56)   <= X"20";  -- space
	line2(55 downto 48)   <= X"45";  -- E
	line2(47 downto 40)   <= X"78";  -- x
	line2(39 downto 32)   <= X"61";  -- a
	line2(31 downto 24)   <= X"6D";  -- m
	line2(23 downto 16)   <= X"70";  -- p
	line2(15 downto 8)    <= X"6C";  -- l
	line2(7 downto 0)     <= X"65";  -- e

	line1_buffer <= line2 when switch_lines = '1' else line1;
	line2_buffer <= line1 when switch_lines = '1' else line2;

	-- switch lines every second
	process(clk)
	begin
	 if rising_edge(clk) then
		if timer = 0 then
		  timer <= 100000000;
		  switch_lines <= not switch_lines;
		else
		  timer <= timer - 1;
		end if;
	 end if;
	 
	end process;

end Behavioral;

