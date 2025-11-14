use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.pipeline_package.all;
library ads;
use ads.ads_fixed.all;
use ads.ads_complex_pkg.all;

/*
Description:
Every clock cycle, pipeline output should yield the number of iterations for a particular point in the set
Pros: Higher resolutons images, no intermedia memory, can make use of high iteration count.

- Every stage of the pipeline performs the equivalent of one iteration.
- Every stage propogates the results of the square and accumulate operation to the next stage.
- Each stage performs comparison of the magnitude of current z to threshold.
- Pipeline propogates the result of the comparison and the pipeline stage number.
- If z > threshold: any subsequent stages of the pipeline propagate the stage number that has been sent to it.

Output of the pipeline will contain # of iterations for the seed c to escape.
- Use these numbers to index the color table.
- We can feed new seed c to the start of pipeline every clock cycle.
*/

-- Create a pipeline with the stages

entity pipeline_stage is 
    generic(
        threshold : ads_sfixed := to_ads_sfixed(4);
        stage_number : natural
    );
    port(
        reset : in std_logic;
        clock : in std_logic;

        stage_input : in signal_elements;
        stage_output : out signal_elements

    );

end pipeline_stage;

architecture rtl of pipeline_stage is
    -- add any signals you may need
    signal stage_valid : boolean; 
    -- signal stage_number : natural; --remove this if wrong
    signal multiply_result : ads_complex;
    signal add_result : ads_complex;
    signal comp_result : ads_complex;

    signal re_re, im_im, re_im, abs2_z: ads_sfixed;

begin
    -- perform computations and complete assignments
    --stage_input.stage_overflow := false;
    -- ...
    --multiply_result <= stage_input.z * stage_input.z;
    re_re <= stage_input.z.re * stage_input.z.re;
    im_im <= stage_input.z.im * stage_input.z.im;
    re_im <= stage_input.z.re * stage_input.z.im;

    abs2_z <= re_re + im_im;
    multiply_result.re <= re_re - im_im;
    multiply_result.im <= re_im + re_im;

    stage: process(clock, reset) is
    begin   
        if reset = '0' then
        -- reset pipeline stage
            stage.stage_data = 0;
            stage.stage_overflow = 0;
            stage.stage_number = 0;
            stage.stage_valid = 0;

        elsif rising_edge(clock) then
            -- I don't remember what we did to optimize this portion of the code
            -- When rising 

            if stage_input.stage_overflow then
                stage_output.stage_data <= stage_input.stage_data;
            else
                stage_output.stage_data <= stage.stage_number;
                -- Is stage_number defined??
            end if;
            --same with this
            stage_output.c <= stage_input.c;
            --first part
            -- multiply then store in register

            --second part
            -- add then store in register
            stage_output.z <= stage_input.c + multiply_result

            --third part
            -- compare then drive all outputs
            -- optimize for 3 multipies
    
            if abs2_z > threshold then
                    stage_input.stage_overflow := true;

            --stage_output.z <= stage_input.z * stage_input.z + stage_input.c;
            -- if stage_input.stage_overflow then
            --     stage_output.stage_overflow <= stage_input.stage_overflow;
            --     else
            --     stage_output.stage_overflow <= stage_input.stage_overflow > threshold;
            -- end if;

        end if;
    end process stage;


end architecture rtl;
