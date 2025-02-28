library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity state_machine is
    Port (
        btn : in std_logic_vector(3 downto 0);
        clk : in std_logic;
        q : out std_logic;
        rst : in std_logic
    );
end state_machine;

architecture Behavioral of state_machine is
    -- Define state type
    type statetype is (S0, S1, S2, S3, S4, S5, S6, S7, S8, S9, S10, S11, S12, S13, S14, S15, S16, S17, S18, S19);
    type bit_array_type is array (0 to 138) of std_logic;
    signal clk_down : integer := 0;
    signal count : integer := 0;  -- Internal 4-bit counter signal
    constant bit_array : bit_array_type := ( '0',
        -- A
        '1', '0',
        '1', '1', '1', '0',
        '0', '0', '0',

        -- C
        '1', '1', '1', '0',
        '1', '0',
        '1', '1', '1', '0',
        '1', '0',
        '0', '0', '0',

        -- C
        '1', '1', '1', '0',
        '1', '0',
        '1', '1', '1', '0',
        '1', '0',
        '0', '0', '0',

        -- E
        '1', '0',
        '0', '0', '0',

        -- S
        '1', '0',
        '1', '0',
        '1', '0',
        '0', '0', '0',

        -- S
        '1', '0',
        '1', '0',
        '1', '0',
        '0', '0', '0',

        -- G
        '1', '1', '1', '0',
        '1', '1', '1', '0',
        '1', '0',
        '0', '0', '0',

        -- R
        '1', '0',
        '1', '1', '1', '0',
        '1', '0',
        '0', '0', '0',

        -- A
        '1', '0',
        '1', '1', '1', '0',
        '0', '0', '0',

        -- N
        '1', '1', '1', '0',
        '1', '0',
        '0', '0', '0',

        -- T
        '1', '1', '1', '0',
        '0', '0', '0',

        -- E
        '1', '0',
        '0', '0', '0',

        -- D
        '1', '1', '1', '0',
        '1', '0',
        '1', '0',
        
        '0','0','0','0','0','0','0','0','0','0','0','0','0','0'
    );

    -- State signals initialized to default state S0
    signal state, nextstate : statetype := S0;
    
    -- Synchronized version of button input to avoid metastability
    signal btn_sync, btn_prev : std_logic_vector(3 downto 0) := (others => '0');
    signal btn_changed : std_logic := '0';  -- Flag for button change detection
    signal clk_val : std_logic;
begin
    -- Synchronize the button inputs with the clock
    process(clk)
    begin
        if rising_edge(clk) then
            btn_sync <= btn;  -- Synchronize button input
        end if;
    end process;

    -- Detect button changes
    process(clk)
    begin
        if rising_edge(clk) then
            if btn_sync /= btn_prev then
                btn_changed <= '1';
                btn_prev <= btn_sync;
            else
                btn_changed <= '0';
            end if;
        end if;
    end process;

    -- State register with synchronous reset
    process(clk)
    begin
        if rising_edge(clk) then
            if rst = '1' then
                state <= S0;  -- Reset state
            else
                state <= nextstate;  -- Move to next state
            end if;
        end if;
    end process;

    -- State transition logic based on synchronized button input
    process(state, btn_sync, btn_changed)
    begin
        -- Default: Hold the current state
        nextstate <= state;

        -- Only transition state if the button has changed
        if btn_changed = '1' then
            case state is
                when S0 =>
                    if btn_sync = "0001" then
                        nextstate <= S1;
                    else nextstate <= S0;
                    end if;

                when S1 =>
                    if btn_sync = "0000" then
                        nextstate <= S2;
                    elsif btn_sync = "0001" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S2 =>
                    if btn_sync = "0100" then
                        nextstate <= S3;
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S3 =>
                    if btn_sync = "0000" then
                        nextstate <= S4;
                    elsif btn_sync = "0100" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S4 =>
                    if btn_sync = "0010" then
                        nextstate <= S5;
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S5 =>
                    if btn_sync = "0000" then
                        nextstate <= S6;
                    elsif btn_sync = "0010" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S6 =>
                    if btn_sync = "0010" then
                        nextstate <= S7;
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S7 =>
                    if btn_sync = "0000" then
                        nextstate <= S8;
                    elsif btn_sync = "0010" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S8 =>
                    if btn_sync = "0010" then
                        nextstate <= S9; 
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S9 =>
                    if btn_sync = "0000" then
                        nextstate <= S10;
                    elsif btn_sync = "0010" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S10 =>
                    if btn_sync = "1000" then
                        nextstate <= S11; 
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S11 =>
                    if btn_sync = "0000" then
                        nextstate <= S12; 
                    elsif btn_sync = "1000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;

                when S12 =>
                    if btn_sync = "0001" then
                        nextstate <= S13;  
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S13 =>
                    if btn_sync = "0000" then
                        nextstate <= S14;
                    elsif btn_sync = "0001" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S14 =>
                    if btn_sync = "0010" then
                        nextstate <= S15; 
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S15 =>
                    if btn_sync = "0000" then
                        nextstate <= S16; 
                    elsif btn_sync = "0010" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S16 =>
                    if btn_sync = "1000" then
                        nextstate <= S17; 
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S17 =>
                    if btn_sync = "0000" then
                        nextstate <= S18; 
                    elsif btn_sync = "1000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S18 =>
                    if btn_sync = "0001" then
                        nextstate <= S19; 
                    elsif btn_sync = "0000" then
                        nextstate <= state;
                    else nextstate <= S0;
                    end if;
                    
                when S19 =>
                    if btn_sync = "0000" then
                        nextstate <= S19;       -- Stay at S19
                    end if;

                when others =>
                    nextstate <= S0;
            end case;
        end if;
    end process;
    
    process(clk, rst)
    begin
    
    if state = S19 then
        if rst = '1' then
            count <= 0;  -- Reset the counter to 0
            clk_down <= 0;
        elsif rising_edge(clk) then
            if clk_down = 15000000 then
                clk_down <= 0;
                if count = 138 then
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
    
    q <= bit_array(count);
    -- Output logic based on the state
--    q <= "1111" when state = S19 else
--         "0000";  -- Default output for unexpected states

end Behavioral;
