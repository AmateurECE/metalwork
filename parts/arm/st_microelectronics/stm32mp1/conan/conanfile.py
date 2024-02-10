from conan import ConanFile
from conan.tools.cmake import CMakeToolchain, CMake, cmake_layout
from conan.tools.files import get, copy, apply_conandata_patches, export_conandata_patches
import glob


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

    def layout(self):
        cmake_layout(self)

    def export_sources(self):
        # TODO: Put logic to generate CMakeLists.txt in custom Python generator
        # https://docs.conan.io/2.0/reference/conanfile/methods/generate.html
        copy(self, "CMakeLists.txt", self.recipe_folder, self.export_sources_folder)
        export_conandata_patches(self)

    def source(self):
        # TODO: Put this in a conandata.yml
        get(self, **self.conan_data["sources"][self.version], strip_root=True)

    def generate(self):
        tc = CMakeToolchain(self, generator="Ninja")
        tc.generate()

    def build(self):
        apply_conandata_patches(self)
        cmake = CMake(self)
        cmake.configure(variables={'DEVICE': self.options.device})
        cmake.build()

    def package(self):
        cmake = CMake(self)
        cmake.install()

    def package_info(self):
        device = str(self.options.device)
        self.cpp_info.components['hal'].libs = ['stm32mp1xx_hal_driver']
        self.cpp_info.components['hal'].includedirs = ['include/stm32mp1xx/hal']
        flags = ['-DUSE_HAL_DRIVER', f'-D{device}', '-DCORE_CM4']
        # TODO: Can we remove the -include stdint.h?
        self.cpp_info.components['hal'].cflags = ['-include', 'stdint.h'] + flags
        self.cpp_info.components['hal'].cxxflags = ['-include', 'cstdint'] + flags

        self.cpp_info.components['lock_resource'].libs = ['stm32mp1xx_lock_resource']
        self.cpp_info.components['lock_resource'].requires = ['hal']

        self.cpp_info.components['disco_bsp'].libs = ['stm32mp1xx_disco_bsp']
        self.cpp_info.components['disco_bsp'].includedirs = ['include/stm32mp1xx/bsp']
        self.cpp_info.components['disco_bsp'].requires = ['hal', 'lock_resource']

        self.cpp_info.components['eval_bsp'].libs = ['stm32mp1xx_eval_bsp']
        self.cpp_info.components['eval_bsp'].includedirs = ['include/stm32mp1xx/bsp']
        self.cpp_info.components['eval_bsp'].requires = ['hal', 'lock_resource']

        # NOTE: Conan apparently changes the extension of the installed
        # object files from '.obj' to '.o'
        self.cpp_info.components['c_polyfill'].objects = glob.glob(self.package_folder + '/lib/*.o')
        # TODO: Make linker script an option
        self.cpp_info.components['c_polyfill'].exelinkflags = ['-T', 'STM32MP157CAAX_RAM.ld']
