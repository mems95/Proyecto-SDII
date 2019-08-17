Library ieee;
use ieee.std_logic_1164.all;

entity controller2 is
	Port(Resetn, clock: in std_logic;
		VaciaCola, WenCola, Cont2s: in std_logic;
		En2s, Ld2s, selC, enMod, enMost, selMost, EnCont, EnTurn: out std_logic;
		estate:	out std_logic_vector(2 downTo 0)
	);
end controller2;

Architecture sol of controller2 is
	type estado is (A, B, C, D, E, F, G, H);
	signal y: estado;
begin
	--mss estados
	Process(Resetn, clock)
	begin
		if Resetn = '0' then y <= A; 
		elsif clock'event and clock = '1' then
			case y is
				when A => if VaciaCola = '0' then y<= B; end if;
				when B => if WenCola = '0' then y<=C; end if;
				when C => y <= D;
				when D => y <= E;
				when E => if cont2s = '0' then y<= F; end if;
				when F => y <= G;
				when G => if cont2s = '0' then y <= H; end if;
				when H => y <= A;
			end case;
		end if;
	end process;
	--mss Salidas
	
	Process(Resetn, clock)
	begin
		En2s<='0'; Ld2s<='0'; selC<='0'; enMod<='0'; enMost<='0'; selMost<='0';
		EnCont<='0'; EnTurn<='0'; estate <= "000";
		case y is
			when A => En2s <= '1'; Ld2s <= '1'; estate <= "000";
			when B => estate <= "001";
			when C => selC <= '1'; estate <= "010";
			when D => enMod <= '1'; selC <= '1'; estate <= "011";
			when E => enMost <= '1'; en2s <= '1'; estate <= "100";
			when F => en2s <= '1'; ld2s <= '1'; estate <= "101";
			when G => enMost <= '1'; selMost <= '1'; en2s <= '1'; estate <= "110";
			when H => Encont <= '1'; EnTurn <= '1'; estate <= "111";
		end case;
	end process;
end sol;