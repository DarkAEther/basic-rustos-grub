.PHONY: default build run clean

default: run
build: build/rustos.iso

run: build/rustos.iso
	qemu-system-x86_64 -cdrom build/rustos.iso

build/rustos.iso: build/kernel.bin
	mkdir -p build/isofiles/boot/grub
	cp src/grub.cfg build/isofiles/boot/grub
	cp build/kernel.bin build/isofiles/boot
	grub-mkrescue -o build/rustos.iso build/isofiles

build/multiboot_header.o: src/multiboot_header.asm
	mkdir -p build
	nasm -o build/multiboot_header.o -f elf64 src/multiboot_header.asm

build/boot.o: src/boot.asm
	mkdir -p build
	nasm -f elf64 -o build/boot.o src/boot.asm

build/kernel.bin: build/multiboot_header.o build/boot.o src/linker.ld rust/target/x86_64-unknown-rustos-gnu/release/librustos.a
	ld -n -o build/kernel.bin -T src/linker.ld build/multiboot_header.o build/boot.o rust/target/x86_64-unknown-rustos-gnu/release/librustos.a

rust/target/x86_64-unknown-rustos-gnu/release/librustos.a: rust/src/lib.rs
	cd rust; xargo build --release --target=x86_64-unknown-rustos-gnu; cd ..

clean:
	rm -r build
	cd rust; cargo clean; cd ..
