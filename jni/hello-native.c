#include <stdio.h>

int err(void)
{
	return fprintf(stderr, "A quick brown fox jumps over the lazy dog.\n");
}

int main(int argc, char *argv[])
{
	printf("Hello, world!\n");
	return err();
}
