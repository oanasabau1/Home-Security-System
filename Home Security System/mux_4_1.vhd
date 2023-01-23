library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity mux_4_1 is
 port(A,B,C,D : in STD_LOGIC;
     Sel: in STD_LOGIC_VECTOR (1 downto 0);
     Z: out STD_LOGIC );
end mux_4_1;
 
architecture behavioral of mux_4_1 is
begin
process (A,B,C,D,Sel) is
begin
  if (Sel="00") then
      Z <= A;
  elsif (Sel="01") then
      Z <= B;
  elsif (Sel="10") then
      Z <= C;
  else
      Z <= D;
  end if;
end process;
end behavioral;
