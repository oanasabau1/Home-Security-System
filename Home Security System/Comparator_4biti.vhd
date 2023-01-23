library IEEE;
use IEEE.STD_LOGIC_1164.all;  
use STD_LOGIC_UNSIGNED.all;

entity Comparator_16biti is
	port (A, B: in STD_LOGIC_VECTOR (15 downto 0);
	Y: out STD_LOGIC);
end Comparator_16biti; 

architecture arch_comp of Comparator_16biti is
signal S: STD_LOGIC_VECTOR (15 downto 0);
begin  
    S(0) <=	A(0) xnor B(0);
	S(1) <=	A(1) xnor B(1);
	S(2) <=	A(2) xnor B(2);
	S(3) <=	A(3) xnor B(3);
	S(4) <=	A(4) xnor B(4);
	S(5) <=	A(5) xnor B(5);
	S(6) <=	A(6) xnor B(6);
	S(7) <=	A(7) xnor B(7);
	S(8) <=	A(8) xnor B(8);
	S(9) <=	A(9) xnor B(9);
	S(10) <= A(10) xnor B(10);
	S(11) <=A(11) xnor B(11);
	S(12) <=A(12) xnor B(12);
	S(13) <=A(13) xnor B(13);
	S(14) <=A(14) xnor B(14);
	S(15) <=A(15) xnor B(15);
	Y<=(S(3) and S(15) and S(14) and S(13) and S(12) and S(11) and S(10) and S(9) and S(8) and S(7) and S(6) and S(5) and S(4) and S(3) and S(2) and S(1) and S(0));
end architecture;
