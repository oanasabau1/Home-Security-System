library IEEE;
use IEEE.STD_LOGIC_1164.all; 
use STD_LOGIC_UNSIGNED.all;

entity Numarator_15 is
	port (CLK, RST, EN15: in STD_LOGIC;
	T15: out STD_LOGIC;
	Q: inout STD_LOGIC_VECTOR (3 downto 0));
end Numarator_15;

architecture arch_num of Numarator_15 is 
signal counter : integer :=0;
signal clk_div : std_logic;
begin
	process(CLK, RST, EN15)
	begin
		if RST='1' then counter<=0;
		elsif (CLK'EVENT and CLK='1' AND EN15='1') then
			if counter <=49999999 then
				counter <=counter+1;
			else
				counter<=0;	 
				clk_div<=not clk_div;
			end if;
			if counter =49999999 then
				T15 <='1';
				end if;
		end if;
		end process;
end arch_num;
	