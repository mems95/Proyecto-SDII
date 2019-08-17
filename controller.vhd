library ieee;
use ieee.std_logic_1164.all;

entity controller is
	Port(
		Resetn, clock: in std_logic;
		Start, modPress, Fin10Mod, TurnDisp, FullCola, ModCorrecto, EncCor: in std_logic;
		
		selAcum, enCont, enOrd, LdOrd, enTurn, LdTurn, enFn, LdFn, enM, WenCola, enCor, ldCor, encCola: out std_logic;
		estate : out std_logic_vector(3 downto 0)
	);
end controller;

Architecture sol of controller is
	type estado is (A, B, C, D, E, F, G, H, I);
	signal y: estado;
	
Begin
	-- mss estados
	Process(Resetn, clock)
	begin
		if Resetn = '0' then y <= A; 
		elsif clock'event and clock = '1' then
			case y is
				when A => if start = '1' then y <= B; end if;
				when B => if start = '0' then y <= C; end if;
				when C => if ModPress = '1' then y<= D; end if;
				when D => if ModPress = '0' then y<= E; end if;
				when E => if Fin10Mod = '1' then
								if TurnDisp = '0' then y <= A;
								elsif fullCola = '1' then y<= C;
								else y <= G; end if;
							elsif ModCorrecto = '1' then y <= F;
							else y<= C; end if;
				when F => y <= G;
				when G => y <= H;
				when H => y <= I;
				when I => if EnCCor = '0' then y <= C; end if;
			end case;
		end if;
	end process;
	
	-- mss salidas
	
	Process(Resetn, clock, encCor, modPress)
	begin
	selAcum<= '0'; enCont<= '0'; enOrd<= '0'; LdOrd<= '0'; enTurn<= '0'; ldCor <= '0'; encCola <= '0';
	LdTurn<= '0'; enFn<= '0'; enM <= '0'; LdFn<= '0'; WenCola<= '0'; enCor<= '0'; estate <= "0000";
	
	case y is
		when A => selAcum <= '1'; enCont <= '1';  encCola <= '1'; WenCola <= '1'; enOrd <= '1'; ldOrd <= '1'; enTurn <= '1'; LdTurn <= '1'; enFn <= '1'; ldFn <= '1';	estate <= "0000";
		when B => estate <= "0001";
		when C => estate <= "0010";
		when D => estate <= "0011";
					if modPress = '1' then  enM <= '1'; end if;
		when E => estate <= "0100";
		when F => enOrd <= '1'; estate <= "0101";
		when G => WenCola <= '1'; estate <= "0110";
		when H => enFn <= '1'; estate <= "0111";
		when I => enCor <= '1'; estate <= "1000";
					if encCor = '0' then enCor <= '1'; ldCor <= '1'; end if;
	end case;
	end process;
	
end sol;