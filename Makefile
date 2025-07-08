CC = arm-hisiv300-linux-gcc
SDK_PATH = /Hi3520D_SDK_V1.0.2.2
CFLAGS = -I$(SDK_PATH)/include -Wall
LDFLAGS = -L$(SDK_PATH)/lib -lmpi -ldnvqe

all:
    $(CC) main.c -o app $(CFLAGS) $(LDFLAGS)
