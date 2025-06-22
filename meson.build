# SPDX-License-Identifier: CC0-1.0

project('pylibcamera', 'c', 'cpp',
    meson_version : '>= 0.64',
    version : '0.1.0',
    default_options : [
        'werror=true',
        'warning_level=2',
        'cpp_std=c++17',
    ],
    license : 'LGPL 2.1+')

if not get_option('pycamera').enabled()
    error('pycamera must be enabled')
endif

message('Cloning from: @0@, revision @1@'.format(get_option('repository'), get_option('revision')))
#message('Applying patch: @0@'.format(get_option('patch')))
run_command('clone-libcamera.sh', get_option('repository'), get_option('revision'), check : true)

libcamera_proj = subproject(
    'libcamera',
    default_options : [
        'pycamera=enabled',
        'documentation=disabled',
        'test=false',
        'lc-apps=disabled',
        'qcam=disabled',
        'gstreamer=enabled',
        'v4l2=enabled',
    ]
)
libcamera_private = libcamera_proj.get_variable('libcamera_private')
libcamera_source_root = 'subprojects/libcamera'

libcamera_includes = include_directories(
    join_paths(libcamera_source_root, 'include'),
    join_paths(libcamera_source_root, 'src/py/libcamera')
)

# Sub-directories fill py_modules with their dependencies.
#py_modules = []
#subdir(join_paths(libcamera_source_root, 'utils/codegen'))

# grab the py_modules list that libcamera itself populated
py_modules = libcamera_proj.get_variable('py_modules')

py = import('python').find_installation(modules : py_modules, pure : false)

#controls_files = [
#    files(join_paths(libcamera_source_root, 'src/libcamera/control_ids_core.yaml')),
#    files(join_paths(libcamera_source_root, 'src/libcamera/control_ids_draft.yaml')),
#    files(join_paths(libcamera_source_root, 'src/libcamera/control_ids_rpi.yaml')),
#]

#properties_files = [
#    files(join_paths(libcamera_source_root, 'src/libcamera/property_ids_core.yaml')),
#    files(join_paths(libcamera_source_root, 'src/libcamera/property_ids_draft.yaml')),
#]

controls_files   = libcamera_proj.get_variable('controls_files')
properties_files = libcamera_proj.get_variable('properties_files')

#subdir(join_paths(libcamera_source_root, 'src/py'))

# grab the list that libcamera defined in
# subprojects/libcamera/src/py/libcamera/meson.build
pycamera_sources = libcamera_proj.get_variable('pycamera_sources')
pycamera_deps    = libcamera_proj.get_variable('pycamera_deps')
pycamera_args    = libcamera_proj.get_variable('pycamera_args')
py_build_env     = libcamera_proj.get_variable('py_build_env')
py_modules       = libcamera_proj.get_variable('py_modules')

message('Using python version @0@ from @1@'.format(py.version(), py.full_path()))

# py.install_sources(
#    join_paths(libcamera_source_root, 'src/py/libcamera/__init__.py'),
#    subdir : 'libcamera',
#    pure : false,
#)

py.extension_module(
    '_libcamera',
    pycamera_sources,
    install : true,
    install_rpath : ['$ORIGIN'],
    subdir : 'libcamera',
    dependencies : pycamera_deps,
    include_directories : libcamera_includes,
    cpp_args : pycamera_args,
)
