FROM continuumio/miniconda3

LABEL maintainer="Ali Shaikh <ali.shaikh@g1g.com>"

ENV PYTHON_PACKAGES="\
    cython \
    numpy \
    matplotlib \
    scipy \
    scikit-learn \
    pandas \
    nltk \
    datetime"

ENV CONDA_PACKAGES="\
    -c conda-forge tensorflow"

RUN pip install --no-cache-dir $PYTHON_PACKAGES \
    && conda install $CONDA_PACKAGES