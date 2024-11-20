----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2024
-- Design Name: RISC Processor
-- Module Name: tb_risc - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Testbench for the RISC processor
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

entity tb_risc is
end tb_risc;

architecture Behavioral of tb_risc is

    -- Component declaration for the RISC
    component RISC   
        Port(
            clk : in std_logic;
            rst : in std_logic;
            data: inout std_logic_vector(7 downto 0)
        );
    end component;

    -- Signals for the testbench
    signal clk : std_logic := '0';
    signal rst : std_logic := '0';
    signal data : std_logic_vector(7 downto 0) := (others => 'Z');
    signal data_drv : std_logic_vector(7 downto 0);
    signal drive_data : std_logic := '0';  -- Control to drive 'data' signal from testbench

    -- Clock generation
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the RISC processor
    DUT: entity work.RISC
        port map (
            clk => clk,
            rst => rst,
            data => data
        );

    -- Clock process
    ClockGen: process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Test process (stimuli)
    stim_proc: process
    begin
        -- Reset the processor
        rst <= '1';
        drive_data <= '1';  -- Testbench drives the data signal
        data_drv <= "11100001";
        wait for clk_period * 2;

        rst <= '0';
        wait for clk_period * 10;

        -- Add further test cases here
        -- Example: Loading data into memory, performing ALU operations, etc.
        
        -- Finish simulation
        wait;
    end process;

    -- Drive 'data' signal conditionally (for bidirectional use)
    data <= data_drv when drive_data = '1' else (others => 'Z');

end Behavioral;
