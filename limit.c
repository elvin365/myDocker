#include <cap-ng.h>
#include <string.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>


int main(int argc, char *argv[], char *envp[])
{
	if (2 != argc || 1 != strlen(argv[1]) || '0' != argv[1][0])
	{
	}
	else
	{
		capng_clear(CAPNG_SELECT_BOTH);

		capng_updatev(CAPNG_ADD, (CAPNG_EFFECTIVE | CAPNG_PERMITTED | CAPNG_INHERITABLE | CAPNG_BOUNDING_SET), CAP_SETGID , CAP_NET_BIND_SERVICE , CAP_SYS_CHROOT , CAP_SETUID, -1);

		capng_apply(CAPNG_SELECT_BOTH);		
	}

	char *const argv_1[] = { "/bin/vsftpd_pid.sh", NULL };

	char *const argv_2[] = { "/bin/vsftpd_pid.sh", NULL };

	pid_t childPID = fork();

	if (!childPID)
	{
		execve("/bin/vsftpd_pid.sh", argv_1, envp);
	}
	else if (0 < childPID)
	{	
		wait(NULL);
		
		execve("/bin/vsftpd_pid.sh", argv_2, envp);
	}

	return 0;
}
