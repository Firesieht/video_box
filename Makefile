# Первые 5 строк из старой версии:
CC = arm-hisiv100nptl-linux-gcc
SDK_PATH = /Hi3520D_SDK_V1.0.2.2
CFLAGS = -I$(SDK_PATH)/mpp/include -Wall
LDFLAGS = -L$(SDK_PATH)/mpp/lib -lmpi -ldnvqe

# Новые дополнения из новой версии:
REL_LIB = $(SDK_PATH)/mpp/lib
MPI_LIBS := $(REL_LIB)/libmpi.a $(REL_LIB)/libhdmi.a

# Дополнительные библиотеки (при необходимости, можно оставлять пустыми)
AUDIO_LIBA =
JPEGD_LIBA =
COMM_OBJ =

# Разделяем исходные файлы:
# Файлы для пользовательского приложения (исключая *.mod.c, предназначенные для модулей ядра)
USR_SRC := $(filter-out %.mod.c, $(wildcard *.c))
USR_OBJ := $(USR_SRC:.c=.o)

# Имя целевого пользовательского приложения:
TARGET := app

# Путь к исходникам ядра (для сборки модуля)
KERNELDIR := $(SDK_PATH)/osdrv/kernel/linux-3.0.y
CROSS_COMPILE = arm-hisiv100nptl-linux-

.PHONY: all app module clean cleanstream

# Цель all собирает и приложение, и модуль
all: app module

# Сборка приложения (пользовательское пространство)
app: $(TARGET)

$(TARGET): $(USR_OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -lpthread -lm $(MPI_LIBS) $(AUDIO_LIBA) $(JPEGD_LIBA)

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

# Сборка модуля ядра (файл nvp6114_ex.mod.c)
# Эта цель вызывает систему сборки ядра (Kbuild),
# которая корректно обрабатывает заголовочные файлы ядра (linux/module.h и др.)
module:
	$(MAKE) -C $(KERNELDIR) M=$(PWD) CROSS_COMPILE=$(CROSS_COMPILE) obj-m=nvp6114_ex.mod.o

clean:
	@rm -f $(USR_OBJ) $(TARGET) $(COMM_OBJ)
	$(MAKE) -C $(KERNELDIR) M=$(PWD) CROSS_COMPILE=$(CROSS_COMPILE) clean

cleanstream:
	@rm -f *.h264 *.jpg *.mjp *.mp4