library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use work.all;

entity code is
    Port ( clk   : in  STD_LOGIC;  -- Clock signal
           sw    : in std_logic_vector(3 downto 0);
           btn    : in std_logic_vector(3 downto 1);
           rst : in  STD_LOGIC;  -- Active-high reset
           q     : out STD_LOGIC_VECTOR (3 downto 0);  -- 4-bit output count
           clk_out : out std_logic );
end code;

architecture Behavioral of code is
    signal count : integer := 0;  -- Internal 4-bit counter signal
    signal clk_down : integer := 0;
    type hex_arr is array (0 to 39) of std_logic_vector(3 downto 0);
    constant ascii_values : hex_arr := (
        "0100", "1001", -- I  ->  73
        "0101", "0011", -- S  ->  83
        "0101", "0100", -- T  ->  84
        "0101", "0011", -- S  ->  83
        "0111", "1011", -- {  -> 123
        "0100", "0001", -- A  ->  65
        "0100", "0011", -- C  ->  67
        "0100", "0011", -- C  ->  67
        "0011", "0011", -- 3  ->  51
        "0101", "0011", -- S  ->  83
        "0101", "0011", -- S  ->  83
        "0101", "1111", -- _  ->  95
        "0100", "0111", -- G  ->  71
        "0101", "0010", -- R  ->  82
        "0011", "0100", -- 4  ->  52
        "0100", "1110", -- N  ->  78
        "0101", "0100", -- T  ->  84
        "0011", "0011", -- 3  ->  51
        "0100", "0100", -- D  ->  68
        "0111", "1101"  -- }  -> 125
    );
    signal inst : std_logic;
    signal inst1 : std_logic;
    signal inst2 : std_logic;
    signal inst3 : std_logic;
    signal inst4 : std_logic;
    signal inst5 : std_logic;
    signal inst6 : std_logic;
    signal inst7 : std_logic;
    signal inst8 : std_logic;
    signal inst9 : std_logic;
    signal inst10 : std_logic;
    signal inst11 : std_logic;
    signal inst12 : std_logic;
    
    signal clk_val : std_logic;

begin
    process(clk, rst)
    begin
    inst <= sw(2) xnor sw(1);
    inst1 <= not sw(0);
    inst2 <= sw(3) xor inst;
    inst3 <= sw(1) xnor inst1;
    inst4 <= btn(2) xnor btn(1);
    inst5 <= sw(3) and inst2;
    inst6 <= not inst2;
    inst7 <= inst3 or btn(3);
    inst8 <= inst6 nor inst7;
    inst9 <= inst3 or btn(3) or btn(2);
    inst10 <= inst5 and inst8;
    inst11 <= inst9 nor inst4;
    inst12 <= inst10 and inst11;
    
    if inst12 = '1' then
        if rst = '1' then
            count <= 0;  -- Reset the counter to 0
            clk_down <= 0;
        elsif rising_edge(clk) then
            if clk_down = 10000000 then
                clk_down <= 0;
                if count = 39 then
                    count <= 0;
                else
                    count <= count + 1;
                    clk_val <= not clk_val;
                end if;
            else
                clk_down <= clk_down + 1;  -- Now clk_down correctly increments
            end if;
        end if;
    end if;
    end process;
    
    clk_out <= clk_val;
    q <= ascii_values(count);  -- Assign the internal counter to the output
end Behavioral;
