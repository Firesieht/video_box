# Первые 5 строк из старой версии:
CC = arm-hisiv100nptl-linux-gcc
SDK_PATH = /Hi3520D_SDK_V1.0.2.2
CFLAGS = -I$(SDK_PATH)/mpp/include -Wall
LDFLAGS = -L$(SDK_PATH)/mpp/lib -lmpi -ldnvqe

# Новые дополнения из новой версии:
REL_LIB = $(SDK_PATH)/mpp/lib
MPI_LIBS := $(REL_LIB)/libmpi.a $(REL_LIB)/libhdmi.a

# Дополнительные библиотеки (если требуются, можно оставить пустыми)
AUDIO_LIBA =
JPEGD_LIBA =
COMM_OBJ =

# Обработка исходных файлов
SRC  := $(wildcard *.c)
OBJ  := $(SRC:.c=.o)

# Название целевого исполняемого файла
TARGET := app

.PHONY: all clean cleanstream

all: $(TARGET)

$(TARGET): $(OBJ)
	$(CC) $(CFLAGS) $(LDFLAGS) -o $@ $^ -lpthread -lm $(MPI_LIBS) $(AUDIO_LIBA) $(JPEGD_LIBA)

# Правило сборки .o из .c
%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	@rm -f $(OBJ) $(TARGET) $(COMM_OBJ)

cleanstream:
	@rm -f *.h264 *.jpg *.mjp *.mp4