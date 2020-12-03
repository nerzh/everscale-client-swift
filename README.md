# Swift Client for Free Ton SDK

[![SPM](https://img.shields.io/badge/swift-package%20manager-green)](https://swift.org/package-manager/)

| OS | Result |
| ----------- | ----------- |
| MacOS | ✅ |
| Linux | ✅ |
| iOS | Soon |

## Setup TONSDK

### Install sdk with bash script

0. create folder for TONSDK, for example 
```mkdir ./TONSDK```
1. ```cd ./TONSDK```
2. ```bash path_to_this_library/scripts/install_tonsdk.sh```

### Manual install sdk

0. Install Rust to your OS
1. git clone https://github.com/tonlabs/TON-SDK
2. cd ./TON-SDK
3. cargo update
4. cargo build --release
5. copy or create symlink of dynamic library    
macOS :  
**./TON-SDK/target/release/libton_client.dylib**  
to   
**/usr/local/lib/libton_client.dylib**  
    
    Linux :  
**./TON-SDK/target/release/libton_client.so**     
to    
**/usr/lib/libton_client.so**  
6. Create pkgConfig file :  
    
macOS :  
    **/usr/local/lib/pkgConfig/libton_client.pc**  

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
    **/usr/lib/pkgConfig/libton_client.pc**  
    
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
7. Copy or create symlink of file   
**/TON-SDK/ton_client/client/tonclient.h**  
to  
MacOS:  
**/usr/local/include/tonclient.h**  
Linux:  
**/usr/include/tonclient.h**  

## Usage

All requests are async.

```swift
import TonClientSwift

var config: TSDKClientConfig = .init()
config.network = TSDKNetworkConfig(server_address: "https://net.ton.dev")
let client: TSDKClientModule = .init(config: config)

// Crypto
client.crypto.factorize(TSDKParamsOfFactorize(composite: "17ED48941A08F981")) { (response) in
    print(response.result?.factors)
}

// Boc
let payload: TSDKParamsOfParse = .init(bocEncodedBase64: "te6ccgEBAQEAWAAAq2n+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE/zMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzSsG8DgAAAAAjuOu9NAL7BxYpA")
client.boc.parse_message(payload) { (response) in
    if let result = response.result, let parsed: [String: Any] = result.parsed.toDictionary() {
        print(parsed["id"])
        print(parsed["src"])
        print(parsed["dst"])
    }
}
```
## Errors

```swift
client.crypto.factorize(TSDKParamsOfFactorize(composite: "17ED48941A08F981")) { (response) in
    if let error = response.error {
        print(error.data.toJSON())
        print(error.code)
    }
}
```

## Tests
### If you use Xcode for Test

Please, set custom working directory to project folder for your xcode scheme. This is necessary for the relative path "./" to the project folders to work.
You may change it with the xcode edit scheme menu.  

Or inside file path_to_this_library/.swiftpm/xcode/xcshareddata/xcschemes/TonClientSwift.xcscheme
set to tag "LaunchAction" absolute path to this library with options:   
**useCustomWorkingDirectory = "YES"**  
**customWorkingDirectory = "/path_to_ton_sdk"**


Tests

1. inside root directory of ton-client-swift create **.env.debug** file with
NET TON DEV
```
server_address=https://net.ton.dev
giver_address=0:653b9a6452c7a982c6dc92b2da9eba832ade1c467699ebb3b43dca6d77b780dd
giver_abi_name=Giver
giver_function=grant
```
**Optional:** Install locale NodeSE for tests if you needed:  
- launch docker
- install nodejs to your OS
- npm install -g ton-dev-cli
- ton start  
by default nodeSE will start on localhost:80  
NODE SE  
```
server_address=http://localhost:80
giver_address=0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94
giver_abi_name=GiverNodeSE
giver_function=sendGrams
giver_amount=10000000000
```

2. Run Tests  
MacOS:  
Run Tests inside Xcode  
Linux:  
swift test --generate-linuxmain  
swift test --enable-test-discovery  
