# install miniconda
curl -LO "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
bash Miniforge3-Linux-x86_64.sh -p $HOME/miniconda -b
rm Miniforge3-Linux-x86_64.sh && export PATH="$HOME/miniconda/bin:$PATH"
conda update -y conda && conda init && conda install -c anaconda -y python=3.10 gdb cuda-gdb

sed -i '$ a\
export CLAUDE_CODE_USE_VERTEX=1\
export CLOUD_ML_REGION=us-east5\
export ANTHROPIC_VERTEX_PROJECT_ID=itpc-gcp-ai-eng-claude\
export MAX_JOBS=25\
export CC=gcc\
export CXX=g++\
export CMAKE_PREFIX_PATH=/home/sampark/miniconda\
export NVCC_CCBIN=g++' ~/.bashrc

# add use-cuda function to .bashrc
echo '
use_cuda() {
    export PATH=$(echo "$PATH" | tr '"'"':'"'"' '"'"'\n'"'"' | grep -v '"'"'/usr/local/cuda'"'"' | tr '"'"'\n'"'"' '"'"':'"'"' | sed '"'"'s/:$//'"'"')
    export PATH=/usr/local/cuda-$1/bin:$PATH
    export CUDA_HOME=/usr/local/cuda-$1
}' >> ~/.bashrc

source ~/.bashrc

# install pytorch dependencies
cd pytorch && pip install -r requirements.txt mkl-include mkl-static

# install ray dependencies
pip install ray[all]
