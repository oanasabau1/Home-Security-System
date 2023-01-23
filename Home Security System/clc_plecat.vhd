library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clc_plecat is
	port (enable: in std_logic;
	SENZOR: in std_logic_vector (4 downto 0);
Y: out std_logic);
end clc_plecat;

architecture arch of clc_plecat is
begin
process (enable, SENZOR)
begin
if (enable='0') then
	Y<='0';
else
	if SENZOR= not "00000" then
	Y<='1';
end if;
end if;
end process;
end arch;