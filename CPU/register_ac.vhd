library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_ac is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ld_ac : in STD_LOGIC;
           alu_out : in STD_LOGIC_VECTOR (7 downto 0);
           ac_out : out STD_LOGIC_VECTOR (7 downto 0));
end register_ac;

architecture Behavioral of register_ac is
    signal ac_reg : STD_LOGIC_VECTOR (7 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
            ac_reg <= (others => '0');
        elsif rising_edge(clk) then
            if ld_ac = '1' then
                ac_reg <= alu_out;
            end if;
        end if;
    end process;
    ac_out <= ac_reg;
end Behavioral;
