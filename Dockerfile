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
    && conda update -n base -c defaults conda \
    && conda clean --all

ENV JAVA_VERSION jdk-11.0.4+11

RUN set -eux; \
    ARCH="$(dpkg --print-architecture)"; \
    case "${ARCH}" in \
       aarch64|arm64) \
         ESUM='10e33e1862638e11a9158947b3d7b461727d8e396e378b171be1eb4dfe12f1ed'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_aarch64_linux_hotspot_11.0.4_11.tar.gz'; \
         ;; \
       armhf) \
         ESUM='19f16c4b905055a13457d06ce9a107a54289d3828bf3ae378efc6deb908a5572'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_arm_linux_hotspot_11.0.4_11.tar.gz'; \
         ;; \
       ppc64el|ppc64le) \
         ESUM='fc6b616f83fea033edd836c934f3e70764b5aa1dac0446df8a8b49297ca40a5e'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_ppc64le_linux_hotspot_11.0.4_11.tar.gz'; \
         ;; \
       s390x) \
         ESUM='9487d27ef65b0cc30481cd0d23466aa6b36c90dfaa8a033166fad67bc37891de'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_s390x_linux_hotspot_11.0.4_11.tar.gz'; \
         ;; \
       amd64|x86_64) \
         ESUM='90c33cf3f2ed0bd773f648815de7347e69cfbb3416ef3bf41616ab1c4aa0f5a8'; \
         BINARY_URL='https://github.com/AdoptOpenJDK/openjdk11-binaries/releases/download/jdk-11.0.4%2B11/OpenJDK11U-jdk_x64_linux_hotspot_11.0.4_11.tar.gz'; \
         ;; \
       *) \
         echo "Unsupported arch: ${ARCH}"; \
         exit 1; \
         ;; \
    esac; \
    curl -LfsSo /tmp/openjdk.tar.gz ${BINARY_URL}; \
    echo "${ESUM} */tmp/openjdk.tar.gz" | sha256sum -c -; \
    mkdir -p /opt/java/openjdk; \
    cd /opt/java/openjdk; \
    tar -xf /tmp/openjdk.tar.gz --strip-components=1; \
    rm -rf /tmp/openjdk.tar.gz;

ENV JAVA_HOME=/opt/java/openjdk \
    PATH="/opt/java/openjdk/bin:$PATH"