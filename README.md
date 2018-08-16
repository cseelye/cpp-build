# cpp-build
Basic container for building C++ projects with gcc 7.3.1 toolchain and boost 1.67. The container is based on CentOS 6.9 with glibc 2.12. Since glibc is backward compatible, if you wish you can statically link your project and create a binary that will run on most modern linux without recompiling.

You can use this container to build your project by mounting your source directory as a volume, enabling the gcc-7 toolchain, and running your build command:
```
docker run --rm -v $(cwd):/build fnc-build scl enable devtoolset-7 "bash -c 'cd /build && make'"
```
