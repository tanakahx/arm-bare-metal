CPU := arm926ej-s
# CPU := cortex-m3
# CPU := cortex-a9

ifeq ($(CPU), arm926ej-s)
MACHINE := versatilepb
VMA := 0x00010000
endif

ifeq ($(CPU), cortex-m3)
MACHINE := lm3s6965evb
VMA := 0x00000000
endif

ifeq ($(CPU), cortex-a9)
MACHINE := realview-pbx-a9
VMA := 0x00000000
endif

CC := arm-none-eabi-gcc
CFLAGS = -Wall -fno-builtin

LD := ld-arm
LDFLAGS =

OBJS := src/main.o

include cpu/$(CPU)/Makefile

TARGET := image

$(TARGET): $(TARGET).elf
	objcopy-arm -O binary $< $@

$(TARGET).elf: $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $^

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: dis run clean

dis:
	objdump-arm -D -b binary -m arm --adjust-vma=$(VMA) $(TARGET)

run:
	qemu-system-arm -M $(MACHINE) -nographic -kernel $(TARGET)

clean:
	-@$(foreach obj, */*/*.o, rm $(obj);)
	-rm $(TARGET) $(TARGET).elf
