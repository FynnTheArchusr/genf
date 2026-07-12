#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <pwd.h>

#define PINK   "\033[35m"
#define BLUE   "\033[34m"
#define YELLOW "\033[33m"
#define RESET  "\033[0m"

void get_username(char *buffer, size_t size) {
    const char *user = getenv("USER");

    if (user) {
        strncpy(buffer, user, size - 1);
        buffer[size - 1] = '\0';
        return;
    }

    struct passwd *pw = getpwuid(getuid());
    if (pw) {
        strncpy(buffer, pw->pw_name, size - 1);
        buffer[size - 1] = '\0';
    } else {
        strncpy(buffer, "user", size);
    }
}

void get_cpu(char *buffer, size_t size) {
    FILE *fp = fopen("/proc/cpuinfo", "r");
    if (!fp) {
        strncpy(buffer, "Unknown", size);
        return;
    }

    char line[512];

    while (fgets(line, sizeof(line), fp)) {
        if (strncmp(line, "model name", 10) == 0) {
            char *colon = strchr(line, ':');
            if (colon) {
                colon += 2; // Skip ": "
                strncpy(buffer, colon, size - 1);
                buffer[size - 1] = '\0';

                // Remove trailing newline
                buffer[strcspn(buffer, "\n")] = '\0';

                fclose(fp);
                return;
            }
        }
    }

    fclose(fp);
    strncpy(buffer, "Unknown", size);
}

int main(void) {
    char username[64];
    char cpu[256];

    get_username(username, sizeof(username));
    get_cpu(cpu, sizeof(cpu));

    printf(PINK "GentooBox" RESET " " BLUE "%s" RESET "\n", username);
    printf(YELLOW "CPU" RESET ": %s\n", cpu);

    printf(PINK
        "┏━━━┓━━━━━━━━━┏┓━━━━━━━━━\n"
        "┃┏━┓┃━━━━━━━━┏┛┗┓━━━━━━━━\n"
        "┃┃━┗┛┏━━┓┏━┓━┗┓┏┛┏━━┓┏━━┓\n"
        "┃┃┏━┓┃┏┓┃┃┏┓┓━┃┃━┃┏┓┃┃┏┓┃\n"
        "┃┗┻━┃┃┃━┫┃┃┃┃━┃┗┓┃┗┛┃┃┃┗┛\n"
        "┗━━━┛┗━━┛┗┛┗┛━┗━┛┗━━┛┗━━┛\n"
        "━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        "━━━━━━━━━━━━━━━━━━━━━━━━━\n"
        RESET);

    return 0;
}
