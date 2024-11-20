----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2024 16:01:25
-- Design Name: 
-- Module Name: Memoria - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memoria is
generic (n: integer := 8;
         m: integer := 5);
    Port (
        addr  : in std_logic_vector(m-1 downto 0);
        clk   : in std_logic;
        wr    : in std_logic;
        rd    : in std_logic;
        data  : inout std_logic_vector(n-1 downto 0)
    );
end Memoria;

architecture Behavioral of Memoria is
    type memory_array is array (0 to 31) of std_logic_vector(7 downto 0);
    signal mem : memory_array := (others => (others => '0'));
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if wr = '1' then
                mem(to_integer(unsigned(addr))) <= data;
            elsif rd = '1' then
                data <= mem(to_integer(unsigned(addr)));
            end if;
        end if;
    end process;
end Behavioral;
