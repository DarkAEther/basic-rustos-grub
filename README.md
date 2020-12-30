# Building a basic OS using Assembly and Rust
This is a project intended to learn more about how computers and operating systems work together.
This is my experimental work that follows the path charted by the IntermezzOS book (First Edition).

# Working with this code

## Source
All source code is present in the `src` directory.

## Building
All build related files are stored in the `build` directory. This will be created by `make` at build time.
Be sure to have the nightly version of rust installed and run `rustup override set nightly` in the root directory before building the project.

To build the project, run `make build`.

## Running the project
The built ISO can be run on x86_64 hardware or using QEMU. In this implementation, we work with QEMU.
You can run the OS by using the `make run` command.

## Clean up
Running `make clean` cleans up the `build` directory.

# References
1. IntermezzOS book (First Edition) - http://intermezzos.github.io/book/first-edition/
