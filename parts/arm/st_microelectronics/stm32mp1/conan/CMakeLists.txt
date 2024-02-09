cmake_minimum_required(VERSION 3.27)
project(stm32cubemp1 LANGUAGES C ASM)
include(GNUInstallDirs)

# Needs a HAL configuration file. Just use the template.
configure_file(
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_conf_template.h
  "${CMAKE_CURRENT_BINARY_DIR}/stm32mp1xx_hal_conf.h")

# This file is present in the template, but the template has its own
# hal_conf header that is different from ours.
configure_file(
  Projects/STM32MP157C-DK2/Templates/Inc/lock_resource.h
  "${CMAKE_CURRENT_BINARY_DIR}/lock_resource.h")

# ls Drivers/STM32MP1xx_HAL_Driver/Src
add_library(stm32mp1xx_hal_driver
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_adc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_adc_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_cec.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_cortex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_crc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_crc_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_cryp.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_cryp_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dac.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dac_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dcmi.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dfsdm.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dfsdm_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dma.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_dma_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_exti.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_fdcan.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_gpio.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_hash.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_hash_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_hsem.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_i2c.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_i2c_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_ipcc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_lptim.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_mdios.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_mdma.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_msp_template.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_pwr.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_pwr_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_qspi.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_rcc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_rcc_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_rng.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_rtc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_rtc_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sai.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sai_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sd.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sd_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_smartcard.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_smartcard_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_smbus.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_smbus_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_spdifrx.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_spi.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_spi_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_sram.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_tim.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_tim_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_timebase_tim_template.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_uart.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_uart_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_usart.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_usart_ex.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_hal_wwdg.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_adc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_delayblock.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_dma.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_exti.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_fmc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_gpio.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_i2c.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_lptim.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_pwr.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_rcc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_rtc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_sdmmc.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_spi.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_tim.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_usart.c
  Drivers/STM32MP1xx_HAL_Driver/Src/stm32mp1xx_ll_utils.c
  Projects/STM32MP157C-DK2/Templates/Src/lock_resource.c)
list(APPEND stm32mp1xx_hal_driver_headers
# find Drivers/STM32MP1xx_HAL_Driver/Inc/ -maxdepth 1 -type f | grep -v template
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_adc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_adc_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_cec.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_cortex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_crc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_crc_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_cryp.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_cryp_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dac.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dac_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dcmi.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_def.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dfsdm.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dfsdm_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dma.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_dma_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_exti.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_fdcan.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_gpio.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_gpio_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_hash.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_hash_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_hsem.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_i2c.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_i2c_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_ipcc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_lptim.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_mdios.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_mdma.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_pwr.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_pwr_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_qspi.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_rcc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_rcc_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_rng.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_rtc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_rtc_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_sai.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_sai_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_sd.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_sd_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_smartcard.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_smartcard_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_smbus.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_smbus_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_spdifrx.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_spi.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_spi_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_sram.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_tim.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_tim_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_uart.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_uart_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_usart.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_usart_ex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_hal_wwdg.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_adc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_bus.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_cortex.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_delayblock.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_dma.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_dmamux.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_exti.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_fmc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_gpio.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_hsem.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_i2c.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_ipcc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_lptim.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_pwr.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_rcc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_rtc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_sdmmc.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_spi.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_system.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_tim.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_usart.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_utils.h
  Drivers/STM32MP1xx_HAL_Driver/Inc/stm32mp1xx_ll_wwdg.h
  # Plus the CMSIS headers
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151axx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151axx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151cxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151cxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151dxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151dxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151fxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp151fxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153axx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153axx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153cxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153cxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153dxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153dxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153fxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp153fxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157axx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157axx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157cxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157cxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157dxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157dxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157fxx_ca7.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp157fxx_cm4.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/stm32mp1xx.h
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include/system_stm32mp1xx.h
  # Plus the CMSIS core headers
  Drivers/CMSIS/Core/Include/cmsis_armcc.h
  Drivers/CMSIS/Core/Include/cmsis_armclang.h
  Drivers/CMSIS/Core/Include/cmsis_armclang_ltm.h
  Drivers/CMSIS/Core/Include/cmsis_compiler.h
  Drivers/CMSIS/Core/Include/cmsis_gcc.h
  Drivers/CMSIS/Core/Include/cmsis_iccarm.h
  Drivers/CMSIS/Core/Include/cmsis_version.h
  Drivers/CMSIS/Core/Include/core_armv81mml.h
  Drivers/CMSIS/Core/Include/core_armv8mbl.h
  Drivers/CMSIS/Core/Include/core_armv8mml.h
  Drivers/CMSIS/Core/Include/core_cm0.h
  Drivers/CMSIS/Core/Include/core_cm0plus.h
  Drivers/CMSIS/Core/Include/core_cm1.h
  Drivers/CMSIS/Core/Include/core_cm23.h
  Drivers/CMSIS/Core/Include/core_cm3.h
  Drivers/CMSIS/Core/Include/core_cm33.h
  Drivers/CMSIS/Core/Include/core_cm35p.h
  Drivers/CMSIS/Core/Include/core_cm4.h
  Drivers/CMSIS/Core/Include/core_cm7.h
  Drivers/CMSIS/Core/Include/core_sc000.h
  Drivers/CMSIS/Core/Include/core_sc300.h
  Drivers/CMSIS/Core/Include/mpu_armv7.h
  Drivers/CMSIS/Core/Include/mpu_armv8.h
  Drivers/CMSIS/Core/Include/tz_context.h
  # Plus these from the configure_file directives above.
  "${CMAKE_CURRENT_BINARY_DIR}/stm32mp1xx_hal_conf.h"
  "${CMAKE_CURRENT_BINARY_DIR}/lock_resource.h")
set_target_properties(stm32mp1xx_hal_driver PROPERTIES PUBLIC_HEADER
  "${stm32mp1xx_hal_driver_headers}")
target_include_directories(stm32mp1xx_hal_driver PUBLIC
  Drivers/CMSIS/Core/Include
  Drivers/CMSIS/Device/ST/STM32MP1xx/Include
  Drivers/STM32MP1xx_HAL_Driver/Inc
  "${CMAKE_CURRENT_BINARY_DIR}")
target_compile_options(stm32mp1xx_hal_driver PUBLIC
  -DUSE_HAL_DRIVER
  -D${DEVICE}
  -DCORE_CM4)
add_library(STM32MP1xx::HAL_Driver ALIAS stm32mp1xx_hal_driver)
install(TARGETS stm32mp1xx_hal_driver
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/stm32mp1xx/hal)

# BSP configuration file for the DISCO. Start with the template, but enable
# USE_STPMIC1x.
add_custom_target(stm32mp15xx_disco_conf
  COMMAND sed -E -e "\"s/(USE_STPMIC1x\\s+)0U/\\11U/\""
  "${CMAKE_CURRENT_SOURCE_DIR}/Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_conf_template.h"
  > "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_disco_conf.h"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_disco_conf.h")

add_library(stm32mp1xx_disco_bsp
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco.c
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_bus.c
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_stpmic1.c)
# ls Drivers/BSP/STM32MP15xx_DISCO/*.h | grep -v template
list(APPEND stm32mp1xx_disco_bsp_headers
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco.h
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_bus.h
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_errno.h
  Drivers/BSP/STM32MP15xx_DISCO/stm32mp15xx_disco_stpmic1.h
  "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_disco_conf.h")
set_target_properties(stm32mp1xx_disco_bsp PROPERTIES PUBLIC_HEADER
  "${stm32mp1xx_disco_bsp_headers}")
target_include_directories(stm32mp1xx_disco_bsp PUBLIC
  "${CMAKE_CURRENT_BINARY_DIR}")
add_dependencies(stm32mp1xx_disco_bsp stm32mp15xx_disco_conf)
target_link_libraries(stm32mp1xx_disco_bsp PUBLIC
  STM32MP1xx::HAL_Driver)
add_library(STM32MP1xx::DISCO_BSP ALIAS stm32mp1xx_disco_bsp)
install(TARGETS stm32mp1xx_disco_bsp
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/stm32mp1xx/bsp)

# BSP configuration file for the EVAL. Start with the template, but enable
# USE_STPMIC1x.
add_custom_target(stm32mp15xx_eval_conf
  COMMAND sed -E -e "\"s/(USE_STPMIC1x\\s+)0U/\\11U/\""
  "${CMAKE_CURRENT_SOURCE_DIR}/Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_conf_template.h"
  > "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_eval_conf.h"
  BYPRODUCTS "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_eval_conf.h")

add_library(stm32mp1xx_eval_bsp
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval.c
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_bus.c
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_stpmic1.c)
# ls Drivers/BSP/STM32MP15xx_EVAL/*.h | grep -v template
list(APPEND stm32mp1xx_eval_bsp_headers
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval.h
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_bus.h
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_errno.h
  Drivers/BSP/STM32MP15xx_EVAL/stm32mp15xx_eval_stpmic1.h
  "${CMAKE_CURRENT_BINARY_DIR}/stm32mp15xx_eval_conf.h")
set_target_properties(stm32mp1xx_eval_bsp PROPERTIES PUBLIC_HEADER
  "${stm32mp1xx_eval_bsp_headers}")
target_include_directories(stm32mp1xx_eval_bsp PUBLIC
  "${CMAKE_CURRENT_BINARY_DIR}")
add_dependencies(stm32mp1xx_eval_bsp stm32mp15xx_eval_conf)
target_link_libraries(stm32mp1xx_eval_bsp PUBLIC
  STM32MP1xx::HAL_Driver)
add_library(STM32MP1xx::EVAL_BSP ALIAS stm32mp1xx_eval_bsp)
install(TARGETS stm32mp1xx_eval_bsp
  PUBLIC_HEADER DESTINATION ${CMAKE_INSTALL_INCLUDEDIR}/stm32mp1xx/bsp)

if("${DEVICE}" STREQUAL STM32MP157Dxx)
  set(STARTUP_SOURCES Drivers/CMSIS/Device/ST/STM32MP1xx/Source/Templates/gcc/startup_stm32mp157cxx_cm4.s)
endif()

add_library(stm32mp1xx_c_polyfill OBJECT
  "${STARTUP_SOURCES}"
  Drivers/CMSIS/Device/ST/STM32MP1xx/Source/Templates/system_stm32mp1xx.c
  Projects/STM32MP157C-DK2/Templates/STM32CubeIDE/CM4/Application/User/sysmem.c
  Projects/STM32MP157C-DK2/Templates/STM32CubeIDE/CM4/Application/User/syscalls.c)
target_compile_options(stm32mp1xx_c_polyfill PRIVATE -include sys/types.h)
target_link_libraries(stm32mp1xx_c_polyfill PRIVATE STM32MP1xx::HAL_Driver)
add_library(STM32MP1xx::C_POLYFILL ALIAS stm32mp1xx_c_polyfill)
install(FILES "$<TARGET_OBJECTS:stm32mp1xx_c_polyfill>"
  DESTINATION lib)

install(FILES
  Projects/STM32MP157C-DK2/Templates/STM32CubeIDE/CM4/STM32MP157CAAX_RAM.ld
  DESTINATION lib)
