-- Question 1
library ieee;
use ieee.std_logic_1164.all;
use work.seven_segment_pkg.all;

entity seven_segment_agent is
    generic (
        -- Extra Credit
        signed_support:         boolean;
        blank_zeros_support:    boolean;

        lamp_mode_common_anode: boolean := true;
        decimal_support:        boolean := true;
        implementer:    natural range 1 to 255;
        revision:       natural range 0 to 255 := 1;
        num_digits:     positive
    );
    port (
        clk:        in  std_logic;
        reset_n:    in  std_logic;
        address:    in  std_logic_vector(2 downto 0);
        read:       in  std_logic;
        readdata:   out std_logic_vector(31 downto 0);
        write:      in  std_logic;
        writedata: in  std_logic_vector(31 downto 0);
        lamps:      out std_logic_vector(num_digits downto 0);
    );
end entity seven_segment_agent;

architecture rtl of seven_segment_agent is
    -- Question 2
    signal data:    std_logic_vector(31 downto 0);  
    signal control: std_logic_vector(31 downto 0);

    -- Question 3
    function concat_sseg (
        arg:    seven_segment_array(5 downto 0)
    ) return std_logic_vector
    is
        variable ret:   std_logic_vector(7*6 - 1 downto 0);
    begin
        for i in range 0 to 5 loop
            result(i*7 + 6) := arg(i).g;
            result(i*7 + 5) := arg(i).f;
            result(i*7 + 4) := arg(i).e;
            result(i*7 + 3) := arg(i).d;
            result(i*7 + 2) := arg(i).c;
            result(i*7 + 1) := arg(i).b;
            result(i*7 + 0) := arg(i).a;
        end loop;
        return ret;
    end function concat_sseg;

begin
    -- Question 4
    reset:  process(clk) is
    begin
        if rising_edge(clk) then
            if reset_n = '0' then
                data <= (others => '0');
                control <= (others => '0');
            end if;
        end if;

        -- Question 5
        case address is
            when "00" =>
                -- data R/W
                if read = '1' then
                    readdata <= data;
                elsif write = '1' then
                    data <= writedata;
                end if;
            when "01" =>
                -- control R/W
                if read = '1' then
                    readdata <= control;
                elsif write = '1' then
                    control <= writedata;
                end if;
            when "10" =>
                -- features RO
                if read = '1' then
                    readdate <= features;
                end if;
            when "11" =>
                -- magic RO
                if read = '1' then
                    readdata <= x"41445335";
                end if;
            when others =>
                report "unexpected address, can't decode";
		        severity failure;
        end case;

    end process reset;

end architecture rtl;