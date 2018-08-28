----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 30.06.2018 06:09:01
-- Design Name: Piccolo F function
-- Module Name: f_box - Behavioral
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

entity f_box is
    Port ( i : in STD_LOGIC_VECTOR (15 downto 0);
           o : out STD_LOGIC_VECTOR (15 downto 0));
end f_box;

architecture Behavioral of f_box is

component m_box is 
    Port (  s0 : in STD_LOGIC_VECTOR (3 downto 0);
            s1 : in STD_LOGIC_VECTOR (3 downto 0);
            s2 : in STD_LOGIC_VECTOR (3 downto 0);
            s3 : in STD_LOGIC_VECTOR (3 downto 0);
            o0 : out STD_LOGIC_VECTOR (3 downto 0);
            o1 : out STD_LOGIC_VECTOR (3 downto 0);
            o2 : out STD_LOGIC_VECTOR (3 downto 0);
            o3 : out STD_LOGIC_VECTOR (3 downto 0));
end component;
component s_box is 
    Port ( input : in STD_LOGIC_VECTOR (3 downto 0);
           output : out STD_LOGIC_VECTOR (3 downto 0));
end component;

signal avant : STD_LOGIC_VECTOR (15 downto 0); -- 16bits before M (Diffusion Matrice)
signal apres : STD_LOGIC_VECTOR (15 downto 0); -- 16bits after M (Diffusion Matrice)
begin

	-- First layer of S Box (s_box.vhd)
    s_box_3 : s_box port map (i(3 downto 0),avant(3 downto 0));
    s_box_2 : s_box port map (i(7 downto 4),avant(7 downto 4));
    s_box_1 : s_box port map (i(11 downto 8),avant(11 downto 8));
    s_box_0 : s_box port map (i(15 downto 12),avant(15 downto 12));
    
	-- Diffusion Matrice (m_box.vhd)
    M : m_box port map (avant(15 downto 12),avant(11 downto 8),avant(7 downto 4),avant(3 downto 0),
        apres(15 downto 12),apres(11 downto 8),apres(7 downto 4),apres(3 downto 0));
        
	-- Second layer of S Box (s_box.vhd)
    s_box_4 : s_box port map (apres(3 downto 0),o(3 downto 0));
    s_box_5 : s_box port map (apres(7 downto 4),o(7 downto 4));
    s_box_6 : s_box port map (apres(11 downto 8),o(11 downto 8));
    s_box_7 : s_box port map (apres(15 downto 12),o(15 downto 12));
    
end Behavioral;
