#!/bin/bash
#--------------------------------------------
# Build and install LLVM/Clang globally
#--------------------------------------------

set -e

LLVM_VERSION="17.0.6"            # Change to the version you want
SRC_DIR="$HOME/llvm-project"     # Local clone
BUILD_DIR="$HOME/llvm-build"     # Local build directory
NPROC=$(nproc)                   # Parallel build jobs

# ----------------------
# Clone LLVM project if missing
# ----------------------
if [ ! -d "$SRC_DIR" ]; then
    echo "Cloning LLVM $LLVM_VERSION..."
    git clone --branch llvmorg-$LLVM_VERSION https://github.com/llvm/llvm-project.git "$SRC_DIR"
fi

# ----------------------
# Build with Ninja
# ----------------------
mkdir -p "$BUILD_DIR"
cd "$BUILD_DIR"

cmake -G Ninja \
      -DCMAKE_BUILD_TYPE=Release \
      -DCMAKE_INSTALL_PREFIX="/usr/local" \
      -DLLVM_ENABLE_PROJECTS="clang;clang-tools-extra;lld" \
      "$SRC_DIR/llvm"

ninja -j "$NPROC"

# ----------------------
# Install globally (sudo required)
# ----------------------
echo "Installing LLVM/Clang globally to /usr/local..."
sudo ninja install

# ----------------------
# Verify installation
# ----------------------
echo "----------------------------------"
echo "Installed LLVM/Clang:"
clang --version
echo "You can now use clang, clang++, lld globally!"
echo "----------------------------------"