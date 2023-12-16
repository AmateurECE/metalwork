#!/nix/store/lm10ywzflq9qfhr4fl0zqxrhiksf28ks-bash-5.2-p15/bin/bash
# Test our CMake support library.

NUMBER_OF_FAILURES=0

run_test() {
  local test_name=$1
  printf 'Running test %s...\n' $test_name
  eval $test_name
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
  :
}

test_target_generate_map_file() {
  :
}

test_target_generate_artifact_hex() {
  :
}

test_target_generate_artifact_bin() {
  :
}

cmake_version
run_test test_target_set_link_script
run_test test_target_generate_map_file
run_test test_target_generate_artifact_hex
run_test test_target_generate_artifact_bin
summary

RC=$NUMBER_OF_FAILURES
