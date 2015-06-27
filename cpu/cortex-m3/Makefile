CFLAGS += -march=armv7-m -mcpu=$(CPU) -mthumb
LDFLAGS += -T cpu/$(CPU)/arm.ld
OBJS := cpu/$(CPU)/boot.o cpu/$(CPU)/system.o $(OBJS)
