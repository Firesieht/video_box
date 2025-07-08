CC = arm-hisiv100nptl-linux-gcc
SDK_PATH = /Hi3520D_SDK_V1.0.2.2
CFLAGS = -I$(SDK_PATH)/mpp/include -Wall
LDFLAGS = -L$(SDK_PATH)/mpp/lib -lmpi -ldnvqe

all:
	$(CC) main.c -o app $(CFLAGS) $(LDFLAGS)
