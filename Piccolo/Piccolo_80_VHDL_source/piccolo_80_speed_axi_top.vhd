----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 06.08.2018 00:07:38
-- Design Name: Piccolo 80bit speed implementation 32 bits register oriented
-- Module Name: piccolo_80_speed_axi_top - Behavioral
-- Project Name: Piccolo
-- Target Devices: 
-- Tool Versions: 
-- Description: Format the piccolo 80bit input/output to the register format needed for an IP AXI block
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
           reg4 : in STD_LOGIC_VECTOR (31 downto 0); --encrypt flag + key msb (79 downto 64)
           reg5 : in STD_LOGIC_VECTOR (31 downto 0); --key (63 downto 32)
           reg6 : in STD_LOGIC_VECTOR (31 downto 0)); -- key lsb (31 downto 0)
end piccolo_80_speed_axi_top;

architecture Behavioral of piccolo_80_speed_axi_top is

component piccol_80_speed is
    Port ( data : in STD_LOGIC_VECTOR (63 downto 0);
           key : in STD_LOGIC_VECTOR (79 downto 0);
           encrypt : in STD_LOGIC;
           cipher : out STD_LOGIC_VECTOR (63 downto 0));
end component;

signal data0 : STD_LOGIC_VECTOR (63 downto 0); -- input block
signal key0 : STD_LOGIC_VECTOR (79 downto 0); -- 80bits key
signal apres : STD_LOGIC_VECTOR (63 downto 0); --cipher / encrypted block
signal bool : std_logic; -- encrytp flag
begin
	-- mapping the inputs/output 32 bits vector to be connected to 32bits registers
    piccolo_80_logic : piccol_80_speed port map(data0,key0,bool,apres);
    data0 <= reg0 & reg1;
    key0 <= reg4(15 downto 0) & reg5 & reg6;
    bool <= reg4(16);
    reg2 <= apres(63 downto 32);
    reg3 <= apres(31 downto 0);

end Behavioral;
