library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity ULA is 
  generic(n:integer := 8);
  port(
      in_a,in_b : in std_logic_vector(n-1 downto 0);
      alu_out    : out std_logic_vector(n-1 downto 0);
      opcode : in std_logic_vector(2 downto 0);
      a_is_zero : out std_logic
    );     
end ULA;

architecture Behavioral of ULA is
signal result: std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_add:  std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_and:  std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_hlt:  std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_skz:  std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_lda : std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_xor : std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_sto : std_logic_vector(N-1 downto 0) := (others =>'0');
signal s_jmp : std_logic_vector(N-1 downto 0) := (others =>'0');

begin

with opcode select

result <= s_hlt when "000",
		s_skz when "001",
	 	s_add when "010",
		s_and when "011",
   	        s_xor when "100",
		s_lda when "101",
		s_sto when "110",
		s_jmp when "111",
          	result  when others;
s_hlt <= in_a;
s_and  <= in_a and in_b;
s_lda <= in_b;
s_sto <= in_a;
s_add <= in_a + in_b;
s_and <= in_a and in_b;
s_skz <= in_a;
s_jmp <= in_a;


alu_out <= result;


end Behavioral;
  
   
    


  

