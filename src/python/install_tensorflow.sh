#!/bin/bash

cd "$(dirname "${BASH_SOURCE[0]}")" \
    && . "../../script/helper/utils.sh"

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

install_tensorflow() {

    bazel_flags=
    if nvidia_gpu_present; then
        bazel_flags="--config=cuda"
    fi

    mkdir /tmp/tensorflow && cd /tmp/tensorflow
    git clone -q https://github.com/tensorflow/tensorflow .
    git checkout -q r1.0

    venv tf
    print_success "Create virtual environment 'tf'"
    execute "pip install numpy dev pip wheel" \
        "Install Python build packages"
    execute "" \
        "Configure build"
    execute "bazel build --config=opt $bazel_flags //tensorflow/tools/pip_package:build_pip_package" \
        "Compile TensorFlow"
    execute "bazel-bin/tensorflow/tools/pip_package/build_pip_package /tmp/tensorflow_pkg" \
        "Build pip package"
    execute "sudo pip install /tmp/tensorflow_pkg/tensorflow-1.0.1-py2-none-any.whl" \
        "Install wheel"

}

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

print_in_purple "\n   Tensorflow\n\n"
install_tensorflow
