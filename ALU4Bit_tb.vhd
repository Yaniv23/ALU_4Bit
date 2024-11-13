library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity ALU4Bit_tb is
end entity;

architecture tb_behavior of ALU4Bit_tb is

    -- Component Declaration for the ALU
    component ALU4Bit
        Port (
            A, B       : in unsigned (3 downto 0);
            clk, cin, ce : in STD_LOGIC;
            selector   : in std_logic_vector (3 downto 0);
            cout, zero, sign : out STD_LOGIC;
            F : out unsigned (3 downto 0)
        );
    end component;

    -- Input signals
    signal A, B          : unsigned (3 downto 0) := "1111"; -- Set A to maximum to test increment
    signal clk, cin, ce  : std_logic := '0';
    signal selector      : std_logic_vector (3 downto 0) := "0000"; -- Starting with ADD operation

    -- Output signals
    signal cout, zero, sign : std_logic;
    signal F                : unsigned (3 downto 0);

begin

    -- Clock Generation: 100 MHz (10 ns period)
    clk <= not clk after 5 ns;

    -- Instantiate the ALU
    uut: ALU4Bit
        port map (
            A       => A,
            B       => B,
            clk     => clk,
            cin     => cin,
            ce      => ce,
            selector => selector,
            cout    => cout,
            zero    => zero,
            sign    => sign,
            F       => F
        );

    -- Test Process
    process
    begin
        -- Set CE high to enable ALU operations
        wait  for 4999 ps ;-- to synchronize the selector with the clock 
        ce <= '1';
        
        -- Test ADD (A + B)
        selector <= "0000";
        A <= "0001"; B <= "0010"; cin <= '0'; -- A = 1, B = 2, Expect F = 3
        wait for 20 ns;
        
        -- Test ADD with Carry-in
        cin <= '1';                            -- Expect F = 4 (1 + 2 + 1)
        wait for 20 ns; -- Added delay to allow time for output to settle
        
        -- Test A - B (subtraction without carry)
        selector <= "0001";
        cin <= '0';                            -- Expect F = 1 - 2 = 15 (underflow result for unsigned)
        wait for 20 ns;

        -- Test increment A
        selector <= "0011";                    -- Expect F = 0 with cout = '1' (increment A = 1111)
        wait for 20 ns;

        -- Test Two's Complement of A
        selector <= "0101";                    -- Expect F = Two's Complement of A (for A = 0001, expect 1111)
        wait for 20 ns;

        -- Test A OR B
        selector <= "1000";                    -- Expect F = 3 (A or B where A = 1, B = 2)
        wait for 20 ns;

        -- Test A AND B
        selector <= "1001";                    -- Expect F = 0 (A and B where A = 1, B = 2)
        wait for 20 ns;

        -- Test Ones' Complement A
        selector <= "1010";                    -- Expect F = 1110 (one's complement of A where A = 0001)
        wait for 20 ns;

        -- Test Rotate Left A
        selector <= "1100";                    -- Expect F = Rotate Left of A (0001 -> 0010)
        wait for 20 ns;

        -- Test Pass A
        selector <= "1110";                    -- Expect F = A (0001)
        wait for 20 ns;

        -- Test Pass B
        selector <= "1111";                    -- Expect F = B (0010)
        wait for 20 ns;

        -- Finish Simulation
        ce <= '0';  -- Disable the ALU
        wait;
    end process;

end architecture;
