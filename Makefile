# MusicLab's Makefile helper
# Used to prevent misusage of cmake
RELEASE_DIR		=	Release
DEBUG_DIR		=	Debug
BUILD_DIR		=	$(RELEASE_DIR)
BUILD_TYPE		=	Release

CMAKE_ARGS		=

RM		=	rm -rf

all: release

build:
	cmake -E make_directory $(BUILD_DIR)
	cmake -B $(BUILD_DIR) -H. -DCMAKE_BUILD_TYPE=$(BUILD_TYPE) ${CMAKE_ARGS} -GNinja
	cmake --build $(BUILD_DIR)

release:
	$(MAKE) build BUILD_DIR=$(RELEASE_DIR) BUILD_TYPE=Release

debug:
	$(MAKE) build BUILD_DIR=$(DEBUG_DIR) BUILD_TYPE=Debug

tests:
	$(MAKE) release CMAKE_ARGS+=-DML_TESTS=TRUE

tests_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_TESTS=TRUE

run_tests: tests
	ninja -C $(RELEASE_DIR) test

run_tests_debug: tests_debug
	ninja -C $(DEBUG_DIR) test

benchmarks:
	$(MAKE) release CMAKE_ARGS+=-DML_BENCHMARKS=TRUE

benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_BENCHMARKS=TRUE

# Audio
audio:
	$(MAKE) release CMAKE_ARGS+=-DML_AUDIO=TRUE

audio_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_AUDIO=TRUE

audio_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_AUDIO=TRUE -DML_TESTS=TRUE"

audio_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_AUDIO=TRUE -DML_TESTS=TRUE"

audio_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_AUDIO=TRUE -DML_BENCHMARKS=TRUE"

audio_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_AUDIO=TRUE -DML_BENCHMARKS=TRUE"

# Board
board:
	$(MAKE) release CMAKE_ARGS+=-DML_BOARD=TRUE

board_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_BOARD=TRUE

board_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_BOARD=TRUE -DML_TESTS=TRUE"

board_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_BOARD=TRUE -DML_TESTS=TRUE"

board_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_BOARD=TRUE -DML_BENCHMARKS=TRUE"

board_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_BOARD=TRUE -DML_BENCHMARKS=TRUE"

# Board Server
board_server:
	$(MAKE) release CMAKE_ARGS+=-DML_BOARD_SERVER=TRUE

board_server_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_BOARD_SERVER=TRUE

board_server_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_BOARD_SERVER=TRUE -DML_TESTS=TRUE"

board_server_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_BOARD_SERVER=TRUE -DML_TESTS=TRUE"

board_server_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_BOARD_SERVER=TRUE -DML_BENCHMARKS=TRUE"

board_server_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_BOARD_SERVER=TRUE -DML_BENCHMARKS=TRUE"

# Core
core:
	$(MAKE) release CMAKE_ARGS+=-DML_CORE=TRUE

core_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_CORE=TRUE

core_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_CORE=TRUE -DML_TESTS=TRUE"

core_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_CORE=TRUE -DML_TESTS=TRUE"

core_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_CORE=TRUE -DML_BENCHMARKS=TRUE"

core_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_CORE=TRUE -DML_BENCHMARKS=TRUE"

# Protocol
protocol:
	$(MAKE) release CMAKE_ARGS+=-DML_PROTOCOL=TRUE

protocol_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_PROTOCOL=TRUE

protocol_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_PROTOCOL=TRUE -DML_TESTS=TRUE"

protocol_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_PROTOCOL=TRUE -DML_TESTS=TRUE"

protocol_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_PROTOCOL=TRUE -DML_BENCHMARKS=TRUE"

protocol_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_PROTOCOL=TRUE -DML_BENCHMARKS=TRUE"

# Studio
studio:
	$(MAKE) release CMAKE_ARGS+=-DML_STUDIO=TRUE

studio_debug:
	$(MAKE) debug CMAKE_ARGS+=-DML_STUDIO=TRUE

studio_tests:
	$(MAKE) release CMAKE_ARGS+="-DML_STUDIO=TRUE -DML_TESTS=TRUE"

studio_tests_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_STUDIO=TRUE -DML_TESTS=TRUE"

studio_benchmarks:
	$(MAKE) release CMAKE_ARGS+="-DML_STUDIO=TRUE -DML_BENCHMARKS=TRUE"

studio_benchmarks_debug:
	$(MAKE) debug CMAKE_ARGS+="-DML_STUDIO=TRUE -DML_BENCHMARKS=TRUE"

clean:
	$(RM) ${RELEASE_DIR}
	$(RM) ${DEBUG_DIR}

fclean: clean

re: clean all

.PHONY: all \
	release debug \
	examples examples_debug \
	tests tests_debug run_tests run_tests_debug \
	benchmarks benchmarks_debug \
	audio audio_debug audio_tests audio_tests_debug audio_benchmarks audio_benchmarks_debug \
	board board_debug board_tests board_tests_debug board_benchmarks board_benchmarks_debug \
	core core_debug core_tests core_tests_debug core_benchmarks core_benchmarks_debug \
	protocol protocol_debug protocol_tests protocol_tests_debug protocol_benchmarks protocol_benchmarks_debug \
	studio studio_debug studio_tests studio_tests_debug studio_benchmarks studio_benchmarks_debug \
	clean fclean \
	re