library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity FSM is
    Port (
        clk:      in std_logic;
        rst:      in std_logic;
        zero:     in std_logic;
        Phase:    in std_logic_vector(3 downto 0);
        Opcode:   in std_logic_vector(2 downto 0);
        sel:      out std_logic;
        rd:       out std_logic;
        ld_ir:    out std_logic;
        halt:     out std_logic;
        inc_pc:   out std_logic;
        ld_ac:    out std_logic;
        wr:       out std_logic;
        ld_pc:    out std_logic
    );
end FSM;

architecture Behavioral of FSM is

    -- Estados
    type Estado is (zero_o, inst_addr, inst_fetch, inst_load, idle, op_addr, op_fetch, alu_op, store);

    -- Estado atual e próximo
    signal atual_std, proximo_std: Estado;
    signal instrucao: std_logic_vector(2 downto 0);

begin

    -- Processo para atualizar o estado atual
    process(clk, rst)
    begin 
        if rst = '1' then
            atual_std <= zero_o;
        elsif rising_edge(clk) then
            atual_std <= proximo_std;
        end if;
    end process;

    -- Processo para definir as saídas e o próximo estado
    process(atual_std, Opcode, zero)
    begin
        -- Inicializa os sinais de saída
        sel <= '0';
        rd <= '0';
        ld_ir <= '0';
        halt <= '0';
        inc_pc <= '0';
        ld_ac <= '0';
        ld_pc <= '0';
        wr <= '0';

        case atual_std is
            when zero_o =>
                proximo_std <= inst_addr;

            when inst_addr =>
                sel <= '1';
                proximo_std <= inst_fetch;

            when inst_fetch =>
                sel <= '1';
                rd <= '1';
                proximo_std <= inst_load;

            when inst_load =>
                sel <= '1';
                rd <= '1';
                ld_ir <= '1';
                proximo_std <= idle;

            when idle =>
                proximo_std <= op_addr;

            when op_addr =>
                sel <= '1';
                rd <= '1';
                ld_ir <= '1';
                if Opcode = "000" then  
                    halt <= '1';
                end if;
                inc_pc <= '1';
                proximo_std <= op_fetch;

            when op_fetch =>
                sel <= '0';
                if Opcode = "010" or Opcode = "011" or Opcode = "100" or Opcode = "101" then 
                    rd <= '1';
                end if;
                proximo_std <= alu_op;

            when alu_op =>
                if Opcode = "001" and zero = '1' then
                    inc_pc <= '1'; 
                end if;
                
                if Opcode = "111" then
                    ld_pc <= '1';  
                end if;
                
                if Opcode = "110" then
                    wr <= '1';  
                end if;

                proximo_std <= store;

            when store =>
                if Opcode = "010" or Opcode = "011" or Opcode = "100" or Opcode = "101" then
                    ld_ac <= '1';
                end if;
                
                if Opcode = "111" then
                    ld_pc <= '1';  
                end if;
                
                if Opcode = "110" then
                    wr <= '1';  
                end if;

                proximo_std <= inst_addr;

            when others =>
                proximo_std <= inst_addr;

        end case;
    end process;  

end Behavioral;
