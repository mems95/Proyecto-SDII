library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity conv_bin_BCD is
    PORT(
        num_bin: in  STD_LOGIC_VECTOR(3 downto 0);
        U, D: out STD_LOGIC_VECTOR(3 downto 0) --8
    );
end conv_bin_BCD;
 
architecture Behavioral of conv_bin_BCD is
begin
    proceso_bcd: process(num_bin)
        variable z: STD_LOGIC_VECTOR(11 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(6 downto 3) := num_bin;
        for i in 0 to 0 loop
            -- Unidades (4 bits).
            if z(7 downto 4) > 4 then
                z(7 downto 4) := z(7 downto 4) + 3;
            end if;
            -- Decenas (4 bits).
            if z(11 downto 8) > 4 then
                z(11 downto 8) := z(11 downto 8) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(11 downto 1) := z(10 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        D <= z(11 downTo 8);
		  U <= z(7 downTo 4);
    end process;
end Behavioral;