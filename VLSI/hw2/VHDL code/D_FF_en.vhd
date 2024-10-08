library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity D_FF_en is 
  generic(k : integer := 15);
  port(Qin, Qin2 : in std_logic_vector(k downto 0);
       clk, en : in bit;
       Qout : out std_logic_vector(k downto 0));
  end D_FF_en;
architecture behavior of D_FF_en is
 begin 
 process (Qin,clk,en)
   begin 
     if (clk'EVENT and clk='1' and en='1') then
        Qout <= Qin + Qin2;
     elsif (clk'EVENT and clk='1') then
        Qout <= Qin2;
     end if;
   end process;
  end behavior;