library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity MAC is
  port(A, B : in std_logic_vector(7 downto 0); 
       input_valid,clk : in bit;
       C : out std_logic_vector(15 downto 0);
       output_valid : out bit);
  end MAC;

architecture dataflow of MAC is 
 
 component D_FF
  port  (Qin, clk : in bit;
         Qout : out bit);
 end component;
 
 component D_FF_k
  generic(k : integer := 7);
  port(Qin : in std_logic_vector(k downto 0);
       clk : in bit;
       Qout : out std_logic_vector(k downto 0));
 end component;


 signal Q1, Q2 : std_logic_vector(7 downto 0);
 signal v1, v2, v3 : bit;
 signal Q3, Q4 : std_logic_vector(15 downto 0);
 signal Q5 : std_logic_vector(15 downto 0) := "0000000000000000";
 signal en1 : bit := '1';
 
 begin
 G1 : for K in 0 to 2 generate
 G2 : if k = 0 generate
	  reg_1: D_FF_k generic map(7) port map (A,clk,Q1);
	  reg_2: D_FF_k generic map(7) port map (B,clk,Q2);
	  reg_3: D_FF port map (input_valid,clk,v1);
	 end generate;
	 
 G3 : if k = 1 generate
	  reg_4: D_FF_k generic map(15) port map ((Q1*Q2),clk,Q3);
	  reg_5: D_FF port map (v1,clk,v2); 
	 end generate;
 G4 : if k = 2 generate	  
	  process(v2)
	   begin
	    if v2 = '1' then
	     Q4 <= Q3 + Q5;
	    else
	     Q4 <= Q5;
	    end if;
	   end process;
	  reg_6: D_FF_k generic map(15) port map (Q4,clk,Q5);
	  reg_7: D_FF port map (v2,clk,v3);
	 end generate;
 
  C <= Q5;
  output_valid <= v3;
 end generate;
 
 end dataflow;