This *King of Fighters*-esque fighting game was designed as a final project for ECE 287: Digital Systems Design at Miami University.

The goal of this project was to design a video game similar to *Street Fighter* or *King of Fighters* where two fighters face off in an attempt to lower the other's health to zero while also trying not to get hit themselves.

Players can walk, jump, and attack in either state.  Players jumping cannot be hit by players standing, and vice versa.  Each player has 8 health, and each hit lowers that number by 1.

## Project Design

This project is divided into several individual parts: video output, keyboard input, and game logic.

The video output modules (`vga.v` and `graphics.v`) handle the conversion of game states into VGA output.  The VGA adapter outputs to a monitor at 60Hz and a resolution of 640x480.

The keyboard input modules (`player_input.v`, `key_watcher.v`, `keyboard_press_driver.v`, and `keyboard_inner_driver.v`) handle the reading and conversion of PS/2 keyboard scan codes into player input registers (for walking direction, jumping, attacking, etc.).

The game logic modules (`logic.v`) handle all game logic, such as player movement, jumping/gravity, and attacking.

The sprites are handled using 1-Port ROMs created using the IP tools available in Intel's Quartus Prime software.  Each ROM is 21 bits in width and 65,536 words in depth.  Coordinates are stored as 16-bit numbers, where the first 8 bits are the `x` value and the second 8 bits are the `y` value.  The colors themselves are stored as 7-bit numbers, where the first 6 bits are the RGB value (2 bits each) and the final bit is the alpha flag (0 if transparent, 1 if opaque).

The sprites are loaded into the ROMs using the Memory Initialization Files (MIFs) generated using the custom Python script located at `util/png_to_mif`.

## Citations

The `keyboard_press_driver.v` and `keyboard_inner_driver.v` modules were written by Dr. Hauck at the University of Washington ([class.ece.uw.edu/271/hauck2/de1/keyboard](https://class.ece.uw.edu/271/hauck2/de1/keyboard/KeyboardFiles.zip)).

The `vga.v` module is adapted (with some modifications for use on the DE2-115) from *Time to Explore* ([timetoexplore.net/blog/arty-fpga-vga-verilog-01](https://timetoexplore.net/blog/arty-fpga-vga-verilog-01)).

## Conclusions

This project was successful overall, but some changes had to be made throughout the design process to accomodate limitations of the hardware.  For instance, crouching/crouch attacks were initially intended features, but they had to be removed because the DE2-115 board did not have enough block memory to store any more sprites.

## Design Results

The completed design takes 1,350 logic elements and 2,752,512 bits of block memory when optimized in Quartus.

## Images

![Game starting](https://raw.githubusercontent.com/chrisblutz/digital-design-project/master/images/game.jpg)

![Player 1 attacking](https://raw.githubusercontent.com/chrisblutz/digital-design-project/master/images/game_p1_attack.jpg)

![Player 2 attacking](https://raw.githubusercontent.com/chrisblutz/digital-design-project/master/images/game_p2_attack.jpg)
