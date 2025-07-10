# Первые 5 строк из старой версии:
CC = arm-hisiv100nptl-linux-gcc
SDK_PATH = /Hi3520D_SDK_V1.0.2.2
CFLAGS = -I$(SDK_PATH)/mpp/include -Wall
LDFLAGS = -L$(SDK_PATH)/mpp/lib -lmpi -ldnvqe
CFLAGS += -I$(SDK_PATH)/osdrv/kernel/linux-3.0.y/include
# Новые дополнения из новой версии:
# Определяем дополнительный путь к библиотекам
REL_LIB = $(SDK_PATH)/mpp/lib
KERNELDIR := $(SDK_PATH)/osdrv/kernel/linux-3.0.y

# Дополнительные библиотеки (при условии, что они лежат по указанным путям)
MPI_LIBS := $(REL_LIB)/libmpi.a $(REL_LIB)/libhdmi.a

# Если эти переменные требуются, задайте их или оставьте пустыми
AUDIO_LIBA =
JPEGD_LIBA =
COMM_OBJ =

# Обработка исходных файлов
SRC  := $(wildcard *.c)
OBJ  := $(SRC:%.c=%.o)

# Целевой исполняемый файл
TARGET := app

.PHONY: all clean cleanstream

# Основное правило сборки
all: 
	$(MAKE) -C $(KERNELDIR) M=$(PWD) CROSS_COMPILE=$(CROSS_COMPILE) modules
	$(TARGET)


$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -lpthread -lm $(MPI_LIBS) $(AUDIO_LIBA) $(JPEGD_LIBA)

clean:
	@rm -f $(OBJ) $(TARGET) $(COMM_OBJ)

cleanstream:
	@rm -f *.h264 *.jpg *.mjp *.mp4