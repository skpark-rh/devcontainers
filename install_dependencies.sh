# install miniconda
curl -LO "https://github.com/conda-forge/miniforge/releases/latest/download/Miniforge3-Linux-x86_64.sh"
bash Miniforge3-Linux-x86_64.sh -p $HOME/miniconda -b
rm Miniforge3-Linux-x86_64.sh && export PATH="$HOME/miniconda/bin:$PATH"
conda update -y conda && conda init && conda install -c anaconda -y python=3.10 gdb cuda-gdb
source ~/.bashrc

# install pytorch dependencies
cd pytorch && pip install -r requirements.txt mkl-include mkl-static

# install ray dependencies
pip install ray[all]
