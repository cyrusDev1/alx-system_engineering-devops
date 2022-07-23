#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

/**
 * infinite_while - Run an infinite while loop.
 * Return: Always 0.
 */

int infinite_while(void)
{
	while (1)
		sleep(1);
	return (0);
}

/**
 * main - Creates five zombie processes.
 * Return: Always 0.
 */

int main(void)
{
	int i;
	pid_t pid;

	for (i = 0; i < 5; i++)
	{
		pid = fork();
		if (pid > 0)
			printf("Zombie process created, PID: %d\n", pid);
		else
			return (0);
	}

	infinite_while();
	return (0);
}
