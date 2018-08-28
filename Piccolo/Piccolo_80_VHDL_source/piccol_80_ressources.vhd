----------------------------------------------------------------------------------
-- Company: DCU / ECE Paris
-- Engineer: Patrick BORE
-- 
-- Create Date: 03.07.2018 02:18:41
-- Design Name: Piccolo 80 bits ressources implementation
-- Module Name: piccol_80_ressources - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: Top Module
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

entity piccol_80_ressources is
    Port ( data : in STD_LOGIC_VECTOR (63 downto 0);
           key : in STD_LOGIC_VECTOR (79 downto 0);
           encrypt : in STD_LOGIC;
           dataReady : in STD_LOGIC; -- active on low
           cipherReady : out STD_LOGIC; -- active on low
           clk : in std_logic;
           cipher : out STD_LOGIC_VECTOR (63 downto 0));
end piccol_80_ressources;

architecture Behavioral of piccol_80_ressources is

--data synchronisation
signal encrypt_sync : std_logic;
signal key_sync : std_logic_vector(79 downto 0);
signal data_sync : std_logic_vector(63 downto 0);

signal cipher_sync : std_logic_vector(63 downto 0);


-- keys scheduling
signal tour : std_logic_vector(4 downto 0);
signal tour_async : std_logic_vector(4 downto 0);
signal rki_0 : STD_LOGIC_VECTOR (15 downto 0);
signal rki_1 : STD_LOGIC_VECTOR (15 downto 0);
signal wk0 : STD_LOGIC_VECTOR (15 downto 0);
signal wk1 : STD_LOGIC_VECTOR (15 downto 0);
signal wk2 : STD_LOGIC_VECTOR (15 downto 0);
signal wk3 : STD_LOGIC_VECTOR (15 downto 0);

-- piccolo
signal round_input : std_logic_vector(63 downto 0);
signal round_output : std_logic_vector(63 downto 0);
signal first_input : std_logic_vector(63 downto 0);

signal fa : std_logic_vector(15 downto 0);
signal fc : std_logic_vector(15 downto 0);
signal Y : std_logic_vector(63 downto 0);
signal X : std_logic_vector(63 downto 0);

component key_scheduling_rounds is
    Port ( key : in STD_LOGIC_VECTOR (79 downto 0);
           round : in STD_LOGIC_VECTOR(4 downto 0);
           rki_0 : out STD_LOGIC_VECTOR (15 downto 0);
           rki_1 : out STD_LOGIC_VECTOR (15 downto 0);
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
    -- synchronize the data,key and encrypt flag on the data ready flag and the round being round 0
    key_sync <= key when tour = "00000" and dataReady = '0';
    encrypt_sync <= encrypt when tour = "00000" and dataReady = '0';
    data_sync <= data when tour = "00000" and dataReady = '0';
    
	-- mapping of the round key generator
    key_sch_80 : key_scheduling_rounds port map (key_sync,tour,rki_0,rki_1,encrypt_sync,wk0,wk1,wk2,wk3);
    
	-- whitening key for the 1st round
    first_input <= (data(63 downto 48) xor wk0) & data(47 downto 32) & (data(31 downto 16) xor wk1) & data(15 downto 0);
    -- select either the input data or the output of the last round to be the input of the curent round
	round_input <= first_input when tour = "00000" else
                round_output;
	-- nth round 
	-- X is the state after the F function but before the round permutation
	-- Y is the state of the 64 bit data after the full round
	-- fa and fc is just the output of the F function
	-- each round have 2 implementation of the F function (f_box.vhd) 
	-- and 1 implementation of the Round Permutation (Round_permutation.vhd)			
    X(63 downto 48) <= round_input(63 downto 48);
    F_a : f_box port map (round_input(63 downto 48),fa);
    X(47 downto 32) <= round_input(47 downto 32) xor fa xor rki_0;
    X(31 downto 16) <= round_input(31 downto 16);
    F_c : f_box port map (round_input(31 downto 16),fc);
    X(15 downto 0) <= round_input(15 downto 0) xor fc xor rki_1;
    RP : Round_permutation port map(X,Y);
	--synchronize the output of the round (Y) with the clock and 'save it' as a flip-flop
    round_output <= Y when rising_edge(clk);    
        
	-- next value of the counter for the round : stop at the 25th round (24) and check if the data is ready
    tour_async <= "00000" when tour = "11000" else
                std_logic_vector(unsigned(tour) + 1) when dataReady = '0' else
                tour;
    -- counter with an asynchrone reset
	tour <= "00000" when dataReady = '1' else
            tour_async when rising_edge(clk);
    
	-- whitening key for the last round (we use X because there is actully no round permutation on the last round)
    cipher_sync(63 downto 48) <= X(63 downto 48) xor wk2;
    cipher_sync(47 downto 32) <= X(47 downto 32);
    cipher_sync(31 downto 16) <= X(31 downto 16) xor wk3;
    cipher_sync(15 downto 0) <= X(15 downto 0);
    
	-- syncronise the output on the clock and hold it until the next use of the piccolo function
    cipher <= x"0000000000000000" when dataReady = '1' else
        cipher_sync when tour = "11000" and rising_edge(clk);
	
	-- flag that is low only when there is data ready from the last encryption
    cipherReady <= '1' when dataReady = '1' else
                   '0' when tour = "11000" and rising_edge(clk);

end Behavioral;
