# Swift Client for TVM SDK (everscale, venom, gosh)

<!--- 
  <p align="center">
    <a href="https://github.com/venom-blockchain/developer-program">
      <img src="https://raw.githubusercontent.com/venom-blockchain/developer-program/main/vf-dev-program.png" alt="Logo" width="366.8" height="146.4">
    </a>
  </p>
---> 

[![SPM](https://img.shields.io/badge/swift-package%20manager-green)](https://swift.org/package-manager/)
[![SPM](https://img.shields.io/badge/SDK%20VERSION-1.49.2-orange)](https://github.com/tonlabs/ever-sdk)

Swift is a strongly typed language that has long been used not only for iOS development. Apple is actively promoting it to new platforms and today it can be used for almost any task. Thanks to this, this implementation provides the work of TVM (toncoin, everscale, venom, gosh) SDK on many platforms at once, including the native one for mobile phones. Let me remind you that swift can also be built for android.

| OS | Result |
| ----------- | ----------- |
| MacOS | ✅ |
| Linux | ✅ |
| iOS | ✅ |
| Windows | Soon |

## Get api keys and TVM endpoints:

You need to get an API-KEY here [https://dashboard.evercloud.dev](https://dashboard.evercloud.dev)


## Usage

All requests are async

```swift
import EverscaleClientSwift

var config: TSDKClientConfig = .init()
config.network = TSDKNetworkConfig(endpoints: ["https://net.ton.dev"])
let client: TSDKClientModule = .init(config: config)

// Crypto
client.crypto.factorize(TSDKParamsOfFactorize(composite: "17ED48941A08F981")) { (response) in
    print(response.result?.factors)
}

// Boc
let payload: TSDKParamsOfParse = .init(boc: "te6ccgEBAQEAWAAAq2n+AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAE/zMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzMzSsG8DgAAAAAjuOu9NAL7BxYpA")
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

## Native ever-sdk dependency

On Apple platforms the installer creates a local binary target:

```text
Sources/CTonSDKBinary/CTonSDK.xcframework
```

The repository includes a small placeholder XCFramework at that path so SwiftPM can resolve the package without unsafe build flags. Run the installer to replace it with the real native library.

On Linux the installer builds `libever_client.a` into the package-local directory:

```text
Dependencies/ever-sdk/prebuilt/<platform>/libever_client.a
```

It also installs `ctonsdk.pc` into a system `pkg-config` directory, pointing to that package-local library and to `Sources/CTonSDK/include`. By default it uses a directory from `pkg-config --variable pc_path pkg-config`, preferring `/usr/local/lib/pkgconfig`; set `CTONSDK_PKG_CONFIG_DIR` to override it. If the directory is not writable, the installer uses `sudo`.

Install or update the native dependency manually from the package checkout:

```sh
ruby install_EverSdk.rb
```

On macOS the default command builds macOS, iOS device, and iOS simulator libraries, then packages them into `CTonSDK.xcframework`. On Linux it builds the current Linux host architecture.

Useful variants:

```sh
ruby install_EverSdk.rb --platform current
ruby install_EverSdk.rb --platform linux
ruby install_EverSdk.rb --platform ios
ruby install_EverSdk.rb --platform ios-simulator
ruby install_EverSdk.rb --platform macos
ruby install_EverSdk.rb --ref master
ruby install_EverSdk.rb --skip-build --no-update
```

The script clones `https://github.com/everx-labs/ever-sdk` into `Dependencies/ever-sdk`, installs missing Rust targets with `rustup`, builds with Cargo, copies the ready static libraries into `Dependencies/ever-sdk/prebuilt`, writes the SwiftPM XCFramework to `Sources/CTonSDKBinary/CTonSDK.xcframework` on Apple platforms, and installs `ctonsdk.pc` on Linux.

It also copies the matching `ever_client/tonclient.h` from the checked out `ever-sdk` into `Sources/CTonSDK/include/CTonSDK/tonclient.h`, so Swift sees the C API from the same SDK revision that was built.

## Tests
### If you use Xcode for Test

Please, set custom working directory to project folder for your xcode scheme. This is necessary for the relative path "./" to this library folders.
You may change it with the xcode edit scheme menu __Product > Scheme > Edit Scheme__ menu __Run__ submenu __Options__ enable checkbox "Use custom directory" and add custom working directory.  

Or if above variant not available, then inside file path_to_this_library/.swiftpm/xcode/xcshareddata/xcschemes/TonClientSwift.xcscheme
set to tag __"LaunchAction"__ absolute path to this library with options:   
**useCustomWorkingDirectory = "YES"**  
**customWorkingDirectory = "/path_to_this_library"**  


### Tests

1. inside root directory of everscale-client-swift create **.env.debug** file with
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
giver_abi_name=GiverNodeSE_v2
giver_amount=10000000000
```

2. Run Tests  
__MacOS:__  
Run Tests inside Xcode  
__Linux:__  
swift test --generate-linuxmain  
swift test --enable-test-discovery  

### Update SDK

```bash
cd everscale-client-swift
```
```bash
bash api_generate.sh
```
