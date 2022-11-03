commandExist() {
  which $1 > /dev/null && echo '1' && return;
  echo '0';
}

if [ `uname -s` = Linux ]; then
  sudo echo $(whoami)
fi


# INSTALL RUST
SCRIPTPATH="$( cd "$(dirname "$0")" >/dev/null 2>&1 ; pwd -P )"
bash "$SCRIPTPATH/install_rust.sh"
source ~/.profile

# INSTALL SDK
if [ -d "./SDK" ]; then
  echo "SDK FOLDER ALREADY EXISTS"
else
  git clone https://github.com/tonlabs/ever-sdk.git ./SDK
fi
cd ./SDK && git reset --hard HEAD && git pull --ff-only
cargo update

# if [ `uname -s` = Darwin ]; then
#   if [ `uname -m` = arm64 ]; then
#     rustup target add x86_64-apple-darwin
#     cargo build --release --target x86_64-apple-darwin
#   else
#     cargo build --release
#   fi
# else
#   cargo build --release
# fi
cargo build --release
  
if [ `uname -s` = Darwin ]; then
  if [ $(commandExist 'port') == "1" ]; then
    MACOS_LIB_INCLUDE_DIR="/opt/local"
    echo "CHOOSE MACOS MACPORT INCLUDE DIR";
  fi
  if [ $(commandExist 'brew') == "1" ]; then
    if [ -d "/opt/homebrew" ]; then
      MACOS_LIB_INCLUDE_DIR="/opt/homebrew"
      echo "CHOOSE MACOS HOMEBREW /opt/homebrew";
    else
      MACOS_LIB_INCLUDE_DIR="/usr/local"
      echo "CHOOSE MACOS HOMEBREW /usr/local";
    fi
  fi
  if [ $(commandExist 'port') == "1" ]; then
    echo "...";
  elif [ $(commandExist 'brew') == "1" ]; then
    echo "...";
  else
    echo 'ERROR: homebrew or macport is not installed'
  fi
fi

LINUX_LIB_INCLUDE_DIR="/usr"
  
  
LINUX_PKG_CONFIG=$'prefix='"$LINUX_LIB_INCLUDE_DIR"'
exec_prefix=${prefix}
includedir=${prefix}/include
libdir=${exec_prefix}/lib

Name: ton_client
Description: ton_client
Version: 1.0.0
Cflags: -I${includedir}
Libs: -L${libdir} -lton_client'

MACOS_PKG_CONFIG=$'prefix='"$MACOS_LIB_INCLUDE_DIR"'
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
  if [[ -h "${LINUX_LIB_INCLUDE_DIR}/include/tonclient.h" ]]; then
    sudo rm ${LINUX_LIB_INCLUDE_DIR}/include/tonclient.h
    echo "OK: ${LINUX_LIB_INCLUDE_DIR}/include/tonclient.h old symlink already deleted and will create new"
  fi
  sudo ln -s $HEADER ${LINUX_LIB_INCLUDE_DIR}/include/tonclient.h || echo "ERROR: symbolic link tonclient.h already exist"

  DYLIB="$(pwd)/target/release/libton_client.so"
  echo ""
  echo "Create symbolic link libton_client.so"
  if [ -h "${LINUX_LIB_INCLUDE_DIR}/lib/libton_client.so" ]; then
    sudo rm ${LINUX_LIB_INCLUDE_DIR}/lib/libton_client.so
    echo "OK: ${LINUX_LIB_INCLUDE_DIR}/lib/libton_client.so old symlink already deleted and will create new"
  fi
  sudo ln -s $DYLIB ${LINUX_LIB_INCLUDE_DIR}/lib/libton_client.so || echo "ERROR: symbolic link libton_client.so already exist"

  
  echo "$LINUX_PKG_CONFIG" >> libton_client.pc
  sudo mv libton_client.pc ${LINUX_LIB_INCLUDE_DIR}/lib/pkgconfig/libton_client.pc
  
  
  
elif [ `uname -s` = Darwin ]; then
  echo ""
  echo "Create symbolic link tonclient.h"
  if [[ -h "${MACOS_LIB_INCLUDE_DIR}/include/tonclient.h" ]]; then
    sudo rm ${MACOS_LIB_INCLUDE_DIR}/include/tonclient.h
    echo "OK: ${MACOS_LIB_INCLUDE_DIR}/include/tonclient.h old symlink deleted and will create new"
  fi
  echo "$HEADER ${MACOS_LIB_INCLUDE_DIR}/include/tonclient.h"
  sudo ln -s $HEADER ${MACOS_LIB_INCLUDE_DIR}/include/tonclient.h || echo "ERROR: symbolic link tonclient.h already exist"
  
  # if [ `uname -m` = arm64 ]; then
  #   DYLIB="$(pwd)/target/x86_64-apple-darwin/release/libton_client.dylib"
  # else
  #   DYLIB="$(pwd)/target/release/libton_client.dylib"
  # fi
  DYLIB="$(pwd)/target/release/libton_client.dylib"
  echo ""
  echo "Create symbolic link libton_client.dylib"
  if [[ -h "${MACOS_LIB_INCLUDE_DIR}/lib/libton_client.dylib" ]]; then
    sudo rm ${MACOS_LIB_INCLUDE_DIR}/lib/libton_client.dylib
    echo "OK: ${MACOS_LIB_INCLUDE_DIR}/lib/libton_client.dylib old symlink deleted and will create new"
  fi
  sudo ln -s $DYLIB ${MACOS_LIB_INCLUDE_DIR}/lib/libton_client.dylib || echo "ERROR: symbolic link libton_client.dylib already exist"
  echo "${DYLIB} to ${MACOS_LIB_INCLUDE_DIR}/lib/libton_client.dylib"
  
  echo ""
  echo "Copy pc file"
  echo "$MACOS_PKG_CONFIG" >> libton_client.pc
  sudo mv libton_client.pc ${MACOS_LIB_INCLUDE_DIR}/lib/pkgconfig/libton_client.pc
  echo "libton_client.pc to ${MACOS_LIB_INCLUDE_DIR}/lib/pkgconfig/libton_client.pc"
else
  echo "I CAN INSTALL ONLY LINUX(DEBIAN / UBUNTU / ...) OR MACOS"
fi

echo $'\nINSTALLATION SDK COMPLETE'
















