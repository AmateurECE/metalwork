from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout
from conan.tools.files import get


class stm32mp1Recipe(ConanFile):
    name = "stm32mp1"
    version = "1.6.0"
    package_type = "static-library"

    # Optional metadata
    license = "BSD-3-Clause"
    author = "Ethan D. Twardy <ethan.twardy@gmail.com>"
    url = "https://github.com/AmateurECE/metalwork/"
    description = "The STM32CubeMP1 offering from ST Microelectronics"
    topics = ("arm", "stm32", "hal")

    # Binary configuration
    settings = "os", "compiler", "build_type", "arch"
    options = {
        'device': [
            'STM32MP157Dxx',
        ],
    }
    default_options = {
        'device': 'STM32MP157Dxx',
    }

    # TODO: Put logic to generate CMakeLists.txt in custom Python generator
    # https://docs.conan.io/2.0/reference/conanfile/methods/generate.html
    exports_sources = "CMakeLists.txt"

    def layout(self):
        cmake_layout(self)

    def source(self):
        # TODO: Put this in a conandata.yml
        get(
            self,
            "https://github.com/STMicroelectronics/STM32CubeMP1/archive/refs/tags/1.6.0.tar.gz",
            sha256="db5fa905a7ddd827e046fb2516b79c13f106f8a36ab401c45c68ba60e1a38cf3",
            strip_root=True)

    def generate(self):
        tc = CMakeToolchain(self, generator="Ninja")
        tc.generate()

    def build(self):
        cmake = CMake(self)
        cmake.configure(variables={'DEVICE': self.options.device})
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        self.cpp_info.components['hal'].libs = ['stm32mp1xx_hal_driver']
        self.cpp_info.components['hal'].includedirs = ['include/stm32mp1xx/hal']
        flags = ['-DUSE_HAL_DRIVER', '-D' + str(self.options.device), '-DCORE_CM4']
        # TODO: Can we remove the -include stdint.h?
        self.cpp_info.components['hal'].cflags = ['-include', 'stdint.h'] + flags
        self.cpp_info.components['hal'].cxxflags = ['-include', 'cstdint'] + flags

        self.cpp_info.components['disco_bsp'].libs = ['stm32mp1xx_disco_bsp']
        self.cpp_info.components['disco_bsp'].includedirs = ['include/stm32mp1xx/bsp']
        self.cpp_info.components['disco_bsp'].requires = ['hal']

        self.cpp_info.components['eval_bsp'].libs = ['stm32mp1xx_eval_bsp']

        # NOTE: Conan apparently changes the extension of the installed
        # object files from '.obj' to '.o'
        # TODO: Just iterate over the objects in the libdir.
        self.cpp_info.components['c_polyfill'].objects = [
            'lib/syscalls.c.o',
            'lib/sysmem.c.o',
            'lib/startup_stm32mp157cxx_cm4.s.o',
            'lib/system_stm32mp1xx.c.o',
        ]
        # TODO: Make linker script an option
        self.cpp_info.components['c_polyfill'].exelinkflags = [
            '-T', 'STM32MP157CAAX_RAM.ld'
        ]
