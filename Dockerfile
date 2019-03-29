FROM nvidia/cuda:9.1-cudnn7-devel-ubuntu16.04

# Ref. https://github.com/MarcusOlivecrona/REINVENT

RUN apt-get update
RUN apt-get upgrade -y
RUN apt-get install lsof wget curl vim git unzip -y
RUN apt-get install libxrender1 -y

RUN wget -q -c -O /tmp/Miniconda3-latest-Linux-x86_64.sh https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
RUN bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b
ENV PATH /root/miniconda3/bin:$PATH
ENV CONDA_EXE /root/miniconda3/bin/conda
RUN conda update -y -n base -c defaults conda
RUN conda create -y -n py36 python=3.6
ENV PATH /root/miniconda3/envs/py36/bin:$PATH
ENV CONDA_DEFAULT_ENV py36
ENV CONDA_PREFIX /root/miniconda3/envs/py36

RUN conda update -y --all
RUN conda install -y -c pytorch pytorch=0.1.12 cuda91
RUN conda install -y -c rdkit rdkit scipy tqdm
RUN conda install -y jupyter notebook matplotlib pandas

RUN jupyter-notebook --generate-config
RUN echo "c.NotebookApp.ip = '0.0.0.0'" >> /root/.jupyter/jupyter_notebook_config.py
RUN echo 'c.NotebookApp.allow_root = True' >> /root/.jupyter/jupyter_notebook_config.py
RUN echo "c.NotebookApp.password = 'sha1:29a4e89b9f3d:2bc031d09642273adf9128ce40320cbc115edc02'" >> /root/.jupyter/jupyter_notebook_config.py

WORKDIR /root

RUN git clone https://github.com/MarcusOlivecrona/REINVENT.git
