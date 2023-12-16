#!/nix/store/lm10ywzflq9qfhr4fl0zqxrhiksf28ks-bash-5.2-p15/bin/bash
# Test our CMake support library.

if [[ -z "$1" || -z "$2" ]]; then
  >&2 printf '%s\n' "Usage: $0 <cmake_lib_directory> <test_output_directory>"
  exit
fi

NUMBER_OF_FAILURES=0

run_test() {
  local test_name=$1
  local lib_directory=$2
  local test_directory=$3
  printf 'Running test %s...\n' $test_name

  mkdir -p $test_directory/$test_name
  eval $test_name $lib_directory $test_directory/$test_name

  if [[ "$?" != "0" ]]; then
    printf '\tTest %s FAILED\n' $test_name
    NUMBER_OF_FAILURES=$(($NUMBER_OF_FAILURES + 1))
  else
    printf '\tPASS\n' $test_name
  fi
}

summary() {
  if [[ $NUMBER_OF_FAILURES = "0" ]]; then
    printf 'Test complete. All tests passed.\n'
  else
    printf 'Test complete. %s tests failed.\n' $NUMBER_OF_FAILURES
  fi
}

cmake_version() {
  printf '%s\n\t%s\n' "Using CMake: " $(which cmake)
  cmake --version
}

test_target_set_link_script() {
  local lib_directory=$1
  local test_directory=$2

  cat - <<EOF >$test_directory/toolchain.cmake
  set(CMAKE_SYSTEM "Linux")
  set(CMAKE_C_COMPILER $(which gcc))
  set(CMAKE_CXX_COMPILER $(which g++))
EOF

  cat - <<'  EOF' >$test_directory/CMakeLists.txt
  cmake_minimum_required(VERSION 3.25)
  project(test)
  include(${METALWORK_CMAKE_LIB_PATH}/metalwork.cmake)
  add_executable(test test.c)
  target_set_link_script(test target.ld)
  EOF

  cat - <<'  EOF' >$test_directory/test.c
  extern int _test_variable;
  int main() {
    volatile int test = _test_variable;
    while (1) test++;
  }
  EOF

  cat - <<'  EOF' >$test_directory/target.ld
  _test_variable = 1;
  SECTIONS
  {
    . = 0x10000;
    .text : { *(.text) }
    . = 0x8000000;
    .data : { *(.data) }
    .bss : { *(.bss) }
  }
  EOF

  (cd $test_directory \
    && cmake -B builddir -G Ninja \
      -DMETALWORK_CMAKE_LIB_PATH=$lib_directory \
      -DCMAKE_TOOLCHAIN_FILE=$test_directory/toolchain.cmake \
    && ninja -C builddir)
}

test_target_generate_map_file() {
  local lib_directory=$1
  local test_directory=$2

  cat - <<EOF >$test_directory/toolchain.cmake
  set(CMAKE_SYSTEM "Linux")
  set(CMAKE_C_COMPILER $(which gcc))
  set(CMAKE_CXX_COMPILER $(which g++))
EOF

  cat - <<'  EOF' >$test_directory/CMakeLists.txt
  cmake_minimum_required(VERSION 3.25)
  project(test)
  include(${METALWORK_CMAKE_LIB_PATH}/metalwork.cmake)
  add_executable(test test.c)
  target_generate_map_file(test)
  EOF

  cat - <<'  EOF' >$test_directory/test.c
  int main() {
    volatile int test = 0;
    while (1) test++;
  }
  EOF

  (cd $test_directory \
    && cmake -B builddir -G Ninja \
      -DMETALWORK_CMAKE_LIB_PATH=$lib_directory \
      -DCMAKE_TOOLCHAIN_FILE=$test_directory/toolchain.cmake \
    && ninja -C builddir)

  test -f $test_directory/builddir/test.map
}

test_target_generate_artifact_hex() {
  local lib_directory=$1
  local test_directory=$2

  cat - <<EOF >$test_directory/toolchain.cmake
  set(CMAKE_SYSTEM "Linux")
  set(CMAKE_C_COMPILER $(which gcc))
  set(CMAKE_CXX_COMPILER $(which g++))
EOF

  cat - <<'  EOF' >$test_directory/CMakeLists.txt
  cmake_minimum_required(VERSION 3.25)
  project(test)
  include(${METALWORK_CMAKE_LIB_PATH}/metalwork.cmake)
  add_executable(test test.c)
  target_generate_artifact(test HEX)
  EOF

  cat - <<'  EOF' >$test_directory/test.c
  int main() {
    volatile int test = 0;
    while (1) test++;
  }
  EOF

  (cd $test_directory \
    && cmake -B builddir -G Ninja \
      -DMETALWORK_CMAKE_LIB_PATH=$lib_directory \
      -DCMAKE_TOOLCHAIN_FILE=$test_directory/toolchain.cmake \
    && ninja -C builddir)

  test -f $test_directory/builddir/test.hex
}

test_target_generate_artifact_bin() {
  local lib_directory=$1
  local test_directory=$2

  cat - <<EOF >$test_directory/toolchain.cmake
  set(CMAKE_SYSTEM "Linux")
  set(CMAKE_C_COMPILER $(which gcc))
  set(CMAKE_CXX_COMPILER $(which g++))
EOF

  cat - <<'  EOF' >$test_directory/CMakeLists.txt
  cmake_minimum_required(VERSION 3.25)
  project(test)
  include(${METALWORK_CMAKE_LIB_PATH}/metalwork.cmake)
  add_executable(test test.c)
  target_generate_artifact(test BIN)
  EOF

  cat - <<'  EOF' >$test_directory/test.c
  int main() {
    volatile int test = 0;
    while (1) test++;
  }
  EOF

  (cd $test_directory \
    && cmake -B builddir -G Ninja \
      -DMETALWORK_CMAKE_LIB_PATH=$lib_directory \
      -DCMAKE_TOOLCHAIN_FILE=$test_directory/toolchain.cmake \
    && ninja -C builddir)

  test -f $test_directory/builddir/test.bin
}

test_target_generate_artifact_srec() {
  local lib_directory=$1
  local test_directory=$2

  cat - <<EOF >$test_directory/toolchain.cmake
  set(CMAKE_SYSTEM "Linux")
  set(CMAKE_C_COMPILER $(which gcc))
  set(CMAKE_CXX_COMPILER $(which g++))
EOF

  cat - <<'  EOF' >$test_directory/CMakeLists.txt
  cmake_minimum_required(VERSION 3.25)
  project(test)
  include(${METALWORK_CMAKE_LIB_PATH}/metalwork.cmake)
  add_executable(test test.c)
  target_generate_artifact(test SREC)
  EOF

  cat - <<'  EOF' >$test_directory/test.c
  int main() {
    volatile int test = 0;
    while (1) test++;
  }
  EOF

  (cd $test_directory \
    && cmake -B builddir -G Ninja \
      -DMETALWORK_CMAKE_LIB_PATH=$lib_directory \
      -DCMAKE_TOOLCHAIN_FILE=$test_directory/toolchain.cmake \
    && ninja -C builddir)

  test -f $test_directory/builddir/test.srec
}

CMAKE_LIB_DIRECTORY=$(realpath $1)
TEST_DIRECTORY=$(realpath $2)

cmake_version
run_test test_target_set_link_script $CMAKE_LIB_DIRECTORY $TEST_DIRECTORY
run_test test_target_generate_map_file $CMAKE_LIB_DIRECTORY $TEST_DIRECTORY
run_test test_target_generate_artifact_hex $CMAKE_LIB_DIRECTORY $TEST_DIRECTORY
run_test test_target_generate_artifact_bin $CMAKE_LIB_DIRECTORY $TEST_DIRECTORY
run_test test_target_generate_artifact_srec $CMAKE_LIB_DIRECTORY $TEST_DIRECTORY

summary

RC=$NUMBER_OF_FAILURES
