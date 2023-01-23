library IEEE;
use IEEE.std_logic_1164.all;

entity comparator_2bit is
port (en: in std_logic;
A,B: in std_logic_vector(1 downto 0) ;
 Y: out std_logic);
end comparator_2bit; 

architecture arch of comparator_2bit is
signal tmp1,tmp2: std_logic; 
begin 
process (en)
begin
	if (en='1') then
 tmp1 <= A(1) xnor B(1);
 tmp2 <= A(0) xnor B(0);
 Y <= tmp1 and tmp2;  
 else
	 Y<='0';
 end if;
 end process;
end arch;