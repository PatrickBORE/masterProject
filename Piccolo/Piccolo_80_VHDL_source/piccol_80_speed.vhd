----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Patrick BORE
-- 
-- Create Date: 03.07.2018 02:18:41
-- Design Name: 
-- Module Name: piccol_80_speed - Behavioral
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

entity piccol_80_speed is
    Port ( data : in STD_LOGIC_VECTOR (63 downto 0);
           key : in STD_LOGIC_VECTOR (79 downto 0);
           encrypt : in STD_LOGIC;
           cipher : out STD_LOGIC_VECTOR (63 downto 0));
end piccol_80_speed;

architecture Behavioral of piccol_80_speed is

type round is array (24 downto 0) of std_logic_vector(15 downto 0);
type steps is array (24 downto 0) of std_logic_vector(63 downto 0);
type keys is array (49 downto 0) of std_logic_vector(15 downto 0);

signal a : round;
signal fa : round;
signal b : round;
signal c : round;
signal fc : round;
signal d : round;
signal Y : steps;
signal X : steps;

signal rk : keys;
signal wk0 : STD_LOGIC_VECTOR (15 downto 0);
signal wk1 : STD_LOGIC_VECTOR (15 downto 0);
signal wk2 : STD_LOGIC_VECTOR (15 downto 0);
signal wk3 : STD_LOGIC_VECTOR (15 downto 0);

component key_scheduling_linear is
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
end component;
component Round_permutation is
    Port ( i : in STD_LOGIC_VECTOR (63 downto 0);
           o : out STD_LOGIC_VECTOR (63 downto 0));
end component;
component f_box is
    Port ( i : in STD_LOGIC_VECTOR (15 downto 0);
           o : out STD_LOGIC_VECTOR (15 downto 0));
end component;
begin

	-- Mapping the key scheduler to have all the needed key (key_scheduling_linear.vhd)
    key_sch_80 : key_scheduling_linear port map (key,rk(0),rk(1),rk(2),rk(3),rk(4),rk(5),rk(6),rk(7),rk(8),rk(9),rk(10),
    rk(11),rk(12),rk(13),rk(14),rk(15),rk(16),rk(17),rk(18),rk(19),rk(20),rk(21),rk(22),rk(23),rk(24),rk(25),rk(26),
    rk(27),rk(28),rk(29),rk(30),rk(31),rk(32),rk(33),rk(34),rk(35),rk(36),rk(37),rk(38),rk(39),rk(40),rk(41),rk(42),
    rk(43),rk(44),rk(45),rk(46),rk(47),rk(48),rk(49),encrypt,wk0,wk1,wk2,wk3);
    
	-- 1st round : so introduction of the whitening keys
	-- a,b,c and d are the 16bits subdivision before the round permutation
	-- X is the concatenation of a,b,c and d
	-- the input for this round is the input data block (64 bits)
	-- Y is the state of the 64 bit data after the full round
	-- fa and fc is just a and c after going threw the f function
	-- each round have 2 implementation of the F function (f_box.vhd) 
	-- and 1 implementation of the Round Permutation (Round_permutation.vhd)
    a(0) <= data(63 downto 48) xor wk0;
    F0_a : f_box port map (a(0),fa(0));
    b(0) <= data(47 downto 32) xor fa(0) xor rk(0);
    c(0) <= data(31 downto 16) xor wk1;
    F0_c : f_box port map (c(0),fc(0));
    d(0) <= data(15 downto 0) xor fc(0) xor rk(1);
    X(0) <= a(0)&b(0)&c(0)&d(0);
    RP0: Round_permutation port map(X(0),Y(0));
    
	-- nth round 
	-- a,b,c and d are the 16bits subdivision before the round permutation
	-- X is the concatenation of a,b,c and d
	-- Y(n-1) is the state of the 64 bit data before the full round
	-- Y(n) is the state of the 64 bit data after the full round
	-- fa and fc is just a and c after going threw the f function
	-- each round have 2 implementation of the F function (f_box.vhd) 
	-- and 1 implementation of the Round Permutation (Round_permutation.vhd)
    a(1) <= Y(0)(63 downto 48);
    F1_a : f_box port map (a(1),fa(1));
    b(1) <= Y(0)(47 downto 32) xor fa(1) xor rk(2);
    c(1) <= Y(0)(31 downto 16);
    F1_c : f_box port map (c(1),fc(1));
    d(1) <= Y(0)(15 downto 0) xor fc(1) xor rk(3);
    X(1) <= a(1)&b(1)&c(1)&d(1);
    RP1: Round_permutation port map(X(1),Y(1));
    
    a(2) <= Y(1)(63 downto 48);
    F2_a : f_box port map (a(2),fa(2));
    b(2) <= Y(1)(47 downto 32) xor fa(2) xor rk(4);
    c(2) <= Y(1)(31 downto 16);
    F2_c : f_box port map (c(2),fc(2));
    d(2) <= Y(1)(15 downto 0) xor fc(2) xor rk(5);
    X(2) <= a(2)&b(2)&c(2)&d(2);
    RP2: Round_permutation port map(X(2),Y(2));

    a(3) <= Y(2)(63 downto 48);
    F3_a : f_box port map (a(3),fa(3));
    b(3) <= Y(2)(47 downto 32) xor fa(3) xor rk(6);
    c(3) <= Y(2)(31 downto 16);
    F3_c : f_box port map (c(3),fc(3));
    d(3) <= Y(2)(15 downto 0) xor fc(3) xor rk(7);
    X(3) <= a(3)&b(3)&c(3)&d(3);
    RP3: Round_permutation port map(X(3),Y(3));
    
    a(4) <= Y(3)(63 downto 48);
    F4_a : f_box port map (a(4),fa(4));
    b(4) <= Y(3)(47 downto 32) xor fa(4) xor rk(8);
    c(4) <= Y(3)(31 downto 16);
    F4_c : f_box port map (c(4),fc(4));
    d(4) <= Y(3)(15 downto 0) xor fc(4) xor rk(9);
    X(4) <= a(4)&b(4)&c(4)&d(4);
    RP4: Round_permutation port map(X(4),Y(4));
    
    a(5) <= Y(4)(63 downto 48);
    F5_a : f_box port map (a(5),fa(5));
    b(5) <= Y(4)(47 downto 32) xor fa(5) xor rk(10);
    c(5) <= Y(4)(31 downto 16);
    F5_c : f_box port map (c(5),fc(5));
    d(5) <= Y(4)(15 downto 0) xor fc(5) xor rk(11);
    X(5) <= a(5)&b(5)&c(5)&d(5);
    RP5: Round_permutation port map(X(5),Y(5));
    
    a(6) <= Y(5)(63 downto 48);
    F6_a : f_box port map (a(6),fa(6));
    b(6) <= Y(5)(47 downto 32) xor fa(6) xor rk(12);
    c(6) <= Y(5)(31 downto 16);
    F6_c : f_box port map (c(6),fc(6));
    d(6) <= Y(5)(15 downto 0) xor fc(6) xor rk(13);
    X(6) <= a(6)&b(6)&c(6)&d(6);
    RP6: Round_permutation port map(X(6),Y(6));
    
    a(7) <= Y(6)(63 downto 48);
    F7_a : f_box port map (a(7),fa(7));
    b(7) <= Y(6)(47 downto 32) xor fa(7) xor rk(14);
    c(7) <= Y(6)(31 downto 16);
    F7_c : f_box port map (c(7),fc(7));
    d(7) <= Y(6)(15 downto 0) xor fc(7) xor rk(15);
    X(7) <= a(7)&b(7)&c(7)&d(7);
    RP7: Round_permutation port map(X(7),Y(7));
    
    a(8) <= Y(7)(63 downto 48);
    F8_a : f_box port map (a(8),fa(8));
    b(8) <= Y(7)(47 downto 32) xor fa(8) xor rk(16);
    c(8) <= Y(7)(31 downto 16);
    F8_c : f_box port map (c(8),fc(8));
    d(8) <= Y(7)(15 downto 0) xor fc(8) xor rk(17);
    X(8) <= a(8)&b(8)&c(8)&d(8);
    RP8: Round_permutation port map(X(8),Y(8));
    
    a(9) <= Y(8)(63 downto 48);
    F9_a : f_box port map (a(9),fa(9));
    b(9) <= Y(8)(47 downto 32) xor fa(9) xor rk(18);
    c(9) <= Y(8)(31 downto 16);
    F9_c : f_box port map (c(9),fc(9));
    d(9) <= Y(8)(15 downto 0) xor fc(9) xor rk(19);
    X(9) <= a(9)&b(9)&c(9)&d(9);
    RP9: Round_permutation port map(X(9),Y(9));
    
    a(10) <= Y(9)(63 downto 48);
    F10_a : f_box port map (a(10),fa(10));
    b(10) <= Y(9)(47 downto 32) xor fa(10) xor rk(20);
    c(10) <= Y(9)(31 downto 16);
    F10_c : f_box port map (c(10),fc(10));
    d(10) <= Y(9)(15 downto 0) xor fc(10) xor rk(21);
    X(10) <= a(10)&b(10)&c(10)&d(10);
    RP10: Round_permutation port map(X(10),Y(10));
    
    a(11) <= Y(10)(63 downto 48);
    F11_a : f_box port map (a(11),fa(11));
    b(11) <= Y(10)(47 downto 32) xor fa(11) xor rk(22);
    c(11) <= Y(10)(31 downto 16);
    F11_c : f_box port map (c(11),fc(11));
    d(11) <= Y(10)(15 downto 0) xor fc(11) xor rk(23);
    X(11) <= a(11)&b(11)&c(11)&d(11);
    RP11: Round_permutation port map(X(11),Y(11));
    
    a(12) <= Y(11)(63 downto 48);
    F12_a : f_box port map (a(12),fa(12));
    b(12) <= Y(11)(47 downto 32) xor fa(12) xor rk(24);
    c(12) <= Y(11)(31 downto 16);
    F12_c : f_box port map (c(12),fc(12));
    d(12) <= Y(11)(15 downto 0) xor fc(12) xor rk(25);
    X(12) <= a(12)&b(12)&c(12)&d(12);
    RP12: Round_permutation port map(X(12),Y(12));
    
    a(13) <= Y(12)(63 downto 48);
    F13_a : f_box port map (a(13),fa(13));
    b(13) <= Y(12)(47 downto 32) xor fa(13) xor rk(26);
    c(13) <= Y(12)(31 downto 16);
    F13_c : f_box port map (c(13),fc(13));
    d(13) <= Y(12)(15 downto 0) xor fc(13) xor rk(27);
    X(13) <= a(13)&b(13)&c(13)&d(13);
    RP13: Round_permutation port map(X(13),Y(13));
    
    a(14) <= Y(13)(63 downto 48);
    F14_a : f_box port map (a(14),fa(14));
    b(14) <= Y(13)(47 downto 32) xor fa(14) xor rk(28);
    c(14) <= Y(13)(31 downto 16);
    F14_c : f_box port map (c(14),fc(14));
    d(14) <= Y(13)(15 downto 0) xor fc(14) xor rk(29);
    X(14) <= a(14)&b(14)&c(14)&d(14);
    RP14: Round_permutation port map(X(14),Y(14));
    
    a(15) <= Y(14)(63 downto 48);
    F15_a : f_box port map (a(15),fa(15));
    b(15) <= Y(14)(47 downto 32) xor fa(15) xor rk(30);
    c(15) <= Y(14)(31 downto 16);
    F15_c : f_box port map (c(15),fc(15));
    d(15) <= Y(14)(15 downto 0) xor fc(15) xor rk(31);
    X(15) <= a(15)&b(15)&c(15)&d(15);
    RP15: Round_permutation port map(X(15),Y(15));
    
    a(16) <= Y(15)(63 downto 48);
    F16_a : f_box port map (a(16),fa(16));
    b(16) <= Y(15)(47 downto 32) xor fa(16) xor rk(32);
    c(16) <= Y(15)(31 downto 16);
    F16_c : f_box port map (c(16),fc(16));
    d(16) <= Y(15)(15 downto 0) xor fc(16) xor rk(33);
    X(16) <= a(16)&b(16)&c(16)&d(16);
    RP16: Round_permutation port map(X(16),Y(16));
    
    a(17) <= Y(16)(63 downto 48);
    F17_a : f_box port map (a(17),fa(17));
    b(17) <= Y(16)(47 downto 32) xor fa(17) xor rk(34);
    c(17) <= Y(16)(31 downto 16);
    F17_c : f_box port map (c(17),fc(17));
    d(17) <= Y(16)(15 downto 0) xor fc(17) xor rk(35);
    X(17) <= a(17)&b(17)&c(17)&d(17);
    RP17: Round_permutation port map(X(17),Y(17));
    
    a(18) <= Y(17)(63 downto 48);
    F18_a : f_box port map (a(18),fa(18));
    b(18) <= Y(17)(47 downto 32) xor fa(18) xor rk(36);
    c(18) <= Y(17)(31 downto 16);
    F18_c : f_box port map (c(18),fc(18));
    d(18) <= Y(17)(15 downto 0) xor fc(18) xor rk(37);
    X(18) <= a(18)&b(18)&c(18)&d(18);
    RP18: Round_permutation port map(X(18),Y(18));
    
    a(19) <= Y(18)(63 downto 48);
    F19_a : f_box port map (a(19),fa(19));
    b(19) <= Y(18)(47 downto 32) xor fa(19) xor rk(38);
    c(19) <= Y(18)(31 downto 16);
    F19_c : f_box port map (c(19),fc(19));
    d(19) <= Y(18)(15 downto 0) xor fc(19) xor rk(39);
    X(19) <= a(19)&b(19)&c(19)&d(19);
    RP19: Round_permutation port map(X(19),Y(19));
    
    a(20) <= Y(19)(63 downto 48);
    F20_a : f_box port map (a(20),fa(20));
    b(20) <= Y(19)(47 downto 32) xor fa(20) xor rk(40);
    c(20) <= Y(19)(31 downto 16);
    F20_c : f_box port map (c(20),fc(20));
    d(20) <= Y(19)(15 downto 0) xor fc(20) xor rk(41);
    X(20) <= a(20)&b(20)&c(20)&d(20);
    RP20: Round_permutation port map(X(20),Y(20));
    
    a(21) <= Y(20)(63 downto 48);
    F21_a : f_box port map (a(21),fa(21));
    b(21) <= Y(20)(47 downto 32) xor fa(21) xor rk(42);
    c(21) <= Y(20)(31 downto 16);
    F21_c : f_box port map (c(21),fc(21));
    d(21) <= Y(20)(15 downto 0) xor fc(21) xor rk(43);
    X(21) <= a(21)&b(21)&c(21)&d(21);
    RP21: Round_permutation port map(X(21),Y(21));
    
    a(22) <= Y(21)(63 downto 48);
    F22_a : f_box port map (a(22),fa(22));
    b(22) <= Y(21)(47 downto 32) xor fa(22) xor rk(44);
    c(22) <= Y(21)(31 downto 16);
    F22_c : f_box port map (c(22),fc(22));
    d(22) <= Y(21)(15 downto 0) xor fc(22) xor rk(45);
    X(22) <= a(22)&b(22)&c(22)&d(22);
    RP22: Round_permutation port map(X(22),Y(22));
    
    a(23) <= Y(22)(63 downto 48);
    F23_a : f_box port map (a(23),fa(23));
    b(23) <= Y(22)(47 downto 32) xor fa(23) xor rk(46);
    c(23) <= Y(22)(31 downto 16);
    F23_c : f_box port map (c(23),fc(23));
    d(23) <= Y(22)(15 downto 0) xor fc(23) xor rk(47);
    X(23) <= a(23)&b(23)&c(23)&d(23);
    RP23: Round_permutation port map(X(23),Y(23));
	
    -- 25th/last round : so introduction of the whitening keys again
	-- a,b,c and d are the 16bits subdivision before the round permutation
	-- X is the concatenation of a,b,c and d 
	-- Y(n-1) is the state of the 64 bit data before the full round
	-- fa and fc is just a and c after going threw the f function
	-- each round have 2 implementation of the F function (f_box.vhd) 
	-- NO implementation of the Round Permutation (Round_permutation.vhd)
	-- instead the output before the whitening keys is X 
	-- cipher is the final output 64bits block encrypted
    a(24) <= Y(23)(63 downto 48);
    F24_a : f_box port map (a(24),fa(24));
    b(24) <= Y(23)(47 downto 32) xor fa(24) xor rk(48);
    c(24) <= Y(23)(31 downto 16);
    F24_c : f_box port map (c(24),fc(24));
    d(24) <= Y(23)(15 downto 0) xor fc(24) xor rk(49);
    cipher <= (a(24) xor wk2) & b(24) & (c(24) xor wk3) & d(24);
    
    

end Behavioral;
