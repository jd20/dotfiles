#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"
    && . "../ubuntu/utils.sh"

install_pyenv() {
    curl -L https://raw.githubusercontent.com/pyenv/pyenv-installer/master/bin/pyenv-installer | bash
    export PATH="$HOME/.pyenv/bin:$PATH"
    eval "$(pyenv init -)"
    eval "$(pyenv virtualenv-init -)"
}

install_python36() {
    add_ppa "jonathonf/python-3.6"
    sudo apt-get update -qqy
    sudo apt-get upgrade -qqy
    sudo apt-get install --allow-unauthenticated -qqy libssl-dev libsqlite3-dev libreadline-dev libbz2-dev
    pyenv install 3.6.1
    sudo apt-get install --allow-unauthenticated -qqy python2.7-dev python3.6-dev
}

configure_opencv() {

    mkdir $HOME/opencv-$OPENCV_VERSION/build && cd $HOME/opencv-$OPENCV_VERSION/build
    cmake -D CMAKE_BUILD_TYPE=RELEASE \
        -D CMAKE_INSTALL_PREFIX=/usr/local \
        -D INSTALL_PYTHON_EXAMPLES=ON \
        -D INSTALL_C_EXAMPLES=OFF \
        -D OPENCV_EXTRA_MODULES_PATH=$HOME/opencv_contrib-$OPENCV_VERSION/modules \
        -D PYTHON_EXECUTABLE=$HOME/.pyenv/versions/3.6.1/bin/python \
        -D BUILD_EXAMPLES=ON ..
}

build_opencv() {
    make -j4
    sudo make install
    sudo ldconfig
    ln -s /usr/local/lib/python3.6/site-packages/cv2.cpython-36m-x86_64-linux-gnu.so \
        $HOME/.pyenv/versions/cv/lib/python3.6/site-packages/cv2.so
}

install_opencv() {

    declare -r OPENCV_VERSION="3.2.0"
    declare -r OPENCV_URL="https://github.com/Itseez/opencv/archive/$OPENCV_VERSION.zip"
    declare -r OPENCV_CONTRIB_URL="https://github.com/Itseez/opencv_contrib/archive/$OPENCV_VERSION.zip"

    print_in_purple "\n   OpenCV $OPENCV_VERSION\n\n"

    install_package "Build Libraries" "build-essential cmake pkg-config"
    install_package "Image Libraries" "libjpeg8-dev libtiff5-dev libjasper-dev libpng12-dev"
    install_package "Video Libraries" "libavcodec-dev libavformat-dev libswscale-dev libv4l-dev libxvidcore-dev libx264-dev"
    install_package "GUI Libraries" "libgtk-3-dev"
    install_package "Matrix Libraries" "libatlas-base-dev gfortran"

    execute "pyenv virtualenv 3.6.1 cv && pyenv activate cv" \
        "Create virtual environment 'cv'"
    execute "pip install numpy" \
        "Install numpy"
    execute "wget -qO $HOME/opencv-$OPENCV_VERSION.zip $OPENCV_URL && wget -qO $HOME/opencv_contrib-$OPENCV_VERSION.zip $OPENCV_CONTRIB_URL" \
        "Download OpenCV"
    execute "unzip -qqo $HOME/opencv-$OPENCV_VERSION.zip && unzip -qqo $HOME/opencv_contrib-$OPENCV_VERSION.zip" \
        "Extract OpenCV"
    execute "configure_opencv" "Configure OpenCV"
    execute "build_opencv" "Build OpenCV"

    rm $HOME/opencv-$OPENCV_VERSION.zip $HOME/opencv_contrib-$OPENCV_VERSION.zip
    rm -rf $HOME/opencv-$OPENCV_VERSION $HOME/opencv_contrib-$OPENCV_VERSION

}

execute "install_pyenv" "pyenv"
execute "install_python36" "Python 3.6.1"
install_opencv
