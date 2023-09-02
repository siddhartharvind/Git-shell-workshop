#include <stdio.h>
#include <stdlib.h>

int main() {
    char line[100];  // Assuming each line has at most 100 characters
    int num1, num2;

    while (fgets(line, sizeof(line), stdin) != NULL) {
        if (sscanf(line, "%d %d", &num1, &num2) == 2) {
            int sum = num1 + num2;
            printf("%d\n", sum);
        } else {
            fprintf(stderr, "Error: Invalid input format\n");
            return 1; // Exit with an error code
        }
    }

    return 0; // Exit successfully
}