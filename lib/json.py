import json
from conan.tools.files import save


def component_object(cpp_info):
    return {
        # TODO: Some fields are commented out below because I can't think of
        # how I would use them. Are they needed at all?
        "libs": cpp_info.libs,
        "system_libs": cpp_info.system_libs,
        # "frameworks": cpp_info.frameworks,
        "objects": cpp_info.objects,
        "includedirs": cpp_info.includedirs,
        "libdirs": cpp_info.libdirs,
        # "bindirs": cpp_info.bindirs,
        # "resdirs": cpp_info.resdirs,
        # "srcdirs": cpp_info.srcdirs,
        # "builddirs": cpp_info.builddirs,
        # "frameworkdirs": cpp_info.frameworkdirs,
        "defines": cpp_info.defines,
        "cflags": cpp_info.cflags,
        "cxxflags": cpp_info.cxxflags,
        "sharedlinkflags": cpp_info.sharedlinkflags,
        "exelinkflags": cpp_info.exelinkflags,
    }


def cpp_info_object(cpp_info):
    root = component_object(cpp_info)
    root["components"] = {}
    for name, component in cpp_info.components.items():
        leaf = component_object(component)
        leaf["requires"] = component.requires
        root["components"][name] = leaf
    return root


class JsonDeps:
    def __init__(self, conanfile):
        self._conanfile = conanfile

    def generate(self):
        for dep in self._conanfile.dependencies.values():
            save(self._conanfile,
                 f'{dep.ref.name}.json',
                 json.dumps(cpp_info_object(dep.cpp_info)))
