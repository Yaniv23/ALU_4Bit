library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU4Bit is
    Port (
           -- Inputs
           A, B      : in unsigned (3 downto 0);
           clk, cin, ce : in STD_LOGIC;
           selector  : in std_logic_vector (3 downto 0);

           -- Outputs
           cout, zero, sign : out STD_LOGIC;
           F                : out unsigned (3 downto 0)
    );
end ALU4Bit;

architecture Behavioral of ALU4Bit is
    signal F_internal : unsigned (4 downto 0) := (others => '0'); -- Extra bit for carry

begin

    -- Output signals
    sign <= F_internal(3);
    zero <= '1' when F_internal(3 downto 0) = "0000" else '0';
    F <= F_internal(3 downto 0);
    cout <= F_internal(4);

    ALU_process : process(clk)
    begin
        if rising_edge(clk) and ce = '1' then
            case selector is
                -- Arithmetic Operations
                when "0000" => -- A + B
                    if cin = '1' then 
                        F_internal <= ('0' & A) + ('0' & B) + 1; 
                    else 
                        F_internal <= ('0' & A) + ('0' & B); 
                    end if;
                when "0001" => -- A - B
                    if cin = '1' then 
                        F_internal <= ('0' & A) - ('0' & B) - 1; 
                    else 
                        F_internal <= ('0' & A) - ('0' & B); 
                    end if;
                when "0010" => -- B - A
                    if cin = '1' then 
                        F_internal <= ('0' & B) - ('0' & A) - 1; 
                    else 
                        F_internal <= ('0' & B) - ('0' & A); 
                    end if;
                when "0011" => -- Increment A
                    F_internal <= '0' & (A + 1);
                when "0100" => -- Increment B
                    F_internal <= '0' & (B + 1);
                when "0101" => -- Two's Complement A
                    F_internal <= '0' & (not(A) + 1);
                when "0110" => -- Two's Complement B
                    F_internal <= '0' & (not(B) + 1);

                -- Logical Operations
                when "0111" => -- A XOR B
                    F_internal <= '0' & (A xor B);
                when "1000" => -- A OR B
                    F_internal <= '0' & (A or B);
                when "1001" => -- A AND B
                    F_internal <= '0' & (A and B);
                when "1010" => -- One's Complement A
                    F_internal <= '0' & not(A);
                when "1011" => -- One's Complement B
                    F_internal <= '0' & not(B);

                -- Shift Operations
                when "1100" => -- Rotate Left A
                    F_internal <= '0' & rotate_left(A, 1);
                when "1101" => -- Rotate Left B
                    F_internal <= '0' & rotate_left(B, 1);

                -- Pass-through Operations
                when "1110" => -- Pass A
                    F_internal <= '0' & A;
                when "1111" => -- Pass B
                    F_internal <= '0' & B;

                when others => 
                    F_internal <= "00000";
            end case;
        end if;
    end process;

end Behavioral;
