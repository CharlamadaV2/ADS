use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

library ads;
use ads.ads_complex_pkg.ads_complex;

package pipeline_package is
    
    type signal_elements is record
        c : ads_complex;
        z : ads_complex;

        stage_data : natural;
        stage_overflow : boolean;
        stage_valid : boolean;
    end record signal_elements;
    
end package body;