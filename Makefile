#CPU := arm926ej-s
CPU := cortex-m3
#CPU := cortex-a9

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

CC := arm-linux-gnueabi-gcc
LD := arm-linux-gnueabi-ld
OBJCOPY := arm-linux-gnueabi-objcopy
OBJDUMP := arm-linux-gnueabi-objdump
QEMU := qemu-system-arm

CFLAGS = -Wall -fno-builtin
LDFLAGS =

OBJS := src/main.o

TARGET := image

all:
	$(MAKE) $(TARGET)

include cpu/$(CPU)/Makefile

$(TARGET).elf: $(OBJS)
	$(LD) -o $@ $(LDFLAGS) $^

$(TARGET): $(TARGET).elf
	$(OBJCOPY) -O binary $< $@

%.o: %.c
	$(CC) $(CFLAGS) -o $@ -c $<

%.o: %.S
	$(CC) $(CFLAGS) -o $@ -c $<

.PHONY: dis run clean

dis:
	$(OBJDUMP) -D -b binary -m arm --adjust-vma=$(VMA) $(TARGET)

run:
	$(QEMU) -M $(MACHINE) -nographic -kernel $(TARGET)

clean:
	-@$(foreach obj, */*/*.o, rm $(obj);)
	-rm $(TARGET) $(TARGET).elf
