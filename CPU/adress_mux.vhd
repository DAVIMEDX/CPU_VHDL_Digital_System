library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity andress_mux is
generic(
        WIDTH : integer := 5 -- Largura padro parametrizada de 5 bits
    );
    Port (
        clk     : in  std_logic; 
        ir_addr     : in  std_logic_vector(WIDTH-1 downto 0);           
        pc_addr     : in  std_logic_vector(WIDTH-1 downto 0);           
        sel     : in  std_logic; 
        addr : out std_logic_vector(WIDTH-1 downto 0)  
    );
end andress_mux;

architecture Behavioral of andress_mux is
begin
    process(ir_addr,pc_addr,sel,clk)
    begin
    if rising_edge(clk) then
        if (sel = '0') then 
            addr <= ir_addr;
        else    
            addr <= pc_addr;
        end if;
    end if;
    end process;
end Behavioral;
