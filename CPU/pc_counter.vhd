
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-----------
entity pc_counter is
    Port (
        clk     : in  STD_LOGIC;
        rst     : in  STD_LOGIC;
        ld_pc   : in  STD_LOGIC;
        inc_pc  : in  STD_LOGIC;
        ir_addr : in  STD_LOGIC_VECTOR (4 downto 0);
        pc_addr : out STD_LOGIC_VECTOR (4 downto 0)
    );
end pc_counter;

architecture Behavioral of pc_counter is
    signal pc_reg : STD_LOGIC_VECTOR (4 downto 0) := (others => '0');
begin
    process (clk, rst)
    begin
        if rst = '1' then
            -- Reset do contador de programa
            pc_reg <= (others => '0');
        elsif rising_edge(clk) then
            if ld_pc = '1' then
                -- Carregar o PC com o valor de ir_addr
                pc_reg <= ir_addr;
            elsif inc_pc = '1' then
                -- Incrementar o PC
                pc_reg <= pc_reg + 1;
            end if;
        end if;
    end process;

    -- Saída do PC
    pc_addr <= pc_reg;

end Behavioral;