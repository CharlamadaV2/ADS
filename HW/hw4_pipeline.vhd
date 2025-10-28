use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.hw4_pkg.all;


architecture rtl of pipeline_stage is
    -- add any signals you may need
    signal stage_valid : boolean; 
    begin
    -- perform computations and complete assignments
    -- ...
    stage_input.stage_overflow
    stage: process(clock, reset) is
    begin
        if reset = '0' then
        -- reset pipeline stage
        elsif rising_edge(clock) then
            -- I don't remember what we did to optimize this portion of the code
            if stage.stage_input.stage_overflow then
                stage_output.stage_data <= stage_input.stage_data;
            else
                stage_output.stage_data <= stage_number;
                -- Is stage_number defined??
            end if;
            --same with this
            stage_output.c <= stage_input.c;
            stage_output.z <= stage_input.z * stage_input.z + stage_input.c;
            if stage_input.stage_overflow then
                stage_output.stage_overflow <= stage_input.stage_overflow;
                else
                stage_output.stage_overflow <= stage_input.stage_overflow > threshold;
            end if;
        end if;
    end process stage;
end architecture rtl;
