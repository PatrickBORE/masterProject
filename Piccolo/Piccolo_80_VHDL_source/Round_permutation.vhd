----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 02.07.2018 21:10:08
-- Design Name: Piccolo's Round Permutation
-- Module Name: Round_permutation - Behavioral
-- Project Name: Piccolo
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

entity Round_permutation is
    Port ( i : in STD_LOGIC_VECTOR (63 downto 0);
           o : out STD_LOGIC_VECTOR (63 downto 0));
end Round_permutation;

architecture Behavioral of Round_permutation is

begin -- simple reorganisation of the bits order

o(7 downto 0)<=i(23 downto 16);
o(15 downto 8)<=i(63 downto 56);
o(23 downto 16)<=i(39 downto 32);
o(31 downto 24)<=i(15 downto 8);
o(39 downto 32)<=i(55 downto 48);
o(47 downto 40)<=i(31 downto 24);
o(55 downto 48)<=i(7 downto 0);
o(63 downto 56)<=i(47 downto 40);

end Behavioral;
