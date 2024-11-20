library ieee;
use ieee.std_logic_1164.all;

entity driver is
	generic(n:integer := 8);
	port(
		data_in : in std_logic_vector(n-1 downto 0);
		data_out: inout std_logic_vector(n-1 downto 0);
		data_en : in std_logic
	);
end driver;
	
architecture behavioral of driver is
begin
    process(data_en, data_in)
    begin
        if (data_en = '1') then
            data_out <= data_in;
        else
            data_out <= (others => 'Z');  -- Alta impedância
        end if;
    end process;
end behavioral;