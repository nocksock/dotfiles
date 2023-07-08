# add cuda on linux
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    export PATH="/usr/local/cuda-11.6/bin:$PATH"
    export LD_LIBRARY_PATH="/usr/local/cuda-11.6/lib64:$LD_LIBRARY_PATH"
fi
