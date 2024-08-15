library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity RNG_mod is
  port(clk, en : in std_logic;
       result : out integer range 0 to 7
   );
end RNG_mod;

architecture structure of RNG_mod is

component RNG is
  port(seed : in std_logic_vector(63 downto 0);
       clk, sel : in std_logic;
       rng_out : out std_logic_vector(63 downto 0)
   );
end component;

component D_FF_en is 
  port(Qin, Qin2 : in integer range 0 to 7;
       clk, en : in std_logic;
       Qout : out integer range 0 to 7);
end component;
  
signal seed : std_logic_vector(63 downto 0) := "0000101100100110101011011010111010100010101010001110111010111001";
signal sel1 : std_logic;
signal my_RNG_output, temp : std_logic_vector(63 downto 0);
signal ans1, ans2, reg_out : integer range 0 to 7;

begin
  sel1 <= '0', '1' after 100 ns;
  RNG_0 : RNG port map (seed => seed, clk => clk, sel => sel1, rng_out => my_RNG_output);
  ans2 <= conv_integer(my_RNG_output) mod 6;
  reg_0 : D_FF_en port map (Qin => ans1, Qin2 => ans2, clk => clk, en => en, Qout => reg_out);
  temp <= seed;
 process(seed)
  begin
   result <= reg_out;
   seed <= my_RNG_output+1;
   ans1 <= reg_out;

 end process;

end structure;
