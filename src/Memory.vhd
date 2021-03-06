----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Kartik Patel
-- 
-- Create Date:    00:37:57 10/01/2014 
-- Design Name: 
-- Module Name:    Memory - Behavioral 
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
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Memory is
    Port ( MemWrite : in  STD_LOGIC;
			  MemRead : in STD_LOGIC;
           Addr : in  STD_LOGIC_VECTOR (15 downto 0);
           Wd : in  STD_LOGIC_VECTOR (15 downto 0);
           RdOut : out  STD_LOGIC_VECTOR (15 downto 0);
			  CLK : in STD_LOGIC
			);
end Memory;

architecture Behavioral of Memory is
type registerFile is array(0 to 65535) of STD_LOGIC_VECTOR (15 downto 0); --TODO: Integer length? 2147483648 == 2^31 != 2^32 -1
signal registers : registerFile := (others => (others => '0'));
begin
	read: process(CLK)
	begin
		if rising_edge(CLK) then
				if MemRead = '1' and MemWrite = '1' then
					RdOut <= Wd;
					registers(to_integer(unsigned(Addr(15 downto 0)))) <= Wd;
				elsif MemWrite = '1' then
					registers(to_integer(unsigned(Addr(15 downto 0)))) <= Wd;
				elsif MemRead = '1' then
					RdOut <= registers(to_integer(unsigned(Addr(15 downto 0))));
				end if;
		end if;
	end process;
end Behavioral;