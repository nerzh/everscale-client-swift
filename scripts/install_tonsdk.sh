if [ `uname -s` = Linux ]; then
  sudo echo $(whoami)
fi


# INSTALL RUST
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
bash "$SCRIPTPATH/install_rust.sh"


# INSTALL TON-SDK
if [ -d "./TON-SDK" ]; then
  echo "TON-SDK FOLDER ALREADY EXISTS"
else
  git clone https://github.com/tonlabs/TON-SDK.git
fi
cd ./TON-SDK && git pull --ff-only
cargo update
cargo build --release
  
  
  LINUX_PKG_CONFIG=$'prefix=/usr
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: ton_client
Description: ton_client
Version: 1.0.0
Cflags: -I${includedir}
Libs: -L${libdir} -lton_client'

  MACOS_PKG_CONFIG=$'prefix=/usr/local
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: ton_client
Description: ton_client
Version: 1.0.0
Cflags: -I${includedir}
Libs: -L${libdir} -lton_client'

HEADER="$(pwd)/ton_client/tonclient.h"

echo ""
if [[ -f "$HEADER" ]]; then
  echo "CHECK: $HEADER - EXIST"
else
  echo ""
  echo "ERROR: $HEADER - FILE NOT FOUND"
  exit 1;
fi

if [[ -f "./libton_client.pc" ]]; then
  rm ./libton_client.pc
else
  echo "OK: libton_client.pc already deleted"
fi

if [ `uname -s` = Linux ]; then
  echo ""
  echo "Create symbolic link tonclient.h"
  if [[ -h "/usr/include/tonclient.h" ]]; then
    sudo rm /usr/include/tonclient.h
    echo "OK: /usr/include/tonclient.h old symlink already deleted and will create new"
  fi
  sudo ln -s $HEADER /usr/include/tonclient.h || echo "ERROR: symbolic link tonclient.h already exist"

  DYLIB="$(pwd)/target/release/libton_client.so"
  echo ""
  echo "Create symbolic link libton_client.so"
  if [ -h "/usr/lib/libton_client.so" ]; then
    sudo rm /usr/lib/libton_client.so
    echo "OK: /usr/lib/libton_client.so old symlink already deleted and will create new"
  fi
  sudo ln -s $DYLIB /usr/lib/libton_client.so || echo "ERROR: symbolic link libton_client.so already exist"

  
  echo "$LINUX_PKG_CONFIG" >> libton_client.pc
  sudo mv libton_client.pc /usr/lib/pkgconfig/libton_client.pc
elif [ `uname -s` = Darwin ]; then
  echo ""
  echo "Create symbolic link tonclient.h"
  if [[ -h "/usr/local/include/tonclient.h" ]]; then
    sudo rm /usr/local/include/tonclient.h
    echo "OK: /usr/local/include/tonclient.h old symlink already deleted and will create new"
  fi
  ln -s $HEADER /usr/local/include/tonclient.h || echo "ERROR: symbolic link tonclient.h already exist"

  DYLIB="$(pwd)/target/release/libton_client.dylib"
  echo ""
  echo "Create symbolic link libton_client.dylib"
  if [[ -h "/usr/local/lib/libton_client.dylib" ]]; then
    sudo rm /usr/local/lib/libton_client.dylib
    echo "OK: /usr/local/lib/libton_client.dylib old symlink deleted and will create new"
  fi
  ln -s $DYLIB /usr/local/lib/libton_client.dylib || echo "ERROR: symbolic link libton_client.dylib already exist"
  
  echo "$MACOS_PKG_CONFIG" >> libton_client.pc
  mv libton_client.pc /usr/local/lib/pkgconfig/libton_client.pc
else
  echo "I CAN INSTALL ONLY LINUX(DEBIAN / UBUNTU / ...) OR MACOS"
fi

echo $'\nINSTALLATION TON-SDK COMPLETE'
















