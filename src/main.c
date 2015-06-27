extern volatile unsigned int *const UARTDR;

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
