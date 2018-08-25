----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.08.2018 00:07:38
-- Design Name: 
-- Module Name: piccolo_80_speed_axi_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Format the piccolo input/output to the register format needed for an IP AXI block
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

entity piccolo_80_speed_axi_top is
    Port ( reg0 : in STD_LOGIC_VECTOR (31 downto 0); --data_in msb
           reg1 : in STD_LOGIC_VECTOR (31 downto 0); --data_in lsb
           reg2 : out STD_LOGIC_VECTOR (31 downto 0); --data out msb
           reg3 : out STD_LOGIC_VECTOR (31 downto 0); --data out lsb
           reg5 : in STD_LOGIC_VECTOR (31 downto 0); --flag + key msb
           reg6 : in STD_LOGIC_VECTOR (31 downto 0); --key
           reg7 : in STD_LOGIC_VECTOR (31 downto 0)); -- key lsb
end piccolo_80_speed_axi_top;

architecture Behavioral of piccolo_80_speed_axi_top is

component piccol_80_top is
    Port ( data : in STD_LOGIC_VECTOR (63 downto 0);
           key : in STD_LOGIC_VECTOR (79 downto 0);
           encrypt : in STD_LOGIC;
           cipher : out STD_LOGIC_VECTOR (63 downto 0));
end component;

signal data0 : STD_LOGIC_VECTOR (63 downto 0);
signal key0 : STD_LOGIC_VECTOR (79 downto 0);
signal apres : STD_LOGIC_VECTOR (63 downto 0) ;
signal bool : std_logic;
begin

    piccolo_80_logic : piccol_80_top port map(data0,key0,bool,apres);
    data0 <= reg0 & reg1;
    key0 <= reg5(15 downto 0) & reg6 & reg7;
    bool <= reg5(16);
    reg2 <= apres(63 downto 32);
    reg3 <= apres(31 downto 0);

end Behavioral;
