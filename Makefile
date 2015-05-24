image.bin: boot.S main.c arm.ls
	arm-none-eabi-gcc -mcpu=arm926ej-s -c boot.S
	arm-none-eabi-gcc -mcpu=arm926ej-s -c main.c
	ld-arm -o image.elf -T arm.ls boot.o main.o
	objcopy-arm -O binary image.elf image.bin

dis:
	objdump-arm -D -b binary -m arm --adjust-vma=0x00010000 image.bin

run:
	qemu-system-arm -M versatilepb -nographic -kernel image.bin

clean:
	-rm *.o image.elf image.bin
