#include <stdio.h>
#include "hi_comm_vi.h"
#include "mpi_vi.h"

int main() {
    printf("Hello, Hi3520D!\n");
    HI_MPI_VI_Init(); 
    return 0;
}