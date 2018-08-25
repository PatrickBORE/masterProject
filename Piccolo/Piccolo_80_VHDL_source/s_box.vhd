----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2018 02:18:25
-- Design Name: 
-- Module Name: s_box - Behavioral
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

entity s_box is
    Port ( sw : in STD_LOGIC_VECTOR (3 downto 0);
           led : out STD_LOGIC_VECTOR (3 downto 0));
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

a<= sw(2) nor sw(3);
o3 <= sw(0) xor a;
b <= sw(1) nor sw(2);
o2 <= b xor sw(3);
c <= sw(1) nor o3;
o1 <= c xnor sw(2);
d <= o2 nor o3;
o0 <= d xor sw(1);

led(0) <= o0;
led(1) <= o1;
led(2) <= o2;
led(3) <= o3;

end Behavioral;
