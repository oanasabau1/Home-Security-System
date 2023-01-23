library IEEE;
use IEEE.STD_LOGIC_1164.all;
use STD_LOGIC_UNSIGNED.all;

entity sistem is
	port (Senzor: in STD_LOGIC_VECTOR (4 downto 0);	 -- sistemul de senzori, fiecarui bit ii corespunde un senzor in aceasta ordine: U.G1.G2.M1.M2 ; if Senzor="10000", inseamna ca senzorul de la usa este activ 
	      PIN: in STD_LOGIC_VECTOR (15 downto 0);
	      SEL: in STD_LOGIC_VECTOR (1 downto 0); 
		  RST, CLK: in STD_LOGIC;
	      ALARM: out STD_LOGIC);
end sistem; 

architecture arch of sistem is	
--descriere structurala

component Numarator_15 is
port (signal CLK, RST, EN15: in STD_LOGIC;
	signal T15: out STD_LOGIC;
	signal Q: inout STD_LOGIC_VECTOR (3 downto 0)
	);
end component;	 

component Comparator_16biti is
	port (A, B: in STD_LOGIC_VECTOR (15 downto 0);
	Y: out STD_LOGIC);
end component; 	

component clc_acasa is
	port (enable: in std_logic;
	SENZOR: in std_logic_vector(4 downto 0);
	Y: out std_logic);
end component;

component clc_plecat is
	port (enable: in std_logic;
	SENZOR: in std_logic_vector(4 downto 0);
	Y: out std_logic);
end component; 

component comparator_2bit is
port (en: in std_logic;
A,B: in std_logic_vector(1 downto 0) ;
 Y: out std_logic);
end component;

component and_gate is
	port (A, B: in std_logic;
	Y: out std_logic);
end component;	  

component mux_4_1 is
 port(A,B,C,D : in STD_LOGIC;
     Sel: in STD_LOGIC_VECTOR (1 downto 0);
     Z: out STD_LOGIC );
end component;

signal Y, A1, A2, A3, A4, D1, D2, D3, D4, T: std_logic;
signal Q: std_logic_vector (15 downto 0) := "0010001110010111" ; --pin-ul memorat
signal r: std_logic_vector (3 downto 0);

 begin
u1: Comparator_16biti port map (PIN, Q, Y);	--determina daca pinul introdus este corect
u2: comparator_2bit port map (Y, SEL, "00", A1);  	--comparator de 2 biti pt modul inactiv; in acest fel vom determina la final daca se activeaza alarma
u3: comparator_2bit port map (Y, SEL, "10", A2);	  --comparator de 2 biti pt modul plecat; in acest fel vom determina la final daca se activeaza alarma
u4: comparator_2bit port map (Y, SEL, "01", A3);	  --comparator de 2 biti pt modul acasa; in acest fel vom determina la final daca se activeaza alarma
u5: comparator_2bit port map (Y, SEL, "11", A4); 	 --comparator de 2 biti pt modul iesire; in acest fel vom determina la final daca se activeaza alarma
u6: and_gate port map (A1, '0', D1);				 --dezactivarea alarmei pentru modul inactiv
u7: and_gate port map (A4, '0', D4);				  --dezactivarea alarmei pentru modul iesire
u8: clc_acasa port map (A3, SENZOR, D3);			  --interogare senzori pentru modul acasa  
u9: Numarator_15 port map (CLK, RST, A2, T, R);		  --pornirea numaratorului modulo 15 pentru modul plecat
u10: clc_plecat port map (T, SENZOR, D2);			   --interogare senzori pentru modul plecat
u11: mux_4_1 port map (D1, D2, D3, D4, SEL, ALARM);		--declansare alarma pentru modul selectat
end arch;

