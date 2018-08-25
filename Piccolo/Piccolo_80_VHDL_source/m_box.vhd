----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.06.2018 05:51:44
-- Design Name: 
-- Module Name: m_box - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity m_box is
    Port (  s0 : in STD_LOGIC_VECTOR (3 downto 0);
            s1 : in STD_LOGIC_VECTOR (3 downto 0);
            s2 : in STD_LOGIC_VECTOR (3 downto 0);
            s3 : in STD_LOGIC_VECTOR (3 downto 0);
            o0 : out STD_LOGIC_VECTOR (3 downto 0);
            o1 : out STD_LOGIC_VECTOR (3 downto 0);
            o2 : out STD_LOGIC_VECTOR (3 downto 0);
            o3 : out STD_LOGIC_VECTOR (3 downto 0));
end m_box;

architecture Behavioral of m_box is

signal t_0 : STD_LOGIC_VECTOR (4 downto 0);
signal t_1 : STD_LOGIC_VECTOR (4 downto 0);
signal t_2 : STD_LOGIC_VECTOR (4 downto 0);
signal t_3 : STD_LOGIC_VECTOR (4 downto 0);
signal d_0 : STD_LOGIC_VECTOR (4 downto 0);
signal d_1 : STD_LOGIC_VECTOR (4 downto 0);
signal d_2 : STD_LOGIC_VECTOR (4 downto 0);
signal d_3 : STD_LOGIC_VECTOR (4 downto 0);
signal sum_0 : STD_LOGIC_VECTOR (4 downto 0);
signal sum_1 : STD_LOGIC_VECTOR (4 downto 0);
signal sum_2 : STD_LOGIC_VECTOR (4 downto 0);
signal sum_3 : STD_LOGIC_VECTOR (4 downto 0);

begin
t_0 <= (s0 & '0') xor ('0' & s0);
t_1 <= (s1 & '0') xor ('0' & s1);
t_2 <= (s2 & '0') xor ('0' & s2);
t_3 <= (s3 & '0') xor ('0' & s3);

d_0 <= s0 & '0';
d_1 <= s1 & '0';
d_2 <= s2 & '0';
d_3 <= s3 & '0';

sum_0 <= d_0 xor t_1 xor ('0' & s2) xor ('0' & s3);
sum_1 <= ('0' & s0) xor d_1 xor t_2 xor ('0' & s3);
sum_2 <= ('0' & s0) xor ('0' & s1) xor d_2 xor t_3;
sum_3 <= t_0 xor ('0' & s1) xor ('0' & s2) xor d_3;

o0 <= sum_0(3 downto 0) when sum_0(4) = '0' else
      sum_0(3 downto 0) xor "0011";
o1 <= sum_1(3 downto 0) when sum_1(4) = '0' else
      sum_1(3 downto 0) xor "0011";
o2 <= sum_2(3 downto 0) when sum_2(4) = '0' else
      sum_2(3 downto 0) xor "0011";
o3 <= sum_3(3 downto 0) when sum_3(4) = '0' else
      sum_3(3 downto 0) xor "0011";

end Behavioral;
