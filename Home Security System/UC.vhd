library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;
--codul organigramei (UC)
entity sistem_casa is
	port (SENZOR: in STD_LOGIC_VECTOR (4 downto 0);	 -- sistemul de senzori, fiecarui bit ii corespunde un senzor in aceasta ordine: U.G1.G2.M1.M2 ; if Senzor="10000", inseamna ca senzorul de la usa este activ 
		PIN: in STD_LOGIC_VECTOR (15 downto 0);
		CLK, RST,T15: in STD_LOGIC;	 
				  EN15:inout std_logic;
		SEL: in STD_LOGIC_VECTOR (1 downto 0);
		buton_confirmare, buton_start, evaluare_pin, buton_dezactivare,buton_pornire: in std_logic;
	    ALARMA: out STD_LOGIC);
end sistem_casa; 	  

architecture functionare of sistem_casa is
type STARE_T is (STARE_INITIALA, START, INTRODUCERE_PIN, CONFIRMARE_PIN, MENIU, ACTIVARE_SISTEM_ACASA, ACTIVARE_SISTEM_PLECAT);	--starile din organigrama
signal STARE:STARE_T:=STARE_INITIALA;
signal NXSTARE:STARE_T:=STARE_INITIALA;
begin
	ACTUALIZEAZA_STARE: process (RST, CLK,STARE)	--primul proces 
	begin
		if (RST='1') then
			STARE<=STARE_INITIALA;
		elsif (CLK'EVENT and CLK='1') then
			STARE <= NXSTARE;
		end if;
		end process;	  
		
TRANZITII: process (STARE, SENZOR, SEL)	   --procesul de tranzitie intre stari
begin
	case STARE is
		when STARE_INITIALA => if buton_pornire='1' then 
			 NXSTARE <= START;	 
		 else
			 NXSTARE <=STARE_INITIALA;
		end if;		  
		
		when START => if buton_start='1' then
			NXSTARE <= INTRODUCERE_PIN;
		else
			NXSTARE <= START;
		end if;
		when INTRODUCERE_PIN => if buton_confirmare='1' then NXSTARE<= CONFIRMARE_PIN ;
		else  NXSTARE<= INTRODUCERE_PIN;  
		end if;
		when CONFIRMARE_PIN => if evaluare_pin ='1' then
			NXSTARE <= MENIU;
		else
			NXSTARE <= START;
		end if;	
		when MENIU => if (SEL = "00" or SEL = "11") then NXSTARE <= START; --modul inactiv sau de iesire
		elsif SEL = "10" then 
			NXSTARE <= ACTIVARE_SISTEM_ACASA;
		elsif SEL = "01" then
			NXSTARE <= ACTIVARE_SISTEM_PLECAT;	  			 
		end if; 
		when ACTIVARE_SISTEM_ACASA=> 
			if ((SENZOR=not"00000") or (SENZOR=not"00001") or (SENZOR=not"00011")) then 	
				ALARMA <= '1';
			end if;
			if buton_dezactivare='1' then 	NXSTARE <=START;
				end if;
		when ACTIVARE_SISTEM_PLECAT=> 
		if SENZOR = not"00000" then
			EN15 <= '1'; 
		elsif T15 = '1' then 
			ALARMA <='1';
			end if;			   
		if buton_dezactivare='1' then 	NXSTARE <=START;
				end if;
		when others => 
	end case;
	end process;
end functionare;	