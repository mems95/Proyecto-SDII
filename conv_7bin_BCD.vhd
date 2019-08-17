library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity conv_7bin_BCD is
    PORT(
        num_bin: in  STD_LOGIC_VECTOR(6 downto 0);
        U, D: out STD_LOGIC_VECTOR(3 downto 0) --8
    );
end conv_7bin_BCD;
 
architecture Behavioral of conv_7bin_BCD is
begin
    proceso_bcd: process(num_bin)
        variable z: STD_LOGIC_VECTOR(14 downto 0);
    begin
        -- Inicialización de datos en cero.
        z := (others => '0');
        -- Se realizan los primeros tres corrimientos.
        z(9 downto 3) := num_bin;
        for i in 0 to 3 loop
            -- Unidades (4 bits).
            if z(10 downto 7) > 4 then
                z(10 downto 7) := z(10 downto 7) + 3;
            end if;
            -- Decenas (4 bits).
            if z(14 downto 11) > 4 then
                z(14 downto 11) := z(14 downto 11) + 3;
            end if;
            -- Corrimiento a la izquierda.
            z(14 downto 1) := z(13 downto 0);
        end loop;
        -- Pasando datos de variable Z, correspondiente a BCD.
        D <= z(14 downTo 11);
		  U <= z(10 downTo 7);
    end process;
end Behavioral;