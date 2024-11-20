----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12.09.2024 20:49:55
-- Design Name: 
-- Module Name: RISC - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;



entity RISC is
    Port(
        clk : in std_logic;
        rst : in std_logic;
        data: inout std_logic_vector(7 downto 0)
        );
end RISC;

architecture Behavioral of RISC is
signal s_opcode:  std_logic_vector(2 downto 0);
signal s_clk: std_logic;
signal s_data: std_logic_vector(7 downto 0);


--Memória
signal s_addr: std_logic_vector(4 downto 0);
signal s_wr: std_logic;
signal s_rd: std_logic;



--ULA
signal s_in_a: std_logic_vector(8-1 downto 0);
signal s_in_b:  std_logic_vector(8-1 downto 0);
signal s_alu_out:  std_logic_vector(8-1 downto 0);
signal s_a_is_zero:  std_logic;


--Resgister Ir

signal s_rst:  std_logic;
signal s_ld_ir:  std_logic;
signal s_ir_addr:  std_logic_vector(4 downto 0);


--FSM
signal s_phase : std_logic_vector(3 downto 0);
signal s_sel : std_logic;
signal s_halt : std_logic;
signal s_inc_pc : std_logic;
signal s_ld_ac : std_logic;
signal s_ld_pc : std_logic;


--MUX_adress
signal s_pc_addr : std_logic_vector(4 downto 0);

begin


Memoria: entity work.Memoria
    Port map (
        addr => s_addr,
        clk => s_clk ,
        wr  => s_wr  ,
        rd  => s_rd  ,
        data => s_data
    );

ULA: entity work.ULA
    Port map (
        in_a => s_in_a,
        in_b => s_in_b,
        alu_out => s_alu_out,    
        opcode => s_opcode,
        a_is_zero => s_a_is_zero
    );
    
Register_Ir: entity work.register_ir 
    Port map ( clk => s_clk,
           rst => s_rst,
           ld_ir => s_ld_ir,
           data => s_data,
           ir_addr => s_ir_addr,
           opcode => s_opcode
           );
           
           
Driver: entity work.driver 
    Port map( 
           data_in => s_alu_out,
           data_en => s_ld_ir,
           data_out => s_data
           );
FSM: entity work.FSM
    Port map(
              clk => s_clk,
              rst  => s_rst,
              zero  => s_a_is_zero,
              Phase  => s_phase,
              Opcode => s_opcode  ,
              sel    => s_sel ,
              rd     => s_rd  ,
              ld_ir  => s_ld_ir  ,
              halt   => s_halt ,
              inc_pc => s_inc_pc ,
              ld_ac  => s_ld_ac  ,
              wr     => s_wr  ,
              ld_pc  => s_ld_pc
            );
           
Mux_adress: entity work.andress_mux
        Port Map(
              clk => s_clk,   
              ir_addr => s_ir_addr,               
              pc_addr => s_pc_addr,            
              sel => s_sel,  
              addr => s_addr     
             );
                 
                 
Contador_PC: entity work.pc_counter
        Port Map(
                 clk => s_clk,
                 rst => s_rst,
                 ld_pc => s_ld_pc,
                 inc_pc => s_inc_pc,
                 ir_addr => s_ir_addr,
                 pc_addr => s_pc_addr
                );

Gerador_de_Fase: entity work.phase_generator
        Port Map(
                 clk   => s_clk,
                 rst   => s_rst,
                 phase => s_phase
        
                 );
Registrador_AC: entity work.register_ac
        Port Map(
                clk => s_clk,
                rst => s_rst,
                ld_ac => s_ld_ac,
                alu_out => s_alu_out,
                ac_out => s_in_a
                );
                
 data <= s_data;
        
end Behavioral;
