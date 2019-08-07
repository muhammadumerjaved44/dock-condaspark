FROM continuumio/miniconda3

ENV PYTHON_DATABASES_PACKAGES="\
    SQLAlchemy \
    boto3 \
    pyspark"

ENV PYTHON_COMPUTATION_PACKAGES="\
    cython \
    numpy \
    scipy \
    scikit-learn \
    pandas \
    nltk \
    datetime \
    beautifulsoup4 \
    scrapy"

ENV PYTHON_VISUAL_PACKAGES="\
    seaborn \
    bokeh \
    matplotlib"

ENV CONDA_PACKAGES="\
    conda-forge::tensorflow \
    anaconda::pyodbc"

RUN pip install --no-cache-dir $PYTHON_DATABASES_PACKAGES $PYTHON_COMPUTATION_PACKAGES $PYTHON_VISUAL_PACKAGES \
    && conda install $CONDA_PACKAGES \
    && conda update -n base -c defaults conda
    && conda clean --all