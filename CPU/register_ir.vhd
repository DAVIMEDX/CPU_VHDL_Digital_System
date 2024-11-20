library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity register_ir is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           ld_ir : in STD_LOGIC;
           data : inout STD_LOGIC_VECTOR (7 downto 0); -- Aumentei o tamanho do vetor para incluir o opcode
           ir_addr : out STD_LOGIC_VECTOR (4 downto 0);
           opcode : out STD_LOGIC_VECTOR (2 downto 0)); -- Saída para o opcode
end register_ir;

architecture Behavioral of register_ir is
    signal s_d : std_logic_vector(7 downto 0);
begin
    process(clk, rst)
    begin
        if rst = '1' then
             s_d<= (others => '0');
        elsif rising_edge(clk) then
            if ld_ir = '1' then
                s_d <= data;
            end if;
        end if;
    end process;
    ir_addr <= s_d(4 downto 0); -- Parte do registrador para o endereço
    opcode <= s_d(7 downto 5); -- Parte do registrador para o opcode
end Behavioral;
