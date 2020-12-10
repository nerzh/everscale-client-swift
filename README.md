# Swift Client for Free Ton SDK

[![SPM](https://img.shields.io/badge/swift-package%20manager-green)](https://swift.org/package-manager/)

Swift is a strongly typed language that has long been used not only for iOS development. Apple is actively promoting it to new platforms and today it can be used for almost any task. Thanks to this, this implementation provides the work of TonSDK on many platforms at once, including the native one for mobile phones. Let me remind you that swift can also be built for android.

| OS | Result |
| ----------- | ----------- |
| MacOS | ✅ |
| Linux | ✅ |
| iOS | ✅ |
| Windows | Soon |

## Usage

All requests are async

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

## Setup TONSDK For Linux and MacOS

### Install sdk with bash script
 
0. This download TON-SDK to current dirrectory, compile it and add library symlinks to your system   
```bash path_to_this_library/scripts/install_tonsdk.sh```

- __note:__ then you can update the TON-SDK version simply by running these commands:   
```
cd path_to/TON-SDK
git pull
cargo update
cargo build --release
```

### Manual install sdk ( if you have any problem with script install_tonsdk.sh )

<details>
  <summary>SPOILER: Manual installation</summary>

0. Install Rust to your OS   
1. git clone https://github.com/tonlabs/TON-SDK   
2. cd ./TON-SDK
3. cargo update
4. cargo build --release
5. copy or create symlink of dynamic library    
__macOS :__  
**./TON-SDK/target/release/libton_client.dylib**  
to   
**/usr/local/lib/libton_client.dylib**  
    
    __Linux :__  
**./TON-SDK/target/release/libton_client.so**     
to    
**/usr/lib/libton_client.so**  
6. Create pkgConfig file :  
    
__macOS :__  
    **/usr/local/lib/pkgconfig/libton_client.pc**  

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
__Linux:__  
    **/usr/lib/pkgconfig/libton_client.pc**  
    
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
__MacOS:__  
**/usr/local/include/tonclient.h**  
__Linux:__  
**/usr/include/tonclient.h**  

</details>

## Setup TONSDK For iOS

0.   For install Rust and rust dependencies you should download and execute the install_rust.sh script from scripts directory   
```bash install_rust.sh```  
⚠️ Wait installation

1. 
```
git clone https://github.com/tonlabs/TON-SDK.git
cd ./TON-SDK
cargo lipo --release
```  
⚠️ Wait installation

2. In xcode __File > Add files to "Name Your Project"__ navigate to ./TON-SDK/ton_client/tonclient.h

3. Create bridge. In xcode __File > New > File__, select Header File, set name for example Tonclient-Bridging-Header.h and add __#include <stdbool.h>__ and __#import "tonclient.h"__ like this:

```C
#ifndef Tonclient_Bridging_Header_h
#define Tonclient_Bridging_Header_h

#include <stdbool.h>
#import "tonclient.h"

#endif
```   
4. Add path to search for bridge headers ( path to Tonclient-Bridging-Header.h )  
![](https://user-images.githubusercontent.com/10519803/101789966-9591bc80-3b0a-11eb-8918-1adf36130617.png)

5. Add path to search for libraries ( path to directory withlibton_client.a )   
![](https://user-images.githubusercontent.com/10519803/101791171-e524b800-3b0b-11eb-98fa-29b7a50c3b67.png)

6. __File > Swift Packages > Add Package Dependency__  
![](https://user-images.githubusercontent.com/10519803/101791238-fa99e200-3b0b-11eb-99f3-8e8120c57e96.png)

7. Build project ...

## Tests
### If you use Xcode for Test

Please, set custom working directory to project folder for your xcode scheme. This is necessary for the relative path "./" to this library folders.
You may change it with the xcode edit scheme menu __Product > Scheme > Edit Scheme__ menu __Run__ submenu __Options__ enable checkbox "Use custom directory" and add custom working directory.  

Or if above variant not available, then inside file path_to_this_library/.swiftpm/xcode/xcshareddata/xcschemes/TonClientSwift.xcscheme
set to tag __"LaunchAction"__ absolute path to this library with options:   
**useCustomWorkingDirectory = "YES"**  
**customWorkingDirectory = "/path_to_this_library"**  


### Tests

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
- docker run -d --name local-node -p 80:80 tonlabs/local-node   
nodeSE will start on localhost:80   
```
server_address=http://localhost:80
giver_address=0:841288ed3b55d9cdafa806807f02a0ae0c169aa5edfe88a789a6482429756a94
giver_abi_name=GiverNodeSE
giver_function=sendGrams
giver_amount=10000000000
```

2. Run Tests  
__MacOS:__  
Run Tests inside Xcode  
__Linux:__  
swift test --generate-linuxmain  
swift test --enable-test-discovery  
