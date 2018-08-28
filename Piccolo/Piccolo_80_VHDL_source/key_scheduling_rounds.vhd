----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 02.07.2018 21:10:08
-- Design Name: Piccolo 80bit key scheduling rounds version
-- Module Name: key_scheduling_rounds - Behavioral
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

entity key_scheduling_rounds is
    Port ( key : in STD_LOGIC_VECTOR (79 downto 0);
           round : in STD_LOGIC_VECTOR(4 downto 0);
           rki_0 : out STD_LOGIC_VECTOR (15 downto 0);
           rki_1 : out STD_LOGIC_VECTOR (15 downto 0);
           encrypt : in STD_LOGIC;
           wk0 : out STD_LOGIC_VECTOR (15 downto 0);
           wk1 : out STD_LOGIC_VECTOR (15 downto 0);
           wk2 : out STD_LOGIC_VECTOR (15 downto 0);
           wk3 : out STD_LOGIC_VECTOR (15 downto 0));
end key_scheduling_rounds;

architecture Behavioral of key_scheduling_rounds is

signal k0 : std_logic_vector(15 downto 0);
signal k1 : std_logic_vector(15 downto 0);
signal k2 : std_logic_vector(15 downto 0);
signal k3 : std_logic_vector(15 downto 0);
signal k4 : std_logic_vector(15 downto 0);
signal rk0 : std_logic_vector(15 downto 0);
signal rk1 : std_logic_vector(15 downto 0);

signal consti : std_logic_vector(31 downto 0);

signal round_plus_1 : std_logic_vector(4 downto 0);

signal mod_5 : std_logic_vector(2 downto 0);

begin

-- 80 bit key subdivision 
k4 <= key(15 downto 0);
k3 <= key(31 downto 16);
k2 <= key(47 downto 32);
k1 <= key(63 downto 48);
k0 <= key(79 downto 64);

-- generation on the whitening keys
wk0<= key(79 downto 72) & key(55 downto 48)when encrypt = '1' else
        key(15 downto 8) & key(23 downto 16);
wk1<= key(63 downto 56) & key(71 downto 64)when encrypt = '1' else
        key(31 downto 24) & key(7 downto 0);
wk2<= key(15 downto 8) & key(23 downto 16)when encrypt = '1' else
        key(79 downto 72) & key(55 downto 48);
wk3<= key(31 downto 24) & key(7 downto 0)when encrypt = '1' else
        key(63 downto 56) & key(71 downto 64);
        
-- store the value of the round plus 1 or the oposite (encrypt or decrypt) to be used in the constant generation
round_plus_1 <= std_logic_vector(unsigned(round) + 1)when encrypt = '1' else
                std_logic_vector(24 - unsigned(round) + 1);
-- generate the constant for the current round
consti <= (round_plus_1 &"00000"& round_plus_1 &"00" & round_plus_1 &"00000"& round_plus_1) xor x"0f1e2d3c";

-- keep track of the round modulo 5 for the diferentiation
mod_5 <= std_logic_vector(to_unsigned( to_integer(unsigned(round)) mod 5 , 3)) when encrypt = '1' else
         std_logic_vector(to_unsigned( (24 - to_integer(unsigned(round)) )mod 5 , 3)); -- use the pseudo round for the decryption
        
-- generate the 2 current round keys (encryption key)
rk0 <=  consti(31 downto 16) xor k2 when mod_5 = "000" else
        consti(31 downto 16) xor k2 when mod_5 = "010" else
        consti(31 downto 16) xor k0 when mod_5 = "001" else
        consti(31 downto 16) xor k0 when mod_5 = "100" else
        consti(31 downto 16) xor k4;
rk1 <=  consti(15 downto 0) xor k3 when mod_5 = "000" else
        consti(15 downto 0)  xor k3 when mod_5 = "010" else
        consti(15 downto 0)  xor k1 when mod_5 = "001" else
        consti(15 downto 0)  xor k1 when mod_5 = "100" else
        consti(15 downto 0)  xor k4;
-- output the key in the correct order according to the decryption algorithm and the encryption algorithm
rki_0 <= rk0 when encrypt = '1' else
        rk0 when round(0) = '0' else --parity
        rk1;
rki_1 <= rk1 when encrypt = '1' else
        rk1 when round(0) = '0' else --parity
        rk0;

end Behavioral;
