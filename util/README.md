This folder contains scripts and utilities for building the project contained
in this repository.

## PNG to Verilog (`png_to_v`)

This Python script converts PNG images into Verilog modules which output red, green,
blue, and alpha color values (along with image width/height).

**Syntax:**
```sh
utils/png_to_v --rdepth=8 --gdepth=8 --bdepth=8 --xywidth=10 image1.png ...
```

The `rdepth`, `gdepth`, and `bdepth` options determine how many bits are in each
color channel.  The script assumes all input files are 24-bit color PNGS (which
have 8 bits per color channel).  The `xywidth` option determines how many bits
the X/Y positions need.  Any number of images can be provided.
