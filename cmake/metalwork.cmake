## \brief The Metalwork CMake support library
## \desc The Metalwork CMake support library contains CMake functions that
## modify targets to perform operations that are interesting or necessary for
## most embedded projects. For example, generating a map file, setting a linker
## script, or converting the output binary to an SREC.

## \brief Set a link script to be used for a target
## \desc Pass LINK_SCRIPT to the compiler to interpret as a link script for
## TARGET_NAME. If the link script is a relative path, it is interpreted to be
## relative to CMAKE_CURRENT_SOURCE_DIR. The link script becomes a dependency
## of the target, so the target will be rebuilt if the link script is modified.
## \arg TARGET_NAME The name of the target that will be linked
## \arg LINK_SCRIPT Absolute or relative path to an LD link script
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

## \brief Generate a map file for the target
## \desc Instruct the compiler to generate a map file for the target in the
## target's binary directory with the name of the target.
## \arg TARGET_NAME The name of the target to generate the map file for
function(target_generate_map_file TARGET_NAME)
  target_link_options(${TARGET_NAME} PUBLIC
    -Wl,-Map=${CMAKE_CURRENT_BINARY_DIR}/${TARGET_NAME}.map,--cref)
endfunction()

## \brief Use objcopy to generate an artifact from the target output file.
## \desc Use objcopy to generate an additional build artifact beyond the
## default output file. E.g, can be used to generate hex and bin files from an
## ELF executable. ARTIFACT_FORMAT should be one of the supported types: HEX,
## BIN, and SREC. The generated target is added to the ALL target, and the
## input target is set as a dependency, so the artifact is regenerated if the
## target is rebuilt.
## \arg TARGET_NAME The input target
## \arg ARTIFACT_FORMAT The format of the artifact to create. Should be one of
##  the supported types: BIN, HEX, or SREC.
function(target_generate_artifact TARGET_NAME ARTIFACT_FORMAT)
  if(ARTIFACT_FORMAT STREQUAL "HEX")
    set(EXTENSION hex)
    set(FORMAT ihex)
  elseif(ARTIFACT_FORMAT STREQUAL "BIN")
    set(EXTENSION bin)
    set(FORMAT binary)
  elseif(ARTIFACT_FORMAT STREQUAL "SREC")
    set(EXTENSION srec)
    set(FORMAT srec)
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
