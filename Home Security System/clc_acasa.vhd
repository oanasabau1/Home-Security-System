library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity clc_acasa is
	port (enable: in std_logic;
	SENZOR: in std_logic_vector(4 downto 0);
	Y: out std_logic);
end clc_acasa;

architecture arch of clc_acasa is
begin
	process (enable, SENZOR)
	begin
		if (enable='0')	then 
			Y<='0';
		else
			if ((SENZOR=not"00000") or (SENZOR=not"00001") or (SENZOR=not"00011")) then
				Y<='1';
			end if;
			end if;
		end process;
		end arch;
		