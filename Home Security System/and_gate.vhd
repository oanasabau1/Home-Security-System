library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity and_gate is
	port (A, B: in std_logic;
	Y: out std_logic);
end and_gate;

architecture data_flow of and_gate is
begin
	Y<=A and B;
end data_flow;

