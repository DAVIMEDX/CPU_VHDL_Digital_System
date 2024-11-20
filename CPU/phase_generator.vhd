library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity phase_generator is
    Port (
        clk    : in  STD_LOGIC;
        rst    : in  STD_LOGIC;
        phase  : out STD_LOGIC_VECTOR (3 downto 0)  -- Ajuste o tamanho conforme o número de fases desejadas
    );
end phase_generator;

architecture Behavioral of phase_generator is
    signal counter : STD_LOGIC_VECTOR (3 downto 0) := (others => '0'); -- Ajuste o tamanho conforme o número de fases desejadas
begin
    process (clk, rst)
    begin
        if rst = '1' then
            -- Reset do contador
            counter <= (others => '0');
        elsif rising_edge(clk) then
            -- Incrementar o contador
            counter <= counter + 1;
        end if;
    end process;

    -- Saída de fase
    phase <= counter;

end Behavioral;



  
