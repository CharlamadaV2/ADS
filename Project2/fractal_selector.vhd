use library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

use work.pipeline_package.all;
library ads;
use ads.ads_fixed.all;

-- When SW9 is High: Fatou and Julia sets
-- When SW9 is Low: Mandelbot set

-- When switching between fractals, you should also switch
-- between windowing areas, as to center the fractals in the screen.

-- Description:
-- 1. We need to map points on the screen to points on the complex plane.
-- The VGA gives us a y-coorrdinate in lines, and the x-coordiantes as pixels in line

-- 2. We need to translate the x and y values into a viewing range in the complex plane
-- C_w is the viewing range
--     We denote this operations as M: (p, l) -> C_w
--     For the resolution 480 x 640
--     R{c} := 3.2 x p/640 
--     I{c} := 2.2 x (240-l) / 480
--     for the real and imaginary parts of the number, respectively

entity fractal_selector is
    port(
        switch_9 : in std_logic;
        seed_input : in 
        selector_output : out signal_elements;
    );

end entity fractal_selector;
architecture rtl of fractal_selector is
    
    begin
        if switch_9 then
            selector_output.z = --initial value
            selector_output.c = -- some constant
        else 
            selector_output.z = 0
            selector_output.c = --initial value
        end if;

end architecture rtl;