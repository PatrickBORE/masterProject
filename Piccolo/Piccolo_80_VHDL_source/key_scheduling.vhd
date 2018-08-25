----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 02.07.2018 21:10:08
-- Design Name: 
-- Module Name: key_scheduling - Behavioral
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

entity key_scheduling is
    Port ( key : in STD_LOGIC_VECTOR (79 downto 0);
           rk0 : out STD_LOGIC_VECTOR (15 downto 0);
           rk1 : out STD_LOGIC_VECTOR (15 downto 0);
           rk2 : out STD_LOGIC_VECTOR (15 downto 0);
           rk3 : out STD_LOGIC_VECTOR (15 downto 0);
           rk4 : out STD_LOGIC_VECTOR (15 downto 0);
           rk5 : out STD_LOGIC_VECTOR (15 downto 0);
           rk6 : out STD_LOGIC_VECTOR (15 downto 0);
           rk7 : out STD_LOGIC_VECTOR (15 downto 0);
           rk8 : out STD_LOGIC_VECTOR (15 downto 0);
           rk9 : out STD_LOGIC_VECTOR (15 downto 0);
           rk10 : out STD_LOGIC_VECTOR (15 downto 0);
           rk11 : out STD_LOGIC_VECTOR (15 downto 0);
           rk12 : out STD_LOGIC_VECTOR (15 downto 0);
           rk13 : out STD_LOGIC_VECTOR (15 downto 0);
           rk14 : out STD_LOGIC_VECTOR (15 downto 0);
           rk15 : out STD_LOGIC_VECTOR (15 downto 0);
           rk16 : out STD_LOGIC_VECTOR (15 downto 0);
           rk17 : out STD_LOGIC_VECTOR (15 downto 0);
           rk18 : out STD_LOGIC_VECTOR (15 downto 0);
           rk19 : out STD_LOGIC_VECTOR (15 downto 0);
           rk20 : out STD_LOGIC_VECTOR (15 downto 0);
           rk21 : out STD_LOGIC_VECTOR (15 downto 0);
           rk22 : out STD_LOGIC_VECTOR (15 downto 0);
           rk23 : out STD_LOGIC_VECTOR (15 downto 0);
           rk24 : out STD_LOGIC_VECTOR (15 downto 0);
           rk25 : out STD_LOGIC_VECTOR (15 downto 0);
           rk26 : out STD_LOGIC_VECTOR (15 downto 0);
           rk27 : out STD_LOGIC_VECTOR (15 downto 0);
           rk28 : out STD_LOGIC_VECTOR (15 downto 0);
           rk29 : out STD_LOGIC_VECTOR (15 downto 0);
           rk30 : out STD_LOGIC_VECTOR (15 downto 0);
           rk31 : out STD_LOGIC_VECTOR (15 downto 0);
           rk32 : out STD_LOGIC_VECTOR (15 downto 0);
           rk33 : out STD_LOGIC_VECTOR (15 downto 0);
           rk34 : out STD_LOGIC_VECTOR (15 downto 0);
           rk35 : out STD_LOGIC_VECTOR (15 downto 0);
           rk36 : out STD_LOGIC_VECTOR (15 downto 0);
           rk37 : out STD_LOGIC_VECTOR (15 downto 0);
           rk38 : out STD_LOGIC_VECTOR (15 downto 0);
           rk39 : out STD_LOGIC_VECTOR (15 downto 0);
           rk40 : out STD_LOGIC_VECTOR (15 downto 0);
           rk41 : out STD_LOGIC_VECTOR (15 downto 0);
           rk42 : out STD_LOGIC_VECTOR (15 downto 0);
           rk43 : out STD_LOGIC_VECTOR (15 downto 0);
           rk44 : out STD_LOGIC_VECTOR (15 downto 0);
           rk45 : out STD_LOGIC_VECTOR (15 downto 0);
           rk46 : out STD_LOGIC_VECTOR (15 downto 0);
           rk47 : out STD_LOGIC_VECTOR (15 downto 0);
           rk48 : out STD_LOGIC_VECTOR (15 downto 0);
           rk49 : out STD_LOGIC_VECTOR (15 downto 0);
           encrypt : in STD_LOGIC;
           wk0 : out STD_LOGIC_VECTOR (15 downto 0);
           wk1 : out STD_LOGIC_VECTOR (15 downto 0);
           wk2 : out STD_LOGIC_VECTOR (15 downto 0);
           wk3 : out STD_LOGIC_VECTOR (15 downto 0));
end key_scheduling;

architecture Behavioral of key_scheduling is

signal k0 : std_logic_vector(15 downto 0);
signal k1 : std_logic_vector(15 downto 0);
signal k2 : std_logic_vector(15 downto 0);
signal k3 : std_logic_vector(15 downto 0);
signal k4 : std_logic_vector(15 downto 0);

signal const0 : std_logic_vector(31 downto 0);
signal const2 : std_logic_vector(31 downto 0);
signal const4 : std_logic_vector(31 downto 0);
signal const6 : std_logic_vector(31 downto 0);
signal const8 : std_logic_vector(31 downto 0);
signal const10 : std_logic_vector(31 downto 0);
signal const12 : std_logic_vector(31 downto 0);
signal const14 : std_logic_vector(31 downto 0);
signal const16 : std_logic_vector(31 downto 0);
signal const18 : std_logic_vector(31 downto 0);
signal const20 : std_logic_vector(31 downto 0);
signal const22 : std_logic_vector(31 downto 0);
signal const24 : std_logic_vector(31 downto 0);
signal const26 : std_logic_vector(31 downto 0);
signal const28 : std_logic_vector(31 downto 0);
signal const30 : std_logic_vector(31 downto 0);
signal const32 : std_logic_vector(31 downto 0);
signal const34 : std_logic_vector(31 downto 0);
signal const36 : std_logic_vector(31 downto 0);
signal const38 : std_logic_vector(31 downto 0);
signal const40 : std_logic_vector(31 downto 0);
signal const42 : std_logic_vector(31 downto 0);
signal const44 : std_logic_vector(31 downto 0);
signal const46 : std_logic_vector(31 downto 0);
signal const48 : std_logic_vector(31 downto 0);


begin
k4 <= key(15 downto 0);
k3 <= key(31 downto 16);
k2 <= key(47 downto 32);
k1 <= key(63 downto 48);
k0 <= key(79 downto 64);

wk0<= key(79 downto 72) & key(55 downto 48)when encrypt = '1' else
        key(15 downto 8) & key(23 downto 16);
wk1<= key(63 downto 56) & key(71 downto 64)when encrypt = '1' else
        key(31 downto 24) & key(7 downto 0);
wk2<= key(15 downto 8) & key(23 downto 16)when encrypt = '1' else
        key(79 downto 72) & key(55 downto 48);
wk3<= key(31 downto 24) & key(7 downto 0)when encrypt = '1' else
        key(63 downto 56) & key(71 downto 64);
const0 <= ("00001"&"00000"&"00001"&"00"&"00001"&"00000"&"00001") xor "00001111000111100010110100111100";
const2 <= ("00010"&"00000"&"00010"&"00"&"00010"&"00000"&"00010") xor "00001111000111100010110100111100";
const4 <= ("00011"&"00000"&"00011"&"00"&"00011"&"00000"&"00011") xor "00001111000111100010110100111100";
const6 <= ("00100"&"00000"&"00100"&"00"&"00100"&"00000"&"00100") xor "00001111000111100010110100111100";
const8 <= ("00101"&"00000"&"00101"&"00"&"00101"&"00000"&"00101") xor "00001111000111100010110100111100";
const10<= ("00110"&"00000"&"00110"&"00"&"00110"&"00000"&"00110") xor "00001111000111100010110100111100";
const12 <= ("00111"&"00000"&"00111"&"00"&"00111"&"00000"&"00111") xor "00001111000111100010110100111100";
const14 <= ("01000"&"00000"&"01000"&"00"&"01000"&"00000"&"01000") xor "00001111000111100010110100111100";
const16 <= ("01001"&"00000"&"01001"&"00"&"01001"&"00000"&"01001") xor "00001111000111100010110100111100";
const18 <= ("01010"&"00000"&"01010"&"00"&"01010"&"00000"&"01010") xor "00001111000111100010110100111100";
const20 <= ("01011"&"00000"&"01011"&"00"&"01011"&"00000"&"01011") xor "00001111000111100010110100111100";
const22 <= ("01100"&"00000"&"01100"&"00"&"01100"&"00000"&"01100") xor "00001111000111100010110100111100";
const24 <= ("01101"&"00000"&"01101"&"00"&"01101"&"00000"&"01101") xor "00001111000111100010110100111100";
const26 <= ("01110"&"00000"&"01110"&"00"&"01110"&"00000"&"01110") xor "00001111000111100010110100111100";
const28 <= ("01111"&"00000"&"01111"&"00"&"01111"&"00000"&"01111") xor "00001111000111100010110100111100";
const30 <= ("10000"&"00000"&"10000"&"00"&"10000"&"00000"&"10000") xor "00001111000111100010110100111100";
const32 <= ("10001"&"00000"&"10001"&"00"&"10001"&"00000"&"10001") xor "00001111000111100010110100111100";
const34 <= ("10010"&"00000"&"10010"&"00"&"10010"&"00000"&"10010") xor "00001111000111100010110100111100";
const36 <= ("10011"&"00000"&"10011"&"00"&"10011"&"00000"&"10011") xor "00001111000111100010110100111100";
const38 <= ("10100"&"00000"&"10100"&"00"&"10100"&"00000"&"10100") xor "00001111000111100010110100111100";
const40 <= ("10101"&"00000"&"10101"&"00"&"10101"&"00000"&"10101") xor "00001111000111100010110100111100";
const42 <= ("10110"&"00000"&"10110"&"00"&"10110"&"00000"&"10110") xor "00001111000111100010110100111100";
const44 <= ("10111"&"00000"&"10111"&"00"&"10111"&"00000"&"10111") xor "00001111000111100010110100111100";
const46 <= ("11000"&"00000"&"11000"&"00"&"11000"&"00000"&"11000") xor "00001111000111100010110100111100";
const48 <= ("11001"&"00000"&"11001"&"00"&"11001"&"00000"&"11001") xor "00001111000111100010110100111100";

rk0 <= const0(31 downto 16) xor k2 when encrypt = '1' else --0
    const48(31 downto 16) xor k0;--48
rk1 <= const0(15 downto 0) xor k3 when encrypt = '1' else --1
    const48(15 downto 0) xor k1;--49
rk2 <= const2(31 downto 16) xor k0 when encrypt = '1' else --2
    const46(15 downto 0) xor k4;--47
rk3 <= const2(15 downto 0) xor k1 when encrypt = '1' else --3
    const46(31 downto 16) xor k4;--46
rk4 <= const4(31 downto 16) xor k2 when encrypt = '1' else --4
    const44(31 downto 16) xor k2;--44
rk5 <= const4(15 downto 0) xor k3 when encrypt = '1' else --5
    const44(15 downto 0) xor k3;--45
rk6 <= const6(31 downto 16) xor k4 when encrypt = '1' else --6
    const42(15 downto 0) xor k1;--43
rk7 <= const6(15 downto 0) xor k4 when encrypt = '1' else --7
    const42(31 downto 16) xor k0;--42
rk8 <= const8(31 downto 16) xor k0 when encrypt = '1' else --8
    const40(31 downto 16) xor k2;--40
rk9 <= const8(15 downto 0) xor k1 when encrypt = '1' else --9
    const40(15 downto 0) xor k3;--41
rk10 <= const10(31 downto 16) xor k2 when encrypt = '1' else --10
    const38(15 downto 0) xor k1;--39
rk11 <= const10(15 downto 0) xor k3 when encrypt = '1' else --11
    const38(31 downto 16) xor k0;--38
rk12 <= const12(31 downto 16) xor k0 when encrypt = '1' else --12
    const36(31 downto 16) xor k4;--36
rk13 <= const12(15 downto 0) xor k1 when encrypt = '1' else --13
    const36(15 downto 0) xor k4;--37
rk14 <= const14(31 downto 16) xor k2 when encrypt = '1' else --14
    const34(15 downto 0) xor k3;--35
rk15 <= const14(15 downto 0) xor k3 when encrypt = '1' else --15
    const34(31 downto 16) xor k2;--34
rk16 <= const16(31 downto 16) xor k4 when encrypt = '1' else --16
    const32(31 downto 16) xor k0;--32
rk17 <= const16(15 downto 0) xor k4 when encrypt = '1' else --17
    const32(15 downto 0) xor k1;--33
rk18 <= const18(31 downto 16) xor k0 when encrypt = '1' else --18
    const30(15 downto 0) xor k3;--31
rk19 <= const18(15 downto 0) xor k1 when encrypt = '1' else --19
    const30(31 downto 16) xor k2;--30
rk20 <= const20(31 downto 16) xor k2 when encrypt = '1' else --20
    const28(31 downto 16) xor k0;--28
rk21 <= const20(15 downto 0) xor k3 when encrypt = '1' else --21
    const28(15 downto 0) xor k1;--29
rk22 <= const22(31 downto 16) xor k0 when encrypt = '1' else --22
    const26(15 downto 0) xor k4;--27
rk23 <= const22(15 downto 0) xor k1 when encrypt = '1' else --23
    const26(31 downto 16) xor k4;--26
rk24 <= const24(31 downto 16) xor k2 when encrypt = '1' else --24
    const24(31 downto 16) xor k2;--24
rk25 <= const24(15 downto 0) xor k3 when encrypt = '1' else --25
    const24(15 downto 0) xor k3;--25
rk26 <= const26(31 downto 16) xor k4 when encrypt = '1' else --26
    const22(15 downto 0) xor k1;--23
rk27 <= const26(15 downto 0) xor k4 when encrypt = '1' else --27
    const22(31 downto 16) xor k0;--22
rk28 <= const28(31 downto 16) xor k0 when encrypt = '1' else --28
    const20(31 downto 16) xor k2;--20
rk29 <= const28(15 downto 0) xor k1 when encrypt = '1' else --29
    const20(15 downto 0) xor k3;--21
rk30 <= const30(31 downto 16) xor k2 when encrypt = '1' else --30
    const18(15 downto 0) xor k1;--19
rk31 <= const30(15 downto 0) xor k3 when encrypt = '1' else --31
    const18(31 downto 16) xor k0;--18
rk32 <= const32(31 downto 16) xor k0 when encrypt = '1' else --32
    const16(31 downto 16) xor k4;--16
rk33 <= const32(15 downto 0) xor k1 when encrypt = '1' else --33
    const16(15 downto 0) xor k4;--17
rk34 <= const34(31 downto 16) xor k2 when encrypt = '1' else --34
    const14(15 downto 0) xor k3;--15
rk35 <= const34(15 downto 0) xor k3 when encrypt = '1' else --35
    const14(31 downto 16) xor k2;--14
rk36 <= const36(31 downto 16) xor k4 when encrypt = '1' else --36
    const12(31 downto 16) xor k0;--12
rk37 <= const36(15 downto 0) xor k4 when encrypt = '1' else --37
    const12(15 downto 0) xor k1;--13
rk38 <= const38(31 downto 16) xor k0 when encrypt = '1' else --38
    const10(15 downto 0) xor k3;--11
rk39 <= const38(15 downto 0) xor k1 when encrypt = '1' else --39
    const10(31 downto 16) xor k2;--10
rk40 <= const40(31 downto 16) xor k2 when encrypt = '1' else --40
    const8(31 downto 16) xor k0;--8
rk41 <= const40(15 downto 0) xor k3 when encrypt = '1' else --41
    const8(15 downto 0) xor k1;--9
rk42 <= const42(31 downto 16) xor k0 when encrypt = '1' else --42
    const6(15 downto 0) xor k4;--7
rk43 <= const42(15 downto 0) xor k1 when encrypt = '1' else --43
    const6(31 downto 16) xor k4;--6
rk44 <= const44(31 downto 16) xor k2 when encrypt = '1' else --44
    const4(31 downto 16) xor k2;--4
rk45 <= const44(15 downto 0) xor k3 when encrypt = '1' else --45
    const4(15 downto 0) xor k3;--5
rk46 <= const46(31 downto 16) xor k4 when encrypt = '1' else --46
    const2(15 downto 0) xor k1;--3
rk47 <= const46(15 downto 0) xor k4 when encrypt = '1' else --47
    const2(31 downto 16) xor k0;--2
rk48 <= const48(31 downto 16) xor k0 when encrypt = '1' else --48
    const0(31 downto 16) xor k2;--0
rk49 <= const48(15 downto 0) xor k1 when encrypt = '1' else --49
    const0(15 downto 0) xor k3;--1
end Behavioral;
