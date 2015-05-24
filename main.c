volatile unsigned int *const UARTDR = (unsigned int *)0x101F1000;

// Put a string on standard output from UART0 device (PL011).
void puts(const char *s)
{
	while (*s) {
		*UARTDR = *s++;
	}
	*UARTDR = '\n';
}

int main()
{
	puts("Hello, world!");

	return 0;
}
