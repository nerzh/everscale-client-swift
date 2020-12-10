commandExist() {
  which $1 > /dev/null && echo '1' && return;
  echo '0';
}

if [ $(commandExist 'cargo') == "1" ]; then
  echo "RUST ALREADY INSTALLED TO YOUR OS";
else
  echo "CARGO NOT FOUND";
  echo "INSTALL RUST TO YOUR OS ?";
  echo "y / n ?";
  read answer
  if [ $answer == "y" ]; then
    if [ $(commandExist 'curl') != "1" ]; then
      echo "Please install curl";
      exit 0;
    fi
    echo "INSTALL RUST...";
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    source ~/.profile
  else
    echo "RUST NOT INSTALLED. EXIT.";
    exit 0;
  fi
fi;

if [ `uname -s` = Darwin ]; then
  source ~/.profile
  echo "Install cargo-lipo"
  USER=$(whoami)
  sudo -H -u $USER bash -lc 'cargo install cargo-lipo'
  sudo -H -u $USER bash -lc 'rustup target add aarch64-apple-ios x86_64-apple-ios'
fi
  
echo $'\nINSTALLATION RUST COMPLETE'
















