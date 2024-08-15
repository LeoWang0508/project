library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity Counter is 
  port  (reset1, enable1 : in std_logic;
         count1 : in std_logic_vector(4 downto 0);
         complete : out std_logic;
         count2 : out std_logic_vector(4 downto 0));
  end Counter;
architecture behavior of Counter is
 
 begin 
 process (reset1, enable1, count1)
   begin 
     if (reset1='0' and enable1='1') then
        count2 <= count1 + 1;
     end if;
     if (count1 = "00011") then
       complete <= '1';
     end if;
   end process;

 end behavior;