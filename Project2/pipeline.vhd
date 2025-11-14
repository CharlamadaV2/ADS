use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.pipeline_package.all;
library ads;
use ads.ads_fixed.all;

use work.pipeline_stage.all;
use work.fractal_selector.all;

entity pipeline is
    generic(
        --At least 16 stages for pipeline
        max_stage : positive := 16

    );

end pipeline;

architecture rtl of pipeline is
    type stage_data_array_type is array(0 to max_stage) of signal_elements; 
    signal stage_data_array: signal_data_array_type;
    
begin
    --Connected output from fractal selector to initial pipeline stage
    stage_data_array(0).z <= z_out;
    stage_data_array(0).c <= c_out;

    g_pipeline_stage: for stage_number in 0 to max_stage - 1 generate 
        --pipeline_stage(stage_number + 1) <= pipeline_stage(stage_number)
        stage: entity work.pipeline_stage
            generic map (
                threshold => to_ads_sfixed(4),
                stage_number => stage_number
            )
            port map (
                reset => reset,
                clock => clock,

                -- Figure out how to not have this on initial stage
                stage_input => stage_data_array(stage_number),
                stage_output => stage_data_array(stage_number + 1)
            );

    end generate g_pipeline_stage;

    -- Drive the output of the pipeline to color_data
    pipieline_output <= pipeline_stage(max_stage);
    
end architecture rtl;

