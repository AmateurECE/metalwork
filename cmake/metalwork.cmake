# Pass ${LINK_SCRIPT} to the compiler to interpret as a link script for
# ${TARGET_NAME}. If the link script is a relative path, it is interpreted to
# be relative to CMAKE_CURRENT_SOURCE_DIR.
function(target_set_link_script TARGET_NAME LINK_SCRIPT)
  cmake_path(IS_RELATIVE LINK_SCRIPT LINK_SCRIPT_IS_RELATIVE)
  if(${LINK_SCRIPT_IS_RELATIVE})
    set(LINK_SCRIPT ${CMAKE_CURRENT_SOURCE_DIR}/${LINK_SCRIPT})
  endif()

  # Rebuild ${TARGET_NAME} if the link script changes.
  set_target_properties(${TARGET_NAME}
    PROPERTIES LINK_DEPENDS ${LINK_SCRIPT})
  target_link_options(${TARGET_NAME} PUBLIC -T ${LINK_SCRIPT})
endfunction()

# Instruct the compiler to generate a map file for the target in the target's
# binary directory with the name of the target.
function(target_generate_map_file TARGET_NAME)
  target_link_options(${TARGET_NAME} PUBLIC
    -Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.map,--cref)
endfunction()

# Use objcopy to generate an additional build artifact beyond the default
# output file. E.g, can be used to generate hex and bin files from an ELF
# executable. ARTIFACT_FORMAT should be one of the supported types: HEX or BIN.
function(target_generate_artifact TARGET_NAME ARTIFACT_FORMAT)
  if(ARTIFACT_FORMAT STREQUAL "HEX")
    set(EXTENSION hex)
    set(FORMAT ihex)
  elseif(ARTIFACT_FORMAT STREQUAL "BIN")
    set(EXTENSION bin)
    set(FORMAT binary)
  else()
    message(FATAL_ERROR
      "Unsupported ARTIFACT_FORMAT passed to target_generate_artifact. Supported formats are HEX and BIN.")
  endif()

  # Don't have to use DEPENDS here because our generator expression
  # automatically adds the target as a dependency. See:
  # https://cmake.org/cmake/help/latest/manual/cmake-generator-expressions.7.html#genex:TARGET_FILE
  add_custom_target(${TARGET_NAME}_${ARTIFACT_FORMAT}
    ALL
    COMMAND objcopy -O ${FORMAT}
      $<TARGET_FILE:${TARGET_NAME}>
      ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.${EXTENSION}
    BYPRODUCTS ${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.${EXTENSION})
endfunction()
