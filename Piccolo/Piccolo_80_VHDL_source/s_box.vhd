----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 30.06.2018 02:18:25
-- Design Name: Piccolo 4-bit bijective S-box
-- Module Name: s_box - Behavioral
-- Project Name: Piccolo
-- Target Devices: 
-- Tool Versions: 
-- Description: Lookup table
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

entity s_box is
    Port ( input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0));
end s_box;

architecture Behavioral of s_box is

signal a : std_logic;
signal b : std_logic;
signal c : std_logic;
signal d : std_logic;
signal o0 : std_logic;
signal o1 : std_logic;
signal o2 : std_logic;
signal o3 : std_logic;

begin

--logic gate implementin the lookup table as presented in the piccolo description
a<= input(2) nor input(3);
o3 <= input(0) xor a;
b <= input(1) nor input(2);
o2 <= b xor input(3);
c <= input(1) nor o3;
o1 <= c xnor input(2);
d <= o2 nor o3;
o0 <= d xor input(1);

output(0) <= o0;
output(1) <= o1;
output(2) <= o2;
output(3) <= o3;

end Behavioral;
