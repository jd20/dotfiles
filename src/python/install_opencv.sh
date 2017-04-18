#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh" \
    && . "../$(get_os)/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

declare -r OPENCV_VERSION="3.2.0"
declare -r OPENCV_URL="https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.zip"
declare -r OPENCV_CONTRIB_URL="https://github.com/Itseez/opencv_contrib/archive/$OPENCV_VERSION.zip"
declare -r OPENCV_LIBRARY="$HOME/.pyenv/versions/cv/lib/python3.6/site-packages/cv2.so"

configure_opencv() {
    mkdir /tmp/opencv-$OPENCV_VERSION/build && cd /tmp/opencv-$OPENCV_VERSION/build
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib-$OPENCV_VERSION/modules \
        -D PYTHON_EXECUTABLE=$HOME/.pyenv/versions/3.6.1/bin/python \
        -D BUILD_EXAMPLES=ON ..
}

build_opencv() {
    cd /tmp/opencv-$OPENCV_VERSION/build
    make -j4
    sudo make install
    sudo ldconfig
    ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-36m-x86_64-linux-gnu.so \
        $OPENCV_LIBRARY
}

install_opencv() {

    if [ -e $OPENCV_LIBRARY ]; then
        print_success "OpenCV already installed"
        return 0
    fi

    if [ "$(get_os)" == "macos" ]; then
    else
        install_package "Build Libraries" "build-essential cmake pkg-config"
        install_package "Image Libraries" "libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev"
        install_package "Video Libraries" "libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev"
        install_package "GUI Libraries" "libgtk-3-dev"
        install_package "Matrix Libraries" "libatlas-base-dev gfortran"
    fi

    cd /tmp
    venv cv
    print_success "Create virtual environment 'cv'"
    execute "pip install numpy" \
        "Install numpy"
    execute "wget -qO /tmp/opencv-$OPENCV_VERSION.zip $OPENCV_URL && wget -qO /tmp/opencv_contrib-$OPENCV_VERSION.zip $OPENCV_CONTRIB_URL" \
        "Download OpenCV"
    execute "unzip -qqo /tmp/opencv-$OPENCV_VERSION.zip && unzip -qqo /tmp/opencv_contrib-$OPENCV_VERSION.zip" \
        "Extract OpenCV"
    execute "configure_opencv" "Configure OpenCV"
    execute "build_opencv" "Build OpenCV"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   OpenCV\n\n"
install_opencv
