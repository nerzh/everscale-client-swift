# Swift Free Ton SDK

[![SPM](https://img.shields.io/badge/swift-package%20manager-green)](https://swift.org/package-manager/)

## Setup TONSDK
0. Install Rust to your OS
1. git clone https://github.com/tonlabs/TON-SDK
2. cd ./TON-SDK
3. cargo update
4. cargo build --release
5. macOS :
    copy or create symlink of file ./TON-SDK/target/release/libton_client.dylib to /usr/local/lib/libton_client.dylib
    Linux :
    copy or create symlink of file ./TON-SDK/target/release/libton_client.so to /usr/lib/libton_client.so
6. Create pkgConfig file :
    macOS :
    
```bash

prefix=/usr/local
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: ton_client
Description: ton_client
Version: 1.0.0
Cflags: -I${includedir}
Libs: -L${libdir} -lton_client

```
    Linux:

```bash
prefix=/usr
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: ton_client
Description: ton_client
Version: 1.0.0
Cflags: -I${includedir}
Libs: -L${libdir} -lton_client
```


## Tests
### If you use Xcode for Test

Please, set custom working directory to project folder for your xcode scheme. This is necessary for the relative path "./" to the project folders to work.
You may change it with the xcode edit scheme menu.
Or inside file path_to_ton_sdk/.swiftpm/xcode/xcshareddata/xcschemes/TonClientSwift.xcscheme
set to tag "LaunchAction" absolute path to this library with options:
useCustomWorkingDirectory = "YES"
customWorkingDirectory = "/path_to_ton_sdk"

